From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP] completion: complete git diff with only changed
 files.
Date: Tue, 17 May 2011 22:29:04 -0700
Message-ID: <7v8vu4efvj.fsf@alter.siamese.dyndns.org>
References: <4DD30F87.2000807@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Paul Ebermann <Paul-Ebermann@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 18 07:29:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMZJw-0002Il-4r
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 07:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639Ab1ERF3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 01:29:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33341 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab1ERF3O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 01:29:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AE1CF23C7;
	Wed, 18 May 2011 01:31:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mZZzwyEGXHye+xMY5Qtm1kDwTo0=; b=rcCVrx
	5pCu0CKOCgmtFvUkN/FJQSZ5E61/FY21TlzAn7AGad1V/DQ05IUIhOwAFRB61vfN
	nGXNvEDR/2ZxMV55vsvxwezIfB/RC1Aw10+65xnjhZKHoifKiHJg1EFEK8E+AW8m
	sHwzjmqvsucFtyVu03vXAop64vzpUiGT8vMBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c/tOLZr+byxGOYxRE3+aoWYq+Yb9YG+p
	jk2oPw5nitOBgiE2JM5+781EsqCvgWclSKpbOrCaSijxHETYo/9Hq1/ple1cNmKZ
	ShSyjzgF0XhbhR7TTB19bRfZP8QGfxesTpF36OEIVeCP32xuaBTlvwGE5GYsJW4N
	Abu+UPtgI/U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7978323C3;
	Wed, 18 May 2011 01:31:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2B86823C2; Wed, 18 May 2011
 01:31:13 -0400 (EDT)
In-Reply-To: <4DD30F87.2000807@gmx.de> (Paul Ebermann's message of "Wed, 18
 May 2011 02:15:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E84D236-8110-11E0-BE7F-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173845>

Paul Ebermann <Paul-Ebermann@gmx.de> writes:

> I ported this idea to git. Now
>    git diff -- <tab>
> will complete any changed files. It also works for the other ways
> of calling git diff, except the .. and ... notations (as I'm
> not sure how to do this).

Very interesting.

I would be a bit dissapointed if this change makes

	git diff maint master -- builtin/lo<TAB>

not complete for me when builtin/log.c did not change between these two
branches, as running between different maintenance tracks and the master
branch to see how far things have diverged is my first quick sanity check
before deciding where in the history a new patch should be queued.

Spending cycles to keep me waiting while running "diff" before giving me
the control back, and implicitly telling me by not telling me that lo...
is a completion candidate, would surely make me go "Huh? Is it being slow?
Hello? <TAB> <TAAAB> <TAAAAAAAB> ... hmm, did I mistype the directory
name?  B-U-I-L-T-I-N ... that's correct.... what's going on?  ah wait a
minute, we recently applied that stupid change that tells me what I really
want to know by not telling me, which is backwards."

That's already 12 seconds wasted, and worse yet, even after I learn the
quirk of the new behaviour that tells what I want to know by not telling
me, the need to make sure that I didn't mistype the directory name would
not disappear.

I would rather not to be retrained to wire my brain backwards in the first
place.

> +    local -a args=()
> +    local finish=false
> +
> +    for (( i=1 ; i < cword ; i++)) do
> +    local current_arg=${words[$i]}
> +    #  echo checking $current_arg >&2
> +       case $current_arg in
> +           --cached)

case arms align with case and esac in our codebase, i.e.

	case $current_arg in
        --cached)
        	...
                ;;
                ...
	esac

> +           *)
> +               if git cat-file -e $current_arg 2> /dev/null
> +               then
> +                   case $( git cat-file -t $current_arg ) in

I do not see the need for the outer if/then/fi here. Wouldn't this
sufficient?

		case "$(git cat-file -t $current_arg 2>/dev/null)" in
		commit|tag)
                	...

If you are interested in dealing with ../... notation, you could instead
use "git rev-parse --revs-only --no-flags", e.g.

	$ git rev-parse --revs-only --no-flags maint..master
        b602ed7dea968d72c5b3f61ca016de7f285d80ef
	^ea1ab4b280ed3b041da53e161e32e38930569f3e

        $ git rev-parse --revs-only --no-flags jch...pu
        11b715c624d3766546a52cc333bc2ea2e426f631
        14f92e20522bae26faa841374bbbe6c0d08770de
        ^14f92e20522bae26faa841374bbbe6c0d08770de

But I tend to think this change itself is not such a great idea to begin
with, so....
