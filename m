From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix crash in path.c on Windows
Date: Wed, 04 Feb 2009 15:51:27 -0800
Message-ID: <7vbpthlq0w.fsf@gitster.siamese.dyndns.org>
References: <498A1E1E.8010901@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Feb 05 00:53:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUrYd-0006sf-63
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 00:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760642AbZBDXvi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Feb 2009 18:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760040AbZBDXvi
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 18:51:38 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35416 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760614AbZBDXvh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Feb 2009 18:51:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5DD2B9638C;
	Wed,  4 Feb 2009 18:51:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CEDCE9637F; Wed,
  4 Feb 2009 18:51:30 -0500 (EST)
In-Reply-To: <498A1E1E.8010901@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Thu, 05 Feb 2009 00:00:46 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C19564F6-F316-11DD-A4A8-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108471>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> @@ -387,7 +387,7 @@ int normalize_absolute_path(char *buf, const char=
 *path)
>  	assert(path);
> =20
>  	while (*comp_start) {
> -		assert(*comp_start =3D=3D '/');
> +		assert(is_absolute_path(comp_start));
>  		while (*++comp_end && *comp_end !=3D '/')
>  			; /* nothing */
>  		comp_len =3D comp_end - comp_start;

This change does not make sense to me.  The assert is about the initial
iteration beginning at the "root" level, and at the same time previous
iteration ended at dir_sep.  On mingw you would probably need these two=
 as
separate tests.  In other words, I would understand if the fix were lik=
e
this:

	if (it begins with dos_prefix) {
        	/* this is never true outside windows */
		copy the dos prefix out and advance comp_start as
        	necessary;
	}
        while (*comp_start) {
        	assert(is_dir_sep(*comp_start));
                while (*++comp_end && !is_dir_sep(*comp_end))
                	; /* nothing */
		...
	}
