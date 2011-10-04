From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] refs: Use binary search to lookup refs faster
Date: Tue, 04 Oct 2011 13:58:29 -0700
Message-ID: <7vehysbhje.fsf@alter.siamese.dyndns.org>
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
 <7vk48qouht.fsf@alter.siamese.dyndns.org> <4E87F383.1050403@alum.mit.edu>
 <7vd3egj6aa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Martin Fick <mfick@codeaurora.org>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 04 22:58:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBC4U-0002OJ-AP
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 22:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933746Ab1JDU6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 16:58:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40590 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933569Ab1JDU6c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 16:58:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCF4F60AD;
	Tue,  4 Oct 2011 16:58:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f0Gn1q+cTVBeUoXStLi1FjVmuqY=; b=bS0GpQ
	Y/G4fcSo8hrpsuXbFR9tbQvQKWl4Uly4+3GTBOJe9qx0belrt9fEh0XACITOlm7D
	+bkcF95cibAgqYzU9kwlh2Kdnpaq36c4TSuZ9xOMjONpbrAr+UofaBX7cx24EuAT
	qf+kzaMsD64stbvp2xprnNYligyvi3CYsnqDo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DewPhXqx/R2CbdWS7cGYo4U1GdWyiX6a
	iO450vhuptt5fDHfbK6IspHb6NVeWdfDwGR/9LHaBBiksOvPcsYNlfhahJ/LjbVU
	gSll34NX9KaFHMxjELAZKOIR+FEFMhi3OP/Rc5Y3K8VBxGkrQWUhNkLYjhJop7xB
	Zqlqh7Fi/f8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B329D60AC;
	Tue,  4 Oct 2011 16:58:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B42660AB; Tue,  4 Oct 2011
 16:58:31 -0400 (EDT)
In-Reply-To: <7vd3egj6aa.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 01 Oct 2011 22:45:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9DB6708A-EECB-11E0-BB27-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182804>

Junio C Hamano <gitster@pobox.com> writes:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> Um, well, my patch series includes the same changes that Julian's wants
>> to introduce, but following lots of other changes, cleanups,
>> documentation improvements, etc.  Moreover, my patch series builds on
>> mh/iterate-refs, with which Julian's patch conflicts.  In other words,
>> it would be a real mess to reroll my series on top of Julian's patch.
>
> Conflicts during re-rolling was not something I was worried too much
> about---that is just the fact of life. We cannot easily resolve two topics
> that want to go in totally different direction, but we should be able to
> converge two topics that want to take the same approach in the end,
> especially one is a subset of the other.

Ah, also I should have noted that I have a fix-up between mh/iterate-refs
and Julian's patch already queued on 'pu'.

I am planning to make mh/iterate-refs graduate to 'master' soonish, so
hopefully things will become simpler.

Thanks.
