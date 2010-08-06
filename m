From: Junio C Hamano <gitster@pobox.com>
Subject: Re: jk/tag-contains: stalled
Date: Thu, 05 Aug 2010 22:44:23 -0700
Message-ID: <7vr5ic9txk.fsf@alter.siamese.dyndns.org>
References: <7v62zqf23s.fsf@alter.siamese.dyndns.org>
 <20100805001629.GC2901@thunk.org> <7vsk2tdnv5.fsf@alter.siamese.dyndns.org>
 <7vhbj9dm6h.fsf@alter.siamese.dyndns.org> <20100805173635.GA15760@sigill>
 <7vy6ckdhhu.fsf@alter.siamese.dyndns.org> <20100805190653.GA2942@sigill>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Ts'o <tytso@mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 06 07:44:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhFjX-0004Rz-Be
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 07:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755796Ab0HFFoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 01:44:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48931 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198Ab0HFFof (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 01:44:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 03906CAAD2;
	Fri,  6 Aug 2010 01:44:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W812Ji0BSTRT503dttAa25UIqlM=; b=qCdKIg
	Fo1RmILKJ7zZnCdQjJjWA3H5PoWwb+EAyD/9W6g/yW89IVsykXCiefDrcGbjdPDS
	RB/YBqa58FLAVIPT9antaTFezJnAX+EBzLyxLSDqmggwSqKUB8aIPexfWeypgbiT
	GlmCmpw10oTMZzFa77VbBmYuvFZEAuha9ifM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=olQ3Bs31JT5M3n9ksVB+R+gB+YhuDS/a
	VnPycpQNOtsrgs51r2Zr1O5+PWWeEuXdKbvI9ypNnb7dfgKb+qlLd3xU7zBnkbZs
	iSwr16yOf9kYpunLSJsSLR1Jw+mNNXqde+8C8mw/Cmezxymhc9mLUdAZQyb3kEsf
	6Ikjb++tA4I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C01FFCAACF;
	Fri,  6 Aug 2010 01:44:29 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3336CAACA; Fri,  6 Aug
 2010 01:44:25 -0400 (EDT)
In-Reply-To: <20100805190653.GA2942@sigill> (Jeff King's message of "Thu\, 5
 Aug 2010 15\:06\:54 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AE737ABE-A11D-11DF-8808-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152765>

Jeff King <peff@peff.net> writes:

> On Thu, Aug 05, 2010 at 11:47:09AM -0700, Junio C Hamano wrote:
>
>> My gut feeling is that it is probably Ok if contains() and its
>> recursive helper are moved to builtin/tag.c and are made static, to
>> make it clear that this should not be reused outside the current
>> context as a generic "contains" function.  It would probably help to
>> have a comment at the end of list_tags() to say that TMP_MARK _ought_
>> to be cleaned before leaving the function but we don't do that because
>> we know it is the last function in the callchain before we exit.

After thinking about this a bit more, I changed my mind.

I think depth-first traversal from all tag tips, without running any
traversal from the wanted commit, has a serious downside.  What happens
when you run "git tag --contains master" in a Linus tree after a major
release but before he tags the -rc1 and closes the merge window?  Doesn't
the algorithm run all the way down to the root, only to say nothing?
Admittedly the traversal will visit each commit once (starting from
v2.6.12 down to v2.6.12-rc2, then skipping v2.6.12-rc2 through v2.6.12-rc6
because they are already seen and known not to contain the "master", then
starting from v2.6.13 down to v2.6.12, and so on), but visiting all the
commits down to root feels really wrong.

I think the merge-base traversal is essential.  Suppose we have hundreds
of commits with two tags 'T1' and 'T2':

                                  o---T2        o---o---Y
                                 /             /
 ---o---o---o---o---o---o---o---%---...---X---*---T1

If you are probing for 'X', traversing from all the tags until you hit a
wanted commit will stop at a reasonable point (namely, 'X') if you are
lucky and you started from 'T1' not 'T2', with your new algorithm.  If you
are unlucky and started from 'T2', you will however traverse down to root
from 'T2' which would be the bulk of the history.

Also, when you are probing for 'Y', you end up traversing all the way
down, whether you start from 'T1' or 'T2', don't you?

You can (and should) dig both from 'Y' and 'T1' and stop traversal at '*',
as that commit is an ancestor of 'Y' and at that point you have proven
that any ancestor of that you will find by traversing further will not
find 'Y'.  Similarly for 'Y' and 'T2' pair, which should stop at '%'.

As the author of show-branch, I think I know one trick that may speed this
up without compromising the worst case scenario.

We can run this traversal in parallel for many tags at once.  Use bit #0
of object.flags for the wanted commit, and bit #1..bit #N for N tags (if
you have more tags than that fit in the flags word, you run the algorithm
multiple times, N tags at a time, clearing the flags after each round).

The parallel traversal will run, smudging the parent commit's flags with
those of the child, in the usual way.

Suppose that you are probing for 'Y'.  You start traversal from 'Y', 'T1'
and 'T2' (as two tags will fit comfortably in a single flags word).  When
you come to commit '%', you will notice that all the ancestors of that
commit are contained in the wanted commit and all the tags you are probing
for ('T1' and 'T2').  There is no point to go further than that point
during this round, as you know you will not find 'Y' by digging further
from that point.

In general, when you find that a commit has both bit #0 and bit #i set,
that commit is known to be a common ancestor between 'Y' and 'Ti', so
there is no point going further from that point to see if 'Ti' contains
'Y'---you know it doesn't.  So you can stop when you see bit 0..N are all
set.  After traversing as many commits as possible this way, look at the
bits 1..i that is given to 'Y'.  They represent the set of tags that
contain 'Y' (you will find only bit #0 is set on 'Y').

Similarly, if you are probing for 'X', start the traversal from 'X', 'T1'
and 'T2'.  The traversal that begins at 'T1' will reach 'X' (so 'X' will
initially start with bit #0 set, but then when the traversal that started
from 'T1' reaches it, its bit #1 gets set) eventually.  Because bit #2 is
not set at that point, you don't stop and keep traversing.

You may already have started marking 'X' and its parent with bit #0 with
the traversal you started at 'X', but when you reach 'X' from 'T1' again,
you will be changing bit #1; anytime you change the flag, you would push
the commit back to the stack and re-traverse it.  Eventually, you will
smudge '%' with all 3 bits (depending on clock skew, you might traverse a
few more levels of its parents) and you can stop.  The flag word on 'X'
will have bis #0 and #1 set, so you know 'T1' reaches it but 'T2' doesn't.

To optimize this further, you may want to take advantage of the fact that
tags are not supposed to change, and have a cache that knows what tag is
contained in what other tag (e.g. if v1.0 is contained in v2.0, you do not
have to run the probe for v2.0 once you know the wanted commit is
reachable from v1.0).  But that can come later, I think.

But I haven't thought things really through.  If I am lucky, I may be able
to find time tomorrow during the day to try conjuring something out, but
no promises...
