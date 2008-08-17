From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Allow configure to override CC_LD_DYNPATH
Date: Sat, 16 Aug 2008 21:56:24 -0700
Message-ID: <7vwsig9r47.fsf@gitster.siamese.dyndns.org>
References: <1218891667-6014-1-git-send-email-gafunchal@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giovanni Funchal <gafunchal@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 06:58:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUaLp-0005i0-Gk
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 06:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbYHQE4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 00:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbYHQE4c
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 00:56:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbYHQE4c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 00:56:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B90315CB71;
	Sun, 17 Aug 2008 00:56:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AE6955CB70; Sun, 17 Aug 2008 00:56:27 -0400 (EDT)
In-Reply-To: <1218891667-6014-1-git-send-email-gafunchal@gmail.com> (Giovanni
 Funchal's message of "Sat, 16 Aug 2008 15:01:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DB64E65C-6C18-11DD-B13A-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92574>

Giovanni Funchal <gafunchal@gmail.com> writes:

> @@ -689,7 +689,6 @@ ifeq ($(uname_S),NetBSD)
>  	endif
>  	BASIC_CFLAGS += -I/usr/pkg/include
>  	BASIC_LDFLAGS += -L/usr/pkg/lib
> -	ALL_LDFLAGS += -Wl,-rpath,/usr/pkg/lib
>  endif
>  ifeq ($(uname_S),AIX)
>  	NO_STRCASESTR=YesPlease
> @@ -763,9 +762,21 @@ ifneq (,$(findstring arm,$(uname_M)))
>  	ARM_SHA1 = YesPlease
>  endif
>  
> +# Runtime dynamic library path switch
> +ifdef NO_R_TO_GCC_LINKER
> +	# Some linkers use -Wl,-rpath,
> +	CC_LD_DYNPATH = -Wl,-rpath,
> +else
> +	# Some others need -R
> +	CC_LD_DYNPATH = -R
> +endif
> +
>  -include config.mak.autogen
>  -include config.mak
>  
> +ifeq ($(uname_S),NetBSD)
> +	ALL_LDFLAGS += $(CC_LD_DYNPATH)/usr/pkg/lib
> +endif

I think this NetBSD change might be a good idea.

By moving "ifdef" before where we "include config.mak", however, you broke
existing setups that use NO_R_TO_GCC_LINKER to cause "-Wl,-rpath=" to be
used.

How about doing it the way the attached patch does instead?  Then the
autoconf can configure CC_LD_DYNPATH to be used that may even be different
from "-Wl,-rpath=" (e.g. the one with double-dash "-Wl,--rpath").

 Makefile |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 53ab4b5..264ede3 100644
--- a/Makefile
+++ b/Makefile
@@ -688,8 +688,7 @@ ifeq ($(uname_S),NetBSD)
 		NEEDS_LIBICONV = YesPlease
 	endif
 	BASIC_CFLAGS += -I/usr/pkg/include
-	BASIC_LDFLAGS += -L/usr/pkg/lib
-	ALL_LDFLAGS += -Wl,-rpath,/usr/pkg/lib
+	BASIC_LDFLAGS += -L/usr/pkg/lib $(CC_LD_DYNPATH)/usr/pkg/lib
 endif
 ifeq ($(uname_S),AIX)
 	NO_STRCASESTR=YesPlease
@@ -781,12 +780,14 @@ ifeq ($(uname_S),Darwin)
 	endif
 endif
 
-ifdef NO_R_TO_GCC_LINKER
-	# Some gcc does not accept and pass -R to the linker to specify
-	# the runtime dynamic library path.
-	CC_LD_DYNPATH = -Wl,-rpath=
-else
-	CC_LD_DYNPATH = -R
+ifndef CC_LD_DYNPATH
+	ifdef NO_R_TO_GCC_LINKER
+		# Some gcc does not accept and pass -R to the linker to specify
+		# the runtime dynamic library path.
+		CC_LD_DYNPATH = -Wl,-rpath,
+	else
+		CC_LD_DYNPATH = -R
+	endif
 endif
 
 ifdef NO_CURL
