From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] do not override receive-pack errors
Date: Mon, 13 Feb 2012 13:41:38 -0800
Message-ID: <7v8vk6csx9.fsf@alter.siamese.dyndns.org>
References: <7vhazobto3.fsf@alter.siamese.dyndns.org>
 <1329164235-29955-1-git-send-email-drizzd@aon.at>
 <1329164235-29955-3-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Feb 13 22:41:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx3ec-0002is-7F
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 22:41:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819Ab2BMVll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 16:41:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37754 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451Ab2BMVll (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 16:41:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C4947CB5;
	Mon, 13 Feb 2012 16:41:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xzQA91OZfAhdRjfoBSJJTlLNRIY=; b=HX9Uep
	VoJAKARP5Aejfv78BejHRBMAsb3V71vkXcL/lJja70RUJrYBdHM+SZwTKzKl7ssd
	OjQX2UFaGZPoaIX8BlT769vH0ksPfQRoMXTJrZlNPLOUFnRwkZDh3NYciSRqRMvt
	L3uLT8KhzFaetn6IWBysKL65tkCnxKjjGojQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cL0igC4Rbp1jpYRZjLWTdmYSiFtCG5ca
	YGYsAl8t3vv7i4ERNJHCYuck3+Wff0kSjiUdNEYwKnkGNIjwQlW7PJ68t/HoK1g0
	BXq4MU2O0bc7SYChZW02oJ7h4Cl8BIfJPCX9cDF7vD2ibIvebHR1V4K5Ej9PKMyh
	KKQCN1Riyio=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8286E7CB4;
	Mon, 13 Feb 2012 16:41:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7F507CB2; Mon, 13 Feb 2012
 16:41:39 -0500 (EST)
In-Reply-To: <1329164235-29955-3-git-send-email-drizzd@aon.at> (Clemens
 Buchacher's message of "Mon, 13 Feb 2012 21:17:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8335B5E0-568B-11E1-B234-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190676>

Clemens Buchacher <drizzd@aon.at> writes:

> Receive runs rev-list --verify-objects in order to detect missing
> objects. However, such errors are ignored and overridden later.

This makes me worried (not about the patch, but about the current code).

Are there codepaths where an earlier pass of verify-objects mark a cmd as
bad with a non-NULL error_string, and later code that checks other aspect
of the push says the update does not violate its criteria, and flips the
non-NULL error_string back to NULL?  Or is the only offence you found in
such later code that it fills error_string with its own non-NULL string
when it finds a violation (and otherwise does not touch error_string)?

In other words, is this really "ignored and overridden", not merely
"overwritten"?

In the following review, I assumed that you meant "overwritten".

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index fa7448b..0afb8b2 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -642,8 +642,10 @@ static void check_aliased_updates(struct command *commands)
>  	}
>  	sort_string_list(&ref_list);
>  
> -	for (cmd = commands; cmd; cmd = cmd->next)
> -		check_aliased_update(cmd, &ref_list);
> +	for (cmd = commands; cmd; cmd = cmd->next) {
> +		if (!cmd->error_string)
> +			check_aliased_update(cmd, &ref_list);
> +	}

While I agree with the general concept of this patch (i.e. if we know an
error exists for a particular ref update, we would want to keep the first
one without overwriting it with another error), I am not sure if this hunk
is correct.  This checks cross reactivity between multiple cmds that can
arise when an update made by one will affect the previous value assumed
for another cmd because the former cmd updates a symref whose the target
is what the later cmd wants to update.  If we have already decided the
former cmd is deemed to fail and skip this check, we would not catch that
the latter cmd is trying to make an inconsistent update request, and we
would end up ignoring that case.  Is that the right thing to do?

> @@ -707,8 +709,10 @@ static void execute_commands(struct command *commands, const char *unpacker_erro
>  		set_connectivity_errors(commands);
>  
>  	if (run_receive_hook(commands, pre_receive_hook, 0)) {
> -		for (cmd = commands; cmd; cmd = cmd->next)
> -			cmd->error_string = "pre-receive hook declined";
> +		for (cmd = commands; cmd; cmd = cmd->next) {
> +			if (!cmd->error_string)
> +				cmd->error_string = "pre-receive hook declined";
> +		}
>  		return;
>  	}
>  
> @@ -717,9 +721,15 @@ static void execute_commands(struct command *commands, const char *unpacker_erro
>  	free(head_name_to_free);
>  	head_name = head_name_to_free = resolve_refdup("HEAD", sha1, 0, NULL);
>  
> -	for (cmd = commands; cmd; cmd = cmd->next)
> -		if (!cmd->skip_update)
> -			cmd->error_string = update(cmd);
> +	for (cmd = commands; cmd; cmd = cmd->next) {
> +		if (cmd->error_string)
> +			continue;
> +
> +		if (cmd->skip_update)
> +			continue;
> +
> +		cmd->error_string = update(cmd);
> +	}
>  }

These two hunks look good.
