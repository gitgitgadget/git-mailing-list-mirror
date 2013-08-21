From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [DO NOT APPLY PATCH 4/4] index-pack: optionally skip duplicate packfile entries
Date: Wed, 21 Aug 2013 16:20:07 -0700
Message-ID: <xmqqob8qskbc.fsf@gitster.dls.corp.google.com>
References: <20130821204955.GA28025@sigill.intra.peff.net>
	<20130821205555.GD28165@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 22 01:20:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCHhJ-0001ef-HA
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 01:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059Ab3HUXUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 19:20:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39169 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936Ab3HUXUK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 19:20:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F01D3B626;
	Wed, 21 Aug 2013 23:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Yw+PWWBGxV6SfXDdzdG2sSQ0hw4=; b=q4qrE3
	g1FQ631DCMfBXAi94ei9nl6LHcbH9aGNVQ7VpuzHEYZsROAI2mw6opJsmPxJTLPd
	V5JbKxt3Ue9LrPOd4/g0CR3Gebg5g1ckmg4LA1J/me0C8Hd8u3hHcqTYPHu7V7Qw
	m4Psm02OnGf36vePWLab18c/1OUrlNqNQ2vvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lp9yB97uJh2li0DAPdlcO5M5zyGWd3zr
	Wn2dK1ShfFo1mSfJqOjNylwdLKkkLNvhsQS2NoF2Rsh15Neuc69kVGih5mgO/NBN
	zVPrmTt4V9+GsbfNY4Jb3BV974La5rXKD5/WlFdZgNcfFnJuWmfMbss6G6kTdHjD
	wLd29hhYGhM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 701DB3B624;
	Wed, 21 Aug 2013 23:20:09 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D56DB3B61E;
	Wed, 21 Aug 2013 23:20:08 +0000 (UTC)
In-Reply-To: <20130821205555.GD28165@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 21 Aug 2013 16:55:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 38771598-0AB8-11E3-A953-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232749>

Jeff King <peff@peff.net> writes:

> When we are building the pack index, we can notice that
> there are duplicate objects, pick one "winner" instance, and
> mention the object only once in the index (mapped to the
> winner's offset).
>
> This has the effect that the duplicate packfile entries are
> never found by lookup. The data still exists in the
> packfile, though, and can be used as a delta base if delta
> base offsets are used. If delta refs are used, then it is
> possible that some deltas may be broken.

I do not understand the last bit.  If two copies of an object exist
but you have only one slot for the object in the index, and another
object names it as its base with ref-delta, then reconstituting it
should work just fine---whichever representation of the base object
is recorded in the .idx, that first needs to be reconstituted before
the delta is applied to it, and both copies should yield identical
contents for the delta base object, no?

In any case, ejecting one from the pack .idx would not help in the
presense of either broken or malicious packer that reuses delta too
aggressively.  Suppose you have objects A and B and somehow manage
to create a cycle of deltas, A names B as its delta base and B names
A as its delta base.  The packer may notice its mistake and then add
another copy of A as a base object.  The pack contains two copies of
A (one is delta based on B, the other is full) and B (delta against
A).

If B refers to the copy of A that is delta against B using ofs-delta,
fixing the .idx file will have no effect.  read_packed_sha1(B) will
read the delta data of B, finds the offset to start reading the data
for A which was excised from the .idx and unless that codepath is
updated to consult revindex (i.e. you mark one copy of A in the .pack
as bad, and when B refers to that bad copy of A via ofs-delta, you
check the offset against revindex to get the object name of A and go
to the good copy of A), you will never finish reading B because
reading the bad copy of A will lead you to first reconstitute B.

> I think this line of "fixing" should probably be scrapped.

I tend to agree.
