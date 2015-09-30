From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] sigchain: add command to pop all common signals
Date: Tue, 29 Sep 2015 22:23:21 -0700
Message-ID: <xmqq37xwa3au.fsf@gitster.mtv.corp.google.com>
References: <1443482046-25569-1-git-send-email-sbeller@google.com>
	<1443482046-25569-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Sep 30 07:23:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zh9rW-0003VU-34
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 07:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432AbbI3FXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 01:23:25 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32879 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416AbbI3FXY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 01:23:24 -0400
Received: by pacex6 with SMTP id ex6so28734914pac.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2015 22:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7NfYGSIFCzyPIgGW6sOX8hld3mtvUIsM/6oQ6fQuf6M=;
        b=hUP8oAD/OPQlM1NM9jc6z0aHo72TvjFnPe5UQnFegLmwTlvglTrT6crHKqGkfxp2GA
         2+NBturHrlP/sXqXAzl+WeneChv2t8CM4JizwJQNum4dWiL37O1DbwI4i0Vsi0V1wTcM
         1R+2D6k/rnVt0/mJ72eUPs9/91T5+nqS1YOCOWiwlSrd/NFxP+ggzR0qdcJreKTV15vO
         QfKEU9u/GshmphfZomu3oQRTHcBBxvMc/jYOD5EosVvqaXvQKhpOo0nz7tez21h0AupX
         2r5kurZ0BXdwfqakRnrYgfxdi/hlVP4kbMtCHZRfuEko5icB9I0p3/xu/xhg5J4HyKbf
         DqFg==
X-Received: by 10.68.204.37 with SMTP id kv5mr2510223pbc.64.1443590603638;
        Tue, 29 Sep 2015 22:23:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2c4a:a656:af73:8140])
        by smtp.gmail.com with ESMTPSA id eg5sm29019517pac.30.2015.09.29.22.23.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 29 Sep 2015 22:23:22 -0700 (PDT)
In-Reply-To: <1443482046-25569-6-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 28 Sep 2015 16:14:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278839>

Stefan Beller <sbeller@google.com> writes:

> The new method removes all common signal handlers that were installed
> by sigchain_push.
>
> CC: Jeff King <peff@peff.net>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  sigchain.c | 9 +++++++++
>  sigchain.h | 1 +
>  2 files changed, 10 insertions(+)

Sounds like a good idea, as you need to clean them all up if you did
push_common() and ended up not receiving any signal.

This is merely pure aesthetics, but I somehow thought that ordering
them in the reverse as listed in push_common() might make more
sense, though.

Thanks.

>
> diff --git a/sigchain.c b/sigchain.c
> index faa375d..9262307 100644
> --- a/sigchain.c
> +++ b/sigchain.c
> @@ -50,3 +50,12 @@ void sigchain_push_common(sigchain_fun f)
>  	sigchain_push(SIGQUIT, f);
>  	sigchain_push(SIGPIPE, f);
>  }
> +
> +void sigchain_pop_common(void)
> +{
> +	sigchain_pop(SIGINT);
> +	sigchain_pop(SIGHUP);
> +	sigchain_pop(SIGTERM);
> +	sigchain_pop(SIGQUIT);
> +	sigchain_pop(SIGPIPE);
> +}
> diff --git a/sigchain.h b/sigchain.h
> index 618083b..138b20f 100644
> --- a/sigchain.h
> +++ b/sigchain.h
> @@ -7,5 +7,6 @@ int sigchain_push(int sig, sigchain_fun f);
>  int sigchain_pop(int sig);
>  
>  void sigchain_push_common(sigchain_fun f);
> +void sigchain_pop_common(void);
>  
>  #endif /* SIGCHAIN_H */
