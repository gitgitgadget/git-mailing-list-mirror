From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Set hard limit on delta chain depth
Date: Fri, 09 Dec 2011 16:02:19 -0800
Message-ID: <7vsjktb8fo.fsf@alter.siamese.dyndns.org>
References: <1323068688-31481-1-git-send-email-pclouds@gmail.com>
 <7vvcpthh97.fsf@alter.siamese.dyndns.org>
 <CACsJy8AZg3DgZzmPyXhCH9bGBqo9UN7-zLt_feTtpyajf5U1tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 01:02:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZAOY-0002qg-Vb
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 01:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673Ab1LJACW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 19:02:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46560 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751875Ab1LJACW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 19:02:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2CE06D8F;
	Fri,  9 Dec 2011 19:02:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=MU7bJ2amXNVtfG2cJdlDiG/b7A0=; b=fp7musZ6Brn3gCwu9qMM
	bl1TZmJOZakZ1mvLalUQhoCRlBLyJplgCb22tZGnMCC3YM6p25G4BGqGTPm/CQ/2
	DgnBX5QDEZ1vDtHx9vQHZQKbVBDMxVbLzPW3N+P6hKGUhcpMPOTzXmk0Nrkh2o62
	wC7uCsKDyK638bRz1PhuDu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=b5Xfc41H5RW1WH+K22gaRZ3DoqTtwfO2Dv293ybaxqhr7h
	LWpdBLKBUQ/Ux3RGjmpjej7bQy9WqDEZAIL42Ay8ZSQXTyJBDcBaqLWI0098EgkA
	4DVX/5HFFyc7heIUfzrPsRnaG45PZQHlyTs7Ox4gSaxR43zrUJxORhzeX3y7o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AADF26D8E;
	Fri,  9 Dec 2011 19:02:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DD9E6D8C; Fri,  9 Dec 2011
 19:02:21 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B5AE4CC-22C2-11E1-A574-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186713>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> That's interesting. First of all xmalloc() is controlled by us while
> index-pack code might lead to stack overflow exploit (never done it,
> not sure if it's really pratical to do in this case).

What do you exactly mean by "stack overflow exploit"?

If your callee has prepares a stackframe that is not sufficiently big but
carelessly tries to store more than it has space for, such a write can
overflow the stack (without hardware traps) and overwrite return address,
and instead of coming back to you, the control can be transferred to
random places.

But I do not think that is what we are talking about here.

You attempt to write parameters and return address to the area of memory
pointed by your stack pointer, advance the stack pointer to create a stack
frame and the callee attempts to write to its local variables in the newly
allocated stack frame. These memory accesses eventually attempt to touch
memory beyond the address range the kernel gave you page table entries to
be used as your stack space, and hardware traps. If you haven't run out of
the stack, a new page is lazily added to the page table and your attempted
access will succeed. If you are recursing too deeply, you won't be given a
new page and you will be killed by the kernel. That is a rather controlled
death of the process, unlike smashing the contents of the stack to jump to
a randomly chosen place, isn't it?

Of course, some platforms do not have an unwritable gap between the stack
segment that grow downwards and the heap that grow upwards, and also your
stackframe could be larger than such a gap (in this particular callchain I
do not think that is the case), so the above discussion does not apply
universally, though.
