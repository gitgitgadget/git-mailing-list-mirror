From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH] Fix git-instaweb breakage on MacOS X due to the limited sed functionality
Date: Wed, 19 Dec 2007 12:25:27 +0000
Message-ID: <20071219122527.GA503@hashpling.org>
References: <20071219122308.GA32088@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 13:26:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4xzo-0001Il-3w
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 13:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbXLSMZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 07:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752528AbXLSMZc
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 07:25:32 -0500
Received: from fhw-relay07.plus.net ([212.159.14.215]:52967 "EHLO
	fhw-relay07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbXLSMZc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 07:25:32 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by fhw-relay07.plus.net with esmtp (Exim) id 1J4xzM-0006C0-UZ
	for git@vger.kernel.org; Wed, 19 Dec 2007 12:25:29 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id lBJCPRWw000779
	for <git@vger.kernel.org>; Wed, 19 Dec 2007 12:25:27 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id lBJCPRxL000778
	for git@vger.kernel.org; Wed, 19 Dec 2007 12:25:27 GMT
Content-Disposition: inline
In-Reply-To: <20071219122308.GA32088@hashpling.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68904>

git-instaweb relied on a pipe in a sed script, but this is not supported
by MacOS X sed when using BREs.  git-instaweb relies on a working perl
in any case, and perl re are more consistent between platforms, so
replace sed invocation with an equivalent perl invocation.

Also, fix the documented -b "" to work without giving a spurious 'command
not found' error.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 Makefile        |    1 +
 git-instaweb.sh |   15 +++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 617e5f5..d6d3d65 100644
--- a/Makefile
+++ b/Makefile
@@ -880,6 +880,7 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
 	    -e '/@@GITWEB_CGI@@/d' \
 	    -e '/@@GITWEB_CSS@@/r gitweb/gitweb.css' \
 	    -e '/@@GITWEB_CSS@@/d' \
+	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
 	    $@.sh > $@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 42d8d7f..ad0723c 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2006 Eric Wong
 #
 
+PERL='@@PERL@@'
 OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
 git-instaweb [options] (--start | --stop | --restart)
@@ -232,16 +233,18 @@ EOF
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
+	# Use the configured full path to perl to match the generated
+	# scripts' 'hashpling' line
+	"$PERL" -p -e "$script" "$1.tmp"  > "$1"
 	chmod +x "$1"
 	rm -f "$1.tmp"
 }
@@ -273,4 +276,4 @@ esac
 
 start_httpd
 url=http://127.0.0.1:$port
-"$browser" $url || echo $url
+test -n "$browser" && "$browser" $url || echo $url
-- 
1.5.4.rc0


-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
