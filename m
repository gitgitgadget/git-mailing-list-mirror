From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/4] engine.pl: Fix a recent breakage of the buildsystem generator
Date: Wed, 20 Jan 2010 19:23:36 +0000
Message-ID: <4B575838.2010504@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, sschuberth@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 21:35:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXhGm-0001cs-44
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 21:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480Ab0ATUfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 15:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754419Ab0ATUfF
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 15:35:05 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:35969 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754369Ab0ATUe6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2010 15:34:58 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1NXhGS-0001mW-Wo; Wed, 20 Jan 2010 20:34:56 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137573>


Commit ade2ca0c (Do not try to remove directories when removing
old links, 27-10-2009) added an expression to a 'test' using an
'-o' or connective. This resulted in the buildsystem generator
mistaking the conditional 'rm' for a linker command. In order
to fix the breakage, we filter the out the conditional 'rm'
commands before attempting to identify other commands.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 contrib/buildsystems/engine.pl |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index d506717..245af73 100644
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -135,6 +135,11 @@ sub parseMakeOutput
             }
         } while($ate_next);
 
+        if ($text =~ /^test / && $text =~ /|| rm -f /) {
+            # commands removing executables, if they exist
+            next;
+        }
+
         if($text =~ / -c /) {
             # compilation
             handleCompileLine($text, $line);
-- 
1.6.6
