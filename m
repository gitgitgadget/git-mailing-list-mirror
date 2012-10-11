From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] attr: more matching optimizations from .gitignore
Date: Thu, 11 Oct 2012 08:36:50 +0700
Message-ID: <CACsJy8CdCN0hBU2WwffNvHOwcC87v2OVJj=SYH4BYYveBpFiQw@mail.gmail.com>
References: <7vd30si665.fsf@alter.siamese.dyndns.org> <1349864466-28289-1-git-send-email-pclouds@gmail.com>
 <7v626iatt9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 03:37:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM7iR-0000es-Fo
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 03:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933451Ab2JKBhY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 21:37:24 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:40382 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933385Ab2JKBhV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2012 21:37:21 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so2135533iea.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 18:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=AIH7AGvdGpX52e+04x5Kw8xKoBGtRxA8ZlkPfs9sxqk=;
        b=bu23JkF1mssjIz0/jF0FZcH8jthDrR5im/kPlnP+NsXRXJ5VvSdRtG6BCNT++fqG7t
         hBCTJ/0SdzYlEzAGX/AZ+vhxh6SA+1BaXAoS79ZjXlCXab9IllzGNAAhOsOCobaWd4Jz
         Qw5Ngblbxjyc6hqWGjWWL5JKS7sPNYJ8vCY7LmfEd2loM3d3rApDAcvMBSMKGVJgYKWa
         bMAvoY/ohaHDflS93mTRNVgBMdIx51HOqs0mJ4r1+fSzlrxla3y+EbSQSGdYY47I8kCk
         3br9OUzzgiAna6Rfyo8lrPtW1bpBferKuyRxpCqi8I+mK5w5L/Nyro7Wdo+7VOuSWftT
         LVMA==
Received: by 10.50.208.71 with SMTP id mc7mr7234826igc.47.1349919440940; Wed,
 10 Oct 2012 18:37:20 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Wed, 10 Oct 2012 18:36:50 -0700 (PDT)
In-Reply-To: <7v626iatt9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207453>

On Thu, Oct 11, 2012 at 4:41 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>>    @@ -690,16 +689,18 @@ static int path_matches(const char *pathnam=
e, int pathlen,
>>        * contain the trailing slash
>>        */
>>
>>    -  if (pathlen < baselen ||
>>    +  if (pathlen < baselen + 1 ||
>>           (baselen && pathname[baselen] !=3D '/') ||
>>    -      strncmp(pathname, base, baselen))
>>    +      strncmp_icase(pathname, base, baselen))
>
> Shouldn't the last comparison be
>
>         strncmp_icase(pathname, base, baselen + 1)
>
> instead,

"base" does not contain the trailing slash, so it can only match up to
base[baselen-1], then fail at base[baselen], which is '\0'. The "no
trailing slash" business in this function is tricky :(

> if you are trying to match this part from dir.c where
> baselen does count the trailing slash?
>
>                 if (pathlen < x->baselen ||
>                     (x->baselen && pathname[x->baselen-1] !=3D '/') |=
|
>                     strncmp_icase(pathname, x->base, x->baselen))
>                         continue;

strncmp_icase() here just needs to compare x->baselen-1 chars (i.e. no
trailing slash) as the trailing slash is explicitly checked just above
strncmp_icase. But it does not hurt to compare an extra character so I
leave it unchanged. But obviously it causes confusion when we try to
match this function and the one in attr.c
--=20
Duy
