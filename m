From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: problem with file named with dash character
Date: Wed, 27 Jun 2012 15:17:54 -0700
Message-ID: <7v7gus7625.fsf@alter.siamese.dyndns.org>
References: <52ae7682-3e9a-4b52-bec1-08ba3aadffc0@office.digitalus.nl>
 <80a7ce17-3ee7-4f09-b984-b6685e163b87@office.digitalus.nl>
 <7vk3ys8v96.fsf@alter.siamese.dyndns.org>
 <20120627195205.GA11700@sigill.intra.peff.net>
 <7vfw9g8pqn.fsf@alter.siamese.dyndns.org>
 <7vbok48pfu.fsf@alter.siamese.dyndns.org>
 <7v4npw8pdo.fsf@alter.siamese.dyndns.org>
 <7vzk7o7am5.fsf@alter.siamese.dyndns.org>
 <7vvcic7a6t.fsf@alter.siamese.dyndns.org>
 <20120627210039.GA2292@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Lyubomirov <daniel@digitalus.bg>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 28 00:18:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sk0Yp-0007gP-7v
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 00:18:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268Ab2F0WR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 18:17:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40299 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932236Ab2F0WR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 18:17:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35C778CD9;
	Wed, 27 Jun 2012 18:17:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xxGxAqywpNXvMVN1inu4P3n1Lbk=; b=kIUnNT
	34O+3ZVFOqJuk12BRQ5lKOBIz8bT3WO/W+eJI5ii99SVgjI/3j0KOdZahUYk7BX1
	bRTglgrwF3KOBWo2RQU62w8N/u0eA0aglWma51zbGj6HG+w7hv/AluGhEBsiNIei
	nJUj3X62jnd0egObob7ml9mXllpqQJFcS84xE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qC6M5UgfZKXRlAeV5LhXHk3EbHHLwBTn
	4OIU2lykprfNCNAyO51pMC5VumsYhlFrErtp4Blli3pDlRj3rZGoWwpevTl5XGO6
	45RURkGfvaRYSU3bMbP6mkjEYyZYMOijmYYeUz7tGqnlJHDP4sy814aUhv6NSmwR
	rkNwPaReeL8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BAE08CD8;
	Wed, 27 Jun 2012 18:17:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 920CC8CD6; Wed, 27 Jun 2012
 18:17:55 -0400 (EDT)
In-Reply-To: <20120627210039.GA2292@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 27 Jun 2012 17:00:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1C3BF1E-C0A5-11E1-BE6A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200766>

Jeff King <peff@peff.net> writes:

> From a cursory look, these definitely go in the right direction. I like
> how the third one was able to rip populate_from_stdin entirely out of
> diff.c.
>
> I suspect we could get by without even the nongit_stdin flag you added;
> the only place which uses it is diff_fill_sha1_info, but theoretically
> we don't even need it there; we could just index_mem the file contents
> we get via diff_populate_filespec, and the stdin contents will
> already be there.

Probably that is a sane thing to do.

And as you hinted, we definitely need to give the "the copy in the
filespec->data is the only one; do not discard until we are really
done with it" semantics to the bit, or introduce a separate bit that
is not necessarily related to the "this came from the standard input"
bit.  I offhand do not know what data source we would later add
that needs such a treatment.  "git diff http://example.com/{foo,bar}",
perhaps?  The "do not discard" bit at that point may need to learn
to swap it out to a temporary file or something when it happens.

> Right now we call index_path for worktree files, but I don't really see
> much point; we have to read the whole data either way, and
> populate_filespec should be mmap-ing them for us.
>
>>  - We say on the "diff --git" header uglyness like "a/-", "b/-";
>>    likewise in the metainfo;
>
> I'd consider changing the path to "/dev/stdin" for this case. It doesn't
> exist on some platforms, of course, but neither does /dev/null, which we
> use similarly.

Sensible.

>>  - We show on the "index" header "0*" value for these entries, even
>>    though we should be able to compute it (after all we do so for
>>    files on disk in a non-git directory);
>
> The index_mem I mentioned above would fix that.

Yes.

>>  - We still apply attributes and textconv as if we are dealing with
>>    a regular file "-" at the root level.
>
> I think that's bad. I wonder if it should have "*" attributes applied to
> it or not. While I can see it being convenient in some cases, I think it
> makes the rules confusingly complex.

It is likely that the crlf conversion on Dos systems wants to be
applied regardless.

This is unrelated to the "standard input confusion" issue, but there
are two more things coming either from the way the no-index code is
done or from the way it is bolted onto git.

With the current code, this:

	mkdir foo bar
        echo hello >foo/1
        echo bye >bar/2
        git diff --no-index foo bar

shows differences between a/foo/1 and b/bar/1, as the no-index code
records foo/1 and bar/1 as the paths in the filespec for them.

But if you are comparing two directory hierarchies, it is a lot more
likely that you would want to see corresponding files in these two
directories.  In other words, the patch is better shown as
differences between a/1 and b/1 (the code makes the core compare
foo/1 and bar/2 after all).  This of course requires no-index to
differentiate the logical pathname (i.e. "this is the path inside
collection a/ (or b/)") and the physical location from which the
contents are read.  Such a differentiation would allow us to also do
renames and rename classifications much more sanely.  We had to add
DIFF_PAIR_RENAME() and filepair->renamed_pair only to support this
codepath because of this misdesign.  We could have just run strcmp()
between the logical pathname of one/two members of the filepair to
see if the pair was renamed if it was done that way.

And the way diff-no-index.c::queue_diff() walks two directories to
grab paths from them in parallel and incrementally means that the
filesystem walking code cannot be reused for something like this:

	git diff master:Documentation /var/tmp/docs

to compare a hierarchy represented with a tree object with another
hierarchy stored in the filesystem outside git's control.  A natural
way to do so would be to grab a set of paths from /var/tmp/docs and
have that set compared against the other set that comes from the tree,
and the "grab a set of paths from /var/tmp/docs" machinery can be
used twice to implement the current

	git diff --no-index /var/tmp/foo /var/tmp/bar

which would have been a lot cleaner implementation.

Oh well.
