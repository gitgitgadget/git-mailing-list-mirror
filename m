From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 4/6] t9500-*.sh: Fix highlight test hang on Linux Mint
Date: Sun, 06 Oct 2013 21:50:46 +0100
Message-ID: <5251CD26.8060803@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 06 22:50:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSvHw-000714-Kx
	for gcvg-git-2@plane.gmane.org; Sun, 06 Oct 2013 22:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634Ab3JFUut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Oct 2013 16:50:49 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:38135 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754580Ab3JFUus (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Oct 2013 16:50:48 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id C2F546FBA8D;
	Sun,  6 Oct 2013 21:50:47 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 9443E6FB6F2;
	Sun,  6 Oct 2013 21:50:47 +0100 (BST)
Received: from [192.168.254.7] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Sun,  6 Oct 2013 21:50:47 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.0
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235748>


Linux Mint has an implementation of the highlight command (unrelated
to the one from http://www.andre-simon.de) that works as a simple
filter. The script uses 'sed' to add terminal colour escape codes
around text matching a regular expression. When t9500-*.sh attempts
to run "highlight --version", the script simply hangs waiting for
input. (See https://bugs.launchpad.net/linuxmint/+bug/815005).

The tool required by gitweb can be installed from the 'highlight'
package. Unfortunately, given the default $PATH, this leads to the
tool having lower precedence than the script.

In order to avoid hanging the test, add '</dev/null' to the command
line of the highlight invocation. Also, since the 'highlight' tool
requred by gitweb produces '--version' output (and the script does
not), saving the command output allows a simple check for the wrong
'highlight'.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/t9500-gitweb-standalone-no-errors.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 6fca193..718014d 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -683,9 +683,11 @@ test_expect_success \
 # syntax highlighting
 
 
-highlight --version >/dev/null 2>&1
+highlight_version=$(highlight --version </dev/null 2>/dev/null)
 if [ $? -eq 127 ]; then
-	say "Skipping syntax highlighting test, because 'highlight' was not found"
+	say "Skipping syntax highlighting tests: 'highlight' not found"
+elif test -z "$highlight_version"; then
+	say "Skipping syntax highlighting tests: incorrect 'highlight' found"
 else
 	test_set_prereq HIGHLIGHT
 	cat >>gitweb_config.perl <<-\EOF
-- 
1.8.4
