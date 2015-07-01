From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] pack-protocol.txt: Mark pushee field as optional
Date: Wed, 01 Jul 2015 11:56:35 -0700
Message-ID: <xmqqbnfvaeqk.fsf@gitster.dls.corp.google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
	<1435774099-21260-7-git-send-email-dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 20:56:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZANBa-0002J0-3F
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 20:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270AbbGAS4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 14:56:38 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37860 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbbGAS4h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 14:56:37 -0400
Received: by igblr2 with SMTP id lr2so41322445igb.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7YifLNE5cngK0D9pG46XR2iNBQZUFryA/x1L8ZItrq8=;
        b=wV5WzxN+ZeHWqxlbsuiTDu6BeOGKg1OIisajUVuXNETG9Ql5pj6Ow8QEFbzG3kgYvu
         etQnYlUzivwbproTfl+84fRdCjdAaIq6qRbtfx2meupZ0BEZBmlbsbgwglm6Hgi67JUr
         XQCyenbSLqJehz7Lr3982C7F7afDOVRp8YMwuAfr83vABgDS59xZKAfxF4aSfArL54VQ
         1qv+91R9WXHE5Xqg/i+RLdwPpUlCvlvmtN+JrcRCowC3dMNhCW5AI2Gv3wkBXPwfz+iH
         QeT7LHOsXSuaTjuxHIsiQUq5oC/MA4paztJBrLO93zpjprsIWr5EHgJFr3D4lDRUMCfo
         NTXg==
X-Received: by 10.42.170.74 with SMTP id e10mr5922305icz.71.1435776996591;
        Wed, 01 Jul 2015 11:56:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:64b9:4225:baa1:c97c])
        by mx.google.com with ESMTPSA id i7sm2298775igt.18.2015.07.01.11.56.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Jul 2015 11:56:36 -0700 (PDT)
In-Reply-To: <1435774099-21260-7-git-send-email-dborowitz@google.com> (Dave
	Borowitz's message of "Wed, 1 Jul 2015 11:08:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273181>

Dave Borowitz <dborowitz@google.com> writes:

> send-pack.c omits this field when args->url is null or empty. Fix the
> protocol specification to match reality.

Do some clients omit this in the real world?

As you say, send_pack() does omit it if args->url is null or empty,
but args is prepared in transport.c as a copy of transport->url when
the function is called, and that transport->url is how
builtin/push.c reports where it is pushing with:

   if (verbosity > 0)
       fprintf(stderr, _("Pushing to %s\n"), transport->url);

So I am somewhat puzzled...

>
> Signed-off-by: Dave Borowitz <dborowitz@google.com>
> ---
>  Documentation/technical/pack-protocol.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
> index f37dcf1..98e512d 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -495,7 +495,7 @@ references.
>    push-cert         = PKT-LINE("push-cert" NUL capability-list LF)
>  		      PKT-LINE("certificate version 0.1" LF)
>  		      PKT-LINE("pusher" SP push-cert-ident LF)
> -		      PKT-LINE("pushee" SP url LF)
> +		      [PKT-LINE("pushee" SP url LF)]
>  		      PKT-LINE("nonce" SP nonce LF)
>  		      PKT-LINE(LF)
>  		      *PKT-LINE(command LF)
> @@ -554,7 +554,8 @@ Currently, the following header fields are defined:
>  `pushee` url::
>  	The repository URL (anonymized, if the URL contains
>  	authentication material) the user who ran `git push`
> -	intended to push into.
> +	intended to push into. This field is optional, and included at
> +	the client's discretion.
>  
>  `nonce` nonce::
>  	The 'nonce' string the receiving repository asked the
