From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-merge segfault in 1.6.6 and master
Date: Wed, 20 Jan 2010 14:21:45 -0800
Message-ID: <7vtyugzabq.fsf@alter.siamese.dyndns.org>
References: <hj7abm$5vc$1@ger.gmane.org>
 <7vocko3802.fsf@alter.siamese.dyndns.org>
 <4B577C3F.7040608@brooklynpenguin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Tim Olsen <tim@brooklynpenguin.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 23:22:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXiwB-0004Uk-Vo
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 23:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508Ab0ATWWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 17:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754492Ab0ATWWA
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 17:22:00 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63246 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555Ab0ATWV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 17:21:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 81D2692F6D;
	Wed, 20 Jan 2010 17:21:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RKtftd8Lxw8SbkCkpgg7HjISXcQ=; b=X88KgP
	mYMJoLQh1Pn5oLbaTK/tr5ByPGdwEoG8EmFgHTIQZmJWpD2wlaJTowNLtldrW6f7
	VCxN/pnQWuPrjSGRkUpLmwD79W40k6+S4uzCZG+JfsS5KXBirDG8ac3orlwBzqWh
	4cvE1fMniKAbHe8++X/Yn4WriCDo1fgii8tCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EjWZXVlBip+WL8xxHOfVh9YEMYCHE7D6
	hmCkfWEVPIR81kTtvWsfW5wepjYOe8VrI2vnwAjHr0fuTDuZ1k7x86+X8KTITHSC
	NeA6SYvbKVh39OK3q8nGCQmbq2v+yrlr4+w27CKUtlw35u7917lD2bl+UHnRPMP/
	Z2snHW4Gp9c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4140492F67;
	Wed, 20 Jan 2010 17:21:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5232A92F65; Wed, 20 Jan
 2010 17:21:47 -0500 (EST)
In-Reply-To: <4B577C3F.7040608@brooklynpenguin.com> (Tim Olsen's message of
 "Wed\, 20 Jan 2010 16\:57\:19 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3591DED4-0612-11DF-B757-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137593>

Tim Olsen <tim@brooklynpenguin.com> writes:

> At the beginning of merge_recursive(), the local mrtree appears to be
> set to some globally defined mrtree which is not null:

No; that "assignment" is just to squelch warning from gcc.  mrtree at that
point is uninitialized.

> In merge_trees(), mrtree is the argument **result.  It is at line 1255
> that write_tree_from_memory nulls out the pointee of result:
> ...
> Then in write_tree_from_memory() we find the offending return NULL at
> line 210:
>
> Breakpoint 8, write_tree_from_memory (o=0x7fffffffd560) at
> merge-recursive.c:210
> (gdb) list
> 205				struct cache_entry *ce = active_cache[i];
> 206				if (ce_stage(ce))
> 207					output(o, 0, "%d %.*s", ce_stage(ce),
> 208					       (int)ce_namelen(ce), ce->name);
> 209			}
> 210			return NULL;
> 211		}
> 212	
> 213		if (!active_cache_tree)
> 214			active_cache_tree = cache_tree();
> (gdb)

Are you saying write_tree_from_memory() is returning NULL?  That probably
means that in the recursive (i.e. the step that first merges multiple
common ancestors into one) case the merge is getting conflicts.  Do you
see these "There are unmerged index entries" output?

In the recursive case (i.e. o->call_depth is non-zero), process_renames()
and process_entry() are supposed to be forcing the conflicts resolved,
recording the contents with conflict markers if necessary, before the
control gets to that point, so it clearly is a bug very specific to the
recursive merge implementation.
