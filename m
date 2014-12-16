From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/6] send-pack.c: add --atomic command line argument
Date: Tue, 16 Dec 2014 11:31:09 -0800
Message-ID: <xmqq1tnzbddu.fsf@gitster.dls.corp.google.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418755747-22506-1-git-send-email-sbeller@google.com>
	<1418755747-22506-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, jrnieder@gmail.com,
	ronniesahlberg@gmail.com, Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 20:31:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0xq0-0005Yw-Tf
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 20:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbaLPTbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 14:31:13 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50609 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751172AbaLPTbM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 14:31:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A408289CD;
	Tue, 16 Dec 2014 14:31:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jVxp9BjuN52u1zX2lSmNKWsImRg=; b=Z+os08
	x7p34+Tr++q08X3kOtB44wa7kewCtGWJFwkzASbeSrPYDrTDFHCwdUKl4TD2cJ9Z
	24MPvhf+coHbzCEZvdERodBPZYd/Kdc32v4Ar45FEfojBVrnR+p4XNUtzoTVt7eF
	FaHJSUodhsiyyiccLBr9BA+PaEdiSWENEWP5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MrDmedwkaG9Jj0AzcpAl39WxWS3SifIu
	QKx4J+Psa1aiXh7vA9zgAQ2Mnfc4NT6avuZ0J11hT+XzhwgLve5beioo4R7P3wkk
	NI3DVwVEYEc/KjDdpBQ3WLihSU/CM0CijztF8GnDVY3893eIdlCBA/PHtLkTkvH2
	0eI7OTqQO7w=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8052C289CC;
	Tue, 16 Dec 2014 14:31:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DBB91289CB;
	Tue, 16 Dec 2014 14:31:12 -0500 (EST)
In-Reply-To: <1418755747-22506-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 16 Dec 2014 10:49:04 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1857168C-855A-11E4-A8C2-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261456>

Stefan Beller <sbeller@google.com> writes:

>      * Now we only need a very small change in the existing code and have
>        a new static function, which cares about error reporting.
>     	  Junio wrote:
>     	  > Hmph.  Is "atomic push" so special that it deserves a separate
>     	  > parameter?  When we come up with yet another mode of failure, would
>     	  > we add another parameter to the callers to this function?

I suspect that you completely mis-read me.

If you add an extra arg that is *specifically* for atomic push, like
this:

    -static int update_to_send(...);
    +static int update_to_send(..., int *atomic_push_failed);
    
what signal does it send to the next person who may want to add
a new "nuclear push" option?  Should the patch look like

    -static int update_to_send(..., int *atomic_push_failed);
    +static int update_to_send(..., int *atomic_push_failed, int *nuclear_push_failed);

by adding yet another separate variable for error reporting?

I would have understood if the new variable was named something like
"failure_reason", which may be set to PUSH_FAILURE_ATOMIC when an
atomic push failure was detected.  Making the helper return the
reason why the push failed would be another way, like you did in the
2/6 patch in this round.

Either way, the next person would know to add a code to do his
"nuclear push" and set the reason to PUSH_FAILURE_NUCLEAR when it
fails, instead of piling yet another error reporting variable that
is specific to the feature.

This is all about code maintainability, which is very different from
"who cares about error reporting".

> diff --git a/remote.h b/remote.h
> index 8b62efd..f346524 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -115,7 +115,8 @@ struct ref {
>  		REF_STATUS_REJECT_SHALLOW,
>  		REF_STATUS_UPTODATE,
>  		REF_STATUS_REMOTE_REJECT,
> -		REF_STATUS_EXPECTING_REPORT
> +		REF_STATUS_EXPECTING_REPORT,
> +		REF_STATUS_ATOMIC_PUSH_FAILED
>  	} status;
> ...
>  	for (ref = remote_refs; ref; ref = ref->next) {
> -		if (no_ref_update_to_be_sent(ref, args))
> +		int reject_reason;
> +		if ((reject_reason = no_ref_update_to_be_sent(ref, args))) {

We avoid assignment inside a conditional.

> +			/* When we know the server would reject a ref update if
> +			 * we were to send it and we're trying to send the refs
> +			 * atomically, abort the whole operation */
> +			if (use_atomic && reject_reason == 2)
> +				return atomic_push_failure(args,
> +							   remote_refs,
> +							   ref);
>  			continue;

Perhaps

		switch (check_to_send_update(...)) {
                case 0: /* no error */
                	break;
		case -REF_STATUS_ATOMIC_PUSH_FAILED:                        
                	return atomic_push_failure(args, remote_refs, ref);
                	break;
		default:
			continue;
		}

or something?
