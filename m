From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git-pull.sh: introduce --[no-]autostash and
 pull.autostash
Date: Sun, 24 Mar 2013 00:28:49 -0700
Message-ID: <7va9pt2r4e.fsf@alter.siamese.dyndns.org>
References: <1363955399-13153-1-git-send-email-artagnon@gmail.com>
 <1363955399-13153-4-git-send-email-artagnon@gmail.com>
 <7vtxo374h6.fsf@alter.siamese.dyndns.org>
 <CALkWK0=oOt0teGqCjpDkerR3-t1cY=qKyK-AtoLLCz9L1-+vyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 08:42:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJfZF-0007Uc-58
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 08:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796Ab3CXH3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 03:29:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50922 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753782Ab3CXH3s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 03:29:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59CE59568;
	Sun, 24 Mar 2013 03:28:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UXfEY18L2Ul0DRndTbk5aoCCCms=; b=jgUxJA
	LxJkr+6KGkGRibAXXdzS1tR4iPPxFnsiiQW7Om9EZmyFjlXZ+svB8OQwWb7+ZKFX
	epEXVegTYW/d+f+ebG4sGeShmofkhXPyONvTOQTsIxA9qvUk+Dg3aMtqx8QaV8FS
	sDVcj8p1/sPC0GqPAfH3NerCl8EWtoMEAebJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TwqjYXJwR/LRctWbn9AEOqPPkKgV3YJf
	n7j3kHFhj4dWWQU2Rb0AVKJ8f1K5QiVnw3zmGkwX+s03qy13l8oZ2A9h+JMUUrKX
	L7qlIN5rqoLrcAD69uRCrn6kTIZ8xB4MNIoPiYf85ks/MJKSF+W3bU2Isw3vbg5D
	nKH7WFWBEtQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 504279567;
	Sun, 24 Mar 2013 03:28:51 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8B759566; Sun, 24 Mar 2013
 03:28:50 -0400 (EDT)
In-Reply-To: <CALkWK0=oOt0teGqCjpDkerR3-t1cY=qKyK-AtoLLCz9L1-+vyw@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sat, 23 Mar 2013 18:18:00 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7940CA90-9454-11E2-A9FF-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218945>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>>> +     elif test "$autostash" = false
>>> +     then
>>>               require_clean_work_tree "pull with rebase" "Please commit or stash them."
>>>       fi
>>
>> A safety net, after you run "git stash", to validate that the
>> added "git stash" indeed made the working tree clean, is necessary
>> below, but there does not seem to be any.
>
> Um, isn't that part of the "git stash" testsuite?

You should always "trust but verify" what other commands do at key
points of the operation; and I think this "require-clean-work-tree"
is a key precondition for this mode of operation to work correctly.

Especially because you do not even bother to check the result of
"git stash" before continuing ;-).

>>> +if test "$autostash" = true && stash_required
>>> +then
>>> +     git stash
>>> +     eval "$eval"
>>> +     test $? = 0 && git stash pop
>>> +else
>>> +     eval "exec $eval"
>>> +fi
>>
>> Delaying to run "git stash" as much as possible is fine, but with
>> the above, can the user tell if something was stashed and she has
>> to "stash pop" once she is done helping the command to resolve the
>> conflicts, or she shouldn't run "stash pop" after she is done
>> (because if nothing is stashed at this point, that "pop" will pop an
>> unrelated stash)?
>
> I could easily tell, from the "git pull" output: if conflict, then
> stash hasn't been applied.

The question was about "git stash save".  Depending on the cleanness
of the tree when "git pull" was started, "save" may or may not have
been done.  After resolving a conflicted "git pull" and committing
the result, the user does not have much clue if she needs to pop
anything, does she?  Instead of the usual "resolve the conflicts and
commit the result", she may need to see "resolve the conflicts,
commit the result, *AND* UNSTASH".
