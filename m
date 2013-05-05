From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Make "$remote/$branch" work with unconventional refspecs
Date: Sun, 05 May 2013 12:02:13 -0700
Message-ID: <7v8v3tuu6i.fsf@alter.siamese.dyndns.org>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<7vr4hmuk20.fsf@alter.siamese.dyndns.org>
	<CALKQrgdp9DVDBLNwCAmQHbEfZDvhdsmSW3sh1BRo1XEnyqPPaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun May 05 21:02:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZ4Ce-0005b3-NP
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 21:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988Ab3EETCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 15:02:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41935 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751910Ab3EETCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 15:02:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06CDC1CBD7;
	Sun,  5 May 2013 19:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4gxuJsbp39PhyvWGqhyXVBAW10k=; b=Kdcyv5
	MfeEw9BIBSe6KeCV6Pj4vYgmP7EFNUVfPpbGTs0TdViO47ZP5Xg9qn51jNeZC1B6
	Vh1Z+DmmEQ2tRl1eTQMhWDL219bQt5IjS4Nq5MEkvHSX9qeJbjuME/65f3MTtwRO
	1jiHJlENdX90G09Sf91HOJoVyApgi9O7jWoWE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VzIyvgNDLBhwAoz7YEZCDh2RS7RHCsNK
	CwPsBiKpUzwRJwsH4X3W5+aBN8c7LsGOyZToqdCp7O2m7TcGBE/LgSpZGxAsx7fP
	ZFJaAFji+wx4opLBJflhoGJDUgZJgo+DALssxlEKZIZ08Bjy0BhqK1zfYRARm9tp
	kW92HiAcu0E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0B311CBD5;
	Sun,  5 May 2013 19:02:15 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2EA561CBD2;
	Sun,  5 May 2013 19:02:15 +0000 (UTC)
In-Reply-To: <CALKQrgdp9DVDBLNwCAmQHbEfZDvhdsmSW3sh1BRo1XEnyqPPaA@mail.gmail.com>
	(Johan Herland's message of "Sun, 5 May 2013 11:59:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4CD136D8-B5B6-11E2-9E64-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223414>

Johan Herland <johan@herland.net> writes:

> I want to extend the same reasoning to remote-tracking refs, i.e.
> "$remote/$name" could be auto-completed into any of
>
>   refs/remotes/$remote/$name
>   refs/remotes/$remote/tags/$name
>   refs/remotes/$remote/heads/$name
>
> without causing ambiguity in the common case. When there is ambiguity, we
> would resolve that in the same manner as for local refs.
>
> The current series only concerns itself with the branches, but the larger
> intention is to make it work for tags and other refs as well.

Good ;-).

So another issue that remains is the following, I think.

When interpreting $nick/$name, assuming that we can tell where $nick
for a remote ends and $name for the ref we take from the remote
begins [*1*], how would we determine which refs/remotes/$remote/ is
used for $nick?

My gut feeling is that we should ignore any "remote.$nick.fetch"
wildcard mapping, e.g.

    [remote "foo"]
        fetch = +refs/heads/*:refs/remotes/bar/heads/*
        fetch = +refs/tags/*:refs/remotes/baz/tags/*

so that we look always in refs/remotes/$nick/ somewhere, for at
least two reasons:

 * For sane people, "bar" and "baz" in the above example are both
   "foo", so ignoring remote.foo.fetch mapping is a no-op for them.

 * For people who deliberately wanted to move "foo"'s refs to
   different hierarchies depending on the hierarchies at the origin
   (i.e. branches to "bar", tags to "baz"), they wanted to do so for
   a reason to group related things in "bar" (and "baz") [*2*].  For
   them, mapping with remote.$nick.fetch" means not allowing them to
   use the real name of the group (i.e. "bar") they chose to name
   their refs.

>> If the final end result you are shooting for is to introduce an
>> extra level between the remote name and the branch names, i.e.
>> "heads/", any solution needs to at least have a plan (not necessarily
>> a detailed design or implementation) for the other hierarchies.  The
>> possibility to have these other hierarchies per remote is the true
>> progress that the "heads/" at that level can give us; there is not
>> much point to have heads/ after refs/remotes/origin/, if heads/ is
>> the only thing that can come there.
>
> I fully agree. This series was meant as the first step in that direction
> (sorry for not describing my intentions more clearly).

And I do not think we mind terribly if we extend the ref_rev_parse_rules[]
used in dwim_ref() to also look at these

	refs/remotes/$nick/$name
	refs/remotes/$nick/tags/$name
	refs/remotes/$nick/heads/$name

(the first of the above is existing "refs/remotes/%.*s").  I think
it is going too far if you extend it further to

	refs/remotes/$nick/*/$name

where the code does not control what an acceptable match for '*' is
(i.e. origin/foo matching origin/changes/foo might be OK, but
matching it with origin/randomstring/foo is not, unless the canned
ref_rev_parse_rules[] knows about the "randomstring", or there is a
configuration mechanism for the user to tell us she cares about the
"randomstring" hierarchy in her project).


[Footnotes]

*1* I offhand do not remember if we even allow multi-level remote
    nicks, but I do know we support multi-level branch names, so it
    may turn out that the only valid split of origin/jh/rbranch is
    topic 'jh/rbranch' from remote 'origin' and not topic 'rbranch'
    from remote 'origin/jh'.

*2* Perhaps "bar" in the above is spelled "topics", and the
    hierarchy may be used to collect non-integration single topic
    branches from more than one remote.  An example that is more in
    line with such a usage might be:

    [remote "jh"]
        fetch = +refs/heads/*:refs/remotes/topics/heads/jh/*
    [remote "jk"]
        fetch = +refs/heads/*:refs/remotes/topics/heads/jk/*
    [remote "fc"]
        fetch = +refs/heads/*:refs/remotes/topics/heads/fc/*

    and I would expect "git merge topics/jh/rbranch" to merge the
    "refs/remotes/topics/heads/jh/rbranch" topic branch.
