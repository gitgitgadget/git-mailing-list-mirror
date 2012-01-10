From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/6] clone: factor out checkout code
Date: Mon, 09 Jan 2012 20:59:03 -0800
Message-ID: <7vhb04b1bc.fsf@alter.siamese.dyndns.org>
References: <1325771380-18862-1-git-send-email-pclouds@gmail.com>
 <1326023188-15559-1-git-send-email-pclouds@gmail.com>
 <1326023188-15559-3-git-send-email-pclouds@gmail.com>
 <7vd3ascs85.fsf@alter.siamese.dyndns.org>
 <CACsJy8DZpA0sQ6ZYjgrp8PsRTsYm0nOfSXcDOEhB2TRjqwbM0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 05:59:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkTnl-0002fK-4x
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 05:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756091Ab2AJE7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 23:59:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53079 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756088Ab2AJE7F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 23:59:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63FB2636F;
	Mon,  9 Jan 2012 23:59:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dAr7QWGB7yHtmiymop4nBzlRxNo=; b=KWwoXF
	s8X7yXA3kMzWaAKiCsKlN4P/Uwi41BowgO3/Rn0WeqyKbTouG1OT9vb/l1RT87Le
	+Kyh3hUUPE1a8i6OTt+16Bo4xMDCE+xjO6eyIZsaOJfxIo4VK6LC+5/qBkDakK/e
	le6U1yJDVslN4qC9U6gGB3OaqykpzzkBQgjV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rc1CcBgahYcwEMXKfVNOnwydOrm1EPK9
	EDK+YR8nITfoJahOuYTj6i8MBF+6bEliagDPWis8RJqBKc0LlTGm8zAKdi4XxbwU
	3dZTcAa6LacxRc/S9zxJZ/DSSsH/hLSkjdcnGhof9a54lLmxsTikkFPRnAECZjVz
	0fQNGCEGaUE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B9C1636E;
	Mon,  9 Jan 2012 23:59:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B6438636D; Mon,  9 Jan 2012
 23:59:04 -0500 (EST)
In-Reply-To: <CACsJy8DZpA0sQ6ZYjgrp8PsRTsYm0nOfSXcDOEhB2TRjqwbM0Q@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 10 Jan 2012 09:01:18 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D1DEABAC-3B47-11E1-B1E0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188217>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2012/1/10 Junio C Hamano <gitster@pobox.com>:
>>
>>> Read HEAD from disk instead of relying on local variable
>>> our_head_points_at, so that if earlier code fails to make HEAD
>>> properly, it'll be detected.
>>
>> The end result might be more or less the same with your patch from the
>> end-user's point of view, but "if earlier code fails", shouldn't you
>> detect and diagnose it right there?
>
> Sure, but another fence does not harm.

But that is not "another" fence but is the _only_ fence, as you do not
check after running update_ref of "HEAD".

> There's also one thing I missed in the commit message that it makes
> update head code and checkout code more independent. Update head code
> does not need to maintain our_head_points_at at the end for checkout
> anymore.

I like that reasoning in general. The logic ought to be:

 - Learn what the remote has;

 - Combine it with --branch parameter, determine what local branch our
   head _should_ point at;

 - Make our head point at it, and check it out.

I wonder if we can somehow make the above logic more clear in the
code. Perhaps the first two could be made into a single helper function
"decide_local_branch()", and the third would be the "checkout()" function
in your patch, updated to take "const char *" parameter or something?

> The lack of HEAD probably won't happen because HEAD is created by
> default in init-db. This is mainly to catch invalid HEAD (like putting
> "refs/tags/something" in HEAD).

Sorry; what I meant by "lack" was "... if earlier code fails to make HEAD
properly" case.
