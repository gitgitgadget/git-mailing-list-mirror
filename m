From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH v2 1/4] engine.pl: Fix a recent breakage of the buildsystem
 generator
Date: Fri, 22 Jan 2010 20:00:47 +0000
Message-ID: <4B5A03EF.1030208@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, sschuberth@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>, pgit@pcharlan.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 21:06:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYPlb-0004AQ-Gg
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 21:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558Ab0AVUF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 15:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753473Ab0AVUF6
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 15:05:58 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:49339 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753282Ab0AVUF5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2010 15:05:57 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1NYPlU-00003c-Ww; Fri, 22 Jan 2010 20:05:56 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137780>


Commit ade2ca0c (Do not try to remove directories when removing
old links, 27-10-2009) added an expression to a 'test' using an
'-o' or connective. This resulted in the buildsystem generator
mistaking a conditional 'rm' for a linker command. In order to
fix the breakage, we filter out all 'test' commands before then
attempting to identify the commands of interest.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Changes from v1, in response to comments from Pete Harlan and
Sebastian Schuberth:

    - remove second (useless) regex from condition in filter code
    - remove the commented out version of the original filter code
    - re-worded commit message to reflect the above changes

ATB,
Ramsay Jones

 contrib/buildsystems/engine.pl |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index d506717..8f890fb 100644
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -135,6 +135,11 @@ sub parseMakeOutput
             }
         } while($ate_next);
 
+        if ($text =~ /^test /) {
+            # options to test (eg -o) may be mistaken for linker options
+            next;
+        }
+
         if($text =~ / -c /) {
             # compilation
             handleCompileLine($text, $line);
@@ -180,9 +185,6 @@ sub parseMakeOutput
 #        } elsif ($text =~ /generate-cmdlist\.sh/) {
 #            # command for generating list of commands
 #
-#        } elsif ($text =~ /^test / && $text =~ /|| rm -f /) {
-#            # commands removing executables, if they exist
-#
 #        } elsif ($text =~ /new locations or Tcl/) {
 #            # command for detecting Tcl/Tk changes
 #
-- 
1.6.6
