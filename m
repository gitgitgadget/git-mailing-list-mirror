From: Geoffrey Irving <irving@naml.us>
Subject: [PATCH] git fast-export: add --no-data option
Date: Sat, 25 Jul 2009 09:45:19 -0400
Message-ID: <7f9d599f0907250645s6e6f9b81w3cf20f07eff088eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 15:46:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUhaH-0008Dk-19
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 15:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbZGYNpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 09:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbZGYNpm
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 09:45:42 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:51089 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbZGYNpl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 09:45:41 -0400
Received: by qyk34 with SMTP id 34so966874qyk.33
        for <git@vger.kernel.org>; Sat, 25 Jul 2009 06:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=YIUgKYP/lq0d/qO1b4EV0MMlcZII7AchpIy2B80xRnw=;
        b=a/swomJiB2pRLoZyAQh5xCtcRP23ixpllo5pTAbQYlGB/PjyojmuRgUahHBcQ1hcQS
         28PkkmQ1oE9aA058Yz0tnM5qi7qeD9+OQvg4Sf73aUVSZkvn/IjJG6w2Sbq1aWCCar67
         glWtIwIrxwHhPUfvqMFlmfMW7pLb1fb8UFFEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type:content-transfer-encoding;
        b=JiXbLUKIcDgSQQiu9/hEHx00wGNaMpIfwmct2QmnoLba5ueaODQ5Hx7x8RlRSNx57g
         E0VL+hAS1T/85ZYCLkzfqoYJw4HoygZ/skm4ZzBsXufJAMpAVaVWgFugZNU6hOczAyDR
         FNK54luvhuLbO5ofXuSHCLZ/4byds4TCD3H0o=
Received: by 10.220.74.143 with SMTP id u15mr2968403vcj.35.1248529540272; Sat, 
	25 Jul 2009 06:45:40 -0700 (PDT)
X-Google-Sender-Auth: dc77875d194975a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124006>

When using git fast-export and git fast-import to rewrite the history
of a repository with large binary files, almost all of the time is
spent dealing with blobs.  This is extremely inefficient if all we want
to do is rewrite the commits and tree structure.  --no-data skips the
output of blobs and writes SHA-1s instead of marks, which provides a
massive speedup.

Signed-off-by: Geoffrey Irving <irving@naml.us>
---

I've already done all I need with this change (for now, at least), but
here it is in case it proves useful to others.  Amusingly, rewriting
history with

    git fast-export --no-data <branch> | <python-script> | git fast-import

is now much, much faster than the equivalent

    git filter-branch --prune-empty --msg-filter ...

I haven't investigated why.

 Documentation/git-fast-export.txt |    7 +++++++
 builtin-fast-export.c             |    8 +++++++-
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-fast-export.txt
b/Documentation/git-fast-export.txt
index 0c9eb56..47a96dd 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -71,6 +71,13 @@ marks the same across runs.
 	allow that.  So fake a tagger to be able to fast-import the
 	output.

+--no-data::
+	Skip output of blob objects and instead refer to blobs via
+	their original SHA-1 hash.  This is useful when rewriting the
+	directory structure or history of a repository without
+	touching the contents of individual files.  Note that the
+	resulting stream can only be used by a repository which
+	already contains the necessary objects.

 EXAMPLES
 --------
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 9a8a6fc..ac72791 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -25,6 +25,7 @@ static const char *fast_export_usage[] = {
 static int progress;
 static enum { VERBATIM, WARN, STRIP, ABORT } signed_tag_mode = ABORT;
 static int fake_missing_tagger;
+static int no_data;

 static int parse_opt_signed_tag_mode(const struct option *opt,
 				     const char *arg, int unset)
@@ -101,6 +102,9 @@ static void handle_object(const unsigned char *sha1)
 	char *buf;
 	struct object *object;

+	if (no_data)
+		return;
+
 	if (is_null_sha1(sha1))
 		return;

@@ -158,7 +162,7 @@ static void show_filemodify(struct diff_queue_struct *q,
 			 * Links refer to objects in another repositories;
 			 * output the SHA-1 verbatim.
 			 */
-			if (S_ISGITLINK(spec->mode))
+			if (no_data || S_ISGITLINK(spec->mode))
 				printf("M %06o %s %s\n", spec->mode,
 				       sha1_to_hex(spec->sha1), spec->path);
 			else {
@@ -504,6 +508,8 @@ int cmd_fast_export(int argc, const char **argv,
const char *prefix)
 			     "Import marks from this file"),
 		OPT_BOOLEAN(0, "fake-missing-tagger", &fake_missing_tagger,
 			     "Fake a tagger when tags lack one"),
+		OPT_BOOLEAN(0, "no-data", &no_data,
+			     "Skip output of blob data"),
 		OPT_END()
 	};

-- 
1.6.3.1
