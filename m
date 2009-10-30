From: Erick Mattos <erick.mattos@gmail.com>
Subject: [PATCH] Changed timestamp behavior of options -c/-C/--amend
Date: Fri, 30 Oct 2009 17:36:34 -0200
Message-ID: <1256931394-9338-1-git-send-email-erick.mattos@gmail.com>
Cc: git@vger.kernel.org, Erick Mattos <erick.mattos@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:44:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3xOR-0005ss-U7
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 20:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756885AbZJ3ToE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 15:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755635AbZJ3ToE
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 15:44:04 -0400
Received: from mail-gx0-f226.google.com ([209.85.217.226]:56272 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755913AbZJ3ToD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 15:44:03 -0400
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Oct 2009 15:44:03 EDT
Received: by gxk26 with SMTP id 26so606108gxk.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 12:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ZkBRJi4bpFShfxSs3pZHYilb2lY3LgeV+L4WWGE7X/M=;
        b=b7hr2cUt3hKQgcj6V/2RI8Ywl3FRsBUdUeoujh/ccmLwXCistismuD/Ash852gthWH
         MnVjbM4Ad9Ol/8Is1yxv0FWycWGFE847F2TdeEV6eeFsxUsWLjfPtCDAv92GdAyJ62Yy
         XvS+G+Cy9USTETdgub6W7vVahiu8LUOiS9D7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=VzN9bJmV+ICB2udOZjGrEgaoGPYzGV/jB4NTj5Z4jpngd/+v7IoETFSPImnp3NTDlB
         cj6KzMDp5WsI76YteJz5996KgDKwEJpStxSdm6T9t3rH5sVdttcyuOrbNS1bNIojaZes
         cY6zHrCRNjnSh6zMYuNsIdYanIa7zCPNrs3oI=
Received: by 10.100.209.1 with SMTP id h1mr2270798ang.181.1256931423476;
        Fri, 30 Oct 2009 12:37:03 -0700 (PDT)
Received: from localhost.localdomain ([187.15.77.118])
        by mx.google.com with ESMTPS id 23sm1192566ywh.18.2009.10.30.12.37.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 12:37:03 -0700 (PDT)
X-Mailer: git-send-email 1.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131739>

The code herein changes commit timestamp recording from a source in a
more intuitive way.

Description:
When we use one of the options above we are normally trying to do mainly
two things: one is using the source as a template and second is to
recreate a commit with corrections.

In the first case timestamp should by default be taken by the time we
are doing the commit, not by the source.  On the second case the actual
behavior is acceptable.

Anyway this update creates new options for choosing the source timestamp
or a new one.  And set as default for -c option (editing one) to take a
new timestamp and for -C option the source timestamp.  That is because
we are normally using the source as template when we we are editing and
as a correction when we are just copying it.

Those options are also useful for --amend option which is by default
behaving the same.

Signed-off-by: Erick Mattos <erick.mattos@gmail.com>
---
 Documentation/git-commit.txt |   10 ++++++++--
 builtin-commit.c             |   15 ++++++++++++---
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0578a40..27c61d2 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dry-run]
 	   [(-c | -C) <commit>] [-F <file> | -m <msg>]
+	   [(--old-timestamp | --new-timestamp)]
 	   [--allow-empty] [--no-verify] [-e] [--author=<author>]
 	   [--cleanup=<mode>] [--] [[-i | -o ]<file>...]
 
@@ -61,13 +62,16 @@ OPTIONS
 -C <commit>::
 --reuse-message=<commit>::
 	Take an existing commit object, and reuse the log message
-	and the authorship information (including the timestamp)
-	when creating the commit.
+	and the authorship information when creating the commit.
+	By default, timestamp is taken from specified commit unless
+	option --new-timestamp is included.
 
 -c <commit>::
 --reedit-message=<commit>::
 	Like '-C', but with '-c' the editor is invoked, so that
 	the user can further edit the commit message.
+	By default, timestamp is recalculated and not taken from
+	specified commit unless option --old-timestamp is included.
 
 -F <file>::
 --file=<file>::
@@ -134,6 +138,8 @@ OPTIONS
 	current tip -- if it was a merge, it will have the parents of
 	the current tip as parents -- so the current top commit is
 	discarded.
+	By default, timestamp is taken from latest commit unless option
+	--new-timestamp is included.
 +
 --
 It is a rough equivalent for:
diff --git a/builtin-commit.c b/builtin-commit.c
index c395cbf..a924584 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -52,6 +52,7 @@ static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, no_verify, allow_empty, dry_run;
+static int old_timestamp, new_timestamp;
 static char *untracked_files_arg;
 /*
  * The default commit message cleanup mode will remove the lines
@@ -91,8 +92,10 @@ static struct option builtin_commit_options[] = {
 	OPT_FILENAME('F', "file", &logfile, "read log from file"),
 	OPT_STRING(0, "author", &force_author, "AUTHOR", "override author for commit"),
 	OPT_CALLBACK('m', "message", &message, "MESSAGE", "specify commit message", opt_parse_m),
-	OPT_STRING('c', "reedit-message", &edit_message, "COMMIT", "reuse and edit message from specified commit "),
+	OPT_STRING('c', "reedit-message", &edit_message, "COMMIT", "reuse and edit message from specified commit"),
 	OPT_STRING('C', "reuse-message", &use_message, "COMMIT", "reuse message from specified commit"),
+	OPT_BOOLEAN(0, "old-timestamp", &old_timestamp, "reuse previous commit's timestamp"),
+	OPT_BOOLEAN(0, "new-timestamp", &new_timestamp, "regenerate timestamp, ignoring previous one"),
 	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 	OPT_FILENAME('t', "template", &template_file, "use specified template file"),
 	OPT_BOOLEAN('e', "edit", &edit_flag, "force edit of commit"),
@@ -396,7 +399,8 @@ static void determine_author_info(void)
 
 		name = xstrndup(a + 8, lb - (a + 8));
 		email = xstrndup(lb + 2, rb - (lb + 2));
-		date = xstrndup(rb + 2, eol - (rb + 2));
+		if (!new_timestamp)
+			date = xstrndup(rb + 2, eol - (rb + 2));
 	}
 
 	if (force_author) {
@@ -763,11 +767,16 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		die("You have nothing to amend.");
 	if (amend && in_merge)
 		die("You are in the middle of a merge -- cannot amend.");
+	if (old_timestamp && new_timestamp)
+		die("You can not use --old-timesamp and --new-timestamp together.");
 
 	if (use_message)
 		f++;
-	if (edit_message)
+	if (edit_message) {
+		if (!old_timestamp)
+			new_timestamp = 1;
 		f++;
+	}
 	if (logfile)
 		f++;
 	if (f > 1)
-- 
1.6.5.2.102.g3ad0
