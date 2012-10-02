From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] run-command: don't try to execute directories
Date: Tue, 02 Oct 2012 10:35:16 -0700
Message-ID: <7vvces93qj.fsf@alter.siamese.dyndns.org>
References: <1349189193-25497-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Oct 02 19:36:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ6Na-0007Cg-V9
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 19:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216Ab2JBRfW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Oct 2012 13:35:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44906 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755186Ab2JBRfU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Oct 2012 13:35:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CD3584FF;
	Tue,  2 Oct 2012 13:35:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vIvDRfa8hrd/
	4dbofMbPBrui+uY=; b=ZKakbU2Lh95pCd671aeI5vG1AiA4ZeVx4YCbHAfsFW9Y
	xpRT8EzCmTqxmFAf73KeGWN0427UqWFZBl+LjuSeE828qQ4IQKYARmZdWT6YtBas
	mmoA/aJ3O1TCqurh5zrIkqDMVgTYJaVC2d3Cxit8LxGWB7fTfTZSG3Jl53VcX+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NQCXXH
	plNfgH2pnFpra3CbK6GyL6qAfDWFrWnmjYBCS8fH+gg+iOaGWHQIUPwBPbbc66uI
	mCWXR867KMFSVB1RgMQnCr3kR2qWmqHk0DhxjiKJQa/NvSXu6hL58jCC962s+0f3
	NRZPgbuajjIkJYaYG8OA7W5oNiYG5UB7FEewE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0523B84FE;
	Tue,  2 Oct 2012 13:35:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 660D084FB; Tue,  2 Oct 2012
 13:35:18 -0400 (EDT)
In-Reply-To: <1349189193-25497-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Tue, 2 Oct 2012 16:46:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88908078-0CB7-11E2-8AAD-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206827>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> When looking through $PATH to try to find an external command,
> locate_in_PATH doesn't check that it's trying to execute a file. Add =
a
> check to make sure we won't try to execute a directory.
>
> This also stops us from looking further and maybe finding that the
> user meant an alias, as in the case where the user has
> /home/user/bin/git-foo/git-foo.pl and an alias
>
>     [alias] foo =3D !/home/user/bin/git-foo/git-foo.pl
>
> Running 'git foo' will currently will try to execute ~/bin/git-foo an=
d
> fail because you can't execute a directory. By making sure we don't d=
o
> that, we realise that it's an alias and do the right thing
>
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
>
> ---
>
> This comes from a case in #git. Not sure if this is worth it, or the
> better solution is just to say no to dirs in $PATH.
>
> After writing all of that, I thought to check the shell, and indeed
>
>     % git-foo
>     zsh: permission denied: git-foo
>
> so if the shell doesn't do it, the benefits probably don't outweigh
> having a dozen stat instead of access calls. strace reveals that zsh
> does what git currently does. bash uses stat and says 'command not
> found'.

Hrm, I do not use zsh but it does not seem to reproduce for me.

	$ mkdir -p /var/tmp/xx/git
        $ zsh
        % PATH=3D/var/tmp/xx:$PATH
        % type git
        git is /home/junio/bin/git
        % git version
        git version 1.8.0.rc0.45.g7ce8dc5
	% zsh --version
	zsh 4.3.10 (x86_64-unknown-linux-gnu)

> @@ -101,8 +102,9 @@ static char *locate_in_PATH(const char *file)
>  		}
>  		strbuf_addstr(&buf, file);
> =20
> -		if (!access(buf.buf, F_OK))
> +		if (!stat(buf.buf, &st) && !S_ISDIR(st.st_mode)) {
>  			return strbuf_detach(&buf, NULL);
> +		}

So we used to say "if it exists and accessible, return that".  Now
we say "if it exists and is not a directory, return that".

I have to wonder what would happen if it exists as a non-directory
but we cannot access it.  Is that a regression?


>  		if (!*end)
>  			break;
