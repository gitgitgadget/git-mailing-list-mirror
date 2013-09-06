From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH/RFC] t9500-*.sh: Fix highlight test hang on Linux Mint
Date: Fri, 06 Sep 2013 23:05:25 +0100
Message-ID: <522A51A5.9090905@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, hvoigt@hvoigt.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 07 00:13:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI4HE-0003If-9y
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 00:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827Ab3IFWNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 18:13:12 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:57516 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751258Ab3IFWNM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 18:13:12 -0400
X-Greylist: delayed 393 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Sep 2013 18:13:11 EDT
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 8A8F3A64B8B;
	Fri,  6 Sep 2013 23:06:36 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 57A4CA64977;
	Fri,  6 Sep 2013 23:06:36 +0100 (BST)
Received: from [192.168.254.3] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Fri,  6 Sep 2013 23:06:35 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234106>


Linux Mint has an implementation of the highlight command (unrelated
to the one from http://www.andre-simon.de) that works as a simple
filter. The script uses 'sed' to add terminal colour escape codes
around text matching a regular expression. When t9500-*.sh attempts
to run "highlight --version", the script simply hangs waiting for
input. (See https://bugs.launchpad.net/linuxmint/+bug/815005).

The tool required by gitweb can be installed from the 'highlight'
package. Unfortunately, given the default $PATH, this leads to the
tool having lower precedence than the script.

In order to allow the user to specify the correct tool, introduce
the GIT_TEST_HIGHLIGHT_BIN variable. Also, add '</dev/null' to the
command line of the highlight invocation; this avoids hanging the
test if the filter script is used nonetheless.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

I recently upgraded my Ubuntu installation to Linux Mint 15 Cinnamon.
(Unity makes me want to throw my laptop at the wall!)

Having tickled this bug, I solved the problem by building highlight
v3.15 from source and installing in $HOME.

This patch is marked RFC because this bug does not seem to have
affected too many people (given that Heiko reported the problem
back in 2011) ... :-D

[Also, note that I didn't fix up the form of the conditional.]

ATB,
Ramsay Jones


 t/t9500-gitweb-standalone-no-errors.sh | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 6fca193..0208c8e 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -683,14 +683,18 @@ test_expect_success \
 # syntax highlighting
 
 
-highlight --version >/dev/null 2>&1
+GIT_TEST_HIGHLIGHT_BIN=${GIT_TEST_HIGHLIGHT_BIN:-highlight}
+highlight_version=$($GIT_TEST_HIGHLIGHT_BIN --version </dev/null 2>/dev/null)
 if [ $? -eq 127 ]; then
-	say "Skipping syntax highlighting test, because 'highlight' was not found"
+	say "Skipping syntax highlighting tests: 'highlight' not found"
+elif test -z "$highlight_version"; then
+	say "Skipping syntax highlighting tests: incorrect 'highlight' found"
+	say "set GIT_TEST_HIGHLIGHT_BIN to full path of highlight program"
 else
 	test_set_prereq HIGHLIGHT
-	cat >>gitweb_config.perl <<-\EOF
-	our $highlight_bin = "highlight";
-	$feature{'highlight'}{'override'} = 1;
+	cat >>gitweb_config.perl <<-EOF
+	our \$highlight_bin = "$GIT_TEST_HIGHLIGHT_BIN";
+	\$feature{'highlight'}{'override'} = 1;
 	EOF
 fi
 
-- 
1.8.4
