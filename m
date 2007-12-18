From: Pascal Obry <pascal.obry@gmail.com>
Subject: [PATCH] Add format-patch option --no-name-prefix.
Date: Tue, 18 Dec 2007 16:42:54 +0100
Message-ID: <1197992574-3464-1-git-send-email-pascal@obry.net>
Cc: pascal@obry.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 16:43:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4ebQ-0000E8-4s
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 16:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757505AbXLRPnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 10:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758026AbXLRPnE
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 10:43:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:60307 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758025AbXLRPnD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 10:43:03 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1384933nfb.21
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 07:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:from;
        bh=R2sNUxoJpBb4E1YPv0S19cqyv4VE79bBv/FQ4kO68BM=;
        b=CzJ6mK9d4SpVDxB5ygThLwnnYIyIOCZdB3c32mgEpxzf8esBrVflpatjlhzN+b25oFk+7UaaAXrj/DLPDJLoJOrmxuoz2im7XTf3KBVPMULqba1ovKfKTqTyaybKVRT5XRR/M81aUZIistahnH8YLqg9x1iGKB8kMlnvu3HEt2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=yFTUovlVgmHz5FWcpKiLKG7TLdA3K9vvLLoV2Ymhf9JijB3rlQ11t/8lV2KbEzZhgCJGSZzdKd71FtKXYpO8UcLzcevO1hFQmUMRskBYciPdNickNX8RAtLKqBpTdSZtCoAYFyxiBHbV8BIH7qBA8P1t3Doo2ep7sRfOHqX70Cs=
Received: by 10.78.205.7 with SMTP id c7mr10486617hug.29.1197992580241;
        Tue, 18 Dec 2007 07:43:00 -0800 (PST)
Received: from pascal.obry@gmail.com ( [82.124.126.249])
        by mx.google.com with ESMTPS id w7sm2984253mue.2007.12.18.07.42.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Dec 2007 07:42:59 -0800 (PST)
Received: by pascal.obry@gmail.com (sSMTP sendmail emulation); Tue, 18 Dec 2007 16:42:54 +0100
X-Mailer: git-send-email 1.5.4.rc0.56.g6fbe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68764>

This option can be used to generate a patch file
where file names are relative to the Git root
directory. Such a patch can then be applied with
the standard patch tool using option -p0.

Signed-off-by: Pascal Obry <pascal@obry.net>
---
 Documentation/git-format-patch.txt |    6 +++++-
 builtin-log.c                      |    7 ++++++-
 diff.c                             |   10 ++++++++--
 diff.h                             |    1 +
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 6fb9429..5a642ad 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -15,7 +15,7 @@ SYNOPSIS
                    [-n | --numbered | -N | --no-numbered]
                    [--start-number <n>] [--numbered-files]
                    [--in-reply-to=Message-Id] [--suffix=.<sfx>]
-                   [--ignore-if-in-upstream]
+                   [--ignore-if-in-upstream] [--no-name-prefix]
                    [--subject-prefix=Subject-Prefix]
 		   [ <since> | <revision range> ]
 
@@ -90,6 +90,10 @@ include::diff-options.txt[]
 	without the default first line of the commit appended.
 	Mutually exclusive with the --stdout option.
 
+--no-name-prefix::
+	Generate a patch file that can be applied with a patch(1) -p0
+	from the Git root directory.
+
 -k|--keep-subject::
 	Do not strip/add '[PATCH]' from the first line of the
 	commit log message.
diff --git a/builtin-log.c b/builtin-log.c
index cc3cc90..36582bd 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -599,6 +599,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int subject_prefix = 0;
 	int ignore_if_in_upstream = 0;
 	int thread = 0;
+	int no_name_prefix = 0;
 	const char *in_reply_to = NULL;
 	struct patch_ids ids;
 	char *add_signoff = NULL;
@@ -636,6 +637,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		}
 		else if (!prefixcmp(argv[i], "--start-number="))
 			start_number = strtol(argv[i] + 15, NULL, 10);
+		else if (!prefixcmp(argv[i], "--no-name-prefix"))
+			no_name_prefix = 1;
 		else if (!strcmp(argv[i], "--numbered-files"))
 			numbered_files = 1;
 		else if (!strcmp(argv[i], "--start-number")) {
@@ -719,8 +722,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		die ("unrecognized argument: %s", argv[1]);
 
 	if (!rev.diffopt.output_format)
-		rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY | DIFF_FORMAT_PATCH;
+		rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY | DIFF_FORMAT_PATCH | DIFF_FORMAT_NAME_PREFIX;
 
+	if (no_name_prefix)
+		rev.diffopt.output_format &= ~DIFF_FORMAT_NAME_PREFIX;
 	if (!DIFF_OPT_TST(&rev.diffopt, TEXT))
 		DIFF_OPT_SET(&rev.diffopt, BINARY);
 
diff --git a/diff.c b/diff.c
index e26584c..f07d9c0 100644
--- a/diff.c
+++ b/diff.c
@@ -1212,8 +1212,14 @@ static void builtin_diff(const char *name_a,
 	const char *set = diff_get_color_opt(o, DIFF_METAINFO);
 	const char *reset = diff_get_color_opt(o, DIFF_RESET);
 
-	a_one = quote_two("a/", name_a + (*name_a == '/'));
-	b_two = quote_two("b/", name_b + (*name_b == '/'));
+	if (o->output_format & DIFF_FORMAT_NAME_PREFIX) {
+		a_one = quote_two("a/", name_a + (*name_a == '/'));
+		b_two = quote_two("b/", name_b + (*name_b == '/'));
+	}
+	else {
+		a_one = quote_two("", name_a + (*name_a == '/'));
+		b_two = quote_two("", name_b + (*name_b == '/'));
+	}
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
 	printf("%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
diff --git a/diff.h b/diff.h
index 7e8000a..86458a3 100644
--- a/diff.h
+++ b/diff.h
@@ -30,6 +30,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_FORMAT_SUMMARY	0x0008
 #define DIFF_FORMAT_PATCH	0x0010
 #define DIFF_FORMAT_SHORTSTAT	0x0020
+#define DIFF_FORMAT_NAME_PREFIX 0x0040
 
 /* These override all above */
 #define DIFF_FORMAT_NAME	0x0100
-- 
1.5.4.rc0.56.g6fbe
