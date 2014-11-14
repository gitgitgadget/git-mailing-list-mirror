From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1410: fix breakage on case-insensitive filesystems
Date: Fri, 14 Nov 2014 12:03:03 -0800
Message-ID: <xmqqoas935zc.fsf@gitster.dls.corp.google.com>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com>
	<20141109014354.GA23883@peff.net> <20141109015918.GA24736@peff.net>
	<5463C106.5090803@kdbg.org> <20141112215923.GB6801@peff.net>
	<546470D0.3080809@kdbg.org> <20141113090832.GA8329@peff.net>
	<546653D6.7040505@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Michael Blume <blume.mike@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 21:03:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpN5S-000325-94
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 21:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377AbaKNUDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 15:03:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55043 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753231AbaKNUDO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 15:03:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D0C8B1DF26;
	Fri, 14 Nov 2014 15:03:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0+abUjMKfSyuP/whgVI3AZ+4EtU=; b=ufZzhI
	7ocUUc48/CfKTZV/UxAi9FsAzs8MHrj06yyTI2q5iEkkvCTRzGiUBMcv5so7SJvP
	bpCvpco9U6bFw1NEkaTRRPJMANKuJ9hA8DnbIQplkfHmHRdSZpj4b9R83McUc7wq
	2WxPDRmPqzP3hHMPnpH1MExyHCvsL89RKoRfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uyMVnmFMLUnQqzlRZcGgMZMNEGeQuLWZ
	R2yzbhbYttQg5fqEr7nX8HWzA11TCRUBruol6QW6+R1NVBST2ZHPvJczEGSVER7P
	+Zgq2PnvrSz0x7UAFnLTBC6wT8oMFVjeD7OasjuLcU8L7kYKzXcXY3bxh13jjuiW
	ExIUGQXkiOc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C70DE1DF25;
	Fri, 14 Nov 2014 15:03:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C33D1DF15;
	Fri, 14 Nov 2014 15:03:04 -0500 (EST)
In-Reply-To: <546653D6.7040505@kdbg.org> (Johannes Sixt's message of "Fri, 14
	Nov 2014 20:11:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3ECEC5EC-6C39-11E4-9135-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Not a comment, on this paragraph of yours, but while I was walking
> through the code with gdb, I was wondering why the reflog directory is
> being touched at all when core.logallrefupdates is off (in
> log_ref_setup via log_ref_write). With the patch below I now get the
> same unlink warning as on Linux.

I do not do Windows, but your analysis feels really sound and
explains the symptom well, and the change looks like the right fix
to the issue.

Thanks.

> --- 8< ---
> Subject: [PATCH] Windows: correct detection of EISDIR in mingw_open()
>
> According to the Linux open(2) man page, open() returns EISDIR if a
> directory was attempted to be opened for writing. Our emulation in
> mingw_open() does not get this right: it checks only for O_CREAT. Fix
> it to check for one of the write flags.
>
> This fixes a failure in reflog handling, which opens files with
> O_APPEND|O_WRONLY, but without O_CREAT, and expects EISDIR when the
> named file happens to be a directory.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  compat/mingw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 2ee3fe3..fc64b73 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -312,7 +312,7 @@ int mingw_open (const char *filename, int oflags, ...)
>  		return -1;
>  	fd = _wopen(wfilename, oflags, mode);
>  
> -	if (fd < 0 && (oflags & O_CREAT) && errno == EACCES) {
> +	if (fd < 0 && (oflags & (O_WRONLY|O_RDWR)) && errno == EACCES) {
>  		DWORD attrs = GetFileAttributesW(wfilename);
>  		if (attrs != INVALID_FILE_ATTRIBUTES && (attrs & FILE_ATTRIBUTE_DIRECTORY))
>  			errno = EISDIR;
> -- 
> 2.0.0.12.gbcf935e
>
> -- 
