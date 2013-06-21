From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not ignore merge options in interactive rebase
Date: Fri, 21 Jun 2013 13:43:03 -0700
Message-ID: <7vr4fvkxew.fsf@alter.siamese.dyndns.org>
References: <87bo70dokb.fsf@duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Arnaud Fontaine <arnau@debian.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 22:43:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq8Aq-0005Hj-NE
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 22:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946043Ab3FUUnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 16:43:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64606 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946041Ab3FUUnG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 16:43:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BC4F2A5E3;
	Fri, 21 Jun 2013 20:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T4v2TqqEdWrI9JS6H07JRjyRxxk=; b=M0sSNP
	+P/LKwJUQz/H7i8iPeXqF6s+Dl3fUF/JwSU1T4VVLXbU/bsxmDNAAIXJimjqq3ad
	qWF07YZsVgA9bN5b+XEh/STGWyRAaUKzRhGI3O+QT/3r/zT1L+u0v4Uh85q4asQa
	spvfez8jijQ1QDHbty8t7tipNFk2TqtDz5P30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SNR109zhtqMSMobgxaW67Gm6lVnp5aaT
	lApWrc+2WpNP3ItrwoO648XbG4XHWrGtXQVA7EoBvkWQHl9fUU0nfJUNrGVK320H
	Nf1Q0Yvhm+CZME8npLyzaE6sIJlKd69pTdvQQxYXThSt+gn54qiXekHpYjH8lPBB
	wnfjH62rcHQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 008DA2A5E2;
	Fri, 21 Jun 2013 20:43:06 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 661A42A5E1;
	Fri, 21 Jun 2013 20:43:05 +0000 (UTC)
In-Reply-To: <87bo70dokb.fsf@duckcorp.org> (Arnaud Fontaine's message of "Fri,
	21 Jun 2013 14:23:48 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C7320DC-DAB3-11E2-82AC-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228657>

Arnaud Fontaine <arnau@debian.org> writes:

> Merge strategy and its options can be specified in `git rebase`,
> but with `--interactive`, they were completely ignored.

And why is it a bad thing?  If you meant s/--interactive/-m/ in the
above, then I can sort of understand the justification, though.


> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> old mode 100644
> new mode 100755

I see an unjustifiable mode change here.

> index f953d8d..c157fdf
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -239,7 +239,16 @@ pick_one () {
>  
>  	test -d "$rewritten" &&
>  		pick_one_preserving_merges "$@" && return
> -	output git cherry-pick $empty_args $ff "$@"
> +
> +	if test -n "$do_merge"
> +	then

So you _did_ mean "rebase -m"?

> +		test -z "$strategy" && strategy=recursive
> +		output git cherry-pick --strategy=$strategy \

This is a bad change.

I would understand if the above were:

	git cherry-pick ${strategy+--strategy=$strategy} ...

in other words, "if there is no strategy specified, do not override
the configured default that might be different from recursive"
(pull.twohead may be set to resolve).

> +			$(echo $strategy_opts | sed "s/'--\([^']*\)'/-X\1/g") \

Is it guaranteed $startegy_opts do not have a space in it?

There is a call to "git merge" that uses "${strategy+-s $strategy}",
but it does not seem to propagate the strategy option.  Does it need
a similar change?  It seems that the first step might be to factor
out these calls to the "git cherry-pick" and "git merge" to helper
functions to make it easier to call them with -s/-X options in a
consistent way.

> +			$empty_args $ff "$@"
> +	else
> +		output git cherry-pick $empty_args $ff "$@"
> +	fi

It seems that there is another call to "git cherry-pick" in the
script ("git grep" for it).  Does it need a similar change?
