From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Wed, 29 Apr 2015 22:34:38 -0700
Message-ID: <xmqqfv7i2n81.fsf@gitster.dls.corp.google.com>
References: <1430341032.14907.9.camel@ubuntu>
	<xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
	<1430343059.14907.18.camel@ubuntu> <20150429214817.GA2725@peff.net>
	<1430346576.14907.40.camel@ubuntu> <20150429231150.GB3887@peff.net>
	<20150430003750.GA4258@peff.net> <1430355983.14907.55.camel@ubuntu>
	<20150430011612.GA7530@peff.net> <1430358345.14907.62.camel@ubuntu>
	<20150430033725.GB12361@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 30 07:34:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ynh7X-0005Cl-B3
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 07:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbbD3Fen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 01:34:43 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62584 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750815AbbD3Fem (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 01:34:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5767849F9F;
	Thu, 30 Apr 2015 01:34:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N1RTDuqq9/wA8JyQdwxZw7nD1qE=; b=AV04wa
	34G9DscFJPmItNNoRmbwulM6Hrr8EdYz+FTUmPSx5Q0xniSMPOX21tC5/8yV3cWG
	ygC0hhN9vcFlUw+I20J4rzPm5NhXW2QI382upC5zJfcZPBQWanXzesVhENKWHHly
	1diedDk81npfe1h6MpSGEst++Yy+RBSS3cRBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T5sVGZFkFccLGnw+nGLxluTRIyVlr4qS
	yiAh0zxtSjUhulpPXytpm4Q5UaSDj+QpPHGNHN9fa5tGZ5+Xy3xgCQUftMiKY4oq
	2J6CzXnyKS2RPRV6Jj4/9t86jmop0ER9LDXqiFIBA4M3GPjHL4yuFFNGVLjnfgbL
	0cG2fpTW8Eo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5006349F9E;
	Thu, 30 Apr 2015 01:34:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E607249F9D;
	Thu, 30 Apr 2015 01:34:39 -0400 (EDT)
In-Reply-To: <20150430033725.GB12361@peff.net> (Jeff King's message of "Wed,
	29 Apr 2015 23:37:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 98BA86D8-EEFA-11E4-B6A0-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268057>

Jeff King <peff@peff.net> writes:

> Here are some possible alternatives:
>
>   1. If we can't resolve fully, don't resolve anything. I.e., return the
>      "fleem" object here, and the caller can recurse if they want. This is
>      simple and correct, but not as helpful to somebody who wants to follow
>      the out-of-tree link (they have to re-traverse the fleem->foo/bar/baz
>      link themselves).
>
>   2. Consider it can error if resolution fails. If you ask for
>      "HEAD^{tree}^{commit}", that does not resolve to anything (because
>      we can't peel the tree to a commit). Like (1), this is simple and
>      correct, but probably not all that helpful. The caller has to
>      start from scratch and resolve themselves, rather than getting an
>      intermediate result.
>
>   3. Return an object with the symlink relative to the original
>      filename (so "../external" in this case). This is kind of weird,
>      though, because we're not just returning a string from the name
>      resolution. It's an actual object.  So we'd be generating a fake
>      object that doesn't actually exist in the object db and
>      returning that. Feeding that sha1 to another program would fail.
>
>   4. Return the last object we could resolve, as I described. So
>      foo/bar/baz (with "../../../external" as its content) in this case.
>      When you resolve a name, you can ask for the context we discovered
>      along the way by traversing the tree. The mode is one example we've
>      already discussed, but the path name is another. So something like:
>
>        echo "HEAD^{resolve}:fleem" |
>        git cat-file --batch="%(objectname) %(size) %(intreepath)"
>
>      would show:
>
>        1234abcd 17 foo/bar/baz
>        ../../../external
>
>      And then the caller knows that the path is not relative to the
>      original "fleem", but rather to "foo/bar/baz".
>
>      The problem is that although this context lookup is already part of
>      get_sha1_with_context, that is not exposed through every interface.
>      E.g., "git rev-parse HEAD^{resolve}:fleem" will give you an object,
>      but you have no way of knowing the context.
>
> I can't say that I'm excited about any of them. Perhaps you or somebody
> else can think of a more clever solution.

Me neither, but if I really had to pick one, it would be the last
one, except that %(intreepath) would have to be somehow quoted,
perhaps like how the output from "git diff" quotes funny pathnames.

When we want to use this as an extended SHA-1 syntax (i.e. outside
of "cat-file --batch"), it most likely should just error out if the
link does not resolve to a path that would eventually result in an
in-tree object, with the same error message you would get when you
ask for the object name for "HEAD:no-such-path".

But stepping back a bit.

We have been talking about HEAD^{resolve}:fleem but how did we learn
that there is a path "fleem" in the tree of HEAD in the first place?
I would presume that the answer eventually boils down to "somebody
fed HEAD to 'ls-tree -r'", and then that somebody is an idiot if it
did not grab the mode bits to learn what kind of blob fleem is, or
if it did not tell the guy that wants to drive "cat-file --batch".

So this whole thing somehow starts to smell like a solution that is
looking for a problem that has arisen only because the use case
story behind it is screwy.  Again, why is it such a huge problem to
make it relative and ask a newly formlated question for the guy who
is driving "cat-file --batch" in the first place?
