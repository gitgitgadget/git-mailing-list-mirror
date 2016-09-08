Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35F9A1F859
	for <e@80x24.org>; Thu,  8 Sep 2016 01:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbcIHBZ7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 21:25:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:39854 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752549AbcIHBZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 21:25:57 -0400
Received: (qmail 10109 invoked by uid 109); 8 Sep 2016 01:25:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 01:25:57 +0000
Received: (qmail 10381 invoked by uid 111); 8 Sep 2016 01:26:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 21:26:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2016 21:25:54 -0400
Date:   Wed, 7 Sep 2016 21:25:54 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: "fatal error in commit_refs" from pushing to github
Message-ID: <20160908012553.q2aubze4qggfzjxz@sigill.intra.peff.net>
References: <CACsJy8BF_mnSUcEeH=RBMyfh8RrQGJ4dwm_svsC4TciJtECn_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BF_mnSUcEeH=RBMyfh8RrQGJ4dwm_svsC4TciJtECn_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2016 at 07:49:12AM +0700, Duy Nguyen wrote:

> I got the message in the subject when pushing to github today. Yes I
> know it's github, not git. But according to stackoveflow [1] it's a
> local problem. Which makes me think, if we know exactly what this is
> (or at least roughly the problem area), maybe we could improve git to
> catch it locally in the first place (and because other git servers may
> not have the same protection as github).  Jeff maybe you can reveal
> something about this "fatal error in commit_refs"? I'm sure it's not
> in git code. But I would understand if the answer is "no".

The short answer is that it's nothing to do with Git or the client; it's
GitHub-specific code running on the server that is outside of Git
entirely.

The long answer is that pushes to GitHub don't hit Git directly these
days. They hit a proxy layer that speaks just enough of the Git protocol
to relay to N separate receives spread across N replica servers[1]. Those
receive-packs take in the pack and verify it, but don't actually update
any refs[2]. Then the proxy layer runs its own set of policy hooks, and
speaks a commit-protocol to each of the replicas so that they all agree
on the new ref state. That last step is called "commit_refs" internally.

So this is really an internal failure at the ref-update stage. There
_should_ be a reasonable error message, but I think "fatal error in
commit_refs" is the generic last-ditch fallback. I'll pass this along to
people in charge of that code, as we should be generating a more useful
error message.

-Peff

[1] I glossed over a lot of details there. If you're interested:

    http://githubengineering.com/introducing-dgit/

    http://githubengineering.com/building-resilience-in-spokes/

[2] Initially the proxy just fed a set of temporary refs to
    receive-pack, and it was completely stock. These days we do have
    a trivial patch that skips the ref write. I haven't sent it upstream
    because it's useless by itself (but it's below for reference).

    I'm happy to polish it if somebody actually has a use for it.

---
 Documentation/config.txt        |  8 ++++++++
 builtin/receive-pack.c          | 13 +++++++++++--
 t/t9944-receive-pack-nowrite.sh | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)
 create mode 100755 t/t9944-receive-pack-nowrite.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f8e6484..38cc1ac 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2406,6 +2406,14 @@ receive.refUpdateNameLimit::
 	is a hard limit of 65520 bytes due to git's protocol, so this
 	value must be smaller than that.
 
+receive.writeRefs::
+	If set to `false`, `receive-pack` will perform all of the usual
+	ref consistency checks (checking for non-ff, etc), but _not_
+	actually write any ref changes to disk (nor even check that such
+	writes would succeed, as doing so atomically would require
+	taking individual ref locks to be of any value). The default is
+	`true`.
+
 remote.pushDefault::
 	The remote to push to by default.  Overrides
 	`branch.<name>.remote` for all branches, and is overridden by
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 94704e7..4a87365 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -87,6 +87,8 @@ static long nonce_stamp_slop;
 static unsigned long nonce_stamp_slop_limit;
 static struct ref_transaction *transaction;
 
+static int write_refs = 1;
+
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
 	if (value) {
@@ -244,6 +246,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.writerefs") == 0) {
+		write_refs = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -1060,7 +1067,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 				cmd->did_not_exist = 1;
 			}
 		}
-		if (ref_transaction_delete(transaction,
+		if (write_refs &&
+		    ref_transaction_delete(transaction,
 					   namespaced_name,
 					   old_sha1,
 					   flags, "push", &err)) {
@@ -1077,7 +1085,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		    update_shallow_ref(cmd, si))
 			return "shallow error";
 
-		if (ref_transaction_update(transaction,
+		if (write_refs &&
+		    ref_transaction_update(transaction,
 					   namespaced_name,
 					   new_sha1, old_sha1,
 					   flags, "push",
diff --git a/t/t9944-receive-pack-nowrite.sh b/t/t9944-receive-pack-nowrite.sh
new file mode 100755
index 0000000..7b27bc1
--- /dev/null
+++ b/t/t9944-receive-pack-nowrite.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='test no-write tweak to receive-pack'
+. ./test-lib.sh
+
+test_expect_success 'create a few commits' '
+	test_commit one &&
+	git update-ref refs/heads/a HEAD &&
+	test_commit two &&
+	git update-ref refs/heads/b HEAD &&
+	test_commit three &&
+	git update-ref refs/heads/c HEAD
+'
+
+# push just two; hold back "c" so we can push a creation later
+test_expect_success 'create destination repo' '
+	git init --bare dst.git &&
+	git for-each-ref refs/heads/a refs/heads/b >expect &&
+	git push dst.git a b &&
+	git -C dst.git for-each-ref >actual &&
+	test_cmp expect actual
+'
+
+# push an update, a deletion, and a creation
+test_expect_success 'push with no-write config set' '
+	git push --receive-pack="git -c \
+			receive.writeRefs=false \
+			receive-pack" \
+		dst.git b:a :b c:c
+'
+
+test_expect_success 'push did not touch real refs' '
+	git -C dst.git for-each-ref >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.10.0.rc2.154.gb4a4b8b

