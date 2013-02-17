From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] submodule: add 'deinit' command
Date: Sun, 17 Feb 2013 14:32:46 -0800
Message-ID: <7v38wufu5t.fsf@alter.siamese.dyndns.org>
References: <5112C6F6.4030607@web.de>
 <CABURp0oQcPotK20QcqCG1pGQPVoa4RnN2nDA=iQoKS99gnPEAQ@mail.gmail.com>
 <511BEA75.6000002@web.de> <7vip5w6l8s.fsf@alter.siamese.dyndns.org>
 <5121384B.10009@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	"W. Trevor King" <wking@tremily.us>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Feb 17 23:33:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7CnK-0004ey-4L
	for gcvg-git-2@plane.gmane.org; Sun, 17 Feb 2013 23:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388Ab3BQWcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 17:32:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51181 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753112Ab3BQWct (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 17:32:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F0B8BC27;
	Sun, 17 Feb 2013 17:32:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E2sdaIwDBVBCw4w2u+dI0enxe8s=; b=kv9CD+
	u5Z6nD7skb7+4R13zz6vkQ+mHXrOPJQjc51EP8tAa8RTTnjgcc4KeyeM7bGDnJBl
	iRgWbRJSgBFk202mFqn+BnIxgM8bQAEFlYpHJCi4vxcmAqg8pxNEAnTlkrzKabRB
	5w3uvvZgA6NV0zSwmvNZ5SVMB5qCQUH0ubXMI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EsHxVONL4ysJn5Dommhwxi1oeSwAzp/S
	YeHVbv2c04mrltPCH+DogplWjXVJnlwOPk6sgCYshbPhkB8Nihm/Jx5L8cwG9tYL
	fnELOWSsjQXWDmjfUvko5RP0XGIkEzvq3v4MAbHamjfwO7qFiinDwWPjPr20p6Tj
	UtNIZaTfUEo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92440BC25;
	Sun, 17 Feb 2013 17:32:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE19ABC21; Sun, 17 Feb 2013
 17:32:47 -0500 (EST)
In-Reply-To: <5121384B.10009@web.de> (Jens Lehmann's message of "Sun, 17 Feb
 2013 21:06:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4AC161C-7951-11E2-ADB8-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216409>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Here we go, changes to v4 are:
>
> - I decided to do the proposed special casing for "."; no messages
>   about uninitialized submodules will show up anymore (this is also
>   tested)
> - The spelling fixes and better 'uninitialized' message Phil proposed
> - Added the missing quotation for $sm_path in output strings
> - "deinit" is added to the submodule completion list
> - Added two missing "&&" in t7400

Thanks for being thorough. I honestly did not expect this topic to
take this many cycles before becoming 'next-ready'.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 004c034..0fb6ee0 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -547,6 +548,82 @@ cmd_init()
>  }
>
>  #
> +# Unregister submodules from .git/config and remove their work tree
> +#
> +# $@ = requested paths (use '.' to deinit all submodules)
> +#
> +cmd_deinit()
> +{
> +	# parse $args after "submodule ... init".
> +	while test $# -ne 0
> +	do
> ..
> +	done
> +
> +	if test $# = 0
> +	then
> +		die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"

I do not think I saw anybody mentioned this so far, but how is
"deinit" supposed to work inside a subdirectory of a superproject?
If the answer is to work on submodules appear in that subdirectory,
'.' should probably not mean "all in the superproject" I think?

> +	module_list "$@" |
> +	while read mode sha1 stage sm_path
> +	do
> +		die_if_unmatched "$mode"
> +		name=$(module_name "$sm_path") || exit
> +		url=$(git config submodule."$name".url)
> +		if test -z "$url"
> +		then
> +			test $# -ne 1 || test "$@" = "." ||
> +			say "$(eval_gettext "Submodule '\$name' is not initialized for path '\$sm_path'")"
> +			continue
> +		fi

This 'test "$@" = "."' makes readers feel uneasy.  This particular
invocation happens to be safe only because it is protected with
"test $# -ne 1 ||", but for all other values of $# this will result
in a syntax error.  'test "$1" = "."' would make the intention of
the check more clear.

But stepping back a bit, is the condition this test is trying to
warn against really worth warning?

It seems that this "warn if user told us to deinitialize a submodule
that hasn't been initialized" is from the very initial round of this
series, and not something other people asked for during the review.
If somebody did

	git submodule deinit foo bar

and then later said:

	git submodule deinit foo

would it a mistake that the user wants to be warned about?

Perhaps the user did not mean to deinitialize foo (e.g. wanted to
*initialize* foo instead, or wanted to deinitialize *foz* instead)
and that is worth warning about?  I am not sure, but I have a
feeling that we can do without this check.

Also the value of submodule.$name.url is not used in the later
codepath to ensure that the named submodule is in the pristine state
in the superproject's working tree (i.e. no submodule.$name section
in the local configuration, no working tree for that submodule), so
it may be even a good change to remove the "does submodule.$name.url
exist" check and always do the "deinitialize" process.  That would
give the users a way to recover from a state where a submodule is
only half initialized for some reason safely, no?
