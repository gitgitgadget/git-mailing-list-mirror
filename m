From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] implement metadata cache subsystem
Date: Sat, 04 Aug 2012 15:49:12 -0700
Message-ID: <7vk3xe8dc1.fsf@alter.siamese.dyndns.org>
References: <20120804170905.GA19267@sigill.intra.peff.net>
 <20120804171146.GF19378@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 05 01:08:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxnSo-0005hA-FD
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 01:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109Ab2HDXIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 19:08:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37332 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754071Ab2HDXIt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 19:08:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB92F9644;
	Sat,  4 Aug 2012 19:08:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=YIYUmwJHWGYH0Ne+jePUjUGsMY8=; b=G766VMmUYxekRlOLDW8e
	isNZtahFZVuSpMGu8lDQHI8WPPW/APf1yRfnAezkUMOA2JdPKNpUMGoglt7cNBBj
	N7KuV2245+MDCYmS3y4lGQtQkyVlYsTTM2zNdcu2jFcbeeBHNLWqiS5An4VBxupY
	eZQ53AAyXG5VlsDgWu65X2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=TYYx6XZq4iM6c4cum0ZYFNU91fcYvPQTAiEmn21dlnCRv8
	dFjJnsZcI/C12rVArnPx3Ksa3SHNvKS7FvLVQaUYCrNG3IPu/y8HLKiXGpFvireJ
	TkIbZr1BnBVpeKCfnKnOzhqghQQaEpciwlqPDDABqXPtNm5q1qhD5bnRxYrxs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9931A9643;
	Sat,  4 Aug 2012 19:08:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1295A9642; Sat,  4 Aug 2012
 19:08:47 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 58E0C4DE-DE89-11E1-A272-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202898>

Jeff King <peff@peff.net> writes:

> There are some calculations that git makes repeatedly, even
> though the results are invariant for a certain input (e.g.,
> the patch-id of a certain commit). We can make a space/time
> tradeoff by caching these on disk between runs.
>
> Even though these may be immutable for a certain commit, we
> don't want to directly store the results in the commit
> objects themselves, for a few reasons:
>
>   1. They are not necessarily used by all algorithms, so
>      bloating the commit object might slow down other
>      algorithms.
>
>   2. Because they can be calculated from the existing
>      commits, they are redundant with the existing
>      information. Thus they are an implementation detail of
>      our current algorithms, and should not be cast in stone
>      by including them in the commit sha1.
>
>   3. They may only be immutable under a certain set of
>      conditions (e.g., which grafts or replace refs we are
>      using). Keeping the storage external means we can
>      invalidate and regenerate the cache whenever those
>      conditions change.

4. The algorithm used to compute such values could improve over
time.  The same advantage argument as 3 applies to this case.
