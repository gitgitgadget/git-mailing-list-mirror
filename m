From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 05/18] Add testcase for --index-only merges needing the recursive strategy
Date: Fri, 08 Apr 2016 13:14:18 -0700
Message-ID: <xmqqtwjbvox1.fsf@gitster.mtv.corp.google.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
	<1460098726-5958-6-git-send-email-newren@gmail.com>
	<xmqqzit3vqma.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 22:14:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aocnU-0006I4-28
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 22:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758747AbcDHUOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 16:14:23 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58800 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754160AbcDHUOW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 16:14:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C5EE252A68;
	Fri,  8 Apr 2016 16:14:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YzNPMUjIjuMIQ0GAyjlcYqmrOu0=; b=wpafRc
	WIb8z2N5+Gnv46S/xUj4wpy8YUCh8y0uO5n2MPf/hX96SZiI/BoZzvlLTJF49Sru
	r+k//1rbj5nC6OYaTnQIa8gEaB5GnrCXbx2owepYCb+BSNFuAEUiakI69BaSzLKW
	TaEE7frAKK/PUO/Trhd9pHj0HXYLN9QHzdwJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=btpD+zK45GUcE+JMLB2H55anYFyNHZOX
	CyVnCOM+IvmzUgAEA7jSRbAxcKageNo+5Ix6esMmqueEmoKe/X9m/q8QLwPhZ05o
	9eE09Nm0mvTM9jtb/njSD1EUjUxBBgWPs3Q2tZgYcHfteRcWBbTNkxSyO27XYiNm
	2eZK0flO6T8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA18552A67;
	Fri,  8 Apr 2016 16:14:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3320852A66;
	Fri,  8 Apr 2016 16:14:20 -0400 (EDT)
In-Reply-To: <xmqqzit3vqma.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 08 Apr 2016 12:37:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7A5208D4-FDC6-11E5-9BDC-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291066>

Junio C Hamano <gitster@pobox.com> writes:

> Elijah Newren <newren@gmail.com> writes:
>
>> +test_expect_failure '--index-only with rename/modify works in non-bare-clone' '
>> +	git checkout B^0 &&
>> +
>> +	git merge --index-only -s recursive C^0 &&
>> +
>> +	echo "Making sure the working copy was not updated" &&
>> +	test ! -f b &&
>> +	test -f a &&
>> +	test $(git rev-parse B:a) = $(git hash-object a) &&
>> +
>> +	echo "Making sure the index was updated" &&
>> +	test 1 -eq $(git ls-files -s | wc -l) &&
>> +	test $(git rev-parse B:a) = $(git rev-parse :b)
>
> The most crucial test that is missing (hence prevents reviewers from
> judging if --index-only is a good idea at all) is the test on HEAD.
> Does it record a merge between B and C and move HEAD there, i.e.
>
> 	test $(git rev-parse HEAD^1) = $(git rev-parse B) &&
> 	test $(git rev-parse HEAD^2) = $(git rev-parse C)
>
> or does it make a merge but does not advance HEAD, i.e.
>
> 	test $(git rev-parse HEAD) = $(git rev-parse B)
>
> I fear that it may give a great headache to end users if you move
> HEAD in a repository with a working tree to point at the merge
> result--how do they reconcile the difference between the working
> tree (which was based on B) and the index and HEAD (which is now
> based on the result of the merge)?  The next "git commit -a" would
> appear that it would revert the changes brought in by this merge,
> wouldn't it?

And if the expectation that is not spelled out by this new test is
that the merge does not advance HEAD, the command does not make much
sense either, because there is no way for you to find out the merge
result.

Let's step back a bit.  This may or may not be what you are aiming
at, but I think I can buy a series whose title is "merge without
working tree" if the big-picture objective of the topic were to
support this workflow:

    0. I am working on my own branch that is not 'master'.

    1. I see somebody else worked on and finished a good topic
       'en/topic'.  My work is not yet in a good shape, and I do not
       want to switch to 'master' only to merge 'en/topic' to
       'master', but 'en/topic' is so good and my urge to merge it
       to 'master' is strong.

    2. Hence I want a way to merge 'en/topic' to 'master' and
       advance the tip of 'master', without using my working tree
       (or the index or my HEAD for that matter), without disrupting
       my current state.

    3. For simplicity, I can live with it if the early version of
       that "merge en/topic to master" operation is incapable of
       handling conflicts.  Then I'd say "huh, I'd need to manually
       inspect the merge result so I'll do that later" and continue
       what I was doing, or I'd say "OK, let's really have a look",
       save what I was doing in a temporary commit and switch to
       'master' to do the usual "git merge en/topic".

    4. But it would be even better if I could give a temporary
       directory to it as a scratch-pad area, and if I was asked to
       help it resolving conflicts by editing conflicted files in
       the scratch-pad area.

In any case, what is in my current index (or HEAD) is no use for
merging en/topic into master, so the command should not care or
touch not just what is in my working tree (which gives the operation
the same requirement as your series, i.e. "do not touch or require a
working tree") but also what is in my index or where my HEAD is.

The low-level ingredients that support "git merge", namely, "git
read-tree -m COMMON OURS THEIRS", actually has a support to make
this kind of "merge without fully populated working tree" possible,
by considering the lack of working tree file an equivalent to having
an unmodified working tree file (I suspect that merge-recursive is
probably broken with this regard, as it was mostly done without
knowing that we anticipated such a need in early life of Git long
before merge-recursive was invented).  We can give an empty
"scratch-pad area" as a temporary working tree, create a temporary
index out of 'master' (in the above example), perform the usual
three-way merge with
    
    GIT_DIR=... point at the real thing ...
    GIT_INDEX_FILE=... point at a temporary file ...
    export GIT_DIR GIT_INDEX_FILE
    rm -fr /var/tmp/scratchpad && mkdir /var/tmp/scratchpad
    cd /var/tmp/scratchpad
    base=$(git merge-base master en/topic)
    git read-tree -m $base master en/topic

and run "git merge -s resolve" to drive "git merge-one-file".  This
would populate /var/tmp/scratchpad with files that are involved in
the merge, without wasting diskspace for files in 'master' that does
not change, and you can edit them, "git add" these paths, and then
do a "git write-tree" to create the tree that represents the merge
result.  You obviously need to avoid touching HEAD when recording
that tree as a merge commit and advance the tip of 'master' (as HEAD
is still on my own unrelated branch), but that part is trivial
(i.e. we have written "git commit" at least twice).

Of course, if you are not going to support merges that need manual
conflict resolution, you do not need the scratchpad and the end user
experience would be simpler (i.e. you do not have to think about how
they resolve, record the resolution, etc.)  And your "merge only in
index" topic would fit well in that picture.

But then, using the current index and the HEAD as the place to merge
into is still wrong.  I think this is better done as a separate
command, not "git merge" but perhaps something like

    $ git merge-to en/topic master

or something.  "git merge --into=master en/topic" is also a
possibility.

But as I said in the early part of this message, this may or may not
be what you are aiming at.  The above is the most sensible tangent
that I can think of that may be related to "merge only in index".
