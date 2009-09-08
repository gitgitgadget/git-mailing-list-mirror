From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] post-receive-email: do not call sendmail if no mail was
 generated
Date: Tue, 08 Sep 2009 13:15:13 -0700
Message-ID: <7v4ord19da.fsf@alter.siamese.dyndns.org>
References: <20090908185555.GA3858@lars.home.noschinski.de>
 <1252436418-7660-1-git-send-email-lars@public.noschinski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, andyparkins@gmail.com, pape@smarden.org,
	gitster@pobox.com
To: Lars Noschinski <lars@public.noschinski.de>
X-From: git-owner@vger.kernel.org Tue Sep 08 22:15:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml76P-0007HH-2h
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 22:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbZIHUP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 16:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbZIHUP1
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 16:15:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55032 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbZIHUPX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 16:15:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 99D482B44D;
	Tue,  8 Sep 2009 16:15:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eYOAIr5WSIiPA/FTGc6YzjkuRqA=; b=YFbha0
	WvmuujOLzdsK5FeqdcCf8EJNhF+mI7Ve0ePOftzkeFKzv0r3E+VOccpKnfm1M3xV
	kSzaiAWGFAeN4qO2VdOKWc3v3OpffrQWBjTo3m4fWdIOrfv+GluTSGBfr921EzlT
	IoaMOh3a90mG0LPwX0hJE4PkmeQgJw9U2rUI8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sWdYLzpLHVP9dr+QBfblpKpnOyPhNeQZ
	GeM5tXGOdU8Kc6YvOI0xu5JIEw3AUTYsM8LcHlcMsRt2UrVkKD6MRbA1dDfAUg3f
	hln9iAGAVsax2WYbcfVGqZcJrJs0gv3wNyFfbt8C0N2FBOHCpfm+iZ7pzkMK5lzx
	/dS0tR+CKnk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 637332B44B;
	Tue,  8 Sep 2009 16:15:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 482A02B445; Tue,  8 Sep
 2009 16:15:15 -0400 (EDT)
In-Reply-To: <1252436418-7660-1-git-send-email-lars@public.noschinski.de>
 (Lars Noschinski's message of "Tue\,  8 Sep 2009 21\:00\:18 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 55B72664-9CB4-11DE-BDCC-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128028>

Lars Noschinski <lars@public.noschinski.de> writes:

> contrib/hooks/post-receive-email used to call the send_mail function
> (and thus, /usr/sbin/sendmail), even if generate_mail generated no
> output.  This is problematic, as the sendmail binary provided by exim4
> generates an error mail if provided with an empty input.

I actually have a bigger question, not about the implementation but about
the cause.

If generate_email results in an empty output in this codepath:

	# Check if we've got anyone to send to
	if [ -z "$recipients" ]; then
		...
		echo >&2 "*** $config_name is not set so no email will be sent"
		echo >&2 "*** for $refname update $oldrev->$newrev"
		exit 0
	fi

shouldn't we rather receive an error e-mail than let the
misconfiguration go undetected?

Before this check, I do not see anywhere generate_email would return nor
exit, and after this check, there is a call to generate_email_header and
that guarantees that the output from the generate_email function is not
empty, so it looks to me that triggering this check is the only case your
patch would change the behaviour of the script.

It looks to me that your exim error mail is actually reporting a
legitimate problem you would want to fix in your configuration.

> Therefore, we now read one line ourselves and use the result to decide
> if we really want to call /usr/sbin/sendmail.
> ---
>  contrib/hooks/post-receive-email |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
>
> Two things changed:
>
>  - we do not read the whole mail in a shell variable
>  - the decision whether to call sendmail is based on the output generated
>    by generate_mail, not its return code
>
> diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
> index 2a66063..c855c31 100755
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -637,6 +637,16 @@ show_new_revisions()
>  
>  send_mail()
>  {
> +	OIFS=$IFS
> +	IFS='
> +'
> +	read FIRSTLINE || exit 1

Shouldn't this be merely a "return"?  The caller looks like this:

	while read oldrev newrev refname
	do
		generate_email $oldrev $newrev $refname | send_mail
	done

and you would not want to stop after punting to report on the first ref.

> +	(printf $FIRSTLINE'\n'; cat) | call_sendmail
> +	IFS=$OLD_IFS
> +}
> +
> +call_sendmail()
> +{
>  	if [ -n "$envelopesender" ]; then
>  		/usr/sbin/sendmail -t -f "$envelopesender"
>  	else
> @@ -644,6 +654,7 @@ send_mail()
>  	fi
>  }
>  
> +
>  # ---------------------------- main()
>  
>  # --- Constants

Why?
