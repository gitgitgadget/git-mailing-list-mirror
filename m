From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] (BROKEN) get_merge_bases_many(): walk from many tips
 in parallel
Date: Tue, 28 Aug 2012 16:39:11 -0700
Message-ID: <7vvcg2y4bk.fsf@alter.siamese.dyndns.org>
References: <1346109123-12357-1-git-send-email-gitster@pobox.com>
 <1346109123-12357-6-git-send-email-gitster@pobox.com>
 <7vipc3q041.fsf@alter.siamese.dyndns.org>
 <7v8vcyzomw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 01:39:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6VNU-0002ee-W0
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 01:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753Ab2H1XjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 19:39:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38645 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973Ab2H1XjO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 19:39:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEE659933;
	Tue, 28 Aug 2012 19:39:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wBo4TpdVLCVTzM5rluPSvMpnyYE=; b=vOYMwo
	6ofChNsZ8fyMQIfPFktdKr03e6Lp4Rdm6Z7J3/TFZlSnP1NSvOEt1aLgWW0A46tN
	WK7ca/ne9mTibQ/lS1kc0VMrKcNikYhEsQLVx/1p+MXBYK32+Kwf5dKHiOrGcu1s
	nyHJa02FOx17/X5vo9lnB25awfTQyZ/EOinpM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ap0rV1o5drtUx2WsGBnB7Av18oD/c3Dq
	1FtTj1KVxubsdVNyf9wopF5jOwisIdQ1GKtNO1muIZPyVN0YTp9DMNJthy5FJvNi
	Ru4rNSW8Ye7e6YvE6Its/2yxli2yuZvXFLD4jyLGDu+9XhYIUjKChlFsUXAWFG7r
	a5s7rzfdtbc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBBD49931;
	Tue, 28 Aug 2012 19:39:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43E729930; Tue, 28 Aug 2012
 19:39:13 -0400 (EDT)
In-Reply-To: <7v8vcyzomw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 28 Aug 2012 14:35:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 92B27A5C-F169-11E1-BE97-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204459>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>>  	for (i = 0; i < cnt; i++) {
>>> -		if (rslt[i])
>>> +		/*
>>> +		 * Is rslt[i] an ancestor of any of the others?
>>> +		 * then it is not interesting to us.
>>> +		 */
>>> +		for (j = 0; j < i; j++)
>>> +			others[j] = rslt[j];
>>> +		for (j = 1 + 1; j < cnt; j++)
>>
>> s/1 + 1/i + 1/;
>>
>> With that, all tests seem to pass ;-)
>
> "git merge-base" itself seems to have more room for improvement.
> Trying to recompute bases for recent 200 merges in the kernel
> history with the attached script does not show any improvement with
> or without the series on top of recent "master".  Correctnesswise it
> seems to be OK, though---I get byte-for-byte identical output.
>
> -- >8 --
> #!/bin/sh
>
> git rev-list --committer=torvalds@linux-foundation.org \
>     --max-parents=2 --min-parents=2 --parents v3.5..v3.6-rc2 >RL
>
> cmd='
> 	while read result parent1 parent2
> 	do
> 		$GIT merge-base $parent1 $parent2
> 	done <RL
> '
>
> GIT="rungit master" time sh -c "$cmd" >:stock
> GIT=../git.git/git time sh -c "$cmd" >:optim
> cmp :stock :optim
> -- 8< --

I have this suspicion that it is spending most of its time in
insert-by-date.  Luckily, merge_bases_many() is totally outside of
the usual revision traversal and its use of the commit list is
pretty well isolated.

Peff, can I interest you into resurrecting your $gmane/174007 and
$gmane/174008 (we do not need pop_commit_from_queue() in the latter;
everything can stay as static to commit.c for now) to see how well
priority queue based approach would perform?
