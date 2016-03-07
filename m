From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/15] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
Date: Mon, 07 Mar 2016 14:49:44 -0800
Message-ID: <xmqq7fhdoqd3.fsf@gitster.mtv.corp.google.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
	<1457265902-7949-3-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 23:49:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ad3yJ-00008B-OU
	for gcvg-git-2@plane.gmane.org; Mon, 07 Mar 2016 23:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbcCGWtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 17:49:47 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752248AbcCGWtr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 17:49:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ED4B54BC40;
	Mon,  7 Mar 2016 17:49:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8dW6syod+46W7IK8TAwv2x6p/Tc=; b=BLv54U
	iFa2nHq4uJiWxx5SxNXrphpP2lLjvQt7Q1B0RFT4A0oXjCTueps2StE7DUYUahAT
	T8qcwepy9WF34mQn6Ut3YcmEJu+Q/KgxUljUsfZ3OwRd5PZHBrs5nXEyGPadv0pq
	H5wum+1DofB+yDhYwHC0RjZJFyeAmms9r1XB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vgl9KHiR1vulMFnLoMYJu3kzZXY74UMC
	ZUCdu8XnTGNU0iLmGqyONc4MPGuouv2sd9pTi7NPphhYc8Y8OmSZKXTbc+76+w1H
	DvBXUPmH8+GVS+tY8XZR2Mdk+OmCL8TlVPnX8kWq9tDfIqN9tG7kzelakBUdkyFN
	aARxpsiTvac=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E4C1E4BC3F;
	Mon,  7 Mar 2016 17:49:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6579A4BC3B;
	Mon,  7 Mar 2016 17:49:45 -0500 (EST)
In-Reply-To: <1457265902-7949-3-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Sun, 6 Mar 2016 17:34:49 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E35BC51E-E4B6-11E5-884E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288405>

Karthik Nayak <karthik.188@gmail.com> writes:

> diff --git a/ref-filter.c b/ref-filter.c
> index 41e73f0..440e270 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -22,6 +22,8 @@ struct align {
>  };
>  
>  struct if_then_else {
> +	const char *if_equals,
> +		*not_equals;
>  	unsigned int then_atom_seen : 1,
>  		else_atom_seen : 1,
>  		condition_satisfied : 1;
> @@ -411,6 +413,14 @@ static void if_atom_handler(struct atom_value *atomv, struct ref_formatting_stat
>  {
>  	struct ref_formatting_stack *new;
>  	struct if_then_else *if_then_else = xcalloc(sizeof(struct if_then_else), 1);
> +	const char *valp;
> +
> +	if (skip_prefix(atomv->s, "equals=", &valp))
> +		if_then_else->if_equals = valp;
> +	else if (skip_prefix(atomv->s, "notequals=", &valp))
> +		if_then_else->not_equals = valp;
> +	else if (atomv->s[0])
> +		die(_("format: unknown format if:%s"), atomv->s);
>  
>  	push_stack_element(&state->stack);
>  	new = state->stack;

The fact that you are pushing stack element here tells me that this
"handler" is run once for each 'ref' that we prepare output for
(i.e. unlike the helper functions called "parser" that are called
only once while preparing used_atom[] array).

It somehow feels that this goes against the overall design you did
in the earlier topic to pre-parse as much as possible when you
prepare the used_atom array and avoid parsing at the runtime.  Am I
misreading the patch?
