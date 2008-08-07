From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: [PATCH B] GIT-VERSION-GEN: refresh the index before judging a working dir to be dirty
Date: Thu, 7 Aug 2008 19:59:25 +0200
Message-ID: <a921f9287bf93b1f4de21968ee02a06fe69198a8.1218137290.git.christian@jaeger.mine.nu>
References: <sjj6zt28jy9qy7y8@jaeger.mine.nu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 22:21:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRBzA-0000b4-OV
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 22:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbYHGUUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 16:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbYHGUUV
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 16:20:21 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:52722 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752580AbYHGUUU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 16:20:20 -0400
Received: (qmail 27611 invoked by uid 1000); 7 Aug 2008 20:20:18 -0000
In-Reply-To: <sjj6zt28jy9qy7y8@jaeger.mine.nu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91603>

When building under the control of the "fakeroot" tool [*], as is the
case when building a Debian package using "dpkg-buildpackage
-rfakeroot", GIT-VERSION-GEN appended "-dirty" to the version number;
this happens because "git diff-index --name-only HEAD --" would report
all files as changed if they have a non-root owner/group, since they
appear as owned by root under fakeroot, leading to non-empty
output. Refreshing the index first makes the decision based on content
changes only.

[*] http://fakeroot.alioth.debian.org/

Signed-off-by: Christian Jaeger <christian@jaeger.mine.nu>
---
 GIT-VERSION-GEN |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index cb7cd4b..fb3e2d8 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -17,6 +17,12 @@ elif test -d .git -o -f .git &&
 	*$LF*) (exit 1) ;;
 	v[0-9]*)
 		test -z "$(git diff-index --name-only HEAD --)" ||
+		{
+			# some metadata of files has changed; what
+			# about the contents?
+			git update-index --refresh
+			test -z "$(git diff-index --name-only HEAD --)"
+		} ||
 		VN="$VN-dirty" ;;
 	esac
 then
-- 
1.6.0.rc2.1.g7e734
