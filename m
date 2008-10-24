From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (Oct 2008, #03; Tue, 14)
Date: Thu, 23 Oct 2008 19:44:27 -0700
Message-ID: <7vod1a3e5w.fsf@gitster.siamese.dyndns.org>
References: <7vej2i7rt9.fsf@gitster.siamese.dyndns.org>
 <bsftmRx17krWBpVlulipoJEO1fWsD0hZfF3HOZcajX6GV66RKW8W6A@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Arjen Laarhoven <arjen@yaph.org>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Mike Ralphson" <mike@abacus.co.uk>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Oct 24 04:46:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtChI-00032D-I0
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 04:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbYJXCoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 22:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbYJXCon
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 22:44:43 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61405 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbYJXCon (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 22:44:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7AF2D8EC1D;
	Thu, 23 Oct 2008 22:44:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B20A18EC1B; Thu, 23 Oct 2008 22:44:29 -0400 (EDT)
In-Reply-To: <bsftmRx17krWBpVlulipoJEO1fWsD0hZfF3HOZcajX6GV66RKW8W6A@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Wed, 15 Oct 2008 10:35:30 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B53D6FB6-A175-11DD-8B9B-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98998>

Brandon Casey <casey@nrlssc.navy.mil> writes:

>   2) Do we want to stick with compat/regex on
>
>       Darwin: Arjen
>      FreeBSD: Jeff
>          AIX: Mike
>
>      now that the builtin funcname patterns have been converted to Extended
>      Regular Expressions?

-- >8 --
Subject: Stop using compat/regex.c on platforms with working regexp library

We used to have non-POSIX comformant BRE in our code, and linked with GNU
regexp library on a few platforms (Darwin, FreeBSD and AIX) to work it
around.  This was backwards.

We've fixed the broken regexps to use ERE that native regexp libraries on
these platforms can handle just fine.  There is no need to link with GNU
regexp library on these platforms anymore.

Tested-on-AIX-by: Mike Ralphson <mike@abacus.co.uk>
Tested-on-FreeBSD-by: Jeff King <peff@peff.net>
Tested-on-Darwin-by: Arjen Laarhoven <arjen@yaph.org>
Tested-on-Darwin-by: Pieter de Bie <pieter@frim.nl>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git c/Makefile w/Makefile
index d6f3695..40309e1 100644
--- c/Makefile
+++ w/Makefile
@@ -640,8 +640,6 @@ ifeq ($(uname_S),Darwin)
 	endif
 	NO_STRLCPY = YesPlease
 	NO_MEMMEM = YesPlease
-	COMPAT_CFLAGS += -Icompat/regex
-	COMPAT_OBJS += compat/regex/regex.o
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
@@ -692,8 +690,6 @@ ifeq ($(uname_S),FreeBSD)
 	BASIC_LDFLAGS += -L/usr/local/lib
 	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
 	THREADED_DELTA_SEARCH = YesPlease
-	COMPAT_CFLAGS += -Icompat/regex
-	COMPAT_OBJS += compat/regex/regex.o
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
@@ -720,8 +716,6 @@ ifeq ($(uname_S),AIX)
 	INTERNAL_QSORT = UnfortunatelyYes
 	NEEDS_LIBICONV=YesPlease
 	BASIC_CFLAGS += -D_LARGE_FILES
-	COMPAT_CFLAGS += -Icompat/regex
-	COMPAT_OBJS += compat/regex/regex.o
 endif
 ifeq ($(uname_S),GNU)
 	# GNU/Hurd
