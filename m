From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git for game development?
Date: Wed, 24 Aug 2011 10:17:49 -0700
Message-ID: <7vwre2pw3m.fsf@alter.siamese.dyndns.org>
References: <416D1A48-9916-4E44-A200-3A13C39C4D70@gmail.com>
 <20110824012418.GA19091@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lawrence Brett <lcbrett@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 24 19:18:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwH5T-0003Aa-BI
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 19:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376Ab1HXRRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 13:17:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36265 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550Ab1HXRRx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 13:17:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 200E84B01;
	Wed, 24 Aug 2011 13:17:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZvOgaonlRd8AA53CHerOiJcn2Ts=; b=Lwps6f
	u4fT+KsXxT5vs17k1WCVc2/IEcSXamY+x6gpg8nqhsgJCORMZEq0Ufakm19VPFsd
	WxypVFfXf4EyXzgbAjXv13n9JqgtU0Cwz93ZQevRLUE9w190dpYQ3SA9jad7WzQC
	Yw3TW3nYJTN9TpiJQc0S8pJUf1EF17KIJsxso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gEGXjq/mIWBN2/isiZdpaL+UTB1wXbV9
	pPmUDrgiWnqrNu0YFWTU8Ze8Fud2Ir6Kyevl2V7nhNFf/6XGxDnLsb2jrWoAbxBN
	rOuZhoh+Af2sOSVhTEujcsZY+k9C0E6i6UDDTqm1SmPDDGQijG5YbZgC/GhHpGhh
	K4Cy4pTuFJw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 175CE4B00;
	Wed, 24 Aug 2011 13:17:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D9E54AF5; Wed, 24 Aug 2011
 13:17:51 -0400 (EDT)
In-Reply-To: <20110824012418.GA19091@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 23 Aug 2011 21:24:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF396758-CE74-11E0-9DB1-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180017>

Jeff King <peff@peff.net> writes:

> I don't remember all of the details of bup, but if it's possible to
> implement something similar at a lower level (i.e., at the layer of
> packfiles or object storage), then it can be a purely local thing, and
> the compatibility issues can go away.

I tend to agree, and we might be closer than we realize.

I suspect that people with large binary assets were scared away by rumors
they heard second-hand, based on bad experiences other people had before
any of the recent efforts made in various "large Git" topics, and they
themselves haven't tried recent versions of Git enough to be able to tell
what the remaining pain points are. I wouldn't be surprised if none of the
core Git people tried shoving huge binary assets in test repositories with
recent versions of Git---I certainly haven't.

We used to always map the blob data as a whole for anything we do, but
these days, with changes like your abb371a (diff: don't retrieve binary
blobs for diffstat, 2011-02-19) and my recent "send large blob straight to
a new pack" and "stream large data out to the working tree without holding
everything in core while checking out" topics, I suspect that the support
for local usage of large blobs might be sufficiently better than the old
days. Git might even be usable locally without anything else, which I find
implausible, but I wouldn't be surprised if there remained only a handful
minor things remaining that we need to add to make it usable.

People toyed around with ideas to have a separate object store
representation for large and possibly incompressible blobs (a possible
complaint being that it is pointless to send them even to its own
packfile). One possible implementation would be to add a new huge
hierarchy under $GIT_DIR/objects/, compute the object name exactly the
same way for huge blobs as we normally would (i.e. hash concatenation of
object header and then contents) to decide which subdirectory under the
"huge" hierarchy to store the data (huge/[0-9a-f]{2}/[0-9a-f]{38}/ like we
do for loose objects, or perhaps huge/[0-9a-f]{40}/ expecting that there
won't be very many). The data can be stored unmodified as a file in that
directory, with type stored in a separate file---that way, we won't have
to compress, but we just copy. You still need to hash it at least once to
come up with the object name, but that is what gives us integrity checks,
is unavoidable and is not going to change.

The sha1_object_info() layer can learn to return the type and size from
such a representation, and you can further tweak the same places as the
"streaming checkout" and the "checkin to a pack" topics touched to support
such a representation.

I would suspect that the local object representation is _not_ the largest
pain point; such a separate object store representation is not buying us
very much over a simpler "single large blob in a separate packfile", and
if the counter-argument is "no, decompressing still costs a lot", then the
real issue might be we decompress and look at the data when we do not have
to (i.e. issues similar to what abb371a addressed), not "decompress vs
straight copy make a bit difference".

I would further suspect that we _might_ need a better support for local
repacking and object transfer, with or without such a third object
representation.
