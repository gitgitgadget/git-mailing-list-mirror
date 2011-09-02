From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Funnies with "git fetch"
Date: Thu, 01 Sep 2011 20:09:49 -0700
Message-ID: <7vippbmygy.fsf@alter.siamese.dyndns.org>
References: <7vpqjkw3nb.fsf@alter.siamese.dyndns.org>
 <7vpqjjnau1.fsf@alter.siamese.dyndns.org>
 <20110901233108.GA9339@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 02 05:10:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzK8s-00025O-W7
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 05:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758096Ab1IBDJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 23:09:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51450 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758091Ab1IBDJx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 23:09:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6A4B5474;
	Thu,  1 Sep 2011 23:09:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9luJ3ImFkCTrTbFETJ8qGw20gzs=; b=Xd2WLR
	v/MWD6YjPNGEedz1iYu8QZvEO6vR0iiau1araszuwsj1eRE+IzfUZFxwJZtHVoaD
	ZiMwZ3oXQUKN90yunfNHzIWuGLThRsqsQozxqOjdykNy+Yv+d3ZaFgAl0cRx7Elw
	Aixn0QKygaWHvleXSdLnhBKFc4dW5cmUudIyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w5h/L3qmdRv7QAU522EccIAzKjNQsQNa
	z3UBf+RvTvF3HIHIvrDHVP36ZN7vEbkSfucnnJeRbFoA0Ht5YHcd6Rc9/Cv8HxlM
	nBdRzh8Cn284N/NJgW9tNixAQ/sGh7wdheMJefhQNPj3PPQm1+6oER8D7u6Lo6se
	yJOy4MQvqI0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADD525473;
	Thu,  1 Sep 2011 23:09:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 916A65472; Thu,  1 Sep 2011
 23:09:50 -0400 (EDT)
In-Reply-To: <20110901233108.GA9339@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 1 Sep 2011 19:31:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0596FFFA-D511-11E0-8758-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180592>

Jeff King <peff@peff.net> writes:

> If I understand correctly, your series is just about checking that we
> have newly-referenced blobs. We were already checking commits and trees,
> and we should already be hashing individual objects when we index the
> pack. Right?

You may be slightly misunderstanding the series.

We let unpack-objects or index-pack consume the pack stream, either by
exploding them into loose objects, or computing the object name for each
object to create the mapping from object name to the offset. During this
process, we deflate to read the contents and resolve the delta to come up
with the object name for individual objects, so we would notice corruption
at the individual object level. As pack stream does not say what name each
object is (the recipient is expected to compute it), there is no "stream
says it is object X but the data is actually for object Y" problem. The
recipient does not even see "X"---all it sees is Y.

The current code does not try to make sure we really have the objects
necessary to connect the updated tips to our original refs at all.  Not
just blobs but neither commits nor trees are traversed. The new check in
store_updated_refs() is about that. So in that sense, the series is not
about "just blobs".

The "rev-list --verify-objects" patch is about "blob vs everything else".
It is used in the existing quickfetch() check, and also the additional
check in store_updated_refs(). The existing check we run with "--objects"
is capable of detecting corruptions of commits and trees (as we had to be
able to read them to discover objects they refer to), but that is not a
sufficient check if we worry about missing blobs.
