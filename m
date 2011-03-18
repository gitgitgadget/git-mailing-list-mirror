From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: Add space to PS1 when showing upstream
Date: Fri, 18 Mar 2011 13:01:35 -0700
Message-ID: <7vtyf0w63k.fsf@alter.siamese.dyndns.org>
References: <20110318150222.GB26236@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 21:02:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0frv-0005QG-K0
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 21:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757043Ab1CRUBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 16:01:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38410 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756191Ab1CRUBt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 16:01:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8C77B4A21;
	Fri, 18 Mar 2011 16:03:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9DSM6pko1qTTIufpe4K2j3Rn1VQ=; b=j6e276
	tF5WGMYzNP30sFdPvX19zQ8XpZ4UQpeJSAsJKQ/VID4EoC/Xuf6M9XQQoQPheQqS
	UPK4bsVnTzEhS7DarLzWfesV6as8mK9hUBbCpg2luxDKW1DVSlIcNwP+e8ynozxm
	8p1aTgSjRRJSJnylfDVdQP7jL6Y5ZoU4IhQwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nx8DPvBwOc60ESFmR45oJznjy90iuXbJ
	R/dDOgIyYd+YH0yzC/htkwYa9DMYbfxBubYedLVvISPhADmHO+EW0Js/xg0jZCM7
	7NN/Kv7vCK3+y5tC9o+dN/Zjmq8WhMuRQT6V+JcKQjEcSFJiTJiCvYLiaFeDHFDT
	YdeAghpvvrs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 47D224A20;
	Fri, 18 Mar 2011 16:03:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EB0474A1E; Fri, 18 Mar 2011
 16:03:11 -0400 (EDT)
In-Reply-To: <20110318150222.GB26236@inocybe.localdomain> (Todd Zullinger's
 message of "Fri, 18 Mar 2011 11:02:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3C11402-519A-11E0-93E1-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169352>

Todd Zullinger <tmz@pobox.com> writes:

> Depending on whether other changes were present or displayed in PS1, the
> prompt may have lacked a space between the branch and the upstream
> marker.

The grossly misnamed __git_ps1_show_upstream that does not show anything
but only sets variable $p gives a non-alphanumeric mnemonic (e.g. p=">")
that is not ambiguous without an extra leading SP under non verbose mode
to make things shorter, and in verbose mode the returned string comes its
own leading SP, e.g. " u+" followed by number of commits.  So why would
you want an extra SP in front of that SP that already exists?

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 0b0b913..e5af5f6 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -312,6 +312,7 @@ __git_ps1 ()
>  		local f="$w$i$s$u"
> +		[[ -z $f ]] && p="${p:+ $p}"
>  		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"

Besides, you confused me with the description. You are checking $f to
decide if you add an extra SP in front of $p but what comes in the end
result is "$f$r$p", so "between the branch and marker" is not even true.
Also why is $r ignored while deciding if you need this extra SP in the
first place?

I also happen to think that the user should not even be worried about the
divergence with the upstream when the repository is in any of the special
states, in which case $r is not empty (e.g. "|REBASE-i").  So the above
part may become:

	local f="$w$i$s$u"
	printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}${p:-$r}"

But that would be a separate topic.
