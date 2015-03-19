From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] t5312: test object deletion code paths in a corrupted repository
Date: Thu, 19 Mar 2015 13:04:16 -0700
Message-ID: <xmqqfv90iwjj.fsf@gitster.dls.corp.google.com>
References: <20150317072750.GA22155@peff.net>
	<20150317072844.GA25191@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 21:04:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYgg3-0004Aq-WC
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 21:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbbCSUEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 16:04:20 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58548 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750749AbbCSUET (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 16:04:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 68ED240438;
	Thu, 19 Mar 2015 16:04:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lFOKXuGQ8dxGXhaSY1MCxCOuHPM=; b=BbyHfA
	SfyiHfaNleEPq+3jhf5DHc8SaOLJzfrd+BzXRpFN4qC6O/XfKalZMCuKVlkkH/WF
	esNxlyDhWzCvTmbQormWaJjA0LzYcaeQ7eNg5ILE32xHT4HiCKtaErf7jQ4CgY9W
	omPxjSlLVU7+oJgCMbzkxzRoD/6+yiymwfxhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZhPIcVBWVumx6pgtB2OJO6fCYkMSk+L6
	j1/Qda1OCr4+ip2smTV8N+CPr56D9daTk/FZUB/7sbAL+ygVIeUgE0CThyBDZqyE
	v0lTVzfzPOTbcO4Lu5LATfnFTnykQZlashDPHM6L/D7ZsbUIhyK3iLys+0mtxhRY
	GldTFOcBas0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6030040437;
	Thu, 19 Mar 2015 16:04:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D64B540433;
	Thu, 19 Mar 2015 16:04:17 -0400 (EDT)
In-Reply-To: <20150317072844.GA25191@peff.net> (Jeff King's message of "Tue,
	17 Mar 2015 03:28:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1FDA5B78-CE73-11E4-8B94-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265821>

Jeff King <peff@peff.net> writes:

> +test_expect_success 'create history with missing tip commit' '
> +	test_tick && git commit --allow-empty -m one &&
> +	recoverable=$(git rev-parse HEAD) &&
> +	git cat-file commit $recoverable >saved &&
> +	test_tick && git commit --allow-empty -m two &&
> +	missing=$(git rev-parse HEAD) &&
> +	# point HEAD elsewhere
> +	git checkout $base &&

Could you spell this as "$base^0" (or "--detach") to clarify the
intention?  I have been scraching my head for a few minutes just
now, trying to figure out what you are doing here.  I _think_ you
wanted master to point at the missing "two" and wanted to make sure
all other refs (including HEAD) to point away from it.

Mental note: At this point, the history looks like

    base   one    two
    o------o------o
     \
      o bogus

and because the reference to two is still there but two itself is
missing, pruning may well end up losing one, because the reference
to it is only through master pointing at two.

> +	rm .git/objects/$(echo $missing | sed "s,..,&/,") &&
> +	test_must_fail git cat-file -e $missing
> +'
> +
> +test_expect_failure 'pruning with a corrupted tip does not drop history' '
> +	test_when_finished "git hash-object -w -t commit saved" &&
> +	test_might_fail git prune --expire=now &&
> +	verbose git cat-file -e $recoverable
> +'

Mental note: OK, this demonstrates that the missing two makes us
lose the only reference to one (aka $recoverable in saved).

> +test_expect_success 'pack-refs does not silently delete broken loose ref' '
> +	git pack-refs --all --prune &&
> +	echo $missing >expect &&
> +	git rev-parse refs/heads/master >actual &&
> +	test_cmp expect actual
> +'
> +
> +# we do not want to count on running pack-refs to
> +# actually pack it, as it is perfectly reasonable to
> +# skip processing a broken ref
> +test_expect_success 'create packed-refs file with broken ref' '
> +	rm -f .git/refs/heads/master &&
> +	cat >.git/packed-refs <<-EOF
> +	$missing refs/heads/master
> +	$recoverable refs/heads/other
> +	EOF

I do not know offhand if the lack of the pack-refs feature header
matters here; I assume it does not?

A safer check may be to pack and then make it missing, I guess, but
I do not know if the difference matters.
