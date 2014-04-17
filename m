From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: add -i and --introduced modifier for --contains
Date: Thu, 17 Apr 2014 10:04:52 -0700
Message-ID: <xmqqfvlbga4r.fsf@gitster.dls.corp.google.com>
References: <1397681938-18594-1-git-send-email-mcgrof@do-not-panic.com>
	<xmqqppkhexw3.fsf@gitster.dls.corp.google.com>
	<CAB=NE6VvDrMQ4ybF10MpXM-2672OdUTC_Rp2mdO3a5fuo1-H1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>,
	Jiri Slaby <jslaby@suse.cz>, Andreas Schwab <schwab@suse.de>,
	Jan Kara <jack@suse.cz>, Jeff King <peff@peff.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 19:05:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wapky-0006rv-Lq
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 19:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbaDQRFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 13:05:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62470 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437AbaDQRE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 13:04:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEFC275843;
	Thu, 17 Apr 2014 13:04:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WQChKQicqC+NdtJIohGRYdI2FkM=; b=EjIZqr
	BIDDRkt8zlPCT3slWNMriNw8FZaYqsGu/edfteHD6UTX1ygbOGxlZGJdQWjTpKLz
	cnmTZmyyLa0aAlh+1cj7m3AONDzX61cayJMRLMXg/eOM2gfFqwA3CRZr0uJn0Jry
	l/CLTIZnTtCWmlNDEXoZHbHUFruWO8PHPD+Tk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pjkP4tdTYghv7Hzl/QaDZaF+qr+mv6Wg
	ff0S2sCxCIsNGaNm6ISG9oNBfwBjNf/MiAMIATAhMSpqDiTDLtZPHAK9Zsj3Gu8f
	FQlomwQqlhMpXZVS4EPjNtGHmneUYQPzlM0RPV/jilG71Wx6yDi2s7Rw93WLX196
	Lr0bkv0kVVg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9126C75842;
	Thu, 17 Apr 2014 13:04:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1302575841;
	Thu, 17 Apr 2014 13:04:55 -0400 (EDT)
In-Reply-To: <CAB=NE6VvDrMQ4ybF10MpXM-2672OdUTC_Rp2mdO3a5fuo1-H1Q@mail.gmail.com>
	(Luis R. Rodriguez's message of "Wed, 16 Apr 2014 15:35:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 65F650A0-C652-11E3-B5EA-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246423>

"Luis R. Rodriguez" <mcgrof@do-not-panic.com> writes:

>> And between v3.4 and v3.5-rc1, the latter is a closer anchor point
>> for that commit (v3.5-rc1 only needs about 200 hops to reach the
>> commit, while from v3.4 you would need close to 500 hops),
>
> Ah! Thanks for explaining this mysterious puzzle to me. I'm a bit
> perplexed why still. Can I trouble you for a little elaboration here?
> How could one view from a commit merged on v3.4 possibly yield more
> commits to v3.4 than to v3.5 ? Is it because it starts counting on the
> merge's parent (v3.3) ?

The reason is very simple, once you realize that in a distributed
environment it is very common to fork off a new branch from an
ancient commit and then merging the result to a newer release
without merging it all the way down to older maintenance releases.

Try this sequence:

    1. start from say v3.4~1^2~2
    $ git checkout -b side v3.4~1^2~2

The history near v3.4 proper looks like this:

    $ git log --oneline -3 v3.4
    76e10d1 Linux 3.4
    d6c77973 Merge tag 'parisc-fixes' of git://git.kernel.o...
    5d12045 Merge branch 'x86/ld-fix' of git://git.kernel.o...

and the last merge before v3.4 brings three commits in to the
history:

    $ git log --oneline d6c77973^1..d6c77973^2
    b3cb867 [PARISC] fix panic on prefetch(NULL) on PA7300LC
    207f583 [PARISC] fix crash in flush_icache_page_asm on PA1.1
    5e18558 [PARISC] fix PA1.1 oops on boot

We just forked a new "side" branch off of the bottom one (5e18558).

    2. pretend a new development on this old codebase
    $ git commit --allow-empty -m "[PARISC] another"

    3. let's merge this to v3.5 and call the result v9.0
    $ git checkout v3.5
    $ git merge --no-edit side
    $ git tag -a -m 'Nine' v9.0

Think what just happened to v3.4~1^2~2, the fork-point of this new
side branch (I am not asking what *should* happen. This exercise is
only to illustrate how the commit v3.5-rc1~120^3~76^2 can be closer
to v3.5-rc1 than to v3.4 when it is reachable from both).

Here is how the topology looks like:

                   v3.4                  v9.0
             ---M---X---------------------Y
               /                         /
   ---A---B---C                         /
       \                               / 
        ------------------------------D (side)

where X is v3.4, M is d6c77973, A thru C are the PARISC patches,
D is the "another", and Y is the phoney version Nine we just made.
We are trying to "describe --contains" commit A.

If you start counting from the new tag v9.0, it is on the merged
side branch that brought in one new commit D, and in fact it is the
direct parent of it, so even without asking "describe --contains",
we know that it is v9.0^2~1.  That is 2 hops from v9.0 tag.  If you
count from v3.4, it is 4 hops.

And both of these tags X and Y contain the commit A.

Now, as to what *SHOULD* happen, I think the above exercise shows us
a way to define what the desired semantics is, without resorting to
heuristics (e.g. "which tag has older timestamp?" or "which tag's
name sorts older under Linux version naming convention?").

Commit A can be described in terms of both v3.4 and v9.0, and it may
be closer to v9.0 than v3.4, and under that definition "we pick the
closest tag", the current "describe --contains" behaviour may be
correct, but from the human point of view, it is *WRONG*.

It is wrong because v9.0 can reach v3.4.  So perhaps the rule should
be updated to do something like:

    - find candidate tags that can be used to "describe --contains"
      the commit A, yielding v3.4, v3.5 (not shown), and v9.0;

    - among the candidate tags, cull the ones that contain another
      candidate tag, rejecting v3.5 (not shown) and v9.0;

    - among the surviving tags, pick the closest.

Hmm?
