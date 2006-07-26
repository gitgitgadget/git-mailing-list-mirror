From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] instaweb: Be more clear if httpd or the browser fail
Date: Wed, 26 Jul 2006 23:11:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607262310350.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607261633560.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr708qih4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607262153380.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jul 26 23:12:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5qfX-0004ph-JH
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 23:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWGZVLs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 17:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWGZVLs
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 17:11:48 -0400
Received: from mail.gmx.de ([213.165.64.21]:9678 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751167AbWGZVLs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 17:11:48 -0400
Received: (qmail invoked by alias); 26 Jul 2006 21:11:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 26 Jul 2006 23:11:46 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0607262153380.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24249>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

On Wed, 26 Jul 2006, Johannes Schindelin wrote:

> Well, the fallback mechanism might not be that useful anyway: if you have 
> apache, you have to specify the modules path. I'll do a patch instead 
> which exits cleanly if either $httpd or $browser could not be executed, 
> okay?

Here you are

 git-instaweb.sh |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 1d3ea73..585ad7c 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -54,6 +54,10 @@ start_httpd () {
 			fi
 		done
 	fi
+	if test $? != 0; then
+		echo "Could not execute http daemon $httpd."
+		exit 1
+	fi
 }
 
 stop_httpd () {
@@ -189,7 +193,7 @@ EOF
 	else
 		# plain-old CGI
 		list_mods=`echo "$httpd" | sed "s/-f$/-l/"`
-		$list_mods | grep 'mod_cgi\.c' >/dev/null || \
+		$list_mods | grep 'mod_cgi\.c' >/dev/null 2>&1 || \
 		echo "LoadModule cgi_module $module_path/mod_cgi.so" >> "$conf"
 		cat >> "$conf" <<EOF
 AddHandler cgi-script .cgi
@@ -239,4 +243,5 @@ esac
 
 start_httpd
 test -z "$browser" && browser=echo
-$browser http://127.0.0.1:$port
+url=http://127.0.0.1:$port
+$browser $url || echo $url
-- 
1.4.2.rc2.g84db
