From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] editor: use canonicalized absolute path
Date: Mon, 29 Jul 2013 07:56:58 -0700
Message-ID: <7v8v0p2z45.fsf@alter.siamese.dyndns.org>
References: <1375030782-13339-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= Duy 
	<pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 16:57:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3oso-0000Qg-10
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 16:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571Ab3G2O5F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jul 2013 10:57:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34410 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755Ab3G2O5D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jul 2013 10:57:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 348CD34222;
	Mon, 29 Jul 2013 14:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1zZ1MEcBMh0h
	8qG+elYhZgQ8T1Q=; b=HwHXGr6qrJ3qbAzwsLkkzJkVrwuVa3wQucRWfX4KBY0L
	gjQzJKF2r4AitMZApk+oT8HJRuUQsQjyqi7wXYkB9a6HscFyEQb93me1ERnv17QH
	jIyk4LLwAF9ozcVyJV6HET4QJGxeeggra0HinULIK+VXFt6nZCNaXqxzmdPJgvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YMRcif
	n8SGBCAqVx1zDXn/ND8BlavWboTQ/VB3slMqDZWzkNweXpKCqQ8Q41cz0d6bFMMc
	ntdhu/ZURhaHhzDtB7d29yOVtu+1Y8la/U73vLCuOlUraaDvKgRIGKD0P093BK/3
	niU1jSXnc2vDxAu/jmPR/SKZrq8r41F7BRJl0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B97034221;
	Mon, 29 Jul 2013 14:57:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77B9D3421F;
	Mon, 29 Jul 2013 14:57:00 +0000 (UTC)
In-Reply-To: <1375030782-13339-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sun, 28 Jul 2013 22:29:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F48B740-F85F-11E2-B6AE-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231285>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> By improving the relative_path() algorithm, e02ca72 (path.c: refactor
> relative_path(), not only strip prefix, 2013-06-25) uncovered a laten=
t
> bug.  While most editor applications like cat and vim handle
> non-canonicalized relative paths fine, emacs does not.  This is due t=
o a
> long-standing bug in emacs, where it refuses to resolve symlinks in t=
he
> supplied path:
>
>   #!/bin/sh
>   mkdir z z/a z/b
>   echo moodle >z/a/file
>   ln -s z/b
>   cd b
>   emacs ../a/file # fail: opens /tmp/a/file

Somewhat puzzling.  Perhaps you want to add "cd /tmp" at the very
beginning of the script to clarify, and s/opens/attempts to open/
to avoid confusing a little panda brain.

>
> Even if emacs were to be patched to fix this bug now, we still need t=
o
> support users running older versions.
>
> Co-authored-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

That's a bit strange---the patch text looks like the "how about
this" patch Duy posted earlier.  Shouldn't it be From: Duy with
S-o-b: by two of you instead?

> diff --git a/editor.c b/editor.c
> index 27bdecd..0abbd8d 100644
> --- a/editor.c
> +++ b/editor.c
> @@ -37,7 +37,7 @@ int launch_editor(const char *path, struct strbuf *=
buffer, const char *const *en
>  		return error("Terminal is dumb, but EDITOR unset");
> =20
>  	if (strcmp(editor, ":")) {
> -		const char *args[] =3D { editor, path, NULL };
> +		const char *args[] =3D { editor, real_path(path), NULL };

While I am not fundamentally opposed to add a workaround for bugs in
a popular tool many people use, I am a bit uneasy about this change.

=46or editors that are not broken, this could be an annoying
regression, isn't it?  When the user asks "What is the path of the
file I am editing?" to the editor (i.e. an equivalent of \C-x\C-b),
the updated code will start spewing a long full-path from the root
directory, while we used to give a relative path that is short,
sweet and more in line with the context of user's work.

Compared to not being able to edit, it may be a small price to pay
for those who do need to suffer the broken editor, but the patch
makes those who do not need this workaround to pay the price.
