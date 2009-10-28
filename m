From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2] gitk: Use the --submodule option for displaying diffs
 when available
Date: Wed, 28 Oct 2009 12:40:45 +0100
Message-ID: <4AE82DBD.5070202@web.de>
References: <4AE70AC9.6040302@web.de> <19175.49800.697048.349753@drongo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 12:41:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N36uF-0001Hy-06
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 12:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbZJ1LlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 07:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752643AbZJ1LlV
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 07:41:21 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:54426 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbZJ1LlU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 07:41:20 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 6FB0C12BD1190;
	Wed, 28 Oct 2009 12:40:46 +0100 (CET)
Received: from [80.128.121.48] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1N36tS-0003eg-00; Wed, 28 Oct 2009 12:40:46 +0100
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
In-Reply-To: <19175.49800.697048.349753@drongo.ozlabs.ibm.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/A3d/AI/S7H1mBPKK+ORuYrwiLnYTj95c53YHz
	ejpcmxDMvqeGngjvrVr3562L2G8gei89ZtPtbYcvcP+MZo93u6
	vGfKX8m2J6ZFrUXdn/GA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131447>

Instead of just showing not-quite-helpful SHA-1 pairs in the diff display
of a submodule gitk will display the first lines of the corresponding
commit messages (similar to the output of 'git submodule summary') when
the underlying git installation supports this. That makes it much easier
to evaluate the changes, as it eliminates the need to start a gitk inside
the submodule and use the superprojects hashes there to find out what the
commits are about.

This patch applies to 'next' - which will be 1.6.6 or 1.7.0 when merged -
and uses the new --submodule option of git diff when a version of 1.6.6 or
higher is detected to achieve a more human readable output of submodule
differences in gitk.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---


Thanks for the review of the first version of this patch. I tried to
address all the issues raised and moved the additions of the --submodule
flag to the getblobdiffs procedure, where the --textconv flag is handled
too.


 gitk-git/gitk |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index a0214b7..b06cac7 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -7343,7 +7343,11 @@ proc getblobdiffs {ids} {
     if {[package vcompare $git_version "1.6.1"] >= 0} {
 	set textconv "--textconv"
     }
-    set cmd [diffcmd $ids "-p $textconv -C --cc --no-commit-id -U$diffcontext"]
+    set submodule {}
+    if {[package vcompare $git_version "1.6.6"] >= 0} {
+	set submodule "--submodule"
+    }
+    set cmd [diffcmd $ids "-p $textconv $submodule  -C --cc --no-commit-id -U$diffcontext"]
     if {$ignorespace} {
 	append cmd " -w"
     }
@@ -7481,6 +7485,21 @@ proc getblobdiffline {bdf ids} {
 	    set diffnparents [expr {[string length $ats] - 1}]
 	    set diffinhdr 0

+	} elseif {![string compare -length 10 "Submodule " $line]} {
+	    # start of a new submodule
+	    if {[string compare [$ctext get "end - 4c" end] "\n \n\n"]} {
+		$ctext insert end "\n";     # Add newline after commit message
+	    }
+	    set curdiffstart [$ctext index "end - 1c"]
+	    lappend ctext_file_names ""
+	    set fname [string range $line 10 [expr [string last " " $line] - 1]]
+	    lappend ctext_file_lines $fname
+	    makediffhdr $fname $ids
+	    $ctext insert end "\n$line\n" filesep
+	} elseif {![string compare -length 3 "  >" $line]} {
+	    $ctext insert end "$line\n" dresult
+	} elseif {![string compare -length 3 "  <" $line]} {
+	    $ctext insert end "$line\n" d0
 	} elseif {$diffinhdr} {
 	    if {![string compare -length 12 "rename from " $line]} {
 		set fname [string range $line [expr 6 + [string first " from " $line] ] end]
-- 
1.6.5.2.182.g3d976.dirty
