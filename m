From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 10/19] fsck: Make fsck_tag() warn-friendly
Date: Fri, 19 Jun 2015 13:18:47 -0700
Message-ID: <xmqqegl778pk.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<851b7fdb435c193abf0e20d0f0e171849e302aff.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 19 22:18:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z62kY-0000cI-DK
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 22:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064AbbFSUSu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2015 16:18:50 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:34976 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012AbbFSUSt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 16:18:49 -0400
Received: by iefd2 with SMTP id d2so25399768ief.2
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 13:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=MrpG0E23wC75x+57EjAuUE+++bzMvBLKNdTW7jN7Bro=;
        b=cRIniM0vGNK8tP0BCK3QvVMsLo6i7kwvCrsfZPJ9P8li5/+NIVseE1qQXbwOGrYasa
         vO8fmqpvzRDLzkAwPQzrVvOBLQWQTxSrWTLVh0u5J0+k7lQrAyBbLFIj8ykVyAG3dThk
         L8cK9zuZQ1ECHtN62T24VxsBMYpTHUeaNVSZw2BzSzPKb8ulNftQkwbRtMUrFpsLub/P
         ZtkoVYjHOQ+iaFK5pT4TwnicvABM8vDUGHwOBHcCD621L296mIYHwyovJfyXMBIOVxC3
         8RAV09MHY+37aYV7gYBROjy4ykXwuCFBLpJSyAvEfK6cscGtyJchgFz+T5I1p+IY+W9f
         +bHg==
X-Received: by 10.107.25.199 with SMTP id 190mr25029828ioz.11.1434745129022;
        Fri, 19 Jun 2015 13:18:49 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id j20sm2370490igt.16.2015.06.19.13.18.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 13:18:48 -0700 (PDT)
In-Reply-To: <851b7fdb435c193abf0e20d0f0e171849e302aff.1434720655.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 19 Jun 2015 15:34:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272195>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When fsck_tag() identifies a problem with the commit, it should try
> to make it possible to continue checking the commit object, in case t=
he
> user wants to demote the detected errors to mere warnings.

I agree with that.  But if FSCK_MSG_BAD_OBJECT_SHA1 is an ignorable
error, why should we still have a conditional "goto done" here?

Shouldn't we be parsing the object the same way regardless?

>
> Just like fsck_commit(), there are certain problems that could hide o=
ther
> issues with the same tag object. For example, if the 'type' line is n=
ot
> encountered in the correct position, the 'tag' line =E2=80=93 if ther=
e is any =E2=80=93
> would not be handled at all.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  fsck.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fsck.c b/fsck.c
> index 0cfa4d0..21e3052 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -640,7 +640,8 @@ static int fsck_tag_buffer(struct tag *tag, const=
 char *data,
>  	}
>  	if (get_sha1_hex(buffer, sha1) || buffer[40] !=3D '\n') {
>  		ret =3D report(options, &tag->object, FSCK_MSG_BAD_OBJECT_SHA1, "i=
nvalid 'object' line format - bad sha1");
> -		goto done;
> +		if (ret)
> +			goto done;
>  	}
>  	buffer +=3D 41;
