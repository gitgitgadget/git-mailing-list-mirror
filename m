From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-clean: Display more accurate delete messages
Date: Tue, 18 Dec 2012 18:37:14 -0800
Message-ID: <7vy5gudaxx.fsf@alter.siamese.dyndns.org>
References: <1355743765-17549-1-git-send-email-zoltan.klinger@gmail.com>
 <7vsj74jr2k.fsf@alter.siamese.dyndns.org>
 <CAKJhZwRPzrsnbnW_HgRTo86T6jqmm_osznDqpYo7pKO=cUaVDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 03:37:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl9XM-0004Xw-M4
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 03:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173Ab2LSChT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 21:37:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46498 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799Ab2LSChS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 21:37:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4307DA3F5;
	Tue, 18 Dec 2012 21:37:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uUrBR0WsAUzZcKbCiv1QAHzCcyQ=; b=DMr62N
	zQzaubEenMoh/Is42xVBEGODxCXQ85GUDQC//WK53uAM/NRQsTDpfB8ZNbHZmvdg
	FScuX7W0eBEk2CQ1UbtdZ/+uHuU2LpcKQDNvc5QHAh38p70weOFqgf9RAfuAZ0cn
	i6kPkzieqJC5MpuhYHINfqX/Au344SvmBs+WY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IA9Fjrgl1QpY2am0lQvZ8Y8328/o7jwE
	Nic/++tj2eXOkdAH0AQDfunLqzrLQSu9vfJYAvtjSd26YNXLu+TLq69qOiQYzu1V
	0yMW4xlSG3NjrJanAmOyn1mP32Bi5t7P75WJeZOP0FolSycYsh6NIHhgkjP2B9gE
	n+hwurM6V5c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 308E1A3EB;
	Tue, 18 Dec 2012 21:37:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E949A3E9; Tue, 18 Dec 2012
 21:37:16 -0500 (EST)
In-Reply-To: <CAKJhZwRPzrsnbnW_HgRTo86T6jqmm_osznDqpYo7pKO=cUaVDA@mail.gmail.com> (Zoltan
 Klinger's message of "Wed, 19 Dec 2012 11:59:59 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 00AB9200-4985-11E2-BEC7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211799>

Zoltan Klinger <zoltan.klinger@gmail.com> writes:

> Thanks for the feedback.
>
>> My reading of the above is that "lst" after sorting is expected to
>> have something like:
>>
>>         a/
>>         a/b/
>>         a/b/to-be-removed
>>         a/to-be-removed
>>
>> and we first show "a/", remember that prefix in "dir", not show
>> "a/b/" because it matches prefix, but still update the prefix to
>> "a/b/", not show "a/b/to-be-removed", and because "a/to-be-removed"
>> does not match the latest prefix, it is now shown.  Am I confused???
>
> No, it's a bug. The correct output should be just "a/". Thanks for
> pointing it out, I'm going to fix that.

I am not sure if the approach taken by the patch is an effective
design to achieve what you are trying to do.

Imagine the code is told to "clean" (or "clean a") and is currentlly
looking at "a/b" directory.  If it cannot remove some paths under
that directory, you know that you cannot abbreviate the result to
"removed a/b" and have to report a/b/<paths you managed to remove>
at that point.  On the other hand, if you removed everything in that
directory, you know you have only two possible outcomes regarding
that directory in the final output:

 (1) You would say "removed a/b" if you failed to remove paths that
     are neighbours to that directory (e.g. "a/to-be-removed" may
     not go away for some reason), because you will also list
     "removed a/<other path>" next to it, and report that you
     couldn't remove "a/to-be-removed".  You will not report
     anything about "a/b/to-be-removed" in such a case; or

 (2) You would not even say "removed a/b" if you will successfully
     remove all other paths under "a/".

So in either case, if you managed to remove everything in "a/b", I
do not see any reason to keep the list of successfully removed paths
annd report them upwards.  They will never be used by the caller
that is looking at "a/", or its caller that is looking at the root
level, will they?

On the other hand, if you failed to remove some paths under "a/b",
before recursion leaves that directory, you know which paths to be
reported as successful or failure, which means you can start
producing output without waiting until the traversal touches the
entire tree. That can be a huge latency win, which matters a lot in
a large project.
