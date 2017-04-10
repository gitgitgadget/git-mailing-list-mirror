Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96C8020960
	for <e@80x24.org>; Mon, 10 Apr 2017 22:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752830AbdDJWOP (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 18:14:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:59493 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752173AbdDJWOP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 18:14:15 -0400
Received: (qmail 29780 invoked by uid 109); 10 Apr 2017 22:14:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 22:14:14 +0000
Received: (qmail 29413 invoked by uid 111); 10 Apr 2017 22:14:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 18:14:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Apr 2017 18:14:12 -0400
Date:   Mon, 10 Apr 2017 18:14:12 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/3] refs: reject ref updates while GIT_QUARANTINE_PATH is set
Message-ID: <20170410221412.3rxmkwgofc6aqi54@sigill.intra.peff.net>
References: <20170410221058.2ao64wedg2pa6uc2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170410221058.2ao64wedg2pa6uc2@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As documented in git-receive-pack(1), updating a ref from
within the pre-receive hook is dangerous and can corrupt
your repo. This patch forbids ref updates entirely during
the hook to make it harder for adventurous hook writers to
shoot themselves in the foot.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-receive-pack.txt |  3 ++-
 refs.c                             |  6 ++++++
 t/t5547-push-quarantine.sh         | 11 +++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 7267ecfbe..86a4b32f0 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -239,7 +239,8 @@ This has a few user-visible effects and caveats:
   3. The `pre-receive` hook MUST NOT update any refs to point to
      quarantined objects. Other programs accessing the repository will
      not be able to see the objects (and if the pre-receive hook fails,
-     those refs would become corrupted).
+     those refs would become corrupted). For safety, any ref updates
+     from within `pre-receive` are automatically rejected.
 
 
 SEE ALSO
diff --git a/refs.c b/refs.c
index 0272e332c..62b405d0b 100644
--- a/refs.c
+++ b/refs.c
@@ -1516,6 +1516,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 {
 	struct ref_store *refs = get_ref_store(NULL);
 
+	if (getenv(GIT_QUARANTINE_ENVIRONMENT)) {
+		strbuf_addstr(err,
+			      _("ref updates forbidden inside quarantine environment"));
+		return -1;
+	}
+
 	return refs->be->transaction_commit(refs, transaction, err);
 }
 
diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
index af9fcd833..113c87007 100755
--- a/t/t5547-push-quarantine.sh
+++ b/t/t5547-push-quarantine.sh
@@ -58,4 +58,15 @@ test_expect_success 'push to repo path with path separator (colon)' '
 	git push "$(pwd)/xxx${pathsep}yyy.git" HEAD
 '
 
+test_expect_success 'updating a ref from quarantine is forbidden' '
+	git init --bare update.git &&
+	write_script update.git/hooks/pre-receive <<-\EOF &&
+	read old new refname
+	git update-ref refs/heads/unrelated $new
+	exit 1
+	EOF
+	test_must_fail git push update.git HEAD &&
+	git -C update.git fsck
+'
+
 test_done
-- 
2.12.2.952.g759391acc
