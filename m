From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH] Manual rename correction
Date: Wed, 01 Aug 2012 22:33:44 -0700
Message-ID: <7v6291eu2v.fsf@alter.siamese.dyndns.org>
References: <20120731141536.GA26283@do>
 <7vtxwnki1a.fsf@alter.siamese.dyndns.org>
 <20120731192342.GB30808@sigill.intra.peff.net>
 <7vfw87isx1.fsf@alter.siamese.dyndns.org>
 <20120801004238.GA15428@sigill.intra.peff.net>
 <7v8vdzgngo.fsf@alter.siamese.dyndns.org>
 <20120801215414.GC16233@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 02 07:33:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Swo2l-0003ve-Lo
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 07:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716Ab2HBFdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 01:33:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46606 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751236Ab2HBFdt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 01:33:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C79099565;
	Thu,  2 Aug 2012 01:33:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HKKyBDap3FzYaOxJIcBWS7NIgAQ=; b=cqKjtz
	/eUCT0m8wSZ16iv6fX6m8f5z2dylcEzvA4eC8rlyofw1PWC0MldCerZVL/hSYCP5
	QLitKrC9Kjni5H22OHlc/VEU5vmUHkVtwDMtP070zOnk+m4xfz74cfsrf6EjEAq9
	5zQViV2aLoeTDHt9O0jtHeltBd4gHFIQqdqbo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lAs7zmrZGNUgorCnsysBHzBqODlPOG8t
	+u8YuCfi/PAzObP/IphQyAxPZPlHVpfOkIE2ZjnfMaOfEcIGuCKNkzCtSKAPsKho
	3t0BQBrlOwlsvsFNRL0wSKtbjT0CH/5kcqOdXTNMXETYfyYkvZ5q1KFbAXrlgAKS
	4AC/pB2YaFo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B55D39564;
	Thu,  2 Aug 2012 01:33:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0082A9563; Thu,  2 Aug 2012
 01:33:45 -0400 (EDT)
In-Reply-To: <20120801215414.GC16233@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 1 Aug 2012 17:54:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1136DB0-DC63-11E1-B666-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202743>

Jeff King <peff@peff.net> writes:

> On Tue, Jul 31, 2012 at 11:01:27PM -0700, Junio C Hamano wrote:
>
>>  - As entries in rename cache that record high scores have names of
>>    "similar" blobs, pack-objects may be able to take advantage of
>>    this information.
>
> Yeah, although I suspect it is not as big a win as you might hope.  In
> practice, you're going to diff a lot fewer objects than pack-objects
> would consider, so most of the pack-objects candidate pairs will not
> have a cache entry.  Which means that you really need to not rely on the
> cache (since it is very likely that the best candidate is still to be
> found), and you still do lots of computation.
>
> You could cache the result of comparisons done by pack-objects, but that
> cache ends up being large. You might remember that one of my very first
> patches was a cache for recording negative delta finds (so we try to
> delta A against B and find that it is not a good match, and record that
> information). Even that cache was huge, and we ended up discarding it in
> favor of Linus's much more sensible "if two things are in the same pack
> and not delta'd, then either they are not a good match, or something
> else is in better" heuristic. But one with full-on similarity scores
> would be even bigger.

Yeah, I forgot about your negative cache.  Also the older companion
heuristics "if a delta and its base are in an existing pack, use
that delta" works well enough to make a positive cache unnecessary
(and the "rename similarity cache" can only be a subset of such a
cache).

C.f. http://thread.gmane.org/gmane.comp.version-control.git/16223/focus=16267

>>  - If you declare blobs A and B are similar, it is likely that blobs
>>    C, D, E, ... that are created by making a series of small tweaks
>>    to B are also similar.  Would it make more sense to introduce a
>>    concept of "set of similar blobs" instead of recording pairwise
>>    scores for (A,B), (A,C), (A,D), ... (B,C), (B,D), ...?  If so,
>>    the body of per-dst loop in diffcore_rename() may become:
>
> Yes, this is the transitive bit I mentioned elsewhere. I think there are
> dragons lurking there, as you end up with the edges of the set not
> _really_ being that close to each other. You'd probably want some kind
> of weighted association, like if A->B had 80% similarity, and B->C had
> 90% similarity, then A->C would be 72%.

I recall we discussed the transitivity when we were designing the
basic rename thing, and rejected it after we realized that it was
unworkable.  You may have a blob A, perform a large-ish edit to
produce B, and A and B may be similar by only 60%.  You then may
start from the same A, perform another large-ish edit to produce C,
and A and C may be similar by only 55%.  Depending on the nature of
these two large-ish changes, B and C may be totally dissimilar, or
if the changes are more or less in the same "direction", they may be
95% similar.
