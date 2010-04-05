From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Extremely slow progress during 'git reflog expire --all'
Date: Mon, 05 Apr 2010 11:54:28 -0700
Message-ID: <7v1vetpw63.fsf@alter.siamese.dyndns.org>
References: <201004022154.14793.elendil@planet.nl>
 <201004022350.20999.elendil@planet.nl>
 <20100402224100.GA997@coredump.intra.peff.net>
 <201004031629.01970.elendil@planet.nl>
 <20100403203507.GA12262@coredump.intra.peff.net>
 <7vy6h36pt1.fsf@alter.siamese.dyndns.org>
 <20100405062621.GA30934@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frans Pop <elendil@planet.nl>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:54:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrRe-0003Ze-T1
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756176Ab0DESyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 14:54:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45900 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755872Ab0DESyl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:54:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C97ACA8270;
	Mon,  5 Apr 2010 14:54:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yWgMeVlpUTmmh+iTcl0xyynCCXE=; b=CK6A98
	IvbtSbK3ZTJ/eLi5SwSXQnvvABaTnaoytVoh7vzAPb2tCSGelFpa46JB30WROEn8
	+AJqQ/Z6QknUIWPlIn66S/awzhMbnPvmw68zkAHG0N3Y+erDovc4BcUZuPku+Z5C
	tZ0x9TqAnom9yFR/MJEie79+dmBtPsC3SpQkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MX5kJ9fG67WzH4C8ECsPzWi/rvzN1iV+
	l4D3S/RPwlx0b/TJ9kvkfMBd2z1u8v5gKJoRQ4Kzc+eVXzdtHxQDt4M3vtZ+1Hz7
	ZBxtGyZDybitfl2bzxE361+QpsJ4t8Jps6vwqF2gdrC2cpYhLgA9R+nFqeggnd0j
	wevzPPJgCMg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 23B32A826E;
	Mon,  5 Apr 2010 14:54:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B61AA8269; Mon,  5 Apr
 2010 14:54:30 -0400 (EDT)
In-Reply-To: <20100405062621.GA30934@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 5 Apr 2010 02\:26\:21 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AD61342A-40E4-11DF-A2DB-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144047>

Jeff King <peff@peff.net> writes:

> Hmm. It looks like mark_reachable() stops traversing when it hits a
> commit older than expire_total. I imagine that's to avoid going all the
> way to the roots. But if we hit any unreachable entry, in_merge_bases()
> is going to have to go all the way to the roots, anyway.

Yeah, an alternative is to keep the list of commits where the initial
mark_reachable() run stopped, and instead of doing in_merge_bases(),
lazily restart the traversal all the way down to root, and then rely
solely on the REACHABLE bit from then on.

> Or is that what your "clock skew" is meant to mean?

What I meant was you commit A, a child B, rewind clock to commit its child
C at an incorrect and old time, and fix clock to commit its child D which
is at the tip of a ref.  mark_reachable() will stop at C saying that is
sufficiently old and recent A and B may be pruned too early.

> I wonder if, in addition to your patch, we should remove the
> double-check in_merge_bases and simply report those old ones as
> reachable. We may be wrong, but we are erring on the side of keeping
> entries, and they will eventually expire in the regular cycle (i.e., 90
> days instead of 30).
>
> All of that being said, your patch does drop Frans' case down to about
> 1s of CPU time, so perhaps it is not worth worrying about beyond that.

I think a reasonable solution would be along the lines you described, but
the patch you are responding to does err on the wrong side when a clock
skew is there.  Does it matter?  Probably not.
