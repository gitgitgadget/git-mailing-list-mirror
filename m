From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make xmalloc and xrealloc thread-safe
Date: Wed, 24 Mar 2010 14:28:51 -0700
Message-ID: <7vsk7p4df0.fsf@alter.siamese.dyndns.org>
References: <20100323173114.GB4218@fredrik-laptop>
 <20100323184309.GA31668@spearce.org>
 <4c8ef71003231421u789c4332h461c066add0ec7b1@mail.gmail.com>
 <alpine.LFD.2.00.1003231945480.31128@xanadu.home>
 <4c8ef71003240823o7cd733bn5f19699305c94cba@mail.gmail.com>
 <alpine.LFD.2.00.1003241133430.694@xanadu.home>
 <ec874dac1003241122s3d592f26n1b23d23144939218@mail.gmail.com>
 <alpine.LFD.2.00.1003241435300.694@xanadu.home>
 <ec874dac1003241257r3cad86c9q1af84d3732e23ca8@mail.gmail.com>
 <alpine.LFD.2.00.1003241613020.694@xanadu.home>
 <20100324202814.GA24830@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Bo Yang <struggleyb.nku@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 24 22:29:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuY8i-0007EX-Va
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 22:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990Ab0CXV3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 17:29:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47445 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841Ab0CXV3J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 17:29:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 23A07A5EF7;
	Wed, 24 Mar 2010 17:29:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=49v+hp58DNoFfrysJX5Db6CMvT4=; b=Pt/Yhw
	ml8hfMdcJW6S1h5sjMk/BHtywPNiq90sJ57U/P6J1HJTf0lVaCO9R758DxQIv/gP
	O/z4yMeImD6VrMM/udVr+vLgvvlU7G5mTzgqIvyT4N0eDhPvKRbHP+HIzOZdMwVq
	ZoICuevQcSRfx9pZl9ckb/9dA0aChfo2EOGZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xtFuEYCYNdfD8AIPJ1Ci1n+2+bVoIKVI
	MDY+zsctxFmbj51BLbgah2rvBCXEof9QGLwM9W+vDwgpIr0lY15+EHRAIOSDpfUV
	HovwVpzaIgeNurVlAwu/o/ntvwUt2xQGL3UYdE5zA7LMtzFucM7DoQf9TIT/EwIy
	0MjNTN3Non8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 95117A5EF2;
	Wed, 24 Mar 2010 17:29:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C0D3A5EF1; Wed, 24 Mar
 2010 17:28:53 -0400 (EDT)
In-Reply-To: <20100324202814.GA24830@spearce.org> (Shawn O. Pearce's message
 of "Wed\, 24 Mar 2010 13\:28\:14 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 43B6A552-378C-11DF-8F35-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143129>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> @@ -100,7 +112,7 @@ void *xmmap(void *start, size_t length,
>>  	if (ret == MAP_FAILED) {
>>  		if (!length)
>>  			return NULL;
>> -		release_pack_memory(length, fd);
>> +		try_to_free_routine(length);
>
> This isn't dubious!  The fd passed here is to prevent the pack release
> code from closing this fd right before we try to mmap it.  Its an actual
> bug fix that I had to write years ago, check the history of that section
> of code...  :-)

A tangent.

I thought that it incidentally might be a good example for the "line-mode"
log that has been discussed recently to follow the history of this code,
but this turns out to be too easy:

$ git blame -C -L'/^void \*xmmap/,/^}/' wrapper.c

directly gives you the answer.  d1efefa4 explains why this passes fd
rather well.
