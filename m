From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/WIP PATCH 11/11] Document protocol version 2
Date: Fri, 29 May 2015 13:35:08 -0700
Message-ID: <xmqqsiafazr7.fsf@gitster.dls.corp.google.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-12-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, peff@peff.net
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 29 22:35:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyQzx-00069o-FO
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 22:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757165AbbE2UfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 16:35:16 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33358 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756417AbbE2UfL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 16:35:11 -0400
Received: by igbpi8 with SMTP id pi8so23784138igb.0
        for <git@vger.kernel.org>; Fri, 29 May 2015 13:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/nNqzVOG1C74/ieHLi8zZKGwmx1hMezZ0wyq3bWp/xU=;
        b=D4uw/ZZ0USSrz41mnAYpx6IGaY3VgWhWmaeKPWvIeTz6hiG5E3jfWNfIMd9eLUrEfJ
         kurwJeKA2qufpWwY4LK2MSdZp3973kacp8bDOmWLhSt/RU0binRqJd+rVyWrwPF/t8dL
         XQsFhwDIP63UkFi0tR7YJS33pGusLTMHR8UVhwMkGvF7ZKGsQuy57K+7E3Mc8AzsE/b9
         SrS+U+5AUzpMCUxBKPTDkzz3fStDMz/IqW/1LhUhfWD4/hNUD+gYZYoek98hj6g0FqFE
         jtnT0D6whl/fjSA+883I+i4YaCG1JY5WZGdQkQPoYw7RMwIBZzWGmtC7sXrRahkp6WFn
         mW3w==
X-Received: by 10.50.97.33 with SMTP id dx1mr6285369igb.1.1432931710445;
        Fri, 29 May 2015 13:35:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d9c8:419b:acd5:cf1d])
        by mx.google.com with ESMTPSA id pg7sm2286920igb.6.2015.05.29.13.35.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 29 May 2015 13:35:09 -0700 (PDT)
In-Reply-To: <1432677675-5118-12-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 26 May 2015 15:01:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270271>

Stefan Beller <sbeller@google.com> writes:

> @@ -1,11 +1,11 @@
>  Packfile transfer protocols
>  ===========================
>  
> -Git supports transferring data in packfiles over the ssh://, git:// and
> +Git supports transferring data in packfiles over the ssh://, git://, http:// and

When you have chance, can you do things like this, which is a clear
improvement of the current document even if we never had v2, as
separate patches?

> +Capability discovery (v2)
> +-------------------------
> ...
> +  capability-list  =  *(capability) [agent LF] flush-pkt
> +  capability       =  PKT-LINE("capability:" keyvaluepair LF)
> +  agent            =  keyvaluepair LF
> +  keyvaluepair     =  1*(LC_ALPHA / DIGIT / "-" / "_" / "=")

What is the "=" doing there?  If you meant to cover things like
"lang=en" with this, I do not think it is a good idea.  Rather, it
should be more like this:

	capability = 1*(LC_ALPHA / DIGIT / "-" / "_") [ "=" value ]
	value = 0*( any octet other than LF, NUL )

in order to leave us wiggle room to have more than very limited
subset of US-ASCII in 'value'.  I suspect that we may want to allow
anything other than LF (unlike v1 that allowed anything other than
SP and LF).

> +  LC_ALPHA         =  %x61-7A
> +----
> +
> +The client MUST ignore any data on pkt-lines starting with anything
> +different than "capability" for future ease of extension.
> +
> +The client MUST NOT ask for capabilities the server did not say it
> +supports. The server MUST diagnose and abort if capabilities it does
> +not understand was requested. The server MUST NOT ignore capabilities
> +that client requested and server advertised.  As a consequence of these
> +rules, server MUST NOT advertise capabilities it does not understand.

I think it was already discussed that we shouldn't do the
"capability:" and "cap:" prefixes in reviews of earlier parts, so
the details of this part would be updated?

> @@ -154,10 +203,14 @@ If HEAD is a valid ref, HEAD MUST appear as the first advertised
>  ref.  If HEAD is not a valid ref, HEAD MUST NOT appear in the
>  advertisement list at all, but other refs may still appear.
>  
> -The stream MUST include capability declarations behind a NUL on the
> -first ref. The peeled value of a ref (that is "ref^{}") MUST be
> -immediately after the ref itself, if presented. A conforming server
> -MUST peel the ref if it's an annotated tag.
> +In version 1 the stream MUST include capability declarations behind
> +a NUL on the first ref. The peeled value of a ref (that is "ref^{}")
> +MUST be immediately after the ref itself, if presented. A conforming
> +server MUST peel the ref if it's an annotated tag.
> +
> +In version 2 the capabilities are already negotiated, so the first ref
> +MUST NOT be followed by any capability advertisement, but it should be
> +treated as any other refs advertising line.

Sensible.

> @@ -178,13 +231,28 @@ MUST peel the ref if it's an annotated tag.
>    shallow          =  PKT-LINE("shallow" SP obj-id)
>  
>    capability-list  =  capability *(SP capability)
> -  capability       =  1*(LC_ALPHA / DIGIT / "-" / "_")
> +  capability       =  1*(LC_ALPHA / DIGIT / "-" / "_" / "=")

Ditto.

Thanks.
