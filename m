From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 11/15] builtin-clone: Accept paths for sparse clone
Date: Sat,  4 Sep 2010 18:14:03 -0600
Message-ID: <1283645647-1891-12-git-send-email-newren@gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
Cc: pclouds@gmail.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 02:13:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os2rg-0008IQ-Tp
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 02:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586Ab0IEANX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 20:13:23 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:65512 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754574Ab0IEANW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 20:13:22 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so647396pwi.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 17:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MiiOkg3TxAxAoFe/tDlnyLnVaoOlqubFld8CChgpTB8=;
        b=hSn6zNZlyOgxLKPvtObd6VH1OVW3ewCvgtC7NlO/AXlsRvvb+l+1yubEM28BRGst2N
         BdVdPlDCsUVhzI3TW3ayXpqP6OHIHqOnuGF5e7g85x2USLw21evNJGX5Ch12PXkhrRJV
         kVUsvfXmkd8xAXLwq5qzasL8qGCignExKsyyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gN3rUeqGK49sR5CUpt6N7AABxYCQX/yaRIP/KyfLqJWw0yA4jiwXIDkIbhD/H+r8KG
         agDYqUUc1Lby9rghAOA0irPNZNNLJgW7nLuQ8fQ9C/EgbY2POsPorjC9VyOCap6q9IrL
         j7bFBttR4w+F9c17Lx0nzLldyLCATVeLCCBmM=
Received: by 10.114.125.12 with SMTP id x12mr1361283wac.91.1283645601662;
        Sat, 04 Sep 2010 17:13:21 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 33sm7341833wad.18.2010.09.04.17.13.19
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 17:13:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.140.gd06af
In-Reply-To: <1283645647-1891-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155394>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clone.c  |   28 ++++++++++++++++++++--------
 t/t5601-clone.sh |   14 --------------
 transport.h      |    3 +++
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 19ed640..de0fb66 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -23,6 +23,7 @@
 #include "branch.h"
 #include "remote.h"
 #include "run-command.h"
+#include "quote.h"
 
 /*
  * Overall FIXMEs:
@@ -33,7 +34,7 @@
  *
  */
 static const char * const builtin_clone_usage[] = {
-	"git clone [options] [--] <repo> [<dir>]",
+	"git clone [options] [--] <repo> [<dir>] [-- PATH1 PATH2...]",
 	NULL
 };
 
@@ -375,6 +376,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct transport *transport = NULL;
 	char *src_ref_prefix = "refs/heads/";
 	int err = 0;
+	int rest_argc = 0;
 
 	struct refspec *refspec;
 	const char *fetch_pattern;
@@ -382,11 +384,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	junk_pid = getpid();
 
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
-			     builtin_clone_usage, 0);
-
-	if (argc > 2)
-		usage_msg_opt("Too many arguments.",
-			builtin_clone_usage, builtin_clone_options);
+			     builtin_clone_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (argc == 0)
 		usage_msg_opt("You must specify a repository to clone.",
@@ -418,10 +416,13 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (is_local && option_depth)
 		warning("--depth is ignored in local clones; use file:// instead.");
 
-	if (argc == 2)
+	if (argc >= 2 && strcmp(argv[1], "--") != 0) {
 		dir = xstrdup(argv[1]);
-	else
+		rest_argc = 2;
+	} else {
 		dir = guess_dir_name(repo_name, is_bundle, option_bare);
+		rest_argc = 1;
+	}
 	strip_trailing_slashes(dir);
 
 	dest_exists = !stat(dir, &buf);
@@ -539,6 +540,17 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			transport_set_option(transport, TRANS_OPT_UPLOADPACK,
 					     option_upload_pack);
 
+		if (argc > rest_argc) {
+			struct strbuf buf = STRBUF_INIT;
+			int ret;
+
+			sq_quote_argv(&buf, &argv[rest_argc], 0);
+			ret = transport_set_option(transport, TRANS_OPT_SPARSE,
+						   strbuf_detach(&buf, NULL));
+			if (ret)
+				warning ("Sparse clone not supported!\n");
+		}
+
 		refs = transport_get_remote_refs(transport);
 		if (refs) {
 			mapped_refs = wanted_peer_refs(refs, refspec);
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 987e0c8..17c6a30 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -17,20 +17,6 @@ test_expect_success setup '
 
 '
 
-test_expect_success 'clone with excess parameters (1)' '
-
-	rm -fr dst &&
-	test_must_fail git clone -n src dst junk
-
-'
-
-test_expect_success 'clone with excess parameters (2)' '
-
-	rm -fr dst &&
-	test_must_fail git clone -n "file://$(pwd)/src" dst junk
-
-'
-
 test_expect_success 'output from clone' '
 	rm -fr dst &&
 	git clone -n "file://$(pwd)/src" dst >output &&
diff --git a/transport.h b/transport.h
index e803c0e..41e347a 100644
--- a/transport.h
+++ b/transport.h
@@ -127,6 +127,9 @@ struct transport *transport_get(struct remote *, const char *);
 /* Aggressively fetch annotated tags if possible */
 #define TRANS_OPT_FOLLOWTAGS "followtags"
 
+/* Fetch only certain paths */
+#define TRANS_OPT_SPARSE "sparse"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
-- 
1.7.2.2.140.gd06af
