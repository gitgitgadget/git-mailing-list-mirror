From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Subject: [PATCH master] expand "<branch>" in format.subjectprefix
Date: Wed, 13 Jan 2010 18:16:28 +0100
Message-ID: <1263402988-925-1-git-send-email-rep.dot.nop@gmail.com>
Cc: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 18:11:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV6kz-0006F3-B7
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 18:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756142Ab0AMRLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 12:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756120Ab0AMRLl
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 12:11:41 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:43555 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756088Ab0AMRLl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 12:11:41 -0500
Received: by bwz27 with SMTP id 27so2146238bwz.21
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 09:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=f2CO4yj39JT7IGwxbjAE6XL0j7uFSTk0WzVHD2j58LQ=;
        b=RKqXkPNt0WQ+Z2oRiG4xbhl9Yco9wyOj8Nr+09tJTxs2eKsa+Go+0dQpB7gM2GgNAo
         CyCWCPi/suf7s2G13DbRFNl6kJqO+/OGBNbhrHxKqYpSJ2nLAFTA9VinFg1Z5IT+VJ4Y
         75dxUJmZpgmkAbYVnbFum5AxkcOPDYZI0jQ/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=cNS4mvdpHi/WXuQ2r7NC/1FrH8Qo/SoA80sMUs7WC1chDVSUhh7o+cAZeXYaJIFivF
         ozM66IJXI+6XXfDYyDK8mQHEXgq6QmZKyUzHiD2btmlJ0rbP9umD4Mk2cZFVZq2IHRKX
         y29K/at+2zsjnrD6hBsC2YQR2by3T2w5+VFyw=
Received: by 10.204.34.75 with SMTP id k11mr196424bkd.195.1263402698669;
        Wed, 13 Jan 2010 09:11:38 -0800 (PST)
Received: from s42.loc (85-127-241-136.dynamic.xdsl-line.inode.at [85.127.241.136])
        by mx.google.com with ESMTPS id 15sm3744180bwz.8.2010.01.13.09.11.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Jan 2010 09:11:37 -0800 (PST)
Received: from cow by s42.loc with local (Exim 4.69)
	(envelope-from <rep.dot.nop@gmail.com>)
	id 1NV6pi-0000FW-T5; Wed, 13 Jan 2010 18:16:38 +0100
X-Mailer: git-send-email 1.6.6.103.gbcea0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136841>

Replace "<branch>" with the current branch name for
[format]
        subjectprefix = PATCH <branch>

A subject-prefix given on the command-line overrides the one given in
the config.

Previously this didn't work for me:
$ git config --replace-all format.subjectprefix 'PATCH <branch>'
# edit something, commit it
$ git format-patch -o ~/foo/ HEAD^..HEAD
and that patch still has "<branch>" in the subject, even when
send-email'ed.

A manual
$ git-format-patch -o ~/foo/ HEAD^..HEAD --subject-prefix="PATCH something"
works, but is not convenient since i usually want to denote which branch
the patch is against.

Signed-off-by: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
---
 builtin-log.c |   43 ++++++++++++++++++++++++++++++++++++++++---
 log-tree.c    |    6 +++---
 revision.h    |    2 +-
 3 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 41b6df4..d7624bf 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -31,6 +31,43 @@ static const char * const builtin_log_usage =
 	"git log [<options>] [<since>..<until>] [[--] <path>...]\n"
 	"   or: git show [options] <object>...";
 
+static const char* subst_subject_prefix(void)
+{
+	char *ch;
+
+	/* now expand <branch> */
+	if ((ch = strstr(fmt_patch_subject_prefix, "<branch>")) != NULL)
+	{
+		/* get_or_ask_branch_name(): */
+		struct branch *current_branch;
+		size_t len;
+		int a, b = ch - fmt_patch_subject_prefix;
+		char *branch_name, *new_subject;
+
+		current_branch = branch_get(NULL);
+		if (!current_branch || !current_branch->merge
+				|| !current_branch->merge[0]
+				|| !current_branch->merge[0]->dst) {
+			branch_name = "(no branch)";
+		} else {
+			branch_name = current_branch->merge[0]->dst;
+			ch = strrchr(branch_name, '/');
+			if (ch)
+				branch_name = ++ch;
+		}
+		len = strlen(branch_name);
+		a = strlen(fmt_patch_subject_prefix) - b - strlen("<branch>");
+		new_subject = xcalloc(1, 1 + b + len + a);
+		memcpy(new_subject, fmt_patch_subject_prefix, b);
+		memcpy(new_subject + b, branch_name, len);
+		memcpy(new_subject + b + len,
+			fmt_patch_subject_prefix + b + strlen("<branch>"),
+			a);
+		*&fmt_patch_subject_prefix = new_subject;
+	}
+	return fmt_patch_subject_prefix;
+}
+
 static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		      struct rev_info *rev)
 {
@@ -44,7 +81,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	rev->verbose_header = 1;
 	DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
 	rev->show_root_diff = default_show_root;
-	rev->subject_prefix = fmt_patch_subject_prefix;
+	rev->subject_prefix = &subst_subject_prefix;
 	DIFF_OPT_SET(&rev->diffopt, ALLOW_TEXTCONV);
 
 	if (default_date_mode)
@@ -795,7 +832,7 @@ static int subject_prefix_callback(const struct option *opt, const char *arg,
 			    int unset)
 {
 	subject_prefix = 1;
-	((struct rev_info *)opt->value)->subject_prefix = arg;
+	*&fmt_patch_subject_prefix = arg;
 	return 0;
 }
 
@@ -962,7 +999,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.ignore_merges = 1;
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
 
-	rev.subject_prefix = fmt_patch_subject_prefix;
+	rev.subject_prefix = &subst_subject_prefix;
 
 	if (default_attach) {
 		rev.mime_boundary = default_attach;
diff --git a/log-tree.c b/log-tree.c
index 0fdf159..e29f009 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -203,15 +203,15 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		static char buffer[64];
 		snprintf(buffer, sizeof(buffer),
 			 "Subject: [%s %0*d/%d] ",
-			 opt->subject_prefix,
+			 opt->subject_prefix(),
 			 digits_in_number(opt->total),
 			 opt->nr, opt->total);
 		subject = buffer;
-	} else if (opt->total == 0 && opt->subject_prefix && *opt->subject_prefix) {
+	} else if (opt->total == 0 && opt->subject_prefix()) {
 		static char buffer[256];
 		snprintf(buffer, sizeof(buffer),
 			 "Subject: [%s] ",
-			 opt->subject_prefix);
+			 opt->subject_prefix());
 		subject = buffer;
 	} else {
 		subject = "Subject: ";
diff --git a/revision.h b/revision.h
index d368003..ca45c57 100644
--- a/revision.h
+++ b/revision.h
@@ -100,7 +100,7 @@ struct rev_info {
 	const char	*add_signoff;
 	const char	*extra_headers;
 	const char	*log_reencode;
-	const char	*subject_prefix;
+	const char	*(*subject_prefix)(void);
 	int		no_inline;
 	int		show_log_size;
 
-- 
1.6.6.103.gbcea0.dirty
