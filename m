From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log -g: ignore revision parameters that have no reflog
Date: Wed, 03 Feb 2016 10:32:22 -0800
Message-ID: <xmqqd1sdodah.fsf@gitster.mtv.corp.google.com>
References: <1454241144.2822.7.camel@kaarsemaker.net>
	<1454455961-10640-1-git-send-email-dennis@kaarsemaker.net>
	<xmqqegcuprrw.fsf@gitster.mtv.corp.google.com>
	<1454502958.2713.13.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed Feb 03 19:32:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aR2EA-0005UR-NZ
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 19:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965726AbcBCSc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 13:32:27 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965344AbcBCScZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 13:32:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0AF753E69C;
	Wed,  3 Feb 2016 13:32:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zFtwp0c3i16VLDk+kcrRj/PV+Sw=; b=N+ilZ7
	LT5ZX0Be6au6OvEzMrv3d6axggmY2oQVpJpahvW8ig6tHIXpljDjQREGGacGArlZ
	GFTFl6hOe9VcYy2VxW3SpRBJxb5XvvMNFxpIt4b7cxG1vNHbd7xqXDMT2zHYF3Iv
	fF9ZokZiwayhjy/9Gu6zTl6owV/kPuHwSByPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nQhotkfard1Uu+CDncSn2BRzPZCWs398
	YU5Qkkz2KMDpLBBijOGCBS/1tFxLUwVyABack9Ina9dcgx/Mv5oVcqef/5D/zas9
	EW7IACuBFBX5yKEyqp0SoKAY8uIEorTcJWRwyJUYmsm58ckEHRalClaCudryk4a1
	GZBZTMpEWr4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 01C993E69B;
	Wed,  3 Feb 2016 13:32:24 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7A5AD3E69A;
	Wed,  3 Feb 2016 13:32:23 -0500 (EST)
In-Reply-To: <1454502958.2713.13.camel@kaarsemaker.net> (Dennis Kaarsemaker's
	message of "Wed, 03 Feb 2016 13:35:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 77A1393E-CAA4-11E5-943F-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285372>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> It is not, the code should look for @{, not @.

Not exactly.

    $ git show -s --format='%h %s' 'HEAD^{/@{3}}' --
    55d5d5b combine-diff.c: fix performance problem when folding ...

The commit has a line with a string "@@@" on it and the regular
expression asked for 3 '@', which shows that scanning for "@{" is
not a good way forward--it merely opens another can of worms.

Hopefully by now you have realized that a band-aid to add an ad-hoc
code that second-guesses what the existing code does for real while
parsing the command line is not a good way forward.

Perhaps we may want to step back a bit.

Where is the book-keeping information used for "-g" processing
handled in the codechain?  Upon seeing "-g", the parser calls
init_reflog_walk() to make revs->reflog_info non-NULL.

What are the codepaths that use this field?

We can see the function add_pending_object_with_path() refers to
this revs->reflog_info field, when it calls add_reflog_for_walk(),
with the "name" it receives, after some mangling.

The called function, add_reflog_for_walk(), finds, from an object
and its name, the ref whose log is going to be enumerated.  It looks
at the name, optionally finds '@' in it, and eventually calls the
function read_complete_reflog() [*1*].

We can infer that, by the time it does so, it must have figured out
of which ref it wants to read the reflog.

And it already has calls to die() and a few "return -1" to signal a
non-fatal error to the caller.  Perhaps instead of letting it to
punt and resort to the normal history walking, the code should
realize that some refs do not have reflog (and no non-refs has
reflog) and diagnose it as an error and die()?

Perhaps one of these two functions is a much better place to do your
improvement?  The caller, add_pending_object_with_path(), does some
mangling of "name" that is given by its caller before calling into
the callee, add_reflog_for_walk().  It could be that name mangling
that is leading to a wrong result.  More likely, the way the callee
figures out which ref it needs to read the reflog for given the
"name" may be what you need to fix.

UNLESS we are losing the information we got directly from the user
at the command line before the control is passed down through the
callchain to reach these two functions, that is.  In such a case,
I'd agree that we would need additional checks much closer to the
input.

But I think the callers of this callchain are passing what the user
gave us pretty much verbatim down this callchain, so I would expect
that the leaf callee in this discussion, add_reflog_for_walk(),
would have enough information.


[Footnote]

*1* Yuck.
