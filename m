From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 15/15] clone: Ensure sparse limiting arguments are used in subsequent operations
Date: Sat,  4 Sep 2010 18:14:07 -0600
Message-ID: <1283645647-1891-16-git-send-email-newren@gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
Cc: pclouds@gmail.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 02:13:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os2rj-0008IQ-I6
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 02:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622Ab0IEANi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 20:13:38 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:65512 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613Ab0IEANc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 20:13:32 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so647396pwi.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 17:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=nvCW3XWjyZdQfHAaMixX+zEItO/7ePYiqfvpiP6YJDs=;
        b=dHh2w+tkDnx8WRWPmCwZ79ahXHxINSsb9l9oIv0q7DDOrPNL8z2RBE0cKQtlH0//JF
         k39dzMKK2SZ3O3a/yqy5l+AoKIh+SwqBaXwA97HK8a2axWBKtYjF/RjA04yruahn9Lr9
         Vg67Bvfl6TkJWlyqLM53kreygZZEBryq11UN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WwwXOOf4aN+YELmS2HwcizT4s7L5aY1JtBxSIYfQfAssY4sebEICC7WAx2hARHSP4C
         rXsQJYKXi+j2XNhm5bia4dgu2VH9oGEqzKhTZ8FpvWk/2FKzN/VlI7Rc0I9xbffDJwu8
         eB5TLdumI1EXTAZTr+YWW1u+C5HSfH07OdCts=
Received: by 10.114.120.17 with SMTP id s17mr901836wac.87.1283645612542;
        Sat, 04 Sep 2010 17:13:32 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 33sm7341833wad.18.2010.09.04.17.13.30
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 17:13:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.140.gd06af
In-Reply-To: <1283645647-1891-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155401>

After fetching, register sparse args for subsequent checkout portion of
clone, and record sparse args for any later commands run in the clone.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clone.c                            |   17 +++++++++++++----
 t/t5721-sparse-repository-communication.sh |    4 ++--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5c0f594..4f55ab0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -24,6 +24,7 @@
 #include "remote.h"
 #include "run-command.h"
 #include "quote.h"
+#include "sparse-repo.h"
 
 /*
  * Overall FIXMEs:
@@ -370,7 +371,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	const struct ref *refs, *remote_head;
 	const struct ref *remote_head_points_at;
 	const struct ref *our_head_points_at;
-	struct ref *mapped_refs;
+	struct ref *mapped_refs = NULL;
 	struct strbuf key = STRBUF_INIT, value = STRBUF_INIT;
 	struct strbuf branch_top = STRBUF_INIT, reflog_msg = STRBUF_INIT;
 	struct transport *transport = NULL;
@@ -519,9 +520,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_reset(&value);
 
 	if (is_local) {
+		if (argc > rest_argc)
+			die("Sparse clones of local repositories must be done using the file:// protocol.");
 		refs = clone_local(path, git_dir);
 		mapped_refs = wanted_peer_refs(refs, refspec);
 	} else {
+		struct strbuf quoted_sparse_args = STRBUF_INIT;
 		struct remote *remote = remote_get(option_origin);
 		transport = transport_get(remote, remote->url[0]);
 
@@ -541,12 +545,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					     option_upload_pack);
 
 		if (argc > rest_argc) {
-			struct strbuf buf = STRBUF_INIT;
 			int ret;
 
-			sq_quote_argv(&buf, &argv[rest_argc], 0);
+			sq_quote_argv(&quoted_sparse_args, &argv[rest_argc], 0);
 			ret = transport_set_option(transport, TRANS_OPT_REVLIST_ARGS,
-						   strbuf_detach(&buf, NULL));
+						   quoted_sparse_args.buf);
 			if (ret)
 				warning ("Sparse clone not supported!\n");
 		}
@@ -556,6 +559,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			mapped_refs = wanted_peer_refs(refs, refspec);
 			transport_fetch_refs(transport, mapped_refs);
 		}
+
+		if (argc > rest_argc) {
+			register_sparse_limits(&argv[rest_argc]);
+			record_sparse_limits(quoted_sparse_args.buf);
+		}
+		strbuf_release(&quoted_sparse_args);
 	}
 
 	if (refs) {
diff --git a/t/t5721-sparse-repository-communication.sh b/t/t5721-sparse-repository-communication.sh
index 35cb6a2..61ce8c6 100755
--- a/t/t5721-sparse-repository-communication.sh
+++ b/t/t5721-sparse-repository-communication.sh
@@ -52,7 +52,7 @@ test_expect_success 'make comparison sparse repository' '
 	)
 '
 
-test_expect_failure 'basic sparse clone succeeds' '
+test_expect_success 'basic sparse clone succeeds' '
 	rm -fr dst &&
 	git clone "file://$(pwd)/src" dst -- sub/b/ &&
 	(
@@ -82,7 +82,7 @@ test_expect_failure 'basic sparse clone succeeds' '
 	)
 '
 
-test_expect_failure 'basic sparse clone guts match expectations' '
+test_expect_success 'basic sparse clone guts match expectations' '
 	(
 		# Loose objects only, to facilitate comparison
 		cd dst &&
-- 
1.7.2.2.140.gd06af
