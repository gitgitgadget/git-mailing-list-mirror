Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CF77206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 19:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752760AbcLLTyA (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 14:54:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:55327 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752456AbcLLTx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 14:53:59 -0500
Received: (qmail 1771 invoked by uid 109); 12 Dec 2016 19:53:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Dec 2016 19:53:59 +0000
Received: (qmail 8867 invoked by uid 111); 12 Dec 2016 19:54:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Dec 2016 14:54:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2016 14:53:55 -0500
Date:   Mon, 12 Dec 2016 14:53:55 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Klaus Ethgen <Klaus@Ethgen.ch>,
        git@vger.kernel.org
Subject: [PATCH 2/2] tmp-objdir: quote paths we add to alternates
Message-ID: <20161212195355.znqlu44lgnke3ltc@sigill.intra.peff.net>
References: <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 722ff7f87 (receive-pack: quarantine objects until
pre-receive accepts, 2016-10-03) regressed pushes to
repositories with colon (or semi-colon in Windows in them)
because it adds the repository's main object directory to
GIT_ALTERNATE_OBJECT_DIRECTORIES. The receiver interprets
the colon as a delimiter, not as part of the path, and
index-pack is unable to find objects which it needs to
resolve deltas.

The previous commit introduced a quoting mechanism for the
alternates list; let's use it here to cover this case. We'll
avoid quoting when we can, though. This alternate setup is
also used when calling hooks, so it's possible that the user
may call older git implementations which don't understand
the quoting mechanism. By quoting only when necessary, this
setup will continue to work unless the user _also_ has a
repository whose path contains the delimiter.

Signed-off-by: Jeff King <peff@peff.net>
---
Johannes, please let me know if I am wrong about skipping the test on
!MINGW. The appropriate check there would be ";" anyway, but I am not
sure _that_ is allowed in paths, either.

 t/t5547-push-quarantine.sh | 19 +++++++++++++++++++
 tmp-objdir.c               | 18 +++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
index 1e5d32d06..6275ec807 100755
--- a/t/t5547-push-quarantine.sh
+++ b/t/t5547-push-quarantine.sh
@@ -33,4 +33,23 @@ test_expect_success 'rejected objects are removed' '
 	test_cmp expect actual
 '
 
+# MINGW does not allow colons in pathnames in the first place
+test_expect_success !MINGW 'push to repo path with colon' '
+	# The interesting failure case here is when the
+	# receiving end cannot access its original object directory,
+	# so make it likely for us to generate a delta by having
+	# a non-trivial file with multiple versions.
+
+	test-genrandom foo 4096 >file.bin &&
+	git add file.bin &&
+	git commit -m bin &&
+	git clone --bare . xxx:yyy.git &&
+
+	echo change >>file.bin &&
+	git commit -am change &&
+	# Note that we have to use the full path here, or it gets confused
+	# with the ssh host:path syntax.
+	git push "$PWD/xxx:yyy.git" HEAD
+'
+
 test_done
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 64435f23a..b2d9280f1 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -5,6 +5,7 @@
 #include "string-list.h"
 #include "strbuf.h"
 #include "argv-array.h"
+#include "quote.h"
 
 struct tmp_objdir {
 	struct strbuf path;
@@ -79,12 +80,27 @@ static void remove_tmp_objdir_on_signal(int signo)
  */
 static void env_append(struct argv_array *env, const char *key, const char *val)
 {
-	const char *old = getenv(key);
+	struct strbuf quoted = STRBUF_INIT;
+	const char *old;
 
+	/*
+	 * Avoid quoting if it's not necessary, for maximum compatibility
+	 * with older parsers which don't understand the quoting.
+	 */
+	if (*val == '"' || strchr(val, PATH_SEP)) {
+		strbuf_addch(&quoted, '"');
+		quote_c_style(val, &quoted, NULL, 1);
+		strbuf_addch(&quoted, '"');
+		val = quoted.buf;
+	}
+
+	old = getenv(key);
 	if (!old)
 		argv_array_pushf(env, "%s=%s", key, val);
 	else
 		argv_array_pushf(env, "%s=%s%c%s", key, old, PATH_SEP, val);
+
+	strbuf_release(&quoted);
 }
 
 static void env_replace(struct argv_array *env, const char *key, const char *val)
-- 
2.11.0.203.g6657065
