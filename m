From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cherry-pick is slow
Date: Tue, 15 May 2012 14:03:40 -0700
Message-ID: <7vwr4dcg2b.fsf@alter.siamese.dyndns.org>
References: <CAPZ_ugYojqTaWi0atr2ApOu9xmcwy4y8FduNC+TDhgWgSxXNPQ@mail.gmail.com>
 <CAPc5daW6eBLUf55_Qk+4bA6Y16TehfOUGc1xFzhib9vm=8O2Yw@mail.gmail.com>
 <CAPZ_ugbV6hB+8z8UsQKdHhxGuHbLzC5WK19mK7M8k2tMz+mtXw@mail.gmail.com>
 <20120514145412.GA1159@sigill.intra.peff.net>
 <CAPZ_ugbD=mOPBs6GyapWtv6NWuJ-=r2+bqBN9n+gdTPwGj3F0Q@mail.gmail.com>
 <20120515132451.GA25378@sigill.intra.peff.net>
 <7v1umldw3i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Risenberg <dmitry.risenberg@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 15 23:03:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUOuO-0007D7-83
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 23:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966822Ab2EOVDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 17:03:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64946 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966813Ab2EOVDr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2012 17:03:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 493AF898D;
	Tue, 15 May 2012 17:03:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MkvwLSKot4pIfOW9IIrATH66qCw=; b=ByHfUE
	f0LtL6DYJpv04i/Xy0szu1g8r8wU66B+LFai8wgJONnVrKyQtLXJHb87+KjgRdQq
	brymA8yjdYZsBTHpuTTGRjHdSACGU2zyIqwtTRHnPjIIy7jWyrh1AIEN0t9WGh+4
	dy/yIHv1ZRL31tqL+gTrCZIany/vGiD7uiNCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o9WOuUxpStbBsPedD0ufhWkofVgNImlf
	avzeZmEHNor6FQHVH2d1L1V8J+fZPc0n50vo7GNQaOCazot86OMgKdpJgQcdAXhO
	ETt5wZG7hqPQrDZUbRwaR7wnMGDBidGVillnI9Yq0H3Cv0g7Jd1z9BSpjB0goP9Q
	9kOrYiCr/ZY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 404B8898C;
	Tue, 15 May 2012 17:03:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97FF1898B; Tue, 15 May 2012
 17:03:45 -0400 (EDT)
In-Reply-To: <7v1umldw3i.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 15 May 2012 13:32:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 759BEC2C-9ED1-11E1-B3A1-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197856>

Junio C Hamano <gitster@pobox.com> writes:

> Unfortunately, I do not think that the actual implementation of
> "cherry-pick" matches that expectation, as it is a full three-way merge.
>
> I am somewhat curious to see what the performance characteristics would be
> if the same commit is replayed using
>
> 	git format-patch -1 --stdout $commit | git apply --index --3way
>
> pipeline.  Depending on the number of paths in the whole tree vs the
> number of paths the $commit touches, I wouldn't be surprised if it is
> faster.

An unscientific datapoint shows that with a project as small as the kernel,
the difference is noticeable.

For example, v3.4-rc7-22-g3911ff3 (random tip of the day) touches two
paths, and cherry-picking it on top of v3.3 goes like this:

    $ git checkout v3.3 && EDITOR=: /usr/bin/time git cherry-pick 3911ff3
     Author: Jiri Kosina <jkosina@suse.cz>
     2 files changed, 2 insertions(+)
    1.08user 0.20system 0:01.28elapsed 99%CPU (0avgtext+0avgdata 469728maxresident)k
    0inputs+7536outputs (0major+52604minor)pagefaults 0swaps

as opposed to an alternative that touches only these two paths:

    $ git checkout v3.3 && EDITOR=: /usr/bin/time sh -c '
	git format-patch --stdout -1 3911ff3 | git am -3'
    Applying: genirq: export handle_edge_irq() and irq_to_desc()
    0.36user 0.16system 0:00.46elapsed 112%CPU (0avgtext+0avgdata 254720maxresident)k
    0inputs+14872outputs (0major+55145minor)pagefaults 0swaps

Of course, there are vast differences between v3.3 and 3911ff3^1; 11k+
paths touched, countless paths created and deleted.

I _think_ most of the overhead comes from having to match the large trees
in unpack_trees() even though none of the changes between the base
versions matters for this" cherry-pick".

Both reads the flat index into the core in its entirety and futzing with
the index file format would not affect this comparison, even though it
could improve the performance of "am", if done right, as it could limit
its updates to only two paths.  In the merge case, we pretty much rebuild
the resulting index from scratch by walking the entire tree in
unpack_trees(), so there won't be much benefit.

Perhaps we might want to rethink the way we run merges?
