From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] rebase -p loses commits
Date: Mon, 16 May 2011 18:02:48 -0700
Message-ID: <7vk4dqi1fr.fsf@alter.siamese.dyndns.org>
References: <20110516103354.GA23564@sigill.intra.peff.net>
 <7vfwoel6vw.fsf@alter.siamese.dyndns.org> <4DD1C277.9070605@sohovfx.com>
 <7vpqnii1sx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Wong <andrew.w@sohovfx.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 03:06:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM8jY-0003uE-MJ
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 03:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074Ab1EQBC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 21:02:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44172 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633Ab1EQBC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 21:02:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 57BF35FB9;
	Mon, 16 May 2011 21:05:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AaVj3/Z1x4eBCqTGImnYjnJ2rHQ=; b=hkng/h
	SfVkv2LcRceyCJpOtY2t1VCUoIuTZmk0bFX2oCIgEhYTksOv4zLrJsSpAylvKGWH
	BhVkEPbOEURCcDCRoAXSjZqTxgflQCQe5WkL2t4pXI2EP9QeWlMnh4ByjJg21iHz
	yci4smX+SYd01TgxShYl6V6FIDHv+DYA/o0P4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nKs73RYTav57o4GeZWFgRon3oH5lATmF
	AB1lLroVJlkCg2Z7fluYZSCftmeGLE0UBPQH81NR1KuYHQuDKbeviEtOiCmbIrmk
	g1NDlEQ/IBJpnGovJxxw1y8l7bWn2lBOrWeXrUG3Q6kz6SviWPFb1Np4tpAxG26E
	8cy94US3JLU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 234F05FB8;
	Mon, 16 May 2011 21:05:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9CC4D5FB7; Mon, 16 May 2011
 21:04:56 -0400 (EDT)
In-Reply-To: <7vpqnii1sx.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 16 May 2011 17:54:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B173C258-8021-11E0-B49F-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173778>

Junio C Hamano <gitster@pobox.com> writes:

> But the above "preserving" rewrite does not even preserve the topology of
> the graph (the original * is a true merge between two forks, but *' is
> not) to begin with.  Also, if you want to _usefully_ place F' on top of M,
> such a rewrite should resolve possible conflicts that was resolved at * in
> the original graph at F' anyway, which would mean that the resulting *'
> should become a totally empty commit.
>
> Why would anybody want to do such a thing to begin with?

Note that I am not saying "rebase -p" is not useful in general.  If you
had

         x---x---x---W---X
        /             \   \
    ---M               Y---Z

it is entirely sensible to want to have this history to exclude 'x'

         x---x---x---W---X
        /             \   \
    ---M---W'--X'      Y---Z
            \   \
             Y'--Z'

I think the patch I posted earlier should stop the problematic case Jeff
mentioned from happening, but I am trying to see if it makes sense to stop
without doing anything even when it is forced when onto and merge-base are
the same commit (which is not true for this "sensible" case).
