From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git reset --hard gives clean working tree
Date: Thu, 11 Feb 2016 10:49:58 -0800
Message-ID: <xmqqy4arw089.fsf@gitster.mtv.corp.google.com>
References: <Message-Id=xmqqio26nqk8.fsf@gitster.mtv.corp.google.com>
	<1455207366-24892-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Thu Feb 11 19:50:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTwJh-0007eN-OK
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 19:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbcBKSuG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2016 13:50:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63633 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751631AbcBKSuD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Feb 2016 13:50:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5ABEE40390;
	Thu, 11 Feb 2016 13:50:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tel23a5Elq9W
	q1ihMD+afts08Po=; b=Ja8Guq4nJvp8M03r5YLC6YtabmgxHvzygKxnu8jiQq5Z
	LWZGcDQlywF4h2deH7/qRtbyaICh0f+Hi5u5C48mxngJuzdJfKPS15XkjXFdPOxL
	PyheIyx/GyCS4bNPEVxwvBopNJN4DNLhrIntaCfYywOPcG7Hygy+ivbGh35+DYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PNQQ8a
	FCfNQUpJxYhPE3fYvGtn6zm9mD+pXq3OgK3PB4tdLzHEj9gnnC8ztdE2jZg9/SCF
	VJKhhh+Juxnf588zNHJETiKEtsOhOc7qwDAPe2K8WhdyxC47NhVdIZKRnKcLnfKn
	Lz5GJjTY10vUh7kctC/eDQTBa4ajqU+PBKcBA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DC2894038D;
	Thu, 11 Feb 2016 13:50:01 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 238714038A;
	Thu, 11 Feb 2016 13:50:00 -0500 (EST)
In-Reply-To: <1455207366-24892-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Thu, 11 Feb 2016 17:16:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 40BE61A6-D0F0-11E5-B3F9-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285989>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> We define the working tree file is clean if either:
>
>   * the result of running convert_to_git() on the working tree
>     contents matches what is in the index (because that would mean
>     doing another "git add" on the path is a no-op); OR
>
>   * the result of running convert_to_working_tree() on the content
>     in the index matches what is in the working tree (because that
>     would mean doing another "git checkout -f" on the path is a
>     no-op).
>
> Add an extra check in ce_compare_data() in read_cache.c, and adjust
> the test cases in t0025:
> When a file has CRLF in the index, and is checked out into the workin=
g tree,
> but left unchabged, it is not normalized at the next commit.
> Whenever the file is changed in the working tree, a line is added/del=
eted
> or dos2unix is run, it may be normalized at the next commit,
> depending on .gitattributes.
>
> This patch is a result of a longer discussion on the mailing list,
> how to fix the flaky t0025.

Currently, the codepaths that want to stop if it would lose
information from the index and/or the working tree for the path run
an equivalent of "diff-files path" to see there is any difference.
This indeed is overly strict for a path that has contents in the
index that wouldn't have been created by "clean" conversion (I am
using this word to mean anything convert_to_git() does, not limited
to the "clean" filter).

And it is sensible to allow them to proceed if the contents in the
working tree file for the path match what would be created by
"smudge" conversion of the contents in the index.

But breaking "diff-files" is not the right way to do so.  Teaching
"Am I safe to proceed" callers that paths that do not pass
"diff-files" test may still be safe to work on is.

I did not continue the approach I illustrated because I realized and
finally convinced myself that touching ce_compare_data() is a wrong
solution--it breaks "diff-files".

Imagine if you have contents in the index that wouldn't have been
left by a "clean" conversion of what is in the working tree.  You
then run "git checkout -f".  Now the contents in the working tree
will still not convert back to what is in the index with another
"clean" conversion, but it should pass the "Am I safe to proceed"
check, namely, it matches what convert_to_worktree() would give.

But imagine further what would happen when you add an extra blank
line at the end of the file in the working tree (i.e. "echo >>file")
and then run "diff-files -p".

The illustration patch I gave broke "diff-files" in such a way that
before such an addition of an extra blank line, it would have said
"No changes".  And if you run "diff-files" after adding that extra
blank line, you will see whole bunch of changes, not just the extra
blank line at the end.

This is sufficient to convince me that the approach is broken.

The stolen code from me to do the reverse conversion and comparison
may still be reusable, but it should not go to ce_compare_data().
Such a path that has contents in the index that does not match what
"clean"-ing the working tree contents would give us _must_ remain
dirty and return DATA_CHANGED to ie_modified().

I think the right approach to solve this (assuming that this is
worth solving, which I am yet not sure) would go like this:

 * Allocate an extra bit in options passed to ie_match_stat().  When
   this bit is set, allow it to perform the "Smudge the contents in
   the index and compare it with the working tree contents" check
   and declare "You can proceed, nothing will be lost by touching
   the working tree", but never mark the cache entry up-to-date
   while doing so.

 * Pass the flag from callers that want this semantics,
   e.g. verify_uptodate() in unpack-trees.c, but not from
   "diff-files".

It probably is necessary to enable the new behaviour _only_ when a
new command line option explicitly asks for it, because

 - this is rather expensive;

 - this will have to be done for pretty-much all dirty paths, not
   just the ones that the additional reverse test would declare
   clean;

 - most normal people would not have such a broken data in the
   index;

 - those who has such a broken data would want to "fix" the data in
   the index as a tree-wide flag day correction event, after which
   they do not want to pay the penalty of doing this reverse
   comparison check all the time; and

 - requiring an explicit command line option is not a burden when
   the user _does_ want to do such a one-time "fix".
