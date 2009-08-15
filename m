From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 0/6] {checkout,reset,stash} --patch
Date: Sat, 15 Aug 2009 00:57:06 -0700
Message-ID: <7v4os9v7al.fsf@alter.siamese.dyndns.org>
References: <200908101136.34660.trast@student.ethz.ch>
 <cover.1250164190.git.trast@student.ethz.ch>
 <20090815065125.GA23068@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Pierre Habouzit <madcoder@debian.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 15 10:00:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McEBZ-0005ia-Sj
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 10:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204AbZHOH5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 03:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbZHOH5V
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 03:57:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbZHOH5V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 03:57:21 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CC3C92A869;
	Sat, 15 Aug 2009 03:57:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 333712A867; Sat, 15 Aug 2009
 03:57:07 -0400 (EDT)
In-Reply-To: <20090815065125.GA23068@coredump.intra.peff.net> (Jeff King's
 message of "Sat\, 15 Aug 2009 02\:51\:26 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 431E2526-8971-11DE-B7B9-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125983>

Jeff King <peff@peff.net> writes:

>> reset -p [HEAD]		Reset this hunk? (**)
>> reset -p other		Apply this hunk to index? (**)
>
> This doesn't make sense to me.

Not to me, either.

Let's say you have modified $path and ran "git add $path" earlier.

"reset -p -- $path" and "reset -p HEAD -- $path" both show what your index
has relative to the commit you are resetting your index to and offer to
"Unstage" [*1*].  This is consistent and feels natural.

"reset -p HEAD^ -- $path" however shows the same forward diff (i.e. how
your index is different compared to the commit HEAD^ you are resetting
to), but offers to "Apply".

When a user is resetting to the current HEAD (with or without an explicit
HEAD parameter), it is likely that the user did "git add" earlier and is
trying to reverse the effect of that.  And showing a forward diff makes
sense.  But when a user is resetting to a different commit, it may make
sense to show a reverse diff, saying "Here is a hunk you _could_ choose to
use to bring the current index to a different state, do you want to apply
it to do so?"  Perhaps you meant to show a reverse diff and use the word
"Apply".

However, that would break down rather badly when HEAD did not change $path
since HEAD^.  Logically what the "reset -p" would do to $path is the same,
but the patch shown and the operation offered to the user are opposite.

You could compare HEAD and the commit you are resetting the index to and
see if the path in question is different between the two commits, and
switch the direction---if there is no change, you show forward diff and
offer to "Remove this change out of the index", if there is a change, you
show reverse diff and offer to "Apply this change to the index".  But if
the difference between HEAD and the commit you are resetting to does not
overlap with the change you staged to the index earlier from your work
tree, it is unclear such heuristics would yield a natural feel.

So I actually think you may be better off if you consistently showed a
forward diff (i.e. what patch would have been applied to the commit in
question to bring the index into its current shape), and always offer
"Remove this change out of the index?"

The same comment applies to "checkout -p HEAD" vs "checkout -p HEAD^".
I think the latter shouldn't show a reverse diff and offer "Apply?";
instead both should consitently show a forward diff (i.e. what patch would
have been applied to the commit to bring your work tree into its current
shape), and offer "Remove this change out of the index and the work tree?".

[Footnote]

*1* I actually have a slight problem with the use of word "Unstage" in
this context; "to stage", at least to me, means "adding _from the work
tree_ to the index", not just "modifying the index" from a random source.
The command is resetting the index in this case from a tree-ish and there
is no work tree involved, and the word "stage/unstage" feels out of place.
