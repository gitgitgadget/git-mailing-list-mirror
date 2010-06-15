From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 1/2] format-patch: Add a signature option (--signature)
Date: Mon, 14 Jun 2010 22:00:38 -0700
Message-ID: <1276578039-25023-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 15 07:00:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOOGY-0001xv-52
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 07:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566Ab0FOFAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 01:00:44 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59474 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab0FOFAn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 01:00:43 -0400
Received: by vws13 with SMTP id 13so735784vws.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 22:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=iMz2dttK/nktIvGfB5XTPBCw60IfJJ2Xn8Z3feeALRg=;
        b=wOTA0iyelgUm+Z/lrvBNd51isXD4ACzk9L3EJa44727YmkKD3Qo9F8aYge4daLLRDf
         3Pb3DJjQ2QxvfDnWRMM7YZv03MB56vefqPgUywdd5jOKVYhEiSBgEKWQJHd79lJDxJPZ
         2feYwatm22wMOmyUhhix1Wmk6whLqa8yd58Pg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=sdFlsLuGreKtV6j5+MGQ0ragalPASZmwMtL94zw7xBakHeVsPQ+mY9+bI8NKlYo0pq
         bI2psvm1gU1zX+RDdTAVYPbZEBCViyIoRCaVqoBGBfLXa8TRG35JkA0v65q8PKq56yXc
         FxHPJT41Aq125bDBPoegp+XoWvwa636m8IPCs=
Received: by 10.229.185.1 with SMTP id cm1mr2874758qcb.57.1276578042535;
        Mon, 14 Jun 2010 22:00:42 -0700 (PDT)
Received: from localhost ([24.152.169.138])
        by mx.google.com with ESMTPS id j28sm17289397qck.10.2010.06.14.22.00.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 22:00:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.257.g678728
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149158>

By default, git uses the version string as the signature for all
patches output by format-patch. Many employers (mine included)
require the use of a signature on all outgoing mails. In a
format-patch | send-email workflow there isn't an easy way to modify
the signature without breaking the pipe and manually replacing the
version string with the signature required. Instead of doing all that
work, add an option (--signature) and a config variable
(format.signature) to replace the default git version signature when
formatting patches.

This does modify the original behavior of format-patch a bit. First
off the version string is now placed in the cover letter by default.
Secondly, once the configuration variable format.signature is added
to the .config file there is no way to revert back to the default
git version signature. Instead, specifying the --no-signature option
will remove the signature from the patches entirely.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

I didn't cover the attachment case since there wasn't a signature there
before. Maybe later.

 Documentation/config.txt                           |    5 +++
 Documentation/git-format-patch.txt                 |    8 ++++-
 builtin/log.c                                      |   18 ++++++++--
 ...tch_--stdout_--cover-letter_-n_initial..master^ |    3 ++
 t/t4014-format-patch.sh                            |   35 ++++++++++++++++++++
 5 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 95cf73c..28379cc 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -880,6 +880,11 @@ format.subjectprefix::
 	The default for format-patch is to output files with the '[PATCH]'
 	subject prefix. Use this variable to change that prefix.
 
+format.signature::
+	The default for format-patch is to output a signature containing
+	the git version number. Use this variable to change the default
+	signature.
+
 format.suffix::
 	The default for format-patch is to output files with the suffix
 	`.patch`. Use this variable to change that suffix (make sure to
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 835fb71..9a1b1d0 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git format-patch' [-k] [(-o|--output-directory) <dir> | --stdout]
 		   [--no-thread | --thread[=<style>]]
 		   [(--attach|--inline)[=<boundary>] | --no-attach]
-		   [-s | --signoff]
+		   [-s | --signoff] [--signature=<signature>]
 		   [-n | --numbered | -N | --no-numbered]
 		   [--start-number <n>] [--numbered-files]
 		   [--in-reply-to=Message-Id] [--suffix=.<sfx>]
@@ -180,6 +180,12 @@ will want to ensure that threading is disabled for `git send-email`.
 	containing the shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
 
+--signature=<signature>::
+	Add a signature to each patch and, if --cover-letter is specified,
+	the cover letter. Per RFC 3676 the signature is separated from the
+	body by '-- '. If no signature option is given, the signature defaults
+	to the git version number.
+
 --suffix=.<sfx>::
 	Instead of using `.patch` as the suffix for generated
 	filenames, use specified suffix.  A common alternative is
diff --git a/builtin/log.c b/builtin/log.c
index 976e16f..b78027e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -549,8 +549,9 @@ static void add_header(const char *value)
 
 #define THREAD_SHALLOW 1
 #define THREAD_DEEP 2
-static int thread = 0;
-static int do_signoff = 0;
+static int thread;
+static int do_signoff;
+static const char *signature = git_version_string;
 
 static int git_format_config(const char *var, const char *value, void *cb)
 {
@@ -609,6 +610,8 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		do_signoff = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "format.signature"))
+		return git_config_string(&signature, var, value);
 
 	return git_log_config(var, value, cb);
 }
@@ -703,6 +706,12 @@ static void gen_message_id(struct rev_info *info, char *base)
 	info->message_id = strbuf_detach(&buf, NULL);
 }
 
+static void print_signature(void)
+{
+	if (signature)
+		printf("-- \n%s\n\n", signature);
+}
+
 static void make_cover_letter(struct rev_info *rev, int use_stdout,
 			      int numbered, int numbered_files,
 			      struct commit *origin,
@@ -796,6 +805,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	diff_flush(&opts);
 
 	printf("\n");
+	print_signature();
 }
 
 static const char *clean_message_id(const char *msg_id)
@@ -1035,6 +1045,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 0, "thread", &thread, "style",
 			    "enable message threading, styles: shallow, deep",
 			    PARSE_OPT_OPTARG, thread_callback },
+		OPT_STRING(0, "signature", &signature, "signature",
+			    "add a signature"),
 		OPT_END()
 	};
 
@@ -1313,7 +1325,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 				       mime_boundary_leader,
 				       rev.mime_boundary);
 			else
-				printf("-- \n%s\n\n", git_version_string);
+				print_signature();
 		}
 		if (!use_stdout)
 			fclose(stdout);
diff --git a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
index 8dab4bf..1f0f9ad 100644
--- a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
+++ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
@@ -18,6 +18,9 @@ A U Thor (2):
  create mode 100644 file1
  delete mode 100644 file2
 
+-- 
+g-i-t--v-e-r-s-i-o-n
+
 From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
 From: A U Thor <author@example.com>
 Date: Mon, 26 Jun 2006 00:01:00 +0000
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index d21c37f..06c481f 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -613,4 +613,39 @@ test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
 	git format-patch --ignore-if-in-upstream HEAD
 '
 
+test_expect_success 'format-patch --signature' '
+	git format-patch --stdout --signature="my sig" -1 >output &&
+	grep "my sig" output
+'
+
+test_expect_success 'format-patch with format.signature config' '
+	git config format.signature "config sig" &&
+	git format-patch --stdout -1 >output &&
+	grep "config sig" output
+'
+
+test_expect_success 'format-patch --signature overrides format.signature' '
+	git config format.signature "config sig" &&
+	git format-patch --stdout --signature="overrides" -1 >output &&
+	! grep "config sig" output &&
+	grep "overrides" output
+'
+
+test_expect_success 'format-patch --no-signature ignores format.signature' '
+	git config format.signature "config sig" &&
+	git format-patch --stdout --signature="my sig" --no-signature \
+		-1 >output &&
+	! grep "config sig" output &&
+	! grep "my sig" output &&
+	! grep "^-- \$" output
+'
+
+test_expect_success 'format-patch --signature --cover-letter' '
+	git config --unset-all format.signature &&
+	git format-patch --stdout --signature="my sig" --cover-letter \
+		-1 >output &&
+	grep "my sig" output &&
+	test 2 = $(grep "my sig" output | wc -l)
+'
+
 test_done
-- 
1.7.1.257.g678728
