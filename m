From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] test: work around SVN 1.7 mishandling of svn:special
 changes
Date: Sat, 6 Oct 2012 12:24:56 -0700
Message-ID: <20121006192455.GA14969@elie.Belkin>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <1343468872-72133-8-git-send-email-schwern@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael G. Schwern" <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Oct 06 21:25:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKa00-0007yV-Qg
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 21:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215Ab2JFTZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 15:25:11 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44114 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507Ab2JFTZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 15:25:09 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2904368pbb.19
        for <git@vger.kernel.org>; Sat, 06 Oct 2012 12:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=l6V/SD+4QHJ1m3MBeIaYepPXPbLIRJ8KsYZPAEOfe/8=;
        b=YwSLpzEMUsSftIsJ9ScZdxRjp1/9vd1m9Qvm7DLPzeaFTKEOLgPPn3xnXQCbWyWE1l
         GU1QDlMANHcHPZXoMGHeWPZpdyRgZw9HAjSyGtcQJVWzvlaXNtl4lt/ZFdXNUaCWVesx
         4hvus4ItWmkE+KGTirU28pWyg6ufo2hUy5eJd5VtpdZSAeeScywjXNXb6r404IyPUjpT
         bUpqx/2o2eWgxItlxHDRJQce65M9fg2cF1C+6Waj7Wv3RGqLHSrz1VQThGKcz+laLNDv
         D029zS9rn8D2mErb3R+Wk3SKq1+e6Y6eAUJKT3K2ENlq1b6KQqyB6cF/NcYMbXOyCNS7
         41fA==
Received: by 10.68.138.133 with SMTP id qq5mr40775206pbb.86.1349551509069;
        Sat, 06 Oct 2012 12:25:09 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id vi9sm8028522pbc.41.2012.10.06.12.25.06
        (version=SSLv3 cipher=OTHER);
        Sat, 06 Oct 2012 12:25:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343468872-72133-8-git-send-email-schwern@pobox.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207172>

Subversion represents symlinks as ordinary files with content
starting with "link " and the svn:special property set to "*".  Thus a
file can switch between being a symlink and a non-symlink simply by
toggling its svn:special property, and new checkouts will
automatically write a file of the appropriate type.  Likewise, in
subversion 1.6 and older, running "svn update" would notice changes
in filetype and update the working copy appropriately.

Unfortunately, starting in subversion 1.7 ,changes to the svn:special
property trip an assertion instead:

	$ svn up svn-tree
	Updating 'svn-tree':
	svn: E235000: In file 'subversion/libsvn_wc/update_editor.c' \
	line 1583: assertion failed (action == svn_wc_conflict_action_edit \
	|| action == svn_wc_conflict_action_delete || action == \
	svn_wc_conflict_action_replace)

This is a known bug in "svn update" (Subversion issue 4091) and for
the sake of old repositories it will need to be fixed some day.

Revisions prepared with ordinary svn commands ("svn add" and not "svn
propset") don't trip this because they represent filetype changes
using a replace operation, which is approximately equivalent to
removal followed by adding a new file and works fine.  Perhaps "git
svn" should mimic that, but for now let's teach the test suite to
recover from the bug by testing the content of HEAD with a new
checkout.

After this change, tests t9100.11-13 pass again.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi Eric,

Michael G. Schwern wrote:

> At this point SVN 1.7 passes except for 3 tests in
> t9100-git-svn-basic.sh that look like an SVN bug to do with
> symlinks.

How about this patch?

I didn't add a new xfail test for "svn up" working because I'm not yet
sure what good git-svn behavior would be.  Probably it would be better
to track down that svn bug and get a fix backported to the 1.7.x
branch.

Reference: http://subversion.tigris.org/issues/show_bug.cgi?id=4160

 t/t9100-git-svn-basic.sh |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 749b75e8..34d3485f 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -19,6 +19,15 @@ case "$GIT_SVN_LC_ALL" in
 	;;
 esac
 
+svn_up_avoiding_issue4091 () {
+	if ! svn_cmd_up "$SVN_TREE"
+	then
+		# work around Subversion issue 4091
+		rm -r "$SVN_TREE" &&
+		svn_cmd checkout "$svnrepo" "$SVN_TREE"
+	fi
+}
+
 test_expect_success \
     'initialize git svn' '
 	mkdir import &&
@@ -148,7 +157,7 @@ test_expect_success "$name" '
 	git commit -m "$name" &&
 	git svn set-tree --find-copies-harder --rmdir \
 		${remotes_git_svn}..mybranch5 &&
-	svn_cmd up "$SVN_TREE" &&
+	svn_up_avoiding_issue4091 &&
 	test -h "$SVN_TREE"/exec.sh'
 
 name='new symlink is added to a file that was also just made executable'
@@ -173,7 +182,7 @@ test_expect_success "$name" '
 	git commit -m "$name" &&
 	git svn set-tree --find-copies-harder --rmdir \
 		${remotes_git_svn}..mybranch5 &&
-	svn_cmd up "$SVN_TREE" &&
+	svn_up_avoiding_issue4091 &&
 	test -f "$SVN_TREE"/exec-2.sh &&
 	test ! -h "$SVN_TREE"/exec-2.sh &&
 	test_cmp help "$SVN_TREE"/exec-2.sh'
-- 
1.7.10.4
