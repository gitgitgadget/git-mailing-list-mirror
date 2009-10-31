From: Erick Mattos <erick.mattos@gmail.com>
Subject: [PATCH] commit -c/-C/--amend: take over authorship and restamp time with --claim
Date: Sat, 31 Oct 2009 01:08:00 -0200
Message-ID: <1256958480-6775-1-git-send-email-erick.mattos@gmail.com>
Cc: git@vger.kernel.org, Erick Mattos <erick.mattos@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 04:08:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N44KU-0004Vc-4B
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 04:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757669AbZJaDIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 23:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933093AbZJaDIN
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 23:08:13 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:38121 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757664AbZJaDIM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 23:08:12 -0400
Received: by yxe17 with SMTP id 17so3259959yxe.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 20:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=BNLR7k+i3iYhNbqRTUyTt+d4UQWeES8k+VWflSY23KU=;
        b=QrNjspH/EOMKjZ0uLlgLYA+hWUOiLVg2kfVoaOqbLai4zADsrch1Wsg3SI/Jb50cQq
         /1LMqOTM+ddX5pd7lrTkIlmH0LmQWn3xKB+VJwNXIEb68s9BgvM+Wq1NPQZFFZx57huW
         zyqh2Om0iShTQzACILzuL+EkEEhVjU2KQ41OA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=HgpeALf+EMkf52oJW0nvGYnzkneKGqbhHEsoSR9B3PAng9d1CRWheQ2j8FuiBwasr6
         l7lOoUI8Nejc0lItFY7HvaZUf/hgZaPJ3Uctwckx+7crQ1CU4Ht8kIiHHLF64qKdgyQA
         0jPme4uMXsq2oBqASTguVynlNEGFSvUJivu+Y=
Received: by 10.150.87.1 with SMTP id k1mr4413358ybb.11.1256958496984;
        Fri, 30 Oct 2009 20:08:16 -0700 (PDT)
Received: from localhost.localdomain ([187.15.77.118])
        by mx.google.com with ESMTPS id 22sm1318761ywh.45.2009.10.30.20.08.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 20:08:16 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.102.g0a733
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131828>

When we use one of the options above we are normally trying to do mainly
two things: one is using the source as a template and second is to
recreate a commit with corrections.

When they are used, the authorship and timestamp recorded in the newly
created commit is always taken from the original commit.  And they
should not when we are using it as a template.

The new --claim option is meant to solve this need by regenerating the
timestamp and setting as new author the committer or the one specified
on --author option.

Signed-off-by: Erick Mattos <erick.mattos@gmail.com>
---
 Documentation/git-commit.txt |   10 +++++++---
 builtin-commit.c             |    7 ++++---
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0578a40..96248ab 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dry-run]
-	   [(-c | -C) <commit>] [-F <file> | -m <msg>]
+	   [(-c | -C) <commit>] [-F <file> | -m <msg>] [--claim]
 	   [--allow-empty] [--no-verify] [-e] [--author=<author>]
 	   [--cleanup=<mode>] [--] [[-i | -o ]<file>...]
 
@@ -61,14 +61,18 @@ OPTIONS
 -C <commit>::
 --reuse-message=<commit>::
 	Take an existing commit object, and reuse the log message
-	and the authorship information (including the timestamp)
-	when creating the commit.
+	and the authorship information when creating the commit.
 
 -c <commit>::
 --reedit-message=<commit>::
 	Like '-C', but with '-c' the editor is invoked, so that
 	the user can further edit the commit message.
 
+--claim::
+	When used with -C/-c/--amend options the committer takes over
+	the cloned commit authorship and renew the timestamp thus using
+	only the commit message from the source.
+
 -F <file>::
 --file=<file>::
 	Take the commit message from the given file.  Use '-' to
diff --git a/builtin-commit.c b/builtin-commit.c
index c395cbf..33922df 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -51,7 +51,7 @@ static const char *template_file;
 static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
-static int quiet, verbose, no_verify, allow_empty, dry_run;
+static int quiet, verbose, no_verify, allow_empty, dry_run, claim;
 static char *untracked_files_arg;
 /*
  * The default commit message cleanup mode will remove the lines
@@ -91,8 +91,9 @@ static struct option builtin_commit_options[] = {
 	OPT_FILENAME('F', "file", &logfile, "read log from file"),
 	OPT_STRING(0, "author", &force_author, "AUTHOR", "override author for commit"),
 	OPT_CALLBACK('m', "message", &message, "MESSAGE", "specify commit message", opt_parse_m),
-	OPT_STRING('c', "reedit-message", &edit_message, "COMMIT", "reuse and edit message from specified commit "),
+	OPT_STRING('c', "reedit-message", &edit_message, "COMMIT", "reuse and edit message from specified commit"),
 	OPT_STRING('C', "reuse-message", &use_message, "COMMIT", "reuse message from specified commit"),
+	OPT_BOOLEAN(0, "claim", &claim, "take over cloned commit authorship and renew timestamp"),
 	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 	OPT_FILENAME('t', "template", &template_file, "use specified template file"),
 	OPT_BOOLEAN('e', "edit", &edit_flag, "force edit of commit"),
@@ -381,7 +382,7 @@ static void determine_author_info(void)
 	email = getenv("GIT_AUTHOR_EMAIL");
 	date = getenv("GIT_AUTHOR_DATE");
 
-	if (use_message) {
+	if (use_message && !claim) {
 		const char *a, *lb, *rb, *eol;
 
 		a = strstr(use_message_buffer, "\nauthor ");
-- 
1.6.5.2.102.g0a733
