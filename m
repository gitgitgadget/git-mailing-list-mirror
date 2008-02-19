From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 4/4] Support a --cc=<email> option in format-patch
Date: Tue, 19 Feb 2008 02:40:35 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802190240080.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 08:41:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRN6l-0006Rf-SE
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 08:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760920AbYBSHkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 02:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760821AbYBSHki
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 02:40:38 -0500
Received: from iabervon.org ([66.92.72.58]:33334 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760122AbYBSHkh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 02:40:37 -0500
Received: (qmail 16224 invoked by uid 1000); 19 Feb 2008 07:40:35 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Feb 2008 07:40:35 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74385>

When you have particular reviewers you want to sent particular series
to, it's nice to be able to generate the whole series with them as
additional recipients, without configuring them into your general
headers or adding them by hand afterwards.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Documentation/git-format-patch.txt |    5 +++++
 builtin-log.c                      |    4 ++++
 t/t4014-format-patch.sh            |    8 ++++++++
 3 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index b27bb94..b5207b7 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -17,6 +17,7 @@ SYNOPSIS
 		   [--in-reply-to=Message-Id] [--suffix=.<sfx>]
 		   [--ignore-if-in-upstream]
 		   [--subject-prefix=Subject-Prefix]
+		   [--cc=<email>]
 		   [--cover-letter]
 		   [ <since> | <revision range> ]
 
@@ -136,6 +137,10 @@ include::diff-options.txt[]
 	allows for useful naming of a patch series, and can be
 	combined with the --numbered option.
 
+--cc=<email>::
+	Add a "Cc:" header to the email headers. This is in addition
+	to any configured headers, and may be used multiple times.
+
 --cover-letter::
 	Generate a cover letter template.  You still have to fill in
 	a description, but the shortlog and the diffstat will be
diff --git a/builtin-log.c b/builtin-log.c
index ae62668..e26c986 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -771,6 +771,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 				die("Need a number for --start-number");
 			start_number = strtol(argv[i], NULL, 10);
 		}
+		else if (!prefixcmp(argv[i], "--cc=")) {
+			ALLOC_GROW(extra_cc, extra_cc_nr + 1, extra_cc_alloc);
+			extra_cc[extra_cc_nr++] = xstrdup(argv[i] + 5);
+		}
 		else if (!strcmp(argv[i], "-k") ||
 				!strcmp(argv[i], "--keep-subject")) {
 			keep_subject = 1;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 43d8841..a39e786 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -122,6 +122,14 @@ test_expect_success 'extra headers with multiple To:s' '
 	grep "^ *S. E. Cipient <scipient@example.com>$" hdrs4
 '
 
+test_expect_success 'additional command line cc' '
+
+	git config --replace-all format.headers "Cc: R. E. Cipient <rcipient@example.com>" &&
+	git format-patch --cc="S. E. Cipient <scipient@example.com>" --stdout master..side | sed -e "/^$/Q" >patch5 &&
+	grep "^Cc: R. E. Cipient <rcipient@example.com>,$" patch5 &&
+	grep "^ *S. E. Cipient <scipient@example.com>$" patch5
+'
+
 test_expect_success 'multiple files' '
 
 	rm -rf patches/ &&
-- 
1.5.4.1.192.g8ea3a
