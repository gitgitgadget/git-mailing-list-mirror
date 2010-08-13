From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] hash binary sha1 into patch id
Date: Fri, 13 Aug 2010 15:00:31 -0500
Message-ID: <20100813200031.GD2003@burratino>
References: <20100813094027.GA20906@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Marat Radchenko <marat@slonopotamus.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Aug 13 22:02:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok0SA-0004wN-6c
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 22:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754765Ab0HMUCF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 16:02:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55655 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230Ab0HMUCD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 16:02:03 -0400
Received: by iwn7 with SMTP id 7so138662iwn.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MEEYcFzyDYDH1DwuKy05xa6N1VtUMPTjSeegSZGevdk=;
        b=f/jDd+xfoRK+L4kUI9vmrpsP64KtlRtzYTVk7HtAJs8RrfDVcPDhnzDBOnODTFYQoX
         DzHeRC2D+a5PnHoxEvkt6pgnDQU4BgZEpuK/9gbviXhDoozz52hfWfUb5qGA0fZ2XLRJ
         fODYQ74/qUNCXg6YNCMzh1zM02OJOLGnct/JQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=akFw7+KwEfuXru65pC7wNCjesccjks1tj22/ksb5vXwogazREI+dFiJtGsobi+MGre
         tANrFFlzG+1C8k6VZTINFNWNILhAZQlqlTnFQr+Sj36w1u2svpdtWWLh7gqzGL9xlE8I
         5ldpCF4gM0A2rtwal8bTc8l8iGHALH8b814xQ=
Received: by 10.231.148.83 with SMTP id o19mr1972504ibv.112.1281729722017;
        Fri, 13 Aug 2010 13:02:02 -0700 (PDT)
Received: from burratino ([66.99.3.225])
        by mx.google.com with ESMTPS id h8sm1598570ibk.21.2010.08.13.13.02.00
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 13:02:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100813094027.GA20906@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153489>

Clemens Buchacher wrote:

> Since commit 2f82f760 (Take binary diffs into account for "git rebase=
"), binary
> files are included in patch ID computation. Binary files are diffed u=
sing the
> text diff algorithm, however
[...]
> Instead of hashing the diff of binary files, use the post-image sha1,=
 which is
> just as unique. As a result, performance is much improved.

Maybe it should use both the pre- and post-image?

> diff --git a/diff.c b/diff.c
> index 17873f3..20fc6db 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3758,6 +3758,12 @@ static int diff_get_patch_id(struct diff_optio=
ns *options, unsigned char *sha1)
>  					len2, p->two->path);
>  		git_SHA1_Update(&ctx, buffer, len1);
> =20
> +		if (diff_filespec_is_binary(p->two)) {
> +			len1 =3D sprintf(buffer, "%s", sha1_to_hex(p->two->sha1));
> +			git_SHA1_Update(&ctx, buffer, len1);


i.e., maybe also

			git_SHA1_Update(&ctx, sha1_to_hex(p->one->sha1), 40);

Luckily this is after the filenames and so on have been incorporated,
so there=E2=80=99s no need to add that specially.
