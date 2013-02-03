From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin/apply: tighten (dis)similarity index parsing
Date: Sun, 03 Feb 2013 12:50:11 -0800
Message-ID: <7vd2wh86m4.fsf@alter.siamese.dyndns.org>
References: <cover.1359901732.git.john@keeping.me.uk>
 <2cac21192f79f9fbb5822417775954eba29064fa.1359901732.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Feb 03 21:50:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U26WU-000383-Sx
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 21:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554Ab3BCUuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 15:50:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62034 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753544Ab3BCUuO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 15:50:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE3AABD84;
	Sun,  3 Feb 2013 15:50:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/fDk106ihN5+JVamEbuEIrbhy5k=; b=LXNdOm
	xld8fNAGJj33Co82LaBXXePF8T8pYPkjDISowdPrS5PpFx9WjwUGG+BaWEPBQsiy
	KuLDS7s9790xsJ3B815td4EW0yLGbr8YGdcVeELLaU+B+APIg2I/8x0Ans3L8+lK
	L6uTYL1Rn4nH6BUoy3CRrVjC0I5OIlyvYUycY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HtDLvNH2COwilnOQYXjXC8LqJpfzYe98
	LSd2PVCEtXo+TxTtVhJOpNvYIyhwAwXJJLNWVigYOhfP93sub2apc3hUkZJU+MZh
	beLrON4gkitqufO7hXdkz6fQQeh66uLi5lKEOkrCzqQjMABp4amxEGk9iJU2oTe4
	vdwjCW/FVUU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A35B9BD83;
	Sun,  3 Feb 2013 15:50:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CC1EBD81; Sun,  3 Feb 2013
 15:50:12 -0500 (EST)
In-Reply-To: <2cac21192f79f9fbb5822417775954eba29064fa.1359901732.git.john@keeping.me.uk>
 (John Keeping's message of "Sun, 3 Feb 2013 14:37:11 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4E552600-6E43-11E2-BF1E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215334>

John Keeping <john@keeping.me.uk> writes:

> diff --git a/builtin/apply.c b/builtin/apply.c
> index 6c11e8b..4745e75 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -1041,15 +1041,17 @@ static int gitdiff_renamedst(const char *line, struct patch *patch)
>  
>  static int gitdiff_similarity(const char *line, struct patch *patch)
>  {
> -	if ((patch->score = strtoul(line, NULL, 10)) == ULONG_MAX)
> -		patch->score = 0;
> +	unsigned long val = strtoul(line, NULL, 10);
> +	if (val <= 100)
> +		patch->score = val;
>  	return 0;
>  }
>  
>  static int gitdiff_dissimilarity(const char *line, struct patch *patch)
>  {
> -	if ((patch->score = strtoul(line, NULL, 10)) == ULONG_MAX)
> -		patch->score = 0;
> +	unsigned long val = strtoul(line, NULL, 10);
> +	if (val <= 100)
> +		patch->score = val;
>  	return 0;
>  }

This makes sort of sense; .score is used only for display and not
for making any decision, so as long as you know it is initialized to
zero when the call to this function is made, it should be OK.

Thanks.
