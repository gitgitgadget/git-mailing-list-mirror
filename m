From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] run-command: don't try to execute directories
Date: Tue, 02 Oct 2012 12:59:58 -0700
Message-ID: <7vd3107igx.fsf@alter.siamese.dyndns.org>
References: <1349189193-25497-1-git-send-email-cmn@elego.de>
 <7vvces93qj.fsf@alter.siamese.dyndns.org> <87bogkisas.fsf@centaur.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: cmn@elego.de (Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto)
X-From: git-owner@vger.kernel.org Tue Oct 02 22:01:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ8dj-0004Wa-4h
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 22:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480Ab2JBUAJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Oct 2012 16:00:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52776 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752468Ab2JBUAH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Oct 2012 16:00:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B346919A;
	Tue,  2 Oct 2012 16:00:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2O8qeHw+Js3h
	2IblYTQ4g1Y12pM=; b=olPjaHHeEBXXuVRtoAXqetNBQAs7BoFUUCAx95wK/1Jl
	SYH/r5zOVM88bNfG6/oobmBMb0o4rc+8XEHFVz+mjMHto9sNQzN+v4TvTYl3Pepw
	LXnPs6jJE7TKykLZ0khKUWhHs00v4uUPnlX7Wv/E0vYoVMz0dzTwNuXQ8HVi2oU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=q/1/ol
	EABhBdixn0/o+BToT3vlDWSA/aI8k1RS7bScByOrUCel9eJtrzeaTH5rFLDVCHjR
	E+57LwSqw0mlkqQRDHU3FrZnEMJj3EuqBQ9yIde55hq8pqYyGs6sVsMuOuDD0G+G
	Zj5eaU+Cvp4QgCT0ZPSGdxFaW6cOwaCwcptZ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6714A9195;
	Tue,  2 Oct 2012 16:00:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41A63918B; Tue,  2 Oct 2012
 16:00:00 -0400 (EDT)
In-Reply-To: <87bogkisas.fsf@centaur.cmartin.tk> ("Carlos =?utf-8?Q?Mart?=
 =?utf-8?Q?=C3=ADn?= Nieto"'s message of "Tue, 02 Oct 2012 21:32:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF59DF50-0CCB-11E2-BC14-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206844>

cmn@elego.de (Carlos Mart=C3=ADn Nieto) writes:

> How about something like this instead? We keep the access check and o=
nly
> do the stat call when we have found something we want to look at.

Sounds safer.

Looking at the way the stat call is indented twice, I suspect that
the variable can be defined inner scope, not at the top-level of the
function?

>
> ---8<---
>
> diff --git a/run-command.c b/run-command.c
> index 1101ef7..fb8a93c 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -85,6 +85,7 @@ static char *locate_in_PATH(const char *file)
>  {
>         const char *p =3D getenv("PATH");
>         struct strbuf buf =3D STRBUF_INIT;
> +       struct stat st;
> =20
>         if (!p || !*p)
>                 return NULL;
> @@ -101,7 +102,8 @@ static char *locate_in_PATH(const char *file)
>                 }
>                 strbuf_addstr(&buf, file);
> =20
> -               if (!access(buf.buf, F_OK))
> +               if (!access(buf.buf, F_OK) &&
> +                   !stat(buf.buf, &st) && !S_ISDIR(st.st_mode))
>                         return strbuf_detach(&buf, NULL);
> =20
>                 if (!*end)
