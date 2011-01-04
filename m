From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 3/3] filter-branch: support --submodule-filter
Date: Tue, 04 Jan 2011 11:18:32 -0800
Message-ID: <7vfwt8fpfb.fsf@alter.siamese.dyndns.org>
References: <cover.1293809100.git.trast@student.ethz.ch>
 <44e6104ba28c80a6befe0f39fa4e2d6eeec56aa9.1293809100.git.trast@student.ethz.ch> <4D225F63.1040502@syncleus.com> <201101041414.19587.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeffrey Phillips Freeman <jeffrey.freeman@syncleus.com>,
	<git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 04 20:18:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaCPE-0003EC-8W
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 20:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181Ab1ADTSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 14:18:47 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab1ADTSq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 14:18:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 290C52FA5;
	Tue,  4 Jan 2011 14:19:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=krSuZG0cevK6+5r9XO13iQ1D9HE=; b=HOCuiW0phvllTZo8/nB1TCo
	a+wJfiwRrJDHhUDRNxagrrFRM1yj5IFPGv5HA10Kolfd1zjuv+EzumsphgJhby1m
	L5cFP2G/rRnXJ6KmgmRl7+hk7Xw1PLe6LMSGyVbo2Th6eHiFvw611OA+l8Zp0yJe
	sADzG9iSL4mljEkQ9h/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=anDEhzHWuN4QQ9W1qFaJZb9DJ0U0auOLnuCZuJPcXxZO1B5Tl
	7Ktfmro/6rmL+0mU0s9IgWWSOIeW1MkxFJElKaV9IV1btnfm3YakDLjoKPrUcnRL
	EVPxAYZpJzfq5qHAlR5T6PR1YW9JLX0qYEy4VTGca0wVww0pCeNl3w1lrs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CBF732FA4;
	Tue,  4 Jan 2011 14:19:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 11D472FA2; Tue,  4 Jan 2011
 14:19:09 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 85C9C0E6-1837-11E0-94E9-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164510>

Thomas Rast <trast@student.ethz.ch> writes:

> Subject: TOY PATCH: filter-branch --split-submodule
>
> Sometimes it makes sense to split out a path not as a subdirectory
> (that would be merged by subtree-merge), but as a submodule.  Since
> git objects are just shaped in the right way, this is actually quite
> easy to do in a way that maintains the correct history relations:

The patch from a cursory look feels sane.

> @@ -349,6 +352,43 @@ while read commit parents; do
>  	eval "$filter_index" < /dev/null ||
>  		die "index filter failed: $filter_index"
>  
> +	if test -n "$split_submodule"; then
> +		sub_differs=
> +		sub_parents=
> +		sub_commit=

Just a style, but I find

	if test -n "$split_submodule"
        then
        	sub_differs= sub_parents= sub_commit=

easier to read.  Not a biggie, as the neighbourhood in the script already
is infested in the other style, but I thought I'd mention it.

> +		submodule="$(git rev-parse --verify $commit:$split_submodule 2>/dev/null)"

Do we need double quotes around it?

> +		if test -z "$parents"; then
> +			if test -n "$submodule"; then
> +				sub_differs=t
> +			fi
> +		fi

	if test -z "$parents" && test -n "$submodule"
        then
        	sub_differs=t
	fi

> +		for parent in $parents; do
> +			if ! test "$(git rev-parse --verify $parent:$split_submodule 2>/dev/null)" = "$submodule"; then
> +				sub_differs=t
> +			fi

If even one of the parents is different, we say "differs"...

> +		if test -n "$sub_differs"; then
> +			sub_commit="$(sed -e '1,/^$/d' <../commit |
> +				      git commit-tree $submodule $sub_parents)" || exit
> +		else
> +			for parent in $parents; do
> +				sub_commit="$(git rev-parse --verify "$(map "$parent")":$split_submodule 2>/dev/null)"
> +				break

... so we can just pick from the first parent and know all of them are the
same (could be empty which also is fine).  Good.
