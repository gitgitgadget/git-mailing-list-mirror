Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F05C6FA8B
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 05:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiIVFdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 01:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiIVFdi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 01:33:38 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1DAB276C
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 22:33:31 -0700 (PDT)
Received: (qmail 4704 invoked by uid 109); 22 Sep 2022 05:33:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Sep 2022 05:33:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30473 invoked by uid 111); 22 Sep 2022 05:33:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Sep 2022 01:33:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 22 Sep 2022 01:33:29 -0400
From:   Jeff King <peff@peff.net>
To:     "John A. Leuenhagen" <john@zlima12.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 2/2] remote: handle rename of remote without fetch refspec
Message-ID: <YyvzqZ5tmI0UdRAW@coredump.intra.peff.net>
References: <YyvzIQL9H9aTYNch@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YyvzIQL9H9aTYNch@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We return an error when trying to rename a remote that has no fetch
refspec:

  $ git config --unset-all remote.origin.fetch
  $ git remote rename origin foo
  fatal: could not unset 'remote.foo.fetch'

To make things even more confusing, we actually _do_ complete the config
modification, via git_config_rename_section(). After that we try to
rewrite the fetch refspec (to say refs/remotes/foo instead of origin).
But our call to git_config_set_multivar() to remove the existing entries
fails, since there aren't any, and it calls die().

We could fix this by using the "gently" form of the config call, and
checking the error code. But there is an even simpler fix: if we know
that there are no refspecs to rewrite, then we can skip that part
entirely.

Reported-by: John A. Leuenhagen <john@zlima12.com>
Signed-off-by: Jeff King <peff@peff.net>
---
The diff is a bit noisy due to indentation, but with "-w" you can see
that it's just wrapping this part of the function in a conditional.

 builtin/remote.c  | 48 ++++++++++++++++++++++++-----------------------
 t/t5505-remote.sh | 11 +++++++++++
 2 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 985b845a18..910f7b9316 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -733,29 +733,31 @@ static int mv(int argc, const char **argv, const char *prefix)
 		return error(_("Could not rename config section '%s' to '%s'"),
 				buf.buf, buf2.buf);
 
-	strbuf_reset(&buf);
-	strbuf_addf(&buf, "remote.%s.fetch", rename.new_name);
-	git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
-	strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old_name);
-	for (i = 0; i < oldremote->fetch.raw_nr; i++) {
-		char *ptr;
-
-		strbuf_reset(&buf2);
-		strbuf_addstr(&buf2, oldremote->fetch.raw[i]);
-		ptr = strstr(buf2.buf, old_remote_context.buf);
-		if (ptr) {
-			refspec_updated = 1;
-			strbuf_splice(&buf2,
-				      ptr-buf2.buf + strlen(":refs/remotes/"),
-				      strlen(rename.old_name), rename.new_name,
-				      strlen(rename.new_name));
-		} else
-			warning(_("Not updating non-default fetch refspec\n"
-				  "\t%s\n"
-				  "\tPlease update the configuration manually if necessary."),
-				buf2.buf);
-
-		git_config_set_multivar(buf.buf, buf2.buf, "^$", 0);
+	if (oldremote->fetch.raw_nr) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "remote.%s.fetch", rename.new_name);
+		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
+		strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old_name);
+		for (i = 0; i < oldremote->fetch.raw_nr; i++) {
+			char *ptr;
+
+			strbuf_reset(&buf2);
+			strbuf_addstr(&buf2, oldremote->fetch.raw[i]);
+			ptr = strstr(buf2.buf, old_remote_context.buf);
+			if (ptr) {
+				refspec_updated = 1;
+				strbuf_splice(&buf2,
+					      ptr-buf2.buf + strlen(":refs/remotes/"),
+					      strlen(rename.old_name), rename.new_name,
+					      strlen(rename.new_name));
+			} else
+				warning(_("Not updating non-default fetch refspec\n"
+					  "\t%s\n"
+					  "\tPlease update the configuration manually if necessary."),
+					buf2.buf);
+
+			git_config_set_multivar(buf.buf, buf2.buf, "^$", 0);
+		}
 	}
 
 	read_branches();
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 9006196ac6..43b7bcd715 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -902,6 +902,17 @@ test_expect_success 'rename a remote renames repo remote.pushDefault but keeps g
 	)
 '
 
+test_expect_success 'rename handles remote without fetch refspec' '
+	git clone --bare one no-refspec.git &&
+	# confirm assumption that bare clone does not create refspec
+	test_expect_code 5 \
+		git -C no-refspec.git config --unset-all remote.origin.fetch &&
+	git -C no-refspec.git config remote.origin.url >expect &&
+	git -C no-refspec.git remote rename origin foo &&
+	git -C no-refspec.git config remote.foo.url >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'rename does not update a non-default fetch refspec' '
 	git clone one four.one &&
 	(
-- 
2.38.0.rc1.580.gfaa349ad1e
