From: Dmitry Gryazin <dosagc@gmail.com>
Subject: Re: [PATCH] grep: fix word-regexp colouring
Date: Thu, 21 May 2009 08:29:03 +0400
Message-ID: <4A14D88F.8010105@gmail.com>
References: <4A144E41.4010303@gmail.com> <4A1476C9.8060900@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu May 21 06:31:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6zvt-0002zj-2i
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 06:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbZEUE3N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2009 00:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbZEUE3M
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 00:29:12 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:36065 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbZEUE3L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 00:29:11 -0400
Received: by bwz22 with SMTP id 22so787355bwz.37
        for <git@vger.kernel.org>; Wed, 20 May 2009 21:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=n0W8J2RZhuMd69eS3Ch40TqruDtOrovV0vT6psMMBko=;
        b=MXiLJkJiRr4zxVjRkh9ON1oKQHpMsJah1sie4BTcnbTNpEKzVzHgXsaxWOEc7ZZHfb
         oRZiDMmi19U3kdW4VfrtnEOYQIWiuEWlxtM5sbrj8BJ6uPyoagGRz4E6aRxmconM88Ni
         gACNdimG5Bg6NF6WlFzrctMxqLpS7GO2p/eBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=EwFSpeLnvwCAPeXwDKSHGHChFpHfQVc2j9WmNYYtlICQgJ/bCoN7syYiaZ6PiR6DIp
         5lxF37tR1MCpFP1QY5VoyFS7ecuFZSXtxgfqsUMjXW+RGiGIsrw8AFelLvqC5TU+zkDs
         dXJZiPBMLbtVAMq1OP6CeD3ngee+UcCQcvHI8=
Received: by 10.103.8.17 with SMTP id l17mr1082058mui.125.1242880151781;
        Wed, 20 May 2009 21:29:11 -0700 (PDT)
Received: from ?10.206.120.194? ([77.241.45.26])
        by mx.google.com with ESMTPS id 14sm1365491muo.33.2009.05.20.21.29.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 21:29:11 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
In-Reply-To: <4A1476C9.8060900@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119655>

Ren=C3=A9 Scharfe wrote:
> As noticed by Dmitry Gryazin: When a pattern is found but it doesn't
> start and end at word boundaries, bol is forwarded to after the match=
 and
> the pattern is searched again.  When a pattern is finally found betwe=
en
> word boundaries, the match offsets are off by the number of character=
s
> that have been skipped.
>
> This patch corrects the offsets to be relative to the value of bol as
> passed to match_one_pattern() by its caller.
>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
>  grep.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index 04c777a..a649f06 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -305,6 +305,7 @@ static int match_one_pattern(struct grep_pat *p, =
char *bol, char *eol,
>  {
>  	int hit =3D 0;
>  	int saved_ch =3D 0;
> +	const char *start =3D bol;
> =20
>  	if ((p->token !=3D GREP_PATTERN) &&
>  	    ((p->token =3D=3D GREP_PATTERN_HEAD) !=3D (ctx =3D=3D GREP_CONT=
EXT_HEAD)))
> @@ -365,6 +366,10 @@ static int match_one_pattern(struct grep_pat *p,=
 char *bol, char *eol,
>  	}
>  	if (p->token =3D=3D GREP_PATTERN_HEAD && saved_ch)
>  		*eol =3D saved_ch;
> +	if (hit) {
> +		pmatch[0].rm_so +=3D bol - start;
> +		pmatch[0].rm_eo +=3D bol - start;
> +	}
>  	return hit;
>  }
> =20
>  =20
Thanks.

ACK
