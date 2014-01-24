From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 3/3] merge-recursive: Tolerate missing file when HEAD is up to date
Date: Fri, 24 Jan 2014 11:50:39 -0800
Message-ID: <xmqq8uu5rwfk.fsf@gitster.dls.corp.google.com>
References: <CABPp-BGAsrrjcZxVirzKU_VEyUM1U=4TFj18CieKKE7==c7v2A@mail.gmail.com>
	<cover.1390574980.git.brad.king@kitware.com>
	<5e5bfe752655c39fca626811972af9d0a90ddab9.1390574981.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, newren@gmail.com
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Fri Jan 24 20:50:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6mmB-0006ZC-82
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 20:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086AbaAXTuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 14:50:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47523 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752788AbaAXTup (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 14:50:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D192864DAA;
	Fri, 24 Jan 2014 14:50:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=48Tvrw5AO8NGkkhwSFo7c/Q3qew=; b=gV7NeJ
	OMr8xTLVc02cfxJKPpootTVWgukhnLuVUOGbqEQrpFNFe3Rlibh+NB2qvEvu5JAK
	lXmL/VwlyfPxJH9k+7fxrkaVePHyO/WJo6UycLQiHKMCh+kBPSgUQxaq7vC/Aka0
	8Sw4KCO646NWxDUm6VsXZ/faahZrm7ZLyP4wo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gmOmP6ggriImVl/QZ06NjYzeJENmPFZ1
	WEDb7JYs+b2jNZpcOBPjNGawuIVQEOrRxq1/97NJRXo9q3wHAleLDgSuen7I/gUW
	b7H7oXPGgLsSQlNFI2KTKFIG8j8U+920JaLxFr3h4C5q24/Vjv2A9iO1xc87/pIz
	e5fd1s5nnMU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC67064DA9;
	Fri, 24 Jan 2014 14:50:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A863764DA6;
	Fri, 24 Jan 2014 14:50:42 -0500 (EST)
In-Reply-To: <5e5bfe752655c39fca626811972af9d0a90ddab9.1390574981.git.brad.king@kitware.com>
	(Brad King's message of "Fri, 24 Jan 2014 10:01:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CEE21468-8530-11E3-A7FF-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241024>

Brad King <brad.king@kitware.com> writes:

> Teach add_cacheinfo to optionally tolerate make_cache_entry failure when
> the reason is ENOENT from lstat.  Tell it to do so in the call path when
> the entry from HEAD is known to be up to date.

It somehow feels wrong to force callers of make_cache_entry() to be
so intimate with the implementation details of refresh_cache_ent()
by having them inspect the errno from lstat(2) so deep in the
callchain, and to force callers of make_cache_entry() that says
refresh=NoThanks to pass a useless NULL.

Looking at refresh_cache_ent(), I notice that we already have cases
where we do not bother to lstat and instead say "Yeah, the cache
entry you have is good", and have to wonder if this new feature
should be modeled after them instead, namely, by introducing a new
option bit CE_MATCH_MISSING_OK that asks it to treat a path that is
missing from the working tree as if it is checked out unmodified.
