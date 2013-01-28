From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] read-cache: refuse to create index referring to
 external objects
Date: Sun, 27 Jan 2013 22:06:50 -0800
Message-ID: <7vtxq1yh6t.fsf@alter.siamese.dyndns.org>
References: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
 <1359016940-18849-6-git-send-email-pclouds@gmail.com>
 <7vpq0ubdec.fsf@alter.siamese.dyndns.org>
 <CACsJy8C3tLOHCK4Qc--W630do0M=xLKSMoYUxxv2_GDaUXaRww@mail.gmail.com>
 <7vpq0t3x60.fsf@alter.siamese.dyndns.org>
 <CACsJy8BJZgyEn1n2GWgAVSGhSkVUO-P=GXwR02OcDf0ziTTRaA@mail.gmail.com>
 <7vy5fdyhs0.fsf@alter.siamese.dyndns.org>
 <CACsJy8CXC=poDBenBwo6t8=Qv-_zvGbvHYo-cDdGA8_fpw4Cyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 07:07:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzhsB-0002T4-LL
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 07:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464Ab3A1GGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 01:06:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37633 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071Ab3A1GGx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 01:06:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D08548992;
	Mon, 28 Jan 2013 01:06:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W9kfveIndT1sIPg+/N0xPRSMlMs=; b=UHjn/a
	y1YG8yBFyvYRmn4a0KuzmtRCDPY5Na749sdamSkYI1NEZGfZWc9g95tNeGquoc8P
	g4AVHsEKblpTffouCgapPbC0qjoZiitwCDSs/18muKgeS0utpCTpoko2fTZEck2n
	48zPpGauiSAfZFvhul6yaDdaMcEAY+r7IqVEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yT+nzLLiZnavu7cxhFzYY+Jip6lAvqwR
	MUOaOULF98Pzwx3BRs0RpXVrootp34EPDXPCnBuA16LueC1qJvdDfl0VQAA6dA4q
	TUXITl94oD0BYDgwQD7VhI3ePQ2j4zs/AR/xkyDe5a7sywwKet/689TB6gpw5q5g
	ADaAY3yuYjI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C47398990;
	Mon, 28 Jan 2013 01:06:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53C06898E; Mon, 28 Jan 2013
 01:06:52 -0500 (EST)
In-Reply-To: <CACsJy8CXC=poDBenBwo6t8=Qv-_zvGbvHYo-cDdGA8_fpw4Cyg@mail.gmail.com> (Duy
 Nguyen's message of "Mon, 28 Jan 2013 12:57:15 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8F86664-6910-11E2-9A9E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214810>

Duy Nguyen <pclouds@gmail.com> writes:

>>> Another thing needs to be done for this to work. The current reading
>>
>> For *what* to work???
>
> The "forbid making our repository depend on objects we do not have but
> we know about afterwe peek submodule odb"

With your "when our object database is contaminated, check objects
we base our new object on are available in local or our alternates"
together with the "when we try write_object(), do not bypass it with
has_sha1_file() check because that may find the object in submodule odb
we should *not* have access to; instead check with the same 'local
or our alternates' test" I brought up in the message you were
responding to, I do not think object read order does not make a
difference to our effort to prevent the object database breakage due
to temporary contamination by submodule objects.

>>> Regardless the submodule odb issue, I think we should prefer
>>> reading local loose objects over alternate packed ones.

I suspect you are alluding to make write_object() check with
has_sha1_file_locally() so that we can wean our repository from
existing alternates, but I do not think it is a right approach
(instead, you just fully repack locally if you want to dissociate
yourself from your alternates).  What I was suggesting was to change
it to check with has_sha1_file_proper(), to make sure we do not omit
writing an object we need to access to, when we know it will vanish
once we stop temporarily borrowing from the submodule object store.
