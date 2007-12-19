From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH] Fix git-instaweb breakage on MacOS X due to the limited sed functionality
Date: Wed, 19 Dec 2007 10:57:52 +0000
Message-ID: <20071219105752.GA23932@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 11:58:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4wd3-0005D9-DI
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 11:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbXLSK56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 05:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbXLSK56
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 05:57:58 -0500
Received: from ptb-relay03.plus.net ([212.159.14.214]:37362 "EHLO
	ptb-relay03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbXLSK55 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 05:57:57 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay03.plus.net with esmtp (Exim) id 1J4wcc-0000YI-Jy
	for git@vger.kernel.org; Wed, 19 Dec 2007 10:57:54 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id lBJAvq9t024222
	for <git@vger.kernel.org>; Wed, 19 Dec 2007 10:57:52 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id lBJAvqE7024221
	for git@vger.kernel.org; Wed, 19 Dec 2007 10:57:52 GMT
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68882>

git-instaweb relied on a pipe in a sed script, but this is not supported
by MacOS X sed when using BREs.  git-instaweb relies on a working perl
in any case, and perl re are more consistent between platforms, so
replace sed invocation with an equivalent perl invocation.

Also, fix the documented -b "" to work without giving a spurious 'command
not found' error.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 git-instaweb.sh |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 42d8d7f..3565734 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -232,16 +232,18 @@ EOF
 }
 
 script='
-s#^\(my\|our\) $projectroot =.*#\1 $projectroot = "'$(dirname "$fqgitdir")'";#
-s#\(my\|our\) $gitbin =.*#\1 $gitbin = "'$GIT_EXEC_PATH'";#
-s#\(my\|our\) $projects_list =.*#\1 $projects_list = $projectroot;#
-s#\(my\|our\) $git_temp =.*#\1 $git_temp = "'$fqgitdir/gitweb/tmp'";#'
+s#^(my|our) \$projectroot =.*#$1 \$projectroot = "'$(dirname "$fqgitdir")'";#;
+s#(my|our) \$gitbin =.*#$1 \$gitbin = "'$GIT_EXEC_PATH'";#;
+s#(my|our) \$projects_list =.*#$1 \$projects_list = \$projectroot;#;
+s#(my|our) \$git_temp =.*#$1 \$git_temp = "'$fqgitdir/gitweb/tmp'";#;'
 
 gitweb_cgi () {
 	cat > "$1.tmp" <<\EOFGITWEB
 @@GITWEB_CGI@@
 EOFGITWEB
-	sed "$script" "$1.tmp"  > "$1"
+	# The generated scripts assume that perl is /usr/bin/perl
+	# so the assumption here should be no more harmful
+	/usr/bin/perl -p -e "$script" "$1.tmp"  > "$1"
 	chmod +x "$1"
 	rm -f "$1.tmp"
 }
@@ -273,4 +275,4 @@ esac
 
 start_httpd
 url=http://127.0.0.1:$port
-"$browser" $url || echo $url
+test -n "$browser" && "$browser" $url || echo $url
-- 
1.5.4.rc0
