From: Junio C Hamano <gitster@pobox.com>
Subject: Re: jk/tag-contains: stalled
Date: Thu, 05 Aug 2010 13:53:05 -0700
Message-ID: <7vd3twdbny.fsf@alter.siamese.dyndns.org>
References: <7v62zqf23s.fsf@alter.siamese.dyndns.org>
 <20100805001629.GC2901@thunk.org> <7vsk2tdnv5.fsf@alter.siamese.dyndns.org>
 <7vhbj9dm6h.fsf@alter.siamese.dyndns.org> <20100805173635.GA15760@sigill>
 <7vy6ckdhhu.fsf@alter.siamese.dyndns.org> <20100805190653.GA2942@sigill>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Ts'o <tytso@mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 05 22:53:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh7Rb-0000xr-2d
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 22:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934177Ab0HEUxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 16:53:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39276 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934167Ab0HEUxR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 16:53:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E71ACAE0B;
	Thu,  5 Aug 2010 16:53:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vsyVRzAHsV99VfR2GSeSthtUCUM=; b=HDjz+m
	XdAslF1oPi5nhnTCWIXKNCz+AAr3ye+LAX7M1nSrKeD/Dqh1y8LpBBZLtDy8YCp8
	ubZDmVMbtzeWlhOBPVrTpJqxY8k2cxAqpC+PHipUNdHTQXm2CxBNOYZfH/0Pndij
	6n0Z76kdRQ5uby8V8CZfip+PmHJ5schCAWQ1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qb2HZo9yNcihpFA4Ftzv/dgE/ViOPBw9
	vMtjflfruvU6X5yNt5/MeVi7KGV0vF7Twlt2Uc15IH9hSNKHjXG+KAdhVTTlkiyJ
	Odkwefk1PrHSE4zuS62139hVHHt7l5Tl9WEeiUytyrcAxue6NXyzu1Zd91K2+ELY
	sPqxJSk6nas=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AABACAE0A;
	Thu,  5 Aug 2010 16:53:11 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CB11CAE09; Thu,  5 Aug
 2010 16:53:07 -0400 (EDT)
In-Reply-To: <20100805190653.GA2942@sigill> (Jeff King's message of "Thu\, 5
 Aug 2010 15\:06\:54 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 755F36A4-A0D3-11DF-91FB-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152714>

Jeff King <peff@peff.net> writes:

> Oops, thanks, I had forgotten that the marks needed to be addressed.
> Should I be introducing new flags? We have 27 flag bits, but I would
> hate to waste 2 of them.

In the longer term it would be not just nice but necessary for us to come
up with a scheme where different codepaths can "allocate bits from object
flags", without having to fear stepping on each other's toes.  Some
possible approaches off the top of my head are:

 - Extend "struct object" by another uint64_t to give it 64 more bits?
   That would make the minimum object size from 24 bytes to 32 bytes and
   during a pack-object session we would keep a lot of objects (not just
   commits but trees and blobs) in core, so we probably would not want to
   do this.

 - Extend "struct commit" by another uint32_t?  Currently a "struct
   commit" is 72 bytes on x86_64 (there is an unfortunate 4-byte padding
   gap between indegree and date), and 48 bytes on i386 and this would
   enlarge the latter to 52 bytes (this comes free on 64-bit archs).

   As we need a lot more bits on commits than on other objects
   (e.g. left-right do not need to be placed on trees or blobs), this
   approach might be more space efficient.

 - Use one bit in the current flags section to signal "extended flag bits
   present on this object", and have a separate hashtable for minority
   objects that have that bit set?  This would work only for flag bits
   that are rarely used (otherwise the secondary hashtable will be full of
   objects and per-object overhead will kill us).

 - Migrate some users of flag bits that only mark small miniroty of
   commits to use dedicated hashtable to free their bits [*1*].  I don't
   know if there are candidates for doing this offhand.  Just uttering it
   as an idea.

Independent of this issue, I suspect that we might want to fold
object.used into the general set of flags---it is only used by fsck as far
as I remember.

[Footnote]

*1* Also we would want to do something similar to the commit.util field so
that more than one utility libraries can attach their own stuff to each
commit.  It _might_ make sense to instead get rid of commit.util and
migrate the users to a separate "one object hash per one type of info",
though.  In any case it is a separate topic.
