From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Make xmalloc and xrealloc thread-safe
Date: Tue, 06 Apr 2010 22:21:12 -0700
Message-ID: <7vk4sjg7nb.fsf@alter.siamese.dyndns.org>
References: <4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com>
 <alpine.LFD.2.00.1003231945480.31128@xanadu.home>
 <4c8ef71003240823o7cd733bn5f19699305c94cba@mail.gmail.com>
 <alpine.LFD.2.00.1003241133430.694@xanadu.home>
 <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
 <alpine.LFD.2.00.1003241435300.694@xanadu.home>
 <ec874dac1003241257r3cad86c9q1af84d3732e23ca8@mail.gmail.com>
 <alpine.LFD.2.00.1003241613020.694@xanadu.home>
 <4c8ef71003270626y45685e69j28ccb8a8738b9083@mail.gmail.com>
 <alpine.LFD.2.00.1004062152260.7232@xanadu.home>
 <20100407031655.GA7156@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 07 07:21:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzNhj-0003r1-3r
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 07:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998Ab0DGFV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 01:21:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472Ab0DGFVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 01:21:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 69093A8A0A;
	Wed,  7 Apr 2010 01:21:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=ArWewn+ChDFoIIRC12jY3dKRhD8=; b=CrHUMN
	hPut+LwnJLoynYPIirsfhPoJ0F5+xcKR5T8FqVEnSKIzSLYfz5KxA1//m8G2t48J
	6X+tA/mDTRhhXOLgZS8rEKN1cN1xbSq+pM1W09M9PAzZ4D0mLJhQ8091R3I2+Xla
	ZPb0hjFDUFEpgKOu7VCZCDjgrc2i2XqkmlVag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TMZAegPq2W/BmHIl8AzKLiBzqqG+VJT4
	J3etsrFnecYsY6erGtOx0/fnAEe0cxuA29z1sbL0mzdrDiTM+LZTGeh2mWbJHA+K
	zM1wMoTnYCi5l3fF1sFOc9LW8cMvNn40DTgfYSrbT6EQtEbc2Sdb8h2lucqS8qpo
	SX/yThFCCLg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 04F83A8A08;
	Wed,  7 Apr 2010 01:21:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 120EFA8A06; Wed,  7 Apr
 2010 01:21:13 -0400 (EDT)
In-Reply-To: <20100407031655.GA7156@spearce.org> (Shawn O. Pearce's message
 of "Tue\, 6 Apr 2010 20\:16\:55 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 661DEDC0-4205-11DF-8CC8-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144194>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> +static void try_to_free_from_threads(size_t size)
>> +{
>> +	int self = pthread_equal(read_mutex_owner, pthread_self());
>> +	if (!self)
>> +		read_lock();
>> +	release_pack_memory(size, -1);
>> +	if (!self)
>> +		read_unlock();
>> +}
>
> Is there any concern that a partially unset read_mutex_owner might
> look like the current thread's identity?
>
> That is, memset() can be setting the bytes one by one.  If the lock
> is being released we might observe the current owner as ourselves
> if we see only part of that release, and our identity is the same
> as another thread, only with the lower-address bytes unset.

Yuck.  I hope that it doesn't mean we need another mutex to protect the
owner data.
