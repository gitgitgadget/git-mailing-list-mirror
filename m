From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] receive-pack.c: don't miss exporting unsolicited push certificates
Date: Fri, 09 Jan 2015 17:52:11 -0800
Message-ID: <xmqqmw5r9zck.fsf@gitster.dls.corp.google.com>
References: <xmqqbnm7bj8m.fsf@gitster.dls.corp.google.com>
	<1420849874-32013-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 02:52:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9lDv-0002pN-Ry
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 02:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754322AbbAJBwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 20:52:15 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60837 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753376AbbAJBwO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 20:52:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 828A12FF83;
	Fri,  9 Jan 2015 20:52:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UeuMM1oqwVAeXmTCIqCbbNadaps=; b=fHKOIK
	ocJA/Afx9Yv6Hq0gTORprpiNprxcKqtDM+7Bm9PAGjCabOrfH0ayeycL+klY/Hp0
	AAoKFR1+M1tPLMZzPS+4O88Ko3W8ujhuLSNZry28ngE9K2m6OzWg4JnR2K6as7Ba
	K9ZOMR30o55uW+NxS7EYWVwhbEwqT8/ZdBHlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VsCmQaePXcDhqcZN7saPLcMeq3Z2ibI8
	KlsDoInzMHyQ6iWrjzZfzwL3KYeV0+y3itfLGlqoLomM9DOlWqbeTpQrAlkP2yRA
	8v9oBWbLvt2TldxEUa8lZhdawg/Hp7CT+EtVFg5qp3LoX9YqyrBOpaFpqftXFwed
	sGKgT24JeV0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 77F6D2FF82;
	Fri,  9 Jan 2015 20:52:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F2DAD2FF81;
	Fri,  9 Jan 2015 20:52:12 -0500 (EST)
In-Reply-To: <1420849874-32013-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 9 Jan 2015 16:31:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4BE2D8A0-986B-11E4-947B-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262254>

Stefan Beller <sbeller@google.com> writes:

> If the server is configured to not advertise push certificates,
> a push certificate that gets pushed nevertheless will not be fully
> recorded because push_cert_nonce is NULL.

Sorry, but I do not quite see what you are trying to get at.

When we did not advertise that this feature is supported, we know
the incoming nonce is meaningless junk because we didn't supply the
correct answer the pusher can give us; we do not even have the
correct answer ourselves.

Besides, while reviewing the other patch, didn't we agree that we
should reject such a push?  Then there is nothing to log anyway, no?

    ... reads the patch and code beyond the context while scratching
    head ...

I notice that the above three lines do not correspond what you did
in this patch.  The certificate is exported via the blob interface
fully with or without this change.

What is not given to the hook is the push-cert-nonce-status.  While
it is sufficient to tell the hook that we are not getting a good
nonce (i.e. the hook does not see GIT_PUSH_CERT_NONCE_STATUS=G), we
are not showing that nonce-status is "unsolicited", even though we
internally compute and decide that; is that what you are trying to
fix?

Still puzzled...

>
> The recording of GIT_PUSH_CERT_NONCE_STATUS should be dependent on
> the status being there instead of push_cert_nonce being non NULL.
>
> Without this patch an unsolicited nonce never makes to the stage when
> being exported with GIT_PUSH_CERT_NONCE_STATUS, because in the unsolicited
> case push_cert_nonce is always NULL.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/receive-pack.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 628d13a..0e4878e 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -504,18 +504,18 @@ static void prepare_push_cert_sha1(struct child_process *proc)
>  				 sigcheck.key ? sigcheck.key : "");
>  		argv_array_pushf(&proc->env_array, "GIT_PUSH_CERT_STATUS=%c",
>  				 sigcheck.result);
> -		if (push_cert_nonce) {
> +		if (push_cert_nonce)
>  			argv_array_pushf(&proc->env_array,
>  					 "GIT_PUSH_CERT_NONCE=%s",
>  					 push_cert_nonce);
> +		if (nonce_status)
>  			argv_array_pushf(&proc->env_array,
>  					 "GIT_PUSH_CERT_NONCE_STATUS=%s",
>  					 nonce_status);
> -			if (nonce_status == NONCE_SLOP)
> -				argv_array_pushf(&proc->env_array,
> -						 "GIT_PUSH_CERT_NONCE_SLOP=%ld",
> -						 nonce_stamp_slop);
> -		}
> +		if (nonce_status == NONCE_SLOP)
> +			argv_array_pushf(&proc->env_array,
> +					 "GIT_PUSH_CERT_NONCE_SLOP=%ld",
> +					 nonce_stamp_slop);
>  	}
>  }
