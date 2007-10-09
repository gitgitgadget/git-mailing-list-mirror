From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [take 2] Clean up "git log" format with DIFF_FORMAT_NO_OUTPUT
Date: Tue, 9 Oct 2007 09:35:22 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710090932560.5039@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0710081337490.4964@woody.linux-foundation.org
 > <alpine.LFD.0.999.0710081342530.4964@woody.linux-foundation.org>
 <alpine.LFD.0.999.0710081353290.4964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 18:36:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfI3v-0007ZW-HH
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 18:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904AbXJIQfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 12:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753872AbXJIQfh
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 12:35:37 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39515 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753258AbXJIQfh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Oct 2007 12:35:37 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l99GZMkq024664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Oct 2007 09:35:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l99GZMX1027332;
	Tue, 9 Oct 2007 09:35:22 -0700
In-Reply-To: <alpine.LFD.0.999.0710081353290.4964@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.234 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60422>


Clean up "git log" format with DIFF_FORMAT_NO_OUTPUT

This fixes an unnecessary empty line that we add to the log message when
we generate diffs, but don't actually end up printing any due to having
DIFF_FORMAT_NO_OUTPUT set.

This can happen with pickaxe or with rename following. The reason is that
we normally add an empty line between the commit and the diff, but we do
that even for the case where we've then suppressed the actual printing of
the diff.

This also updates a couple of tests that assumed the extraneous empty
line would exist at the end of output.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This is a resend of the original patch, with just the changes to the tests 
added to make it pass them all. Both of the tests actually got cleaner, I 
think (ie one had the sed script blindly just delete the last line in 
order to match it up with the known input, for example).

			Linus


 log-tree.c                  |    3 ++-
 t/t3900-i18n-commit.sh      |    2 +-
 t/t4013/diff.log_-SF_master |    1 -
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 2319154..62edd34 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -304,7 +304,8 @@ int log_tree_diff_flush(struct rev_info *opt)
 		 * output for readability.
 		 */
 		show_log(opt, opt->diffopt.msg_sep);
-		if (opt->verbose_header &&
+		if ((opt->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT) &&
+		    opt->verbose_header &&
 		    opt->commit_format != CMIT_FMT_ONELINE) {
 			int pch = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
 			if ((pch & opt->diffopt.output_format) == pch)
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index fcbabe8..94b1c24 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -8,7 +8,7 @@ test_description='commit and log output encodings'
 . ./test-lib.sh
 
 compare_with () {
-	git show -s $1 | sed -e '1,/^$/d' -e 's/^    //' -e '$d' >current &&
+	git show -s $1 | sed -e '1,/^$/d' -e 's/^    //' >current &&
 	git diff current "$2"
 }
 
diff --git a/t/t4013/diff.log_-SF_master b/t/t4013/diff.log_-SF_master
index 6162ed2..c1599f2 100644
--- a/t/t4013/diff.log_-SF_master
+++ b/t/t4013/diff.log_-SF_master
@@ -4,5 +4,4 @@ Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
 
     Third
-
 $
