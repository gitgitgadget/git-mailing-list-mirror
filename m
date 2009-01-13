From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] grep: don't call regexec() for fixed strings
Date: Tue, 13 Jan 2009 00:13:18 -0800
Message-ID: <7vy6xfd3oh.fsf@gitster.siamese.dyndns.org>
References: <4967D8F8.9070508@lsrfire.ath.cx>
 <4967DB4A.2000702@lsrfire.ath.cx>
 <81b0412b0901120732t1bd1978awdc4be47767e02863@mail.gmail.com>
 <496B9780.3030000@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jan 13 09:14:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMeQF-0005Ca-AL
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 09:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018AbZAMIN1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jan 2009 03:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbZAMIN0
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 03:13:26 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36743 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434AbZAMIN0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jan 2009 03:13:26 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2184D8FDAC;
	Tue, 13 Jan 2009 03:13:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1ECF38FDAB; Tue,
 13 Jan 2009 03:13:20 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0CE6557A-E14A-11DD-BBDB-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105470>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> +#define RR GIT_REGEX_SPECIAL /* $, (, ), +, ., ^, {, | */
> +#define US GIT_UNDERSCORE
> +#define Ah (GIT_ALPHA | GIT_LOWER_XDIGIT)
> =20
>  unsigned char sane_ctype[256] =3D {
>  	GS,  0,  0,  0,  0,  0,  0,  0,  0, SS, SS,  0,  0, SS,  0,  0,		/*=
 0-15 */

Mental note.  NUL is marked as GIT_SPECIAL.

>  #define isspecial(x) sane_istest(x,GIT_SPECIAL)
> +#define isregexspecial(x) sane_istest(x,GIT_SPECIAL | GIT_REGEX_SPEC=
IAL)

Perhaps isspecial() is misnamed if we were to enhance git-ctype in this
way.  It is about a byte being shell glob pattern or a NUL (!!!), and i=
t
should be renamed to isglobspecial() or something.

dir.c uses isspecial() in two places, and both callers rely on NUL bein=
g a
part of special to terminate the loops they are in, like this:

	for (;;) {
		unsigned char c =3D *match++;
		len++;
		if (isspecial(c))
			return len;
	}

It may be a cunning and cute logic, but I do not particularly like it. =
 It
might be cleaner to rename it to isglobspecial(), drop NUL from it, and
have these two call existing call sites to explicitly check for (c =3D=3D=
 NUL)
for loop termination.
