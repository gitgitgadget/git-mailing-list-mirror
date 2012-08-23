From: Junio C Hamano <gitster@pobox.com>
Subject: Re: in_merge_bases() is too expensive for recent "pu" update
Date: Thu, 23 Aug 2012 14:03:19 -0700
Message-ID: <7vy5l52ueg.fsf@alter.siamese.dyndns.org>
References: <CACsJy8C-VxzwigyUDHnUkXN7vhB+93X96pH9MvgB0ps7v-_NmQ@mail.gmail.com>
 <878vd5k7uu.fsf@thomas.inf.ethz.ch> <7vd32h4h1t.fsf@alter.siamese.dyndns.org>
 <7v393d49xs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Aug 23 23:03:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4eYq-0006jg-Tj
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 23:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934400Ab2HWVDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 17:03:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65099 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932259Ab2HWVDV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 17:03:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FAD09ECD;
	Thu, 23 Aug 2012 17:03:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9ughuuKWa7VQD82gIaq7PkPTPjs=; b=qSq2l+
	dtCEfLtElN9iICFHuvCIbLvZTl98nSOsB4jhpWqce2pjba8vT93WkhuQi293Equ7
	gqX9RbyLgWRRCAjw4l/XCOeGht0vZwylfayJzMizy3qgXi/g6M2ROq+TBM1iK3AH
	vW6V2/SXd8V3YQFCVKv62I/Yfov9XoElSplzE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pqAFLGWBA0G7Uazslyc5+Ndv8Cjb1HuV
	nVfJCFoF9ktoE0EPWRgXgIF/tPM1FdPIGrqjqdv0WzAb5PaIEpwH5WgHbQkqwFaq
	RNKzkCdfPVtjbTYGYgv2qNd3FiAj7JuBGatu95nLnZUq4zsQEYUxr65Vrpk9FpXI
	//xMkloEkQ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CB459ECC;
	Thu, 23 Aug 2012 17:03:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80C919ECA; Thu, 23 Aug 2012
 17:03:20 -0400 (EDT)
In-Reply-To: <7v393d49xs.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 23 Aug 2012 13:42:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F7F55B08-ED65-11E1-86D3-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204171>

Junio C Hamano <gitster@pobox.com> writes:

> The objective of this second traversal is very different from the
> first one, though.  We do not need _all_ the merge bases between '1'
> and '2'; we do not even need merge bases.
>
> The only thing we need to prove that '1' is a merge base (i.e. not
> an ancestor of any other merge base candidates the first round of
> traversal between A and B found) is to do the first round of the
> traversal for '1' as "one" and all the other ('2' in this case) as
> "two"s; if the first round of such traversal finishes without
> painting '1' in both colors, that would mean '1' is not reachable
> from any other candidates of merge base between A and B, so we have
> proven that '1' is a merge base.
>
> So I suspect that the postprocess phase could be made from N*(N-1)
> to N (run merge_bases_many() once for each of the common ancestor
> the first round found).  You might also be able to stop the
> traversal used in the first phase (i.e. get_merge_bases()) a bit
> earlier, if we are digging through '1' to paint 'z' (and eventually
> '2') in STALE (amber+blue) color, as digging further only to paint
> things in STALE color is not necessary with the postprocess.

As a corollary, the "is pu@{0} a fast-forward of pu@{1}?" check does
not need merge base computation at all.  The only thing it needs to
do is to prove pu@{1} is reachable from pu@{0}, and that can be done
the same way in which '1' can be proved unreachable from '2' in the
post processing phase as described above, i.e. it needs only the
first phase of running merge_bases_many() without postprocessing.
