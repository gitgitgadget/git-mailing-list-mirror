From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Borrowing objects from nearby repositories
Date: Wed, 26 Mar 2014 10:29:22 -0700
Message-ID: <xmqqbnwskgwd.fsf@gitster.dls.corp.google.com>
References: <BFF5FBC7-8F53-4958-8D56-90EADD3AD626@kellerfarm.com>
	<CACBZZX5teZuqtNkPT4PdXJn=g34cOhRH2oNehROT8kJ_M2cgfg@mail.gmail.com>
	<xmqqtxammctc.fsf@gitster.dls.corp.google.com>
	<xmqqvbv1kjoc.fsf@gitster.dls.corp.google.com>
	<3533946C-DE97-4214-9B55-F5B788DDD952@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git List <git@vger.kernel.org>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 18:29:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSrdv-0000Iq-Ib
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 18:29:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754997AbaCZR3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 13:29:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54161 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054AbaCZR32 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 13:29:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D990731E5;
	Wed, 26 Mar 2014 13:29:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JV4h+0lENqvXmOPaArF+D20PYRw=; b=Zy4dLR
	wHLPRWjBzIb08a16E2QP7Djk89leIhz2ZAzOPEGldkdaFC+S6zagL5ZyEH0ewyIN
	cqqfuP+PTg9LUY4Rzw/zR+89f3ttflPOZ940A1jH0dcHROeAs7wy2Mj+1zmZeBR9
	yZEaoOZu3I584WxLHAtG8c9bLbiFeWgklU/kg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bP5NbM+3D9yTSDXjF9YIMoPHRyz9tEwm
	PbzLQDYL0ukvQX/S86x2wva6utitjJGtxx+KR/bgpFgjE0mLjmMYy8pY/7IK1fqV
	Mr3D43CBHVaseYBgWqVtXFiFY8lmQVffno8atSlo4D5TSP9dKdO4Co9oaurQDOd4
	DN1OW6kSvcs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C6D1731E4;
	Wed, 26 Mar 2014 13:29:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D9AF731E1;
	Wed, 26 Mar 2014 13:29:26 -0400 (EDT)
In-Reply-To: <3533946C-DE97-4214-9B55-F5B788DDD952@kellerfarm.com> (Andrew
	Keller's message of "Wed, 26 Mar 2014 09:36:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2DD79690-B50C-11E3-85DD-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245198>

Andrew Keller <andrew@kellerfarm.com> writes:

> On Mar 25, 2014, at 6:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>>> I think that the standard practice with the existing toolset is to
>>> clone with reference and then repack.  That is:
>>> 
>>>    $ git clone --reference <borrowee> git://over/there mine
>>>    $ cd mine
>>>    $ git repack -a -d
>>> 
>>> And then you can try this:
>>> 
>>>    $ mv .git/objects/info/alternates .git/objects/info/alternates.disabled
>>>    $ git fsck
>>> 
>>> to make sure that you are no longer borrowing anything from the
>>> borrowee.  Once you are satisfied, you can remove the saved-away
>>> alternates.disabled file.
>> 
>> Oh, I forgot to say that I am not opposed if somebody wants to teach
>> "git clone" a new option to copy its objects from two places,
>> (hopefully) the majority from near-by reference repository and the
>> remainder over the network, without permanently relying on the
>> former via the alternates mechanism.  The implementation of such a
>> feature could even literally be "clone with reference first and then
>> repack" at least initially but even in the final version.

[Administrivia: please wrap your lines to a reasonable length]

> That was actually one of my first ideas - adding some sort of
> '--auto-repack' option to git-clone.  It's a relatively small
> change, and would work.  However, keeping in mind my end goal of
> automating the feature to the point where you could run simply
> 'git clone <url>', an '--auto-repack' option is more difficult to
> undo.  You would need a new parameter to disable the automatic
> adding of reference repositories, and a new parameter to undo
> '--auto-repack', and you'd have to remember to actually undo both
> of those settings.
>
> In contrast, if the new feature was '--borrow', and the evolution
> of the feature was a global configuration 'fetch.autoBorrow', then
> to turn it off temporarily, one only needs a single new parameter
> '--no-auto-borrow'.  I think this is a cleaner approach than the
> former, although much more work.

I think you may have misread me.  With the "new option", I was
hinting that the "clone --reference && repack && rm alternates"
will be an acceptable internal implementation of the "--borrow"
option that was mentioned in the thread.  I am not sure where you
got the "auto-repack" from.

One of the reasons you may have misread me may be because I made it
sound as if "this may work and when it works you will be happy, but
if it does not work you did not lose very much" by mentioning "mv &&
fsck".  That wasn't what I meant.

The "repack -a" procedure is to make the borrower repository no
longer dependent on the borrowee, and it is supposed to always work.
In fact, this behaviour was the whole reason why "repack" later
learned its "-l" option to disable it, because people who cloned
with "--reference" in order to reduce the disk footprint by sharing
older and more common objects [*1*] were rightfully surprised to see
that the borrowed objects were copied over to their borrower
repository when they ran "repack" [*2*].

Because this is "clone", there is nothing complex to "undo".  Either
it succeeds, or you remove the whole new directory if anything
fails.

I said "even in the final version" for a simple reason: you cannot
cannot do realistically any better than the "clone --reference &&
repack -a d && rm alternates" sequence.

But you would need to know a few things about how Git works in order
to come to that realisation.  Here are some:

 * "clone --borrow" (or whatever we end up calling the option) must
   talk to two repositories:

    - We will need to have one upload-pack session with the distant
      origin repository over the network, which will send a complete
      pack.

    - We need to also copy objects that weren't sent from the
      distant origin to our repository from the reference one.

 * A single "repack -a -d" (without "-l") after "clone --reference"
   is already a way to do exactly what you need---enumerate what are
   missing in the packfile that was received from the distant origin
   and come up with packfile(s) that contain all and only objects
   the cloned repository needs.

 * You cannot easily concatenate multiple packfiles into a single
   one (or append runs of objects to an existing packfile) to come
   up with a single packfile.

You _could_ shoehorn the logic to "enumerate and read from the
reference, and append them at the end of the packfile received from
the distant origin repository" into the part that talks to the
distant origin repository, but the object layout in the resulting
packfile will be suboptimal [*3*] and the code complexity required
to do so is not worth it [*4*].


[Footnotes]

*1* From the point of view of supporting both camps, i.e. those who
    want their borrower repositories to keep sharing the objects
    with the borrowee repository and those who want to use a
    borrowee repository temporarily while cloning only to reduce the
    network cost from the distant upstream, the current option name
    "--reference" and the proposed name "--borrow" are backwards.
    The folks who want the original behaviour of keep depending want
    to "borrow" from the borrowee repository; those who want to
    utilize the mechanism temporarily only while cloning would want
    to merely "reference" it only while cloning.

*2* A repository created with "clone --reference" may want to set a
    configuration variable in it to tell future invocations of "git
    repack" to use the "-l" option by default, while allowing those
    who want to fatten such a repository to override it with "repack
    --no-local".  Without such an arrangement, we would risk the
    people who wanted that "-l" option for "repack" in the first
    place to accidentally fatten their lean repositories by mistake,
    forgetting to pass the "-l" option.  Luckily "gc" always runs
    "repack" with "-l", so the risk is limited to those who run
    "repack" themselves, which may be why we heard no complaints on
    this point.

*3* In fact, another program invoked during the object transfer
    "index-pack --fix-thin" does have "append selected objects at
    the end of the packfile received over the wire and fix up the
    whole thing" logic in it).  The pack that results from it
    suffers from the suboptimal layout because the appended objects
    are "appended", not placed in their optimal positions in the
    packfile to reduce seeks.  

    If "--borrow" did the same, the pack layout issue will be worse,
    because the whole point of "--borrow" is to borrow the majority
    of objects from reference repository---we will be appending a
    lot from the reference to a relatively small pack we receive
    over the wire from the distant origin.

*4* The complexity of the code to implement "index-pack --fix-thin"
    is not pretty, but it will be worse for "--borrow", as the
    former at least does not have to walk the dag to find out what
    objects need to be appended but the latter does.
