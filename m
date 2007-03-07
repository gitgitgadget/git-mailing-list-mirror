From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: [PATCH] Avoid rebuilding everything if user changes CFLAGS on the make 
 command line
Date: Wed, 07 Mar 2007 14:41:54 +0100
Organization: eudaptics software gmbh
Message-ID: <45EEC122.EA43CB72@eudaptics.com>
References: <Pine.LNX.4.63.0703062249540.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <45EE854E.210EDAFF@eudaptics.com> <Pine.LNX.4.63.0703071319520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 07 14:39:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOwMc-00046Q-Ir
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 14:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965454AbXCGNjY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 08:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965468AbXCGNjY
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 08:39:24 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160]:21304 "EHLO
	linz.eudaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965454AbXCGNjY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 08:39:24 -0500
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 18E5054D; Wed,  7 Mar 2007 14:39:21 +0100 (CET)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41668>

From: Johannes Sixt <johannes.sixt@telecom.at>

The following sequence of commands is commonly used to recompile
selected files with different flags, for example, to change the debug
information:

   make
   rm builtin-diff.o
   make CFLAGS="-g -O0"

However, the Makefile is clever enough to notice that the second 'make'
invocation changes the build flags and rebuilds everything.

This change exempts the value of CFLAGS (which is explicitly declared
as reserved for the user to change from the command line) from this
auto-detection.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
Johannes Schindelin wrote:
>  GIT-CFLAGS: .FORCE-GIT-CFLAGS
>         @FLAGS='$(TRACK_CFLAGS)'; \
> -           if test x"$$FLAGS" != x"`cat GIT-CFLAGS 2>/dev/null`" ; then \
> +           if test x"$$FLAGS" != x"`cat GIT-CFLAGS 2>/dev/null`" -a \
> +                   -z "$(IGNORE_GIT_CFLAGS)"; then \
>                 echo 1>&2 "    * new build flags or prefix"; \
>                 echo "$$FLAGS" >GIT-CFLAGS; \
>              fi

IMHO, the value of $(CFLAGS) (which the Makefile declares as "for the
users to override from the command line") should never take part in this
build-flags-change-autodetection.

-- Hannes

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 9a37b15..8410530 100644
--- a/Makefile
+++ b/Makefile
@@ -812,7 +812,7 @@ tags:
 	find . -name '*.[hcS]' -print | xargs ctags -a
 
 ### Detect prefix changes
-TRACK_CFLAGS = $(subst ','\'',$(ALL_CFLAGS)):\
+TRACK_CFLAGS = $(subst ','\'',$(BASIC_CFLAGS)):\
             
$(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ)
 
 GIT-CFLAGS: .FORCE-GIT-CFLAGS
-- 
1.5.0.2.279.g4808
