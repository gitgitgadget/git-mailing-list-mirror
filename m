From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Simplify MSGFMT setting in Makefile
Date: Tue, 11 Mar 2008 22:29:52 -0700
Message-ID: <7vr6eg7bn3.fsf_-_@gitster.siamese.dyndns.org>
References: <46a038f90802211553g735215c6q260ddc49ac149bb5@mail.gmail.com>
 <46a038f90802211559w457c5460k7447ba8b38352713@mail.gmail.com>
 <20080222065836.GE8410@spearce.org>
 <46a038f90802220957y7db67d8nb6b7ad784124546a@mail.gmail.com>
 <47C5A974.7080207@gmail.com> <alpine.LSU.1.00.0802271825330.22527@racer.site>
 <47C5AEFA.5020004@gmail.com> <alpine.LSU.1.00.0802272203270.22527@racer.site>
 <7vablmqc7q.fsf@gitster.siamese.dyndns.org> <47C7000C.1000809@gmail.com>
 <20080305071915.GI8410@spearce.org>
 <7v63w0gs87.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 12 06:31:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZJYS-0007eF-5K
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 06:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbYCLFaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 01:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbYCLFaJ
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 01:30:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64798 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbYCLFaI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 01:30:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C687B38B1;
	Wed, 12 Mar 2008 01:30:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E899F38B0; Wed, 12 Mar 2008 01:30:00 -0400 (EDT)
In-Reply-To: <7v63w0gs87.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 06 Mar 2008 00:40:56 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76925>

To prepare msg files for Tcl scripts, the command that is set to MSGFMT
make variable needs to be able to grok "--tcl -l <lang> -d <here>" options
correctly.  This patch simplifies the tests done in git-gui's Makefile to
directly test this condition.  If the test run does not exit properly with
zero status (either because you do not have "msgfmt" itself, or your
"msgfmt" is too old to grok --tcl option --- the reason does not matter),
have it fall back to po/po2msg.sh

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I am planning to close 'master' for -rc1 by the end of this week, so
   please plan to tell me to pull if you have accumulated changes,
   thanks.

 Makefile |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 4e32174..95e99f2 100644
--- a/Makefile
+++ b/Makefile
@@ -221,14 +221,9 @@ ifdef NO_MSGFMT
 	MSGFMT ?= $(TCL_PATH) po/po2msg.sh
 else
 	MSGFMT ?= msgfmt
-	ifeq ($(shell $(MSGFMT) >/dev/null 2>&1 || echo $$?),127)
+	ifneq ($(shell $(MSGFMT) --tcl -l C -d . /dev/null 2>/dev/null; echo $?),0)
 		MSGFMT := $(TCL_PATH) po/po2msg.sh
 	endif
-	ifeq (msgfmt,$(MSGFMT))
-	ifeq ($(shell $(MSGFMT) --tcl -l C -d . /dev/null 2>/dev/null || echo $?),1)
-		MSGFMT := $(TCL_PATH) po/po2msg.sh
-	endif
-	endif
 endif
 
 msgsdir     = $(gg_libdir)/msgs
