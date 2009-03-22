From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Respect core.autocrlf when preparing temporary files for
 external diff
Date: Sun, 22 Mar 2009 00:18:33 -0700
Message-ID: <7v63i281py.fsf@gitster.siamese.dyndns.org>
References: <cover.1237635609u.git.johannes.schindelin@gmx.de>
 <8cb424b16f21164ddc26d0be3f6f7727254b3506.1237635609u.git.johannes.schindelin@gmx.de> <7vocvuekjb.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903220053260.10279@pacific.mpi-cbg.de> <7v8wmybf06.fsf@gitster.siamese.dyndns.org> <7vzlfe9ynj.fsf@gitster.siamese.dyndns.org> <20090322061046.GA14765@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 22 08:22:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlI0l-00047y-Dy
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 08:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbZCVHSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 03:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752142AbZCVHSo
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 03:18:44 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43808 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbZCVHSn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 03:18:43 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 257FF8719;
	Sun, 22 Mar 2009 03:18:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3A16A8717; Sun,
 22 Mar 2009 03:18:35 -0400 (EDT)
In-Reply-To: <20090322061046.GA14765@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 22 Mar 2009 02:10:46 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AAFD4222-16B1-11DE-BFF7-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114127>

Jeff King <peff@peff.net> writes:

> ...how expensive is the check for convert_to_working_tree? It should
> just be a gitattributes lookup, shouldn't it? Which:
>
>   a. we are doing anyway and caching
>
>   b. which takes a fraction of a second (try "time git ls-files | git
>      check-attr --stdin diff >/dev/null", which should give a
>      worst-case).

Ok.  Although I already queued the removal to 'pu' for tonight's pushout
and it is way too late to revert that, I think I didn't have to remove the
function.  The codepath that lets you cheat by borrowing from the checkout
runs convert_to_git() when it borrows, and if you are seeing a meaningful
optimization even with that overhead, perhaps it would be worth keeping.

There is another check that should be there but is missing from the
current implementation of reuse_worktree_file(), other than the "is
convert_to_working_tree() a no-op for this path?" check.  The last check
in the function would say "Yeah, we can reuse it" if the ce is marked
"assume unchanged"; we do not want to blindly reuse the file from the work
tree in that case.

> Anyway, I was planning to make a patch to always feed textconv the
> _clean_ version of each file. My thinking was:
>
>   1. Then tools get a consistent view of the data across platforms.
>      I.e., my textconv munger or external diff script will work no
>      matter what you think the working tree should look like.
>
>   2. The tool may want the clean version, or it may want the smudged
>      version. Or it may be able to operate on either. If we give it a
>      format it doesn't like, it will have to undo whatever we did.
>
>      For most cases, we start with the clean file (i.e., from a tree or
>      from the index).  If we hand out the clean file and the script
>      doesn't like it, it pays the cost to smudge once. If we hand it the
>      smudged file and the script doesn't like it, we pay the cost to
>      smudge _and_ the script pays the cost to clean.

While the purist in me says #1 above is the right argument to make for
feeding "clean" version, I suspect that the textconv or extdiff tools more
often are not made from scratch and ported across platforms than are
cobbled up together out of tools the script writer finds on his platform.
I suspect that Dscho's "a tempfile should look like a checkout" would be
much friendlier to them in practice for this reason.

> For some reason, with your patch the tempfiles are created with mode
> 0005 for me (whereas they are usually 0505), which makes open() in the
> called script unhappy.  Looking over the patch text, though, I have no
> idea what change could be causing that.

Neither 0005 nor 0505 sounds correct to me; shouldn't they be 0600 or
something like that?
