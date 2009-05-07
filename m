From: Jim Meyering <meyering@redhat.com>
Subject: [PATCH] format-patch let -k override a config-specified format.numbered
Date: Thu, 07 May 2009 18:31:07 +0200
Message-ID: <8763gcri2c.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stephen C. Tweedie" <sct@redhat.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 07 18:32:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M26WT-0005cf-G5
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 18:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756249AbZEGQc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 12:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756177AbZEGQc1
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 12:32:27 -0400
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:53017 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760129AbZEGQc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 12:32:26 -0400
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 920162D269
	for <git@vger.kernel.org>; Thu,  7 May 2009 18:32:21 +0200 (CEST)
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 8457B4C8161
	for <git@vger.kernel.org>; Thu,  7 May 2009 18:31:09 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 9FFE74C80A9
	for <git@vger.kernel.org>; Thu,  7 May 2009 18:31:07 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 4BBE69023; Thu,  7 May 2009 18:31:07 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118490>


Let a command-line --keep-subject (-k) override a config-specified
format.numbered (--numbered (-n)), rather than provoking the
"-n and -k are mutually exclusive" failure.
* t4021-format-patch-numbered.sh: Test for the above
---

Here's a quick demo of the problem:

  $ git config format.numbered true
  $ git format-patch --stdout -1 -k > /dev/null
  fatal: -n and -k are mutually exclusive.

This started when a colleague reported that "git rebase master" was failing
with a "fatal: -n and -k are mutually exclusive".  Stephen Tweedie discovered
that it was due to the format.numbered=true setting in ~/.gitconfig
conflicting with the -k of the format-patch command run as part of
the rebase operation.  Here's a fix.

Stephen suggested an alternate patch in which rather than adding a
new variable, you'd use "numbered = -1" to indicate that the setting
originated in config.  Let me know if you'd prefer that.

 builtin-log.c                    |   14 +++++++++++++-
 t/t4021-format-patch-numbered.sh |    7 +++++++
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 5eaec5d..f10cfeb 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -755,6 +755,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int cover_letter = 0;
 	int boundary_count = 0;
 	int no_binary_diff = 0;
+	int numbered_cmdline_opt = 0;
 	struct commit *origin = NULL, *head = NULL;
 	const char *in_reply_to = NULL;
 	struct patch_ids ids;
@@ -786,8 +787,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (!strcmp(argv[i], "--stdout"))
 			use_stdout = 1;
 		else if (!strcmp(argv[i], "-n") ||
-				!strcmp(argv[i], "--numbered"))
+				!strcmp(argv[i], "--numbered")) {
 			numbered = 1;
+			numbered_cmdline_opt = 1;
+		}
 		else if (!strcmp(argv[i], "-N") ||
 				!strcmp(argv[i], "--no-numbered")) {
 			numbered = 0;
@@ -918,6 +921,15 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)

 	if (start_number < 0)
 		start_number = 1;
+
+	/*
+	 * If numbered is set solely due to format.numbered in config,
+	 * and it would conflict with --keep-subject (-k) from the
+	 * command line, reset "numbered".
+	 */
+	if (numbered && keep_subject && !numbered_cmdline_opt)
+		numbered = 0;
+
 	if (numbered && keep_subject)
 		die ("-n and -k are mutually exclusive.");
 	if (keep_subject && subject_prefix)
diff --git a/t/t4021-format-patch-numbered.sh b/t/t4021-format-patch-numbered.sh
index 390af23..9b6e1be 100755
--- a/t/t4021-format-patch-numbered.sh
+++ b/t/t4021-format-patch-numbered.sh
@@ -86,6 +86,13 @@ test_expect_success 'format.numbered && --no-numbered' '

 '

+test_expect_success 'format.numbered && --keep-subject' '
+
+	git format-patch --keep-subject --stdout HEAD^ >patch4a &&
+	grep "^Subject: Third" patch4a
+
+'
+
 test_expect_success 'format.numbered = auto' '

 	git config format.numbered auto
--
1.6.3.195.gad81
