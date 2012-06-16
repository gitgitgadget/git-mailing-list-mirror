From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 0/5] git log -L, all new and shiny
Date: Fri, 15 Jun 2012 23:01:13 -0700
Message-ID: <7v1ulf94nq.fsf@alter.siamese.dyndns.org>
References: <cover.1339063659.git.trast@student.ethz.ch>
 <7vlijpchm2.fsf@alter.siamese.dyndns.org> <8762as4sax.fsf@thomas.inf.ethz.ch>
 <7v1ulgd2f5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jun 16 08:01:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sfm4X-00057M-Vi
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jun 2012 08:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884Ab2FPGBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jun 2012 02:01:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59621 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956Ab2FPGBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2012 02:01:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C75BE3FCF;
	Sat, 16 Jun 2012 02:01:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pvtm5gDWlVb2vOy+0IsucMP9y60=; b=AsyMSV
	pZ7jLnR8qdzymQqqoIRblqXYXosxuakFcgpdKzomYDKwUfjyD0W3kB44BdbDIWPV
	uQgP3qHnjbD2FRhYjcdfuM7ZHtHVWft4n3FjbXX+JINM7Vb+osxGSlisB/qrw/eX
	/2PWipzd9oyIUwD/v0WUGMq0oXDhITOPgANFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EuevkzslyR6BgnD1MUs5xlRGzczuVtF9
	871pQqXVqjoS72quoNa1hRrWzVA9UIrt3BloAUAxaolwyY2TtZ+0FYgSZ6acwF8J
	gQDhJTj0KlZA7A+9go40FQ54dQIsOc2YZmX5aOQtajGBzXWXD6eHqtMMw/eJDCtW
	sK0/I+z0Zrw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF1963FCE;
	Sat, 16 Jun 2012 02:01:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08D453FCD; Sat, 16 Jun 2012
 02:01:14 -0400 (EDT)
In-Reply-To: <7v1ulgd2f5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 15 Jun 2012 08:23:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE9051AC-B778-11E1-B46F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200110>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> This would be the first backwards coupling between the revision-walk and
>> the diff generation parts, at least that I know of.
>
> I am not convinced if you need to have any unusual back-coupling to
> begin with, by the way.
>
> If you say "git log -p [--options] -- pathspec", the revision
> machinery does filter commits that do not touch any paths that patch
> pathspec with the TREESAME logic, but that does not necessarily mean
> you will see _all_ the commits that are not TREESAME.

Let's clarify this part a bit.

Imagine you have three commits on a single strand of pearls.

	A---B---C

Between A and B, you only corrected indentation errors in file F as
a clean-up step, and then between B and C, you did a real change.
"git diff A B -- F" gives changes, "git diff -w A B -- F" does not.
Both "git diff B C -- F" and "git diff -w B C -- F" give you some
output.

Now, "git log --no-root -p -w C -- F" will give you C but not B.

Let's see how that happens.

The revision machinery looks at C and finds its parent B.  It runs
object level tree comparison and finds that their trees are
different at path F.  It makes a mental note that it may need to
show the log message of C, and asks the diff machinery to run
diff-tree between B and C.  The diff machinery finds that it needs
to show something even in the presense of -w option by actual
comparison, and just before showing the very first line of patch
output, it shows the log message of C (due to the earlier "mental
note").

Then the revision machinery looks at B.  It does the same between B
and A, but this time around, the diff machinery finds that, even
though A and B were _not_ TREESAME at the revision traversal level,
there is nothing to be shown after filtering with the -w option.
Hence no patch is shown and log message for B is not shown, either.

The interesting part of the above is that we did not bother using
the -w comparison to affect TREESAME check at the revision traversal
level.

I consider your "-L bottom,top" essentially the same "two blobs may
be different at the object name level, but after filtering the diff,
there may be no output" filter just like the "-w" option is.
Instead of filtering hunks that have changes only in whitespaces, it
filters hunks that do not overlap the given line range.  So if you
replace "-w" in the above example with "-L bottom,top", exactly the
same thing should happen.

The current code structure does not consider the content level
filtering done by the "-w" when computing TREESAME.  This DOES
affect how the merges are simplified.  If you and I start from a
commit X with full of indentation mistakes, you fix the earlier half
of these mistakes and make commit T while I fix the later half of
these mistakes and make commit J, and we merge our results into
merge M:

      J---M
     /   /
    X---T

none of "diff -w J M", "diff -w T M", "diff -w X J", "diff -w X T"
will output anything.  "git diff -p -w M" will however traverse both
branches, even though in this example nothing will be shown in the
output, because no two trees in these four commits are TREESAME.  

In the longer term, this _may_ be something we want to fix, but
teaching the revision machinery about only "-L bottom,top" is not
the way to do it.  Instead, we should devise a new mechanism to call
into the diff_patch machinery from the place where the revision
machinery computes TREESAME, and let it ask the filtered content
level differences if any of these options (these flags flip the
DIFF_FROM_CONTENTS diff option) are in use.  As a part of the
implementation of that new mechanism, we may want to cache the patch
such an early comparison produces, and reuse it when we actually
produce output, as an optimization.  But I think that is not limited
to the "-L bottom,top" option and an orthogonal issue, as it will
work equally well for existing "-w" filter (there may be others).

The above is where my recommendations are coming from.  The first
step for "-L bottom,top" should be to hook it as a new kind of
DIFF_FROM_CONTENTS option that compares two non-identical blobs but
possibly yield empty result into the diff machinery at the same
level as "-w".  Once that is solidly done, we can think about
updating the merge simplification logic to take DIFF_FROM_CONTENTS
changes into account when it computes TREESAME.
