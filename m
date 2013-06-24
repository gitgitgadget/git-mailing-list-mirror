From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/7] rebase: write better reflog messages
Date: Mon, 24 Jun 2013 00:57:40 -0700
Message-ID: <7vtxkoc557.fsf@alter.siamese.dyndns.org>
References: <1371629089-27008-1-git-send-email-artagnon@gmail.com>
	<1371629089-27008-7-git-send-email-artagnon@gmail.com>
	<7vfvw8dw9m.fsf@alter.siamese.dyndns.org>
	<CALkWK0kj3UOx8sq+h=L0giUC-vn+h3by9o_6YbjA8ArRXZfgZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 09:57:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur1el-0007AA-6m
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 09:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931Ab3FXH5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 03:57:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64374 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785Ab3FXH5m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 03:57:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70CB127708;
	Mon, 24 Jun 2013 07:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ncTviQQ7s655fZ9CX8zfXeobkyo=; b=rj77dY
	EiYgwK/inIzjgnLiff4cZh9fNIXCK9pKbh/7TcpPkxmnl9hqJZfU3BvMFZv2C7GR
	toWY+9k+TUgLFKzJ6jAtxP3aCCPdLM8VYNTlDsocqdhvr1m7sW23WDSqv9l0kPzJ
	1ppB5gmZuoKfj3lVys0xJ7bJEi5lFryak228Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q//MPXT2jJIleRgg9wDosVtPiie0BPfp
	ZU0MxF23LzoBi1kR8ScWMInYitMuuQoSRTSKaLsZRDvCq+TXivHIBFE775fQ1Eh6
	Zy5THOkWCRJNw+sry3hbHbPjXGS3V2M6Y2y1g5ldbfIPqY0qID94Y7pG+VWdCInL
	2J4xVBo5aM0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 673D927707;
	Mon, 24 Jun 2013 07:57:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE18427706;
	Mon, 24 Jun 2013 07:57:41 +0000 (UTC)
In-Reply-To: <CALkWK0kj3UOx8sq+h=L0giUC-vn+h3by9o_6YbjA8ArRXZfgZw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 24 Jun 2013 12:37:46 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF24BD40-DCA3-11E2-A9BB-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228788>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>>> +     # always reset GIT_REFLOG_ACTION before calling any external
>>> +     # scripts; they have no idea about our base_reflog_action
>>> +     GIT_REFLOG_ACTION="$base_reflog_action"
>>>       git am $git_am_opt --rebasing --resolvemsg="$resolvemsg"
>>
>> Why does this reroll still use this base_reflog_action convention?
>
> Because it's simple and it makes sense.

Without $base_reflog_action hack, you have to make sure
GIT_REFLOG_ACTION is reasonably pristine when you call out other
people.  Even with $base_reflog_action, you still have to do the
same "keep GIT_REFLOG_ACTION pristine" like this one.  And in
addition, you have to maintain $base_reflog_action as if it is a
read-only variable [*1*].

So you are forcing people to maintain _two_ variables, instead of
just _one_, without making anything simpler.

What's so hard to understand why it is a wrong design?

> ... and we're discussing absolutely trivial inconsequential rubbish
> once again.  In any case, I've given up on arguing with you as it is
> clear that I can't possibly win.  Do whatever you want.

It is not about winning or losing.

If you truly think this is "inconsequential", that unfortunately
convinces me that you cannot yet be trusted enough to give you
latitude to design interfaces that span multiple programs X-<.


[Footnote]

*1* The original orig_reflog_action you borrowed from was bad enough
but it had an excuse that it was confined within the leaf level of
the callchain.  It was merely done as a way to stash the vanilla
action name (e.g. "rebase -i" before it is specialized into "rebase
-i pick" etc) away, so that it can easily "lose" the speciailzation
from GIT_REFLOG_ACTION while preparing for the next operation.
