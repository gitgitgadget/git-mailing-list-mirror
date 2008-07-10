From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] git-imap-send: Add support for SSL.
Date: Wed, 09 Jul 2008 18:20:32 -0700
Message-ID: <7v8wwa5ycf.fsf@gitster.siamese.dyndns.org>
References: <1215638942-25010-2-git-send-email-robertshearman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robert Shearman <rob@codeweavers.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Robert Shearman <robertshearman@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 03:22:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGkrq-0004lq-Jv
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 03:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbYGJBUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 21:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbYGJBUn
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 21:20:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44771 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbYGJBUn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 21:20:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 115EC1DCB5;
	Wed,  9 Jul 2008 21:20:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1C0D81DCAD; Wed,  9 Jul 2008 21:20:35 -0400 (EDT)
In-Reply-To: <1215638942-25010-2-git-send-email-robertshearman@gmail.com>
 (Robert Shearman's message of "Wed, 9 Jul 2008 22:29:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 69B738B0-4E1E-11DD-9DFA-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87927>

Robert Shearman <robertshearman@gmail.com> writes:

> diff --git a/imap-send.c b/imap-send.c
> index 24d76a7..26d1dba 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -23,6 +23,12 @@
>   */
>  
>  #include "cache.h"
> +#ifdef NO_OPENSSL
> +typedef void *SSL;
> +#else
> +# include <openssl/ssl.h>
> +# include <openssl/err.h>
> +#endif

This unfortunately is causing compilation issues.  <openssl/ssl.h> wants
to include <ctype.h> and gets upset by seeing our isalpha() and friends
that are defined indirectly in "cache.h" expanded.

In <ctype.h> (on FC9), isCHARACTERISTC() are defined like this:

	#define __exctype(name) extern int name (int) __THROW
	...
        __exctype (isalnum);
        __exctype (isalpha);

but we have been using our own locale agonistic and signed-chars safe
macros defined in git-compat-util.h.  Including <ctype.h> breaks at the
syntax level, but more importantly if the system <ctype.h> redefines
isalpha() and friends as macro, then it would break _our_ code that expect
these macros are the sane_ctype[] based ones we have.

A hack like the one attached below would make it "work" but it is too
ugly.  Probably we need to bite the bullet and rename ours not to
collide, so that external library headers can safely include <ctype.h>.

Sigh...

diff --git a/git-compat-util.h b/git-compat-util.h
index 8c7e114..0af6406 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -302,6 +302,7 @@ static inline int has_extension(const char *filename, const char *ext)
 }
 
 /* Sane ctype - no locale, and works with signed chars */
+#define _CTYPE_H
 #undef isspace
 #undef isdigit
 #undef isalpha
