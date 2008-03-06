From: Junio C Hamano <gitster@pobox.com>
Subject: Re: msgmft segfaulting on tiger
Date: Thu, 06 Mar 2008 00:40:56 -0800
Message-ID: <7v63w0gs87.fsf@gitster.siamese.dyndns.org>
References: <46a038f90802211553g735215c6q260ddc49ac149bb5@mail.gmail.com>
 <46a038f90802211559w457c5460k7447ba8b38352713@mail.gmail.com>
 <20080222065836.GE8410@spearce.org>
 <46a038f90802220957y7db67d8nb6b7ad784124546a@mail.gmail.com>
 <47C5A974.7080207@gmail.com> <alpine.LSU.1.00.0802271825330.22527@racer.site>
 <47C5AEFA.5020004@gmail.com> <alpine.LSU.1.00.0802272203270.22527@racer.site>
 <7vablmqc7q.fsf@gitster.siamese.dyndns.org> <47C7000C.1000809@gmail.com>
 <20080305071915.GI8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gabriel =?utf-8?Q?Salda=C3=B1a?= <gsaldana@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 09:42:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXBfx-0001nI-D0
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 09:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011AbYCFIlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 03:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754262AbYCFIlL
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 03:41:11 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011AbYCFIlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 03:41:09 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C9C591D0A;
	Thu,  6 Mar 2008 03:41:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E18671D07; Thu,  6 Mar 2008 03:40:58 -0500 (EST)
In-Reply-To: <20080305071915.GI8410@spearce.org> (Shawn O. Pearce's message
 of "Wed, 5 Mar 2008 02:19:15 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76355>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Just to revive a nearly dead thead...  I have a workaround now in
> git-gui maint that looks for this case and falls into our po2msg
> script when msgfmt doesn't see --tcl.
>
> I also set Paul Mackerras a patch for gitk, so it can do the
> same thing.  Maybe Git 1.5.4.4 will include both patches.

I looked at what you have in your Makefile.  

It makes me wonder, however, if it makes more sense to squash the two
invocations of msgfmt you make into one, like the attached patch.

The point is that msgfmt you guys want to use _must_ understand --tcl,
and a msgfmt new enough to be usable would exit with 0 on the above
command line.

-- >8 --
gitk i18n: Fall back to po2msg.sh if msgfmt --tcl fails

Some platforms may have a msgfmt that doesn't understand --tcl.  Mac OS X
Tiger is an example.

Falling back to po2msg.sh on such systems is a reasonable behavior.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index ae2b80b..c72e7f7 100644
--- a/Makefile
+++ b/Makefile
@@ -22,6 +22,9 @@ ifdef NO_MSGFMT
 	MSGFMT ?= $(TCL_PATH) po/po2msg.sh
 else
 	MSGFMT ?= msgfmt
+	ifneq ($(shell $(MSGFMT) --tcl -l C -d . /dev/null 2>/dev/null; echo $?),0)
+		MSGFMT = $(TCL_PATH) po/po2msg.sh 
+	endif
 endif
 
 PO_TEMPLATE = po/gitk.pot

