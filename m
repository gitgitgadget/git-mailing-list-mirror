From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] receive-pack: detect aliased updates which can
 occur with symrefs
Date: Mon, 19 Apr 2010 13:39:32 -0700
Message-ID: <7veiibqirf.fsf@alter.siamese.dyndns.org>
References: <1271694343-31876-2-git-send-email-jaysoffian@gmail.com>
 <1271695179-32131-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O . Pearce" <spearce@spearce.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 22:39:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3xl4-0004fE-F0
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 22:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939Ab0DSUjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 16:39:45 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58227 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab0DSUjo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 16:39:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CC33ACDBB;
	Mon, 19 Apr 2010 16:39:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6d2KZ7sZnfa8jmHNAspdUdWVpa8=; b=wU6mF6
	5FmTxAj6EB68lmKp01pvKA7l7H4JcCe1JyvhM0T/pw7whaDN+ecqPVFVBZW7r/NA
	Kq7+LkcpC219AZ10EyIwvTCgxVHNFs/60aRFv6QFtBW2qEs2CIaaMkFtXHAzGpuf
	e165hVfyKP/4APf9WxRGEnN6qfiIkLvgG/S24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q7fVjCTdNczLOr91bSYy9wrrkbbACPnR
	ZqQjQOu3y4lTAWMdBGrxxicC+XCvYFZqNFGdkTjvgzLbBYsDpZcgBb/4OjAc1RSe
	PNQ6pFU2/ZQLeOnfeAmf2cLcUIrvvowqWqUg1Zj8yqLbbDEUtpVKrvrUbyrm7pA4
	wusyAmV7ZM0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ABD2ACDBA;
	Mon, 19 Apr 2010 16:39:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE252ACDB5; Mon, 19 Apr
 2010 16:39:35 -0400 (EDT)
In-Reply-To: <1271695179-32131-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Mon\, 19 Apr 2010 12\:39\:39 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ACE2C97C-4BF3-11DF-92EB-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145325>

Jay Soffian <jaysoffian@gmail.com> writes:

> @@ -503,9 +562,11 @@ static void execute_commands(struct command *commands, const char *unpacker_erro
>  		return;
>  	}
>  
> +	check_aliased_updates(commands);
> +
>  	head_name = resolve_ref("HEAD", sha1, 0, NULL);
>  
> -	for (cmd = commands; cmd; cmd = cmd->next)
> +	for (cmd = commands; cmd && !cmd->skip_update; cmd = cmd->next)
>  		cmd->error_string = update(cmd);
>  }

Do you really mean to have "skip-update" check as the loop termination
condition like this (i.e. "upon seeing any skip-update, abandon the rest
of the update queue"), or is this a typo of "skip this entry but keep
going, processing the rest" that should have been a separate "if" in the
body of the loop?

> @@ -545,6 +606,7 @@ static struct command *read_head_info(void)
>  		hashcpy(cmd->old_sha1, old_sha1);
>  		hashcpy(cmd->new_sha1, new_sha1);
>  		memcpy(cmd->ref_name, line + 82, len - 81);
> +		cmd->skip_update = 0;
>  		cmd->error_string = NULL;
>  		cmd->next = NULL;

It would make sense to do xcalloc(nmemb, size) of one member of that
length to allocate cmd at this point, instead of adding yet another
assignment like this.

It also would help me a slight bit if you compared what has been queued
with what you sent to catch minor differences between my expectation from
this series and what you have (e.g. I'd like to keep this as a fix that is
back-mergeable to 'maint' and also I have already done some style fixes to
the test).

Thanks.
