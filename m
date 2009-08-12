From: Mark A Rada <marada@uwaterloo.ca>
Subject: [PATCHv2] git-instaweb: detect difference between mod_cgi and mod_cgid for apache2
Date: Tue, 11 Aug 2009 22:34:22 -0400
Message-ID: <F920560B-FABD-47A1-9F83-47A3F2C3193D@mailservices.uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 12 04:35:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb3gh-0001wF-Ew
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 04:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754580AbZHLCe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 22:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754091AbZHLCe2
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 22:34:28 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:49663 "EHLO
	psyche.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752931AbZHLCe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 22:34:28 -0400
Received: from [192.168.1.102] (CPE0018397ddc22-CM001225dfe86e.cpe.net.cable.rogers.com [174.117.223.147])
	(authenticated bits=0)
	by psyche.uwaterloo.ca (8.13.1/8.13.1) with ESMTP id n7C2YNHO006697
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Tue, 11 Aug 2009 22:34:28 -0400
X-Mailer: Apple Mail (2.936)
X-UUID: f7348d0d-7802-45a4-b859-ec51f042942a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125644>

Comments?

--
Mark A Rada (ferrous26)
marada@uwaterloo.ca


--->8----
Some people have mod_cgid in place of mod_cgi, this will check which one
the user has available to them first and then act accordingly.

It is possible to have both mod_cgi and mod_cgid installed at the same
time; in these cases, mod_cgi will preferred over mod_cgid to make
things easier.

In the case that no CGI modules are available for apache2 the script
will print a message to the user notifying him/her about the problem.

Signed-off-by: Mark Rada <marada@uwaterloo.ca>
---
  git-instaweb.sh |   15 ++++++++++++++-
  1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 5f5cac7..ec0b518 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -298,7 +298,20 @@ EOF
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
+				echo "LoadModule cgid_module $module_path/mod_cgid.so" >> "$conf"
+			else
+				echo "You don't have any CGI support!"
+				exit 2
+			fi
+			echo "ScriptSock logs/gitweb.sock" >> "$conf"
+		fi
  		cat >> "$conf" <<EOF
  AddHandler cgi-script .cgi
  <Location /gitweb.cgi>
-- 
1.6.4
