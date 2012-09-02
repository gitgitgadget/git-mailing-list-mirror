From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] Add git-check-ignores
Date: Sun, 02 Sep 2012 13:38:41 -0700
Message-ID: <7v1uikgnnp.fsf@alter.siamese.dyndns.org>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
 <1346544731-938-10-git-send-email-git@adamspiers.org>
 <CACsJy8CLzTddPOCzGhNkOGYjTvEtgWFoD+6DLhAew4Rf1aw5WA@mail.gmail.com>
 <CAOkDyE9wPUOwJpeKQ5wSCoufqyqE9zwRuBuNvDGEZ-z8452DwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git list <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 22:44:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8H2O-00008J-7R
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 22:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925Ab2IBUoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Sep 2012 16:44:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35586 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754900Ab2IBUop (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2012 16:44:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACB598332;
	Sun,  2 Sep 2012 16:44:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=7BXBOTqBVBocKa8zHskOB/OzBYI=; b=SvZf2ZxudGl+c67MIOap
	/TC5Ew3VgctO6RHNAgrICWI6zy7e/mp71L4nSIcOmC9XOORFFnAEzv15/EdQHYX+
	Cr7wEo/0U2Q8nBXDo09SB0ai682h631RIykjvQohCkMKOOk8DZzkmML5K31orkM3
	qm6mSvSxLk6ya5HwST4Bpmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=VoiIKRimyvySy7LrNP8xXWLpy+eGqkhR8t8iUAl/OAsQWR
	VDrymD8QDWQjFe4eM16VHlhnpf9LXahp/0qow/eFxRW+ETN5VWsZSH48Q2F49BTu
	5Uj7EnQ0aFDV8uT2wD3vfCBaJaXmofpg6wHcK6gsssvqDFdz27fnBuoCxj8+U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 974468331;
	Sun,  2 Sep 2012 16:44:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C894C8330; Sun,  2 Sep 2012
 16:44:43 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 067AF2D8-F53F-11E1-8424-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204672>

Adam Spiers <git@adamspiers.org> writes:

>>> +SYNOPSIS
>>> +--------
>>> +[verse]
>>> +'git check-ignore' pathname...
>>> +'git check-ignore' --stdin [-z] < <list-of-paths>
>>
>> Also --quiet option, where check-ignore returns 0 if the given path is
>> ignored, 1 otherwise?

I agree that multiple paths are problematic.

We could error out if multiple paths are given with --quiet until we
figure out what the useful result would be in such a case, and still
give a useful answer to callers that feed a single path, though.

That may encourage suboptimal coding to casual Porcelain writers,
i.e. it would allow

	for path in $paths
        do
		if git check-ignore -q "$path"
                then
			do something to "$path"
		fi
	done

even though we would rather want to encourage

	git check-ignore --name-only $paths |
        while read path
        do
		do something to "$path"
	done

But from lay-scriptors' point of view, being able to easily write a
script (even though it may be inefficient) to do the job at hand is
far better than having to give up writing one because the tool does
not allow easy-and-stupid scripting, so it is not exactly a huge
downside.

>>  - If many paths are given, then perhaps we could print ignored paths
>> (no extra info).
>
> How is this different to git ls-files -i -o ?

I personally think the parts of ls-files that deal with paths not in
the index outlived its usefulness ;-) and users deserve to be given
a better UI.

>>  - Going to the next level, we could print path and the the location
>> of the final exclude/include rule (file and line number).
>
> That's the current behaviour, and I believe it covers the most common
> use case.

Yes; I have a reservation on your output format, though.

>>  - For debugging, given one path, we print all the rules that are
>> applied to it, which may help understand how/why it goes wrong.

I do not think that would be terribly useful.  Maybe for people who
are learning how dir.c internally works, but not for people who are
trying to improve the set of .gitignore files in their project.

> I thought about that, but in the end I decided it probably didn't make
> sense, because none of the exclude matching routines match against the
> index - they all match against the working tree and core.excludesfile.
> This would also require changing the matching logic to honor the index,
> but I didn't see the benefit in doing that, since all operations which
> involve excludes (add, status, etc.) relate to a work tree.

The mechanism primarily is to see if a path in the working tree is a
cruft or a valuable still to be added; I am OK with NEED_WORK_TREE;
when we have a useful case to run this in a bare repository, we can
lift it.

As with the "what to do with multiple paths and -q", it is better to
start with feature set to cover only the known or easily anticipated
use cases, rejecting the cases for which good semantics are not
thought out.

An alternative would be a code that operates sanely only for known
or anticipated cases and do random things with irrational semantics
in other cases, and people start relying on the irrational behaviour
without realizing their input and the behaviour they are seeing are
not something that the feature is designed to for, but whatever the
code with loose precondition checking happens to do.  We do not want
to repeat that kind of mistake, which is hard to fix in future
versions.
