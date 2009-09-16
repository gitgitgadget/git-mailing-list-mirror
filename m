From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2] fetch: Speed up fetch by rewriting
 find_non_local_tags
Date: Wed, 16 Sep 2009 16:15:17 -0700
Message-ID: <7veiq6wkfu.fsf@alter.siamese.dyndns.org>
References: <20090916074737.58044.42776.julian@quantumfyre.co.uk>
 <7vbplb2pi7.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0909162141140.13697@reaper.quantumfyre.co.uk>
 <20090916225350.45746.85139.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu Sep 17 01:15:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo3ip-0005cD-9Y
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 01:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760262AbZIPXPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 19:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756990AbZIPXPX
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 19:15:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52249 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758161AbZIPXPW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 19:15:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D5BC035B84;
	Wed, 16 Sep 2009 19:15:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8RtCzt751oa/ADE1BrPg414xy4s=; b=LHC0Y8
	Qo1+R2Be5J9XK2ccz710EhXiH1OB4Vq79RnQDsjyDvcxRWOx/mfSzXfjIBw3Q/4F
	81fpXMDd4yYRdEDaYv8Hg6ydRu3RhzFD+TxP3iXhavMmL/6BDfb0k591rAOU3E0A
	Cvq4KDtD7q6oshqn0Od4X1if1iojDyKHb4PBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JT5gHaQaHVlXaEtNTNIw1LgtmS2nOfOP
	Gu81ASNuo653ZIPCaHs6/RY0iJAA+nvFBrL2LZziRcgRAKVYs9Uw1uZ8/Fx5i1N7
	uqrvGycH2twHIfY4qRlAfF48UIPJjsZMlK6dggb3fDYmAnGDDLxL3fomiH1nsAW1
	bNgyN9WX+UI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B703E35B7F;
	Wed, 16 Sep 2009 19:15:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 03A5435B7E; Wed, 16 Sep
 2009 19:15:18 -0400 (EDT)
In-Reply-To: <20090916225350.45746.85139.julian@quantumfyre.co.uk> (Julian
 Phillips's message of "Wed\, 16 Sep 2009 23\:53\:49 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CF1D123A-A316-11DE-847D-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128693>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> When trying to get a list of remote tags to see if we need to fetch
> any we were doing a linear search for the matching tag ref for the
> tag^{} commit entries.  This proves to be incredibly slow for large
> numbers of tags.  Rewrite the function so that we can do lookup in
> string_lists instead.
>
> For a repository with 50000 tags (and just a single commit on a single
> branch), a fetch that does nothing goes from ~ 1m50s to ~4.2s.
>
> Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
> ---
>
> Not only does this not require a custom hash table, it is also slightly
> faster than the last version (~4.2s vs ~4.5s).

I am just curious.  How would a "just one item lookbehind" code perform
compared to this one?
