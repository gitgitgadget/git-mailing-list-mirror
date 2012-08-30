From: Ammon Riley <ammon.riley@gmail.com>
Subject: [PATCH] Make git-svn branch patterns match complete URL
Date: Thu, 30 Aug 2012 15:53:57 -0700
Message-ID: <1346367237-28242-1-git-send-email-ammon.riley@gmail.com>
Cc: Ammon Riley <ammon.riley@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 00:54:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7Dcv-00073Z-Jl
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 00:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782Ab2H3WyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 18:54:11 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61623 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab2H3WyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 18:54:09 -0400
Received: by pbbrr13 with SMTP id rr13so3896852pbb.19
        for <git@vger.kernel.org>; Thu, 30 Aug 2012 15:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=7ntHw4Uh3R6mW5mGjJiI4OnJYzEZk8HQWDJRaNvt6ZE=;
        b=1ItsIPmmPbZGA2ZlZcnWaUAfqxgY141EYHX1/xc+Z6iO6mUNx60dEWaPmRHHvYXlgF
         mWR+s+pqYdrRRjdN/58chO69xSbZtUQXZiJ7exQYMboQCKMmyX0bc5cC2tuLSWL4gcjk
         a55nuGR9c18JmoXQkjHS58Ql8MuVswJnMgHrJg0QqDY27TcZj0qR3MHV7iz44Q6UwQKR
         DJn5NKEurhm0mpz675s7f7Wbbb9TahVrJlLZPSTHRWpO4O22+Ex49t062bIWSGhGuEiI
         rkyY/+5xpi8MdMHnzK0eTvRJQpN3NAXG1NV1y477IbT9ZATR396DCx2p+9j2DOneoSWC
         WUHQ==
Received: by 10.68.129.164 with SMTP id nx4mr13858644pbb.28.1346367249021;
        Thu, 30 Aug 2012 15:54:09 -0700 (PDT)
Received: from igloo.hlit.local ([12.108.21.226])
        by mx.google.com with ESMTPS id b4sm2304115pbw.28.2012.08.30.15.54.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 30 Aug 2012 15:54:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204572>

When using the {word,[...]} style of configuration for tags and branches,
it appears the intent is to only match whole path parts, since the words
in the {} pattern are meta-character quoted.

When the pattern word appears in the beginning or middle of the url,
it's matched completely, since the left side, pattern, and (non-empty)
right side are joined together with path separators.

However, when the pattern word appears at the end of the URL, the
right side is an empty pattern, and the resulting regex matches
more than just the specified pattern.

For example, if you specify something along the lines of

    branches = branches/project/{release_1,release_2}

and your repository also contains "branches/project/release_1_2", you
will also get the release_1_2 branch.  By restricting the match regex
with anchors, this is avoided.

Signed-off-by: Ammon Riley <ammon.riley@gmail.com>
---
Tested with Subversion 1.6; applies against maint, and master.

 perl/Git/SVN/GlobSpec.pm      | 4 +++-
 t/t9154-git-svn-fancy-glob.sh | 9 +++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/perl/Git/SVN/GlobSpec.pm b/perl/Git/SVN/GlobSpec.pm
index 96cfd98..c95f5d7 100644
--- a/perl/Git/SVN/GlobSpec.pm
+++ b/perl/Git/SVN/GlobSpec.pm
@@ -44,7 +44,9 @@ sub new {
 	my $right = join('/', @right);
 	$re = join('/', @patterns);
 	$re = join('\/',
-		   grep(length, quotemeta($left), "($re)", quotemeta($right)));
+		   grep(length, quotemeta($left),
+                                "($re)(?=/|\$)",
+                                quotemeta($right)));
 	my $left_re = qr/^\/\Q$left\E(\/|$)/;
 	bless { left => $left, right => $right, left_regex => $left_re,
 	        regex => qr/$re/, glob => $glob, depth => $depth }, $class;
diff --git a/t/t9154-git-svn-fancy-glob.sh b/t/t9154-git-svn-fancy-glob.sh
index a6a56a6..b780e0e 100755
--- a/t/t9154-git-svn-fancy-glob.sh
+++ b/t/t9154-git-svn-fancy-glob.sh
@@ -21,6 +21,15 @@ test_expect_success 'add red branch' "
 	test_must_fail git rev-parse refs/remotes/blue
 	"
 
+test_expect_success 'add gre branch' "
+	GIT_CONFIG=.git/svn/.metadata git config --unset svn-remote.svn.branches-maxRev &&
+	git config svn-remote.svn.branches 'branches/{red,gre}:refs/remotes/*' &&
+	git svn fetch &&
+	git rev-parse refs/remotes/red &&
+	test_must_fail git rev-parse refs/remotes/green &&
+	test_must_fail git rev-parse refs/remotes/blue
+	"
+
 test_expect_success 'add green branch' "
 	GIT_CONFIG=.git/svn/.metadata git config --unset svn-remote.svn.branches-maxRev &&
 	git config svn-remote.svn.branches 'branches/{red,green}:refs/remotes/*' &&
-- 
1.7.11.3
