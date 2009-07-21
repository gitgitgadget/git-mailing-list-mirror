From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] configure.ac: rework/fix the NEEDS_RESOLV and
 NEEDS_LIBGEN tests
Date: Tue, 21 Jul 2009 13:33:36 -0700
Message-ID: <7v3a8pdbdr.fsf@alter.siamese.dyndns.org>
References: <qSl_KXgcJD_1H47Nrg3FwRdtL-WxwLP1_aueDE8gN-By3M0uJOpw1w@cipher.nrlssc.navy.mil> <N0R1rELOlDFDG8pOY2LYJHmWygM5WFD8q_fNZgfE1A2QOX1yg6OPCZW4RbX5i03hokq4Bx2zOjM@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nicolas.s.dev@gmx.fr, git@vger.kernel.org, j6t@kdbg.org,
	peff@peff.net, david@syzdek.net, jnareb@gmail.com, bonzini@gnu.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:33:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTM2A-000736-UC
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755655AbZGUUdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755410AbZGUUdv
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:33:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61904 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190AbZGUUdv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:33:51 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C9F62C838;
	Tue, 21 Jul 2009 16:33:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9891FC834; Tue, 21 Jul 2009
 16:33:38 -0400 (EDT)
In-Reply-To: <N0R1rELOlDFDG8pOY2LYJHmWygM5WFD8q_fNZgfE1A2QOX1yg6OPCZW4RbX5i03hokq4Bx2zOjM@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Tue\, 21 Jul 2009 15\:23\:06 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CCBC0536-7635-11DE-A342-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123709>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Maybe this is the appropriate thing to do?

Thanks.

Instead of saying that "hstrerror not in -lc means we do have -lresolv and
the function will be found there" blindly, we may want to have a nested
check.

	AC_CHECK_LIB([c], [hstrerror], [NEEDS_RESOLV=],
       	    AC_CHECK_LIB([resolv], [hstrerror], [NEEDS_RESOLV=YesPlease]))

But we do not have any provision for the case where -lc does not have it
and -lresolv does not have it either (or -lresolv does not exist) anyway,
so we might as well go with your patch.

I take it that swapping [if-found][if-not-found] parameters is what the
autoconf documentation warns against?  That is, both -lc and -lresolv may
have it but -lresolv one may be a specialized one you would not normally
want.

>  configure.ac |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 74d0af5..ba44cf2 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -479,13 +479,13 @@ test -n "$NEEDS_SOCKET" && LIBS="$LIBS -lsocket"
>  # Define NEEDS_RESOLV if linking with -lnsl and/or -lsocket is not enough.
>  # Notably on Solaris hstrerror resides in libresolv and on Solaris 7
>  # inet_ntop and inet_pton additionally reside there.
> -AC_CHECK_LIB([resolv], [hstrerror],
> +AC_CHECK_LIB([c], [hstrerror],
>  [NEEDS_RESOLV=],
>  [NEEDS_RESOLV=YesPlease])
>  AC_SUBST(NEEDS_RESOLV)
>  test -n "$NEEDS_RESOLV" && LIBS="$LIBS -lresolv"
>  
> -AC_CHECK_LIB([gen], [basename],
> +AC_CHECK_LIB([c], [basename],
>  [NEEDS_LIBGEN=],
>  [NEEDS_LIBGEN=YesPlease])
>  AC_SUBST(NEEDS_LIBGEN)
> -- 
> 1.6.3.1.24.g152f4
