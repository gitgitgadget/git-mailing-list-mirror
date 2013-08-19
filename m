From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] compat: Fix read() of 2GB and more on Mac OS X
Date: Mon, 19 Aug 2013 10:16:56 -0700
Message-ID: <xmqqeh9p8ut3.fsf@gitster.dls.corp.google.com>
References: <1376900499-662-1-git-send-email-prohaska@zib.de>
	<1376926879-30846-1-git-send-email-prohaska@zib.de>
	<CA+55aFzQhJqE4QDwJDKtkTtJpMNbz3_Aw5_Q3yTk5DnhLJyjCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Aug 19 19:17:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBT4l-0001Ye-Nn
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 19:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864Ab3HSRRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 13:17:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44407 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780Ab3HSRRB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 13:17:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98B6D3AEBC;
	Mon, 19 Aug 2013 17:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VABl2rJ9ljIeS4RloeWib4a4Q5M=; b=AHpNti
	M5Z+yUocY2rjSyVOT5KV/5nPCCM9px6Ub7bNVisWuxPQ8+L+teUQmczW8y2dkLTs
	KTp2GvnPDqK76l8JcnOToCk1mTmVz/OQeWAWgK3lIZL/pkX67+pHMHzF9gacQFyW
	3qQJvDpp0mPbuEmcZYRYjezDb9mcQRSjXGCd0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=urmhU6E0ceQr3oq53pME9L/Brs8YoDej
	Kq2YBKUCx7afv2S4YBteL6Q6keggieICqvW8XRjsw5hTdjTTe+MJIEy7IbRqyFqg
	6pwSSvWjbztGJg4ZYRjBtQ0muVLhVQaqYDlM782i1Du+bT8hqY6qx9KaSlL1Q85e
	5k7ti4yeWZc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BA213AEBA;
	Mon, 19 Aug 2013 17:17:00 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6FB583AEB8;
	Mon, 19 Aug 2013 17:16:58 +0000 (UTC)
In-Reply-To: <CA+55aFzQhJqE4QDwJDKtkTtJpMNbz3_Aw5_Q3yTk5DnhLJyjCQ@mail.gmail.com>
	(Linus Torvalds's message of "Mon, 19 Aug 2013 09:04:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 27970A6A-08F3-11E3-BDAE-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232554>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I hate your patch for other reasons, though:
>
>> The problem for read() is addressed in a similar way by introducing
>> a wrapper function in compat that always reads less than 2GB.
>
> Why do you do that? We already _have_ wrapper functions for read(),
> namely xread().  Exactly because you basically have to, in order to
> handle signals on interruptible filesystems (which aren't POSIX
> either, but at least sanely so) or from other random sources. And to
> handle the "you can't do reads that big" issue.

The same argument applies to xwrite(), but currently we explicitly
catch EINTR and EAGAIN knowing that on sane systems these are the
signs that we got interrupted.

Do we catch EINVAL unconditionally in the same codepath?  Could
EINVAL on saner systems mean completely different thing (like our
caller is passing bogus parameters to underlying read/write, which
is a program bug we would want to catch)?

> So why isn't the patch much more straightforward? Like the attached
> totally untested one that just limits the read/write size to 8MB
> (which is totally arbitrary, but small enough to not have any latency
> issues even on slow disks, and big enough that any reasonable IO
> subsystem will still get good throughput).

Ahh.  OK, not noticing EINVAL unconditionally, but always feed IOs
in chunks that are big enough for sane systems but small enough for
broken ones.

That makes sense.  Could somebody on MacOS X test this?

Thanks.
