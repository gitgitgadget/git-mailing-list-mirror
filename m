From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] read-cache: refuse to create index referring to
 external objects
Date: Sun, 27 Jan 2013 21:54:07 -0800
Message-ID: <7vy5fdyhs0.fsf@alter.siamese.dyndns.org>
References: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
 <1359016940-18849-6-git-send-email-pclouds@gmail.com>
 <7vpq0ubdec.fsf@alter.siamese.dyndns.org>
 <CACsJy8C3tLOHCK4Qc--W630do0M=xLKSMoYUxxv2_GDaUXaRww@mail.gmail.com>
 <7vpq0t3x60.fsf@alter.siamese.dyndns.org>
 <CACsJy8BJZgyEn1n2GWgAVSGhSkVUO-P=GXwR02OcDf0ziTTRaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 06:54:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzhfs-0007a0-1Y
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 06:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770Ab3A1FyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 00:54:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55474 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751751Ab3A1FyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 00:54:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F4B2762F;
	Mon, 28 Jan 2013 00:54:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h0oZ23EvJzK8PxUNjwnIkMmTS5g=; b=bUUddn
	0e89xhzdYDkm6RTYKGcYehwy+dXahAGgPTCa7aFu4dzy3KTmsmdiwud120RfB+9H
	ygO8z4TG4anWgG3JdkA3BuHQllG+Pa8ghygTAuCIMPM/X31rYGi7QbmjcZV5qpNK
	bt8PAoAyIXlLXr1A6HqrOzXXfXAzADWy9afvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wxW4uSfLFxo4WVrHRmA3BYwjEId4Ld7S
	9Xi/yZeZ8fWhFwkI9GJN2M9bKOBI13O3U2PrCK4MUyQFW52y5KCWEQzR33wK2oCw
	8/R3LfobBiAjtYMJ8JzDsmEJznxL6BVVqjpLI1eiRxpsUm9jydNTF+MKvrX7EbWs
	enB0zAkbyh4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34636762E;
	Mon, 28 Jan 2013 00:54:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8AA01762A; Mon, 28 Jan 2013
 00:54:08 -0500 (EST)
In-Reply-To: <CACsJy8BJZgyEn1n2GWgAVSGhSkVUO-P=GXwR02OcDf0ziTTRaA@mail.gmail.com> (Duy
 Nguyen's message of "Mon, 28 Jan 2013 12:48:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 21B963F6-690F-11E2-B0F3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214808>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Jan 26, 2013 at 2:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> This is not a tangent, but if you want to go this "forbid making our
>> repository depend on objects we do not have but we know about after
>> we peek submodule odb" route [*1*], write_sha1_file() needs to be
>> told about has_sha1_file_proper().  We may "git add" a new blob in
>> the superproject, the blob may not yet exist in *our* repository,
>> but may happen to already exist in the submodue odb.  In such a
>> case, write_sha1_file() has to write that blob in our repository,
>> without the existing has_sha1_file() check bypassing it.  Otherwise
>> our attempt to create a tree that contains that blob will fail,
>> saying that the blob only seems to exist to us via submodule odb but
>> not in our repository.
>
> Another thing needs to be done for this to work. The current reading

For *what* to work???  I think the performance consideration is the
only thing that should drive the read-order; correctness should not
be affected.

> order is packs first, loose objects next. If we create a local loose
> duplicate of an alternate packed object, our local version will never
> be read. Regardless the submodule odb issue, I think we should prefer
> reading local loose objects over alternate packed ones.
