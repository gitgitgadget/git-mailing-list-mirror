From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] transport.c: mark push status strings for translation
Date: Wed, 13 Nov 2013 15:25:29 -0800
Message-ID: <20131113232529.GQ10302@google.com>
References: <1384345833-8345-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 00:25:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgjoX-0000HX-1R
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 00:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821Ab3KMXZe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Nov 2013 18:25:34 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:57530 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab3KMXZc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 18:25:32 -0500
Received: by mail-pd0-f178.google.com with SMTP id p10so1115967pdj.9
        for <git@vger.kernel.org>; Wed, 13 Nov 2013 15:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KFLxOM1jxJBq6yF24c6e9XRLz8PjeCWyfKQ6RXBFpws=;
        b=KJfXoAJr2o8aTU8tXfZSuB7ItXiMZ+mtVCAXzxFEDV2quCoc2qC0Kj5bvVKxSYQYsb
         nGLKE/PetpRa6JxeDZXbMvSc9SIva89F+HCFMcyCqTcg7VLkUDWlI2imvrBw0tfQS6hV
         PIkFf92V2mN+CsmCZDrRQNS1tPe1Z3jbnZXRypU0TmsheHZXtx9vTchi/qaaH5a+GGpD
         SHZy75ZJjYn/o6US0wkf7GLCJQ69PP9InCHaQZe0HwYabSLXCAMW4wvUEBSibkzg1yGf
         Paj1AmSAUKXbUKXSjqYKJhZ1byob4CYoZ7BGheqIoBQX484/GzKCdnXLz5lwW9zQKAtq
         8yhQ==
X-Received: by 10.68.194.97 with SMTP id hv1mr16453282pbc.162.1384385132177;
        Wed, 13 Nov 2013 15:25:32 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id yi10sm54579571pab.8.2013.11.13.15.25.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 13 Nov 2013 15:25:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1384345833-8345-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237808>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Strings are only marked for translations, the actual lookup is delaye=
d
> until inside print_ref_status(), so we only have to check for
> porcelain flag once.

I was confused about what this means (why would it be faster to call
gettext() once inside print_ref_status() instead of once per caller
in the argument to print_ref_status()?) until I looked at the code.
I guess you mean something like

	Mark strings like "[up to date]" passed to print_ref_status() for
	translation with N_() instead of _() so they can remain untranslated
	in porcelain mode.

> While at there, mark some error strings in git push for translation
> too.

Thanks.

[...]
> +++ b/transport.c
[...]
> @@ -627,16 +628,17 @@ static void print_ref_status(char flag, const c=
har *summary, struct ref *to, str
>  		else
>  			fprintf(stdout, "%s\n", summary);
>  	} else {
> -		fprintf(stderr, " %c %-*s ", flag, TRANSPORT_SUMMARY_WIDTH, summar=
y);
> +		int width =3D TRANSPORT_SUMMARY_WIDTH;
> +		const char *localized_summary =3D _(summary);
> +		/* compensate the invisible bytes in utf-8 strings */
> +		width +=3D strlen(localized_summary) - utf8_strwidth(localized_sum=
mary);
> +		fprintf(stderr, " %c %-*s ", flag, width, localized_summary);

Nit: "Compensate for the ...".

What would happen if 'width' became negative?  That can't happen
because none of the doublewidth characters are ASCII characters, so
the question is just academic, but maybe it's worth a note in the
comment to avoid slowing down people reading.

>  		if (from)
>  			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettif=
y_refname(to->name));

I'm not sure this is correct for right-to-left languages.  Something
to solve another day.

The rest looks good.

If the commit message is clarified,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
