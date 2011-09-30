From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] refs: Use binary search to lookup refs faster
Date: Fri, 30 Sep 2011 09:38:54 -0700
Message-ID: <7vk48qouht.fsf@alter.siamese.dyndns.org>
References: <4DF6A8B6.9030301@op5.se>
 <CAP8UFD3TWQHU0wLPuxMDnc3bRSz90Yd+yDMBe03kofeo-nr7yA@mail.gmail.com>
 <201109281338.04378.mfick@codeaurora.org>
 <201109281610.49322.mfick@codeaurora.org>
 <c76d7f65203c0fc2c6e4e14fe2f33274@quantumfyre.co.uk>
 <960aacbf-8d4d-4b2a-8902-f6380ff9febd@email.android.com>
 <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk>
 <4E84B89F.4060304@lsrfire.ath.cx> <7vy5x7rwq9.fsf@alter.siamese.dyndns.org>
 <20110929041811.5363.33396.julian@quantumfyre.co.uk>
 <7vvcsbqa0k.fsf@alter.siamese.dyndns.org>
 <20110929221143.23806.25666.julian@quantumfyre.co.uk>
 <7v62karjv3.fsf@alter.siamese.dyndns.org> <4E85E07C.5070402@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Martin Fick <mfick@codeaurora.org>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 30 18:40:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from [209.132.180.67] (helo=vger.kernel.org)
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9g8F-0001sL-U7
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 18:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008Ab1I3Qi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 12:38:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43112 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241Ab1I3Qi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 12:38:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B42C4262;
	Fri, 30 Sep 2011 12:38:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0+nsV24Gy3hiIz+SNIYTFssnjXU=; b=BQiaNt
	UndeUjAiGO4b1LWIk0kSYBOcyzQ1dmgR5bhctMln1mkF2v6MxpaxIYAk2QLW8qD2
	/UV/FYzJGiU80MMGOktkeCRg11bT6xnzqc5wJ6JdmuIuHL0zWLn6ZCXoz36ZEYfk
	bfEGNDDbXsXBEKkGE7vbHd2uHo7ZcTzkQFJBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T/FnRCfq8l5chnjWlotUeH6WiyS8JTVv
	VUangiUThP9T1WhGzKYmGO97xasAyHSCvVKsQgrXMoLiYrb5nlgVqL1O3xynWNYW
	cUwIn8RSm1Nc5sZB3eXcjkfxPkgEAN5ZheIAxq8tqQFJDgDNF+Ai7fU8wWnzFTHa
	72NaUlXqx1U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5239F4261;
	Fri, 30 Sep 2011 12:38:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF74C4260; Fri, 30 Sep 2011
 12:38:55 -0400 (EDT)
In-Reply-To: <4E85E07C.5070402@alum.mit.edu> (Michael Haggerty's message of
 "Fri, 30 Sep 2011 17:30:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B066A070-EB82-11E0-B80C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182491>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 09/30/2011 01:48 AM, Junio C Hamano wrote:
>> This version looks sane, although I have a suspicion that it may have
>> some interaction with what Michael may be working on.
>
> Indeed, I have almost equivalent changes in the giant patch series that
> I am working on [1].

Good; that was the primary thing I wanted to know.  I want to take
Julian's patch early but if the approach and data structures were
drastically different from what you are cooking, that would force
unnecessary reroll on your part, which I wanted to avoid.

Thanks.
