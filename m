From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid crippled getpass function on Solaris
Date: Sun, 05 Aug 2012 18:59:48 -0700
Message-ID: <7vboio231n.fsf@alter.siamese.dyndns.org>
References: <1344208672-20028-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Mon Aug 06 04:00:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyCbs-0002i3-LY
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 03:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755504Ab2HFB7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 21:59:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38172 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755352Ab2HFB7u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 21:59:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8390D9199;
	Sun,  5 Aug 2012 21:59:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SLtbIlZtq/dWrpMJrNXu0KwZCRU=; b=hXWzMN
	Ki2MBUfuBl22jv+w1Ofm5b/j85novP0sT6/JRlFjSW5NffuG2qYd5YZlaQCXmIze
	g4OvjG5S8NUrsknnMl3+NEUZM9L5Gl7s9S6R6bXuBsiahWDhvy7PAgBH2p5CLdtO
	bRlADwBO/Tr+FRB4drnszmRJVX7uqPCKy+H84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Llu3VgNhlCuo58KgdCE3hCs6vdJGpCQk
	MTB1n5gMTNtzlc42SQYdgvUOt8reB31hAQ9KWaG7rwhu+/dR/1VMWQsVK21mRhfl
	CYrOuKXHTpsa4YZQTm/xfX3rolzWSgJcT5KGEuOYF8BRIHWUPlzy2bUXZWUKcFus
	DdeB3E222f0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71E529197;
	Sun,  5 Aug 2012 21:59:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7EB19196; Sun,  5 Aug 2012
 21:59:49 -0400 (EDT)
In-Reply-To: <1344208672-20028-1-git-send-email-bwalton@artsci.utoronto.ca>
 (Ben Walton's message of "Sun, 5 Aug 2012 19:17:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 67C4327E-DF6A-11E1-AB65-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202952>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> diff --git a/compat/terminal.h b/compat/terminal.h
> index 97db7cd..8d7b3f9 100644
> --- a/compat/terminal.h
> +++ b/compat/terminal.h
> @@ -3,4 +3,13 @@
>  
>  char *git_terminal_prompt(const char *prompt, int echo);
>  
> +/* getpass() returns at most 8 characters on solaris so use
> +   getpassphrase() which returns up to 256. */
> +# if defined (__SVR4) && defined (__sun) /* solaris */
> +#define GETPASS getpassphrase
> +#else
> +#define GETPASS getpass
> +#endif
> +
> +
>  #endif /* COMPAT_TERMINAL_H */

Wouldn't

	#if solaris
        #define getpass getpassphrase
        #endif

without anything else be more than sufficient?
