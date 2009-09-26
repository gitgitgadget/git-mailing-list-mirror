From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCH] instaweb: support mod_cgid for apache2
Date: Sat, 26 Sep 2009 14:12:32 -0400
Message-ID: <4ABE5990.2060902@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 20:13:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrblZ-00056x-8U
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 20:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbZIZSMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 14:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752489AbZIZSMi
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 14:12:38 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:54491 "EHLO
	mailchk-m04.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751800AbZIZSMf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Sep 2009 14:12:35 -0400
Received: from karakura.local (CPE000e0c6492b0-CM001692fb78dc.cpe.net.cable.rogers.com [99.236.79.58])
	(authenticated bits=0)
	by mailchk-m04.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n8QICWdw003150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 26 Sep 2009 14:12:37 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
X-UUID: 5062b8dd-4f41-4a4c-ae80-f9d39da28ed3
X-Miltered: at mailchk-m04 with ID 4ABE5990.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.1 at mailchk-m04
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m04.uwaterloo.ca [129.97.128.141]); Sat, 26 Sep 2009 14:12:38 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129163>

Some people have mod_cgid instead of mod_cgi, most likely as a result of
choosing a threaded MPM.

In cases where the user has both modules, mod_cgi will be preferred in
order to maintain a simpler setup.

This patch also causes instaweb to print a message and die in cases
where there is no module that instaweb knows how to handle.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---

	I thought I would squeeze this patch in while I was at it today.


 git-instaweb.sh |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index d96eddb..622a5f0 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -317,7 +317,21 @@ EOF
 		resolve_full_httpd
 		list_mods=$(echo "$full_httpd" | sed "s/-f$/-l/")
 		$list_mods | grep 'mod_cgi\.c' >/dev/null 2>&1 || \
-		echo "LoadModule cgi_module $module_path/mod_cgi.so" >> "$conf"
+		if test -f "$module_path/mod_cgi.so"
+		then
+			echo "LoadModule cgi_module $module_path/mod_cgi.so" >> "$conf"
+		else
+			$list_mods | grep 'mod_cgid\.c' >/dev/null 2>&1 || \
+			if test -f "$module_path/mod_cgid.so"
+			then
+				echo "LoadModule cgid_module $module_path/mod_cgid.so" \
+					>> "$conf"
+			else
+				echo "You have no CGI support!"
+				exit 2
+			fi
+			echo "ScriptSock logs/gitweb.sock" >> "$conf"
+		fi
 		cat >> "$conf" <<EOF
 AddHandler cgi-script .cgi
 <Location /gitweb.cgi>
-- 
1.6.4.GIT
