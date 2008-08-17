From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] Only define NEEDS_SOCKET if libsocket is usable
Date: Sun, 17 Aug 2008 02:16:15 -0700
Message-ID: <7v63q080io.fsf@gitster.siamese.dyndns.org>
References: <2EA0EACE-D8FE-476A-BAE2-7E12EE961C46@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Andreas =?utf-8?Q?F=C3=A4rber?= <andreas.faerber@web.de>
X-From: git-owner@vger.kernel.org Sun Aug 17 11:17:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUeO6-0000b7-LI
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 11:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbYHQJQY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Aug 2008 05:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbYHQJQY
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 05:16:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbYHQJQX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Aug 2008 05:16:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5935A64EAE;
	Sun, 17 Aug 2008 05:16:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B16AA64EAD; Sun, 17 Aug 2008 05:16:18 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 28C0DB94-6C3D-11DD-8309-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92591>

Andreas F=C3=A4rber <andreas.faerber@web.de> writes:

> diff --git a/configure.ac b/configure.ac
> index 7c2856e..75ec83a 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -223,11 +223,11 @@ AC_LINK_IFELSE(ZLIBTEST_SRC,
>  LIBS=3D"$old_LIBS"
>  AC_SUBST(NO_DEFLATE_BOUND)
>  #
> -# Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
> +# Define NEEDS_SOCKET if linking with libc is required (SunOS,
>  # Patrick Mauritz).
> -AC_CHECK_LIB([c], [socket],
> -[NEEDS_SOCKET=3D],
> -[NEEDS_SOCKET=3DYesPlease])
> +AC_CHECK_LIB([socket], [socket],
> +[NEEDS_SOCKET=3DYesPlease],
> +[NEEDS_SOCKET=3D])
>  AC_SUBST(NEEDS_SOCKET)
>  test -n "$NEEDS_SOCKET" && LIBS=3D"$LIBS -lsocket"

Doesn't this force linkage with -lsocket even if -lc is enough to use
socket(2) calls?

In other words, "checking libc is not enough" is only half correct.  Th=
e
right thing to do is "check libc and if it is sufficient be happy, but
otherwise do not automatically assume -lsocket is Ok."  Something like:

AC_CHECK_LIB([c], [socket],
[NEEDS_SOCKET=3D],
[AC_CHECK_LIB([socket], [socket],
        	[NEEDS_SOCKET=3DYesPlease],
                [NEEDS_SOCKET=3D])])

Other patches seemed Ok from my cursory look; I do not know the
people whose Ack's were on your patch submission, though...

Thanks.
