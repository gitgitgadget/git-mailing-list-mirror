From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] stash: Delete MERGE_RR before stash apply
Date: Fri, 06 Jul 2012 13:01:54 -0700
Message-ID: <7v7gugodzh.fsf@alter.siamese.dyndns.org>
References: <CABURp0pNsRQgbf7_iYc-xVaySa9-gGiA++Lw4-WgSCQ4QGCXsA@mail.gmail.com>
 <7v7guiruxo.fsf@alter.siamese.dyndns.org>
 <CABURp0rOfr=c-TcF7O6Ms=2iRA3SC9ckt_ukeozBS5vGqaKZaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	martin.von.zweigbergk@gmail.com, tytso@mit.edu
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 22:02:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnEj8-000438-9z
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 22:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846Ab2GFUCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 16:02:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48109 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802Ab2GFUB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 16:01:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D165C96BB;
	Fri,  6 Jul 2012 16:01:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KYyzeYJAnQ9mQKNHuIwl28Rdr5M=; b=QuODzU
	0JRkCq5EGC/P6EPvS2ZJuYNJiDEQwuOetHcNrdN8Gm9o+3Z0OL6x9utVCirBBodI
	hyvS9cb5bWerNl9yIRhd/eKWjovyl/4yJ0RNIEf7QodZy4ov5MpXJkRc43fbFea7
	XfGh3O6CQ3H2QNhb94l4LwQyoZmUHmOFjJTDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MoUY8xedNp8pB8vQm7N8bMh1DU24KOku
	/P5XqWv9oReBfgTzlmjUuP5AZjiNrixB7naKlLS3wCbgYAQLOJBOMJmOqmGe3hiY
	4kEVTRTuUm4RBrlbMsgG9iM3RMGwCPZqhVTTWedLs1RYy3VY4b2xL4E7xEo0prDw
	rasaz2oVFOE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8C1996BA;
	Fri,  6 Jul 2012 16:01:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2DEB096B8; Fri,  6 Jul 2012
 16:01:56 -0400 (EDT)
In-Reply-To: <CABURp0rOfr=c-TcF7O6Ms=2iRA3SC9ckt_ukeozBS5vGqaKZaQ@mail.gmail.com> (Phil
 Hord's message of "Fri, 6 Jul 2012 11:53:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7018617A-C7A5-11E1-B91C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201145>

Phil Hord <phil.hord@gmail.com> writes:

>> Would an obvious alternative of running "git rerere" ourselves after
>> running "git merge-recursive" in this script work?
>>
>>  git-stash.sh | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/git-stash.sh b/git-stash.sh
>> index 4e2c7f8..bbefdf6 100755
>> --- a/git-stash.sh
>> +++ b/git-stash.sh
>> @@ -469,6 +469,7 @@ apply_stash () {
>>         else
>>                 # Merge conflict; keep the exit status from merge-recursive
>>                 status=$?
>> +               git rerere
>>                 if test -n "$INDEX_OPTION"
>>                 then
>>                         gettextln "Index was not unstashed." >&2
>
> Yes, except it needs "git rerere clear".  "git rerere" is not enough
> to cause the clean-up to occur.

Intuitively, it feels wrong to run "rerere clear" after an operation
that potentially can create conflicts in the index and in the
working tree.

The point in the codepath where the above "git rerere" appears is
immediately after we run merge-recursive backend.  Because the
backend does not invoke rerere itself (which by the way probably is
the correct thing not to; I haven't thought things through, though),
we invoke it ourselves there, so that the user can ask rerere to
replay an earlier conflict resolution.  Why can it be a good thing
to discard potentially useful information with "git rerere clear"?

I just tried this sequence (manually without any patch).

    $ git init empty && cd empty
    $ for i in a b c d e; do echo $i; done >file
    $ git add file && git commit -m initial
    $ for i in a b C d e; do echo $i; done >file ;# c to C
    $ git stash

    $ for i in a B c d e; do echo $i; done >file ;# b to B
    $ git commit -a -m second

    $ mkdir .git/rr-cache ;# enable rerere
    $ git stash apply ;# conflicts
    $ git rerere ;# records preimage

    $ for i in a B C d e; do echo $i; done >file ;# c to C
    $ git commit -a -m third ;# records resolution
    $ git reset --hard HEAD^

    $ git stash apply ;# conflicts
    $ git rerere ;# replays

I think the above "how about this" patch is equivalent to the two
"git rerere" invocations I made manually with my experiment, and it
seems to improve the end user experience (please try it yourself).

What am I missing???
