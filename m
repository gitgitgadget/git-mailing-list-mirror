From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/9] t6111: new TREESAME test set
Date: Mon, 06 May 2013 13:36:23 -0700
Message-ID: <7v1u9jrgl4.fsf@alter.siamese.dyndns.org>
References: <1367767977-14513-1-git-send-email-kevin@bracey.fi>
	<1367767977-14513-4-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Mon May 06 22:37:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZS9Z-0007EM-Pd
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 22:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757293Ab3EFUg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 16:36:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36925 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756691Ab3EFUg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 16:36:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B63D41C7F5;
	Mon,  6 May 2013 20:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M/73jRuDpufeJDcTL9PHJCD/X+E=; b=Lfxzgd
	Bs7i6Trpj4x5tICS7MPc8p0n+8S95elQHyvafK+bti2McFwHj+4IusCHzdojdfum
	sx0Q/T+p4W42FG1sCxbSc2vC7ZG1NauXiFeyBtI0D1TgbH7DgukIwx/d5zxD4Ffm
	XHUcHX4KGKqj5kjDEissLOnDht0qErzDNfV2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fSTq5pQFygJ6/bgtlwzxROIh9JA/sWuf
	R6q7X/79hAsChto6I8iiPqUarHmJ71AYHYyVEQAf6Y9qzd+tZYPJ6AJeYi09OOI1
	6uNWAqGfhbPaf/LBF5yh6LghiHRHVXwq1W30MvlCqsN+INMBvD5fuXJFXtYaAb4o
	tCgfIJtALUc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD5021C7F4;
	Mon,  6 May 2013 20:36:25 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4C621C7F1;
	Mon,  6 May 2013 20:36:24 +0000 (UTC)
In-Reply-To: <1367767977-14513-4-git-send-email-kevin@bracey.fi> (Kevin
	Bracey's message of "Sun, 5 May 2013 18:32:51 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9EA01480-B68C-11E2-A377-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223502>

Kevin Bracey <kevin@bracey.fi> writes:

> +#        ,---E--.   *H----------.             * marks !TREESAME parent paths
> +#       /        \ /             \*
> +# *A--*B---D--*F-*G---------K-*L-*M
> +#   \     /*       \       /
> +#    `-C-'          `-*I-*J
> +#
> +# A creates "file", B and F change it.
> +# Odd merge G takes the old version from B.
> +# I changes it, but J reverts it.
> +# H and L both change it, and M merges those changes.
> + ...
> +# Odd merge G drops a change in F. Important that G is listed in all
> +# except the most basic list. Achieving this means normal merge D will also be
> +# shown in normal full-history, as we can't distinguish unless we do a
> +# simplification pass. After simplification, D is dropped but G remains.
> +check_result 'M L K J I H G F E D C B A'

OK.

> +check_result 'M H L K J I G E F D C B A' --topo-order

OK.

> +check_result 'M L H B A' -- file

OK.

> +check_result 'M L H B A' --parents -- file

OK.

> +check_outcome failure 'M L J I H G F D B A' --full-history -- file # drops G

This breaks the promise that full history at least gives a connected
graph.

> +check_result 'M L K J I H G F D B A' --full-history --parents -- file

And it is saved by --parents; the "(parents)commit" notation may
make it easier to read the above two tests.

> +check_outcome failure 'M H L J I G F B A' --simplify-merges -- file # drops G

The hsitory simplify merges gives ought to be a full history that
keeps any commit that locally touches the specified path, so keeping
I and J even though they do not contribute to the end result is
correct.  The path in question is the same between G and B, but
again, F should be shown because it should be in the full history.

Even though E simplifies down to B, making G a merge between B and F
(the former is an ancestor of the latter), G is kept, because...?

Because the path at B and F are different?

I have to wonder what should happen if D makes path different from B,
and then F makes path the same as B.  B and F should still be kept.

So "because the path at B and F are different" is not the reason why
we keep G.  How do we decide why G must be kept?

> +check_result 'M L K G F D B A' --first-parent
> +check_result 'M L G F B A' --first-parent -- file

OK.

> +# Check that odd merge G remains shown when F is the bottom.

I did not have a chance to say this when you responded in the
previous round with that "bottom" thing before you sent this new
round, but I am not sure if it is a good idea to pay special
attention to the "bottom"-ness.  Very often, instead of running "git
log -- path" and stopping when seeing enough by killing the pager,
people run "git log HEAD~200.. -- path" to pick "recent enough"
commits, but the number 200 is very much arbitrary.

> +check_result 'M L K J I H G E' F..M

OK.

> +check_result 'M H L K J I G E' F..M --topo-order

OK.  But a note about style: options should come before revision
ranges.

> +check_result 'M L H' F..M -- file

OK.  It is still one possible history to explain what we have in the
path at the end.

> +check_result 'M L H' F..M --parents -- file # L+H's parents rewritten to B, so more useful than it may seem

OK.

> +check_outcome failure 'M L J I H G' F..M --full-history -- file # drops G

G is same as E which is in the graph (F and B are the boundaries of
the history, and F is no special than B in that regard).  You want
to show a merge that is different from at least one parent (as
opposed to showing only when it is different from all parents), so
you want to show G.  OK.

> +check_result 'M L K J I H G' F..M --full-history --parents -- file

OK.

It almost makes me suspect that the --full-history option should
flip revs->rewrite_parents on (but not revs->print_parents, unless
the --parents option asks us to) when the option is parsed.

> +check_outcome failure 'M H L J I G' F..M --simplify-merges -- file # drops G

The same as the "--full-history without --parents" before.

> +check_result 'M L K J I H G' F..M --ancestry-path
> +check_outcome failure 'M L J I H G' F..M --ancestry-path -- file # drops G

With --ancestry-path, what G does relative to E becomes irrelevant,
because E is not in the F..M graph.  G changes path relative to its
remaining parent F, so it should be shown.  OK.

> +check_result 'M L K J I H G' F..M --ancestry-path --parents -- file

OK.  Again this makes me suspect --ancestry-path should flip
revs->rewrite_parents on.

> +check_result 'M H L J I G' F..M --ancestry-path --simplify-merges -- file

> +check_result 'M L K G' F..M --first-parent
> +check_result 'M L G' F..M --first-parent -- file
> +
> +# Note that G is pruned when E is the bottom, even if it's the same commit list
> +# If we want history since E, then we're quite happy to ignore G that took E.
> +check_result 'M L K J I H G' E..M --ancestry-path

OK.

> +check_result 'M L J I H' E..M --ancestry-path -- file

Because F is outside our graph with --ancestry-path, G does not
bring anything new to path relative to its remaining parent E and
should not be shown.  OK.

> +check_outcome failure 'M L K J I H' E..M --ancestry-path --parents -- file

This fails in what way?  G is shown, because the !treesame with now
irrelevant F comes into play?

> +check_outcome failure 'M H L J I' E..M --ancestry-path --simplify-merges -- file # includes G

Makes me wonder how "--ancestry-path --full-history" would work with
this range and with/without the pathspec.

> +# Should still be able to ignore I-J branch in simple log, despite limiting
> +# to G.
> +check_result 'M L K J I H' G..M
> +check_result 'M H L K J I' G..M --topo-order

OK.

> +check_outcome failure 'M L H' G..M -- file # includes J I
> +check_outcome failure 'M L H' G..M --parents -- file # includes J I

I am not sure if it should be a failure or your expectation is
wrong.  G is outside the graph, so as far as the remainder of the
graph is concerned, J is the sole remaining parent of K and I and J
did change the path in question.  

What makes you think I and J should be excluded in these cases?

Shouldn't the same logic as "--ancestry-path [EF]..M" we saw earlier
apply here?  That is, "-a-p E..M" makes F the sole remaining parent
of G and G does change the path from F so it should be shown, while
"-a-p F..M" makes E the sole parent of G, and G does not change the
path from E, so it should not be shown.

> +check_result 'M L J I H' G..M --full-history -- file
> +check_result 'M L K J I H' G..M --full-history --parents -- file
> +check_result 'M H L J I' G..M --simplify-merges -- file
> +check_result 'M L K J I H' G..M --ancestry-path
> +check_result 'M L J I H' G..M --ancestry-path -- file
> +check_result 'M L K J I H' G..M --ancestry-path --parents -- file
> +check_result 'M H L J I' G..M --ancestry-path --simplify-merges -- file
> +
> +# B..F should be able to simplify the merge D from irrelevant side branch C.
> +# Default log should also be free to follow B-D, and ignore C.
> +# But --full-history shouldn't drop D on its own - without simplification,
> +# we can't decide if the merge from INTERESTING commit C was sensible.
> +check_result 'F D C' B..F
> +check_result 'F' B..F -- file
> +check_outcome failure 'F' B..F --parents -- file # includes D

OK.  --parents should not affect the outcome.

> +check_outcome failure 'F D' B..F --full-history -- file # drops D prematurely

OK.

> +check_result 'F D' B..F --full-history --parents -- file

Again, OK.

> +check_result 'F' B..F --simplify-merges -- file
> +check_result 'F D' B..F --ancestry-path
> +check_result 'F' B..F --ancestry-path -- file

OK.

> +check_outcome failure 'F' B..F --ancestry-path --parents -- file # includes D
> +check_outcome failure 'F' B..F --ancestry-path --simplify-merges -- file # includes D

OK.  "-a-p B..F" makes C outside our graph, and D does not change
the path relative to its sole remaining parent B, so it should not
appear in the result.

> +check_result 'F D' B..F --first-parent
> +check_result 'F' B..F --first-parent -- file

OK.

> +# Any sort of full history of C..F should show D, as it's the connection to C,
> +# and it differs from it.
> +check_result 'F D B' C..F
> +check_result 'F B' C..F -- file

OK, as A is a boundary and its child B changes the path from it.

> +check_result 'F B' C..F --parents -- file

OK.

> +check_outcome failure 'F D B' C..F --full-history -- file # drops D

OK.

> +check_result 'F D B' C..F --full-history --parents -- file
> +check_result 'F D B' C..F --simplify-merges -- file
> +check_result 'F D' C..F --ancestry-path
> +check_outcome failure 'F D' C..F --ancestry-path -- file # drops D

OK. D should not be dropped merely because it is the same with B,
which is now outside our graph "-a-p C..F".

> +check_result 'F D' C..F --ancestry-path --parents -- file
> +check_result 'F D' C..F --ancestry-path --simplify-merges -- file

OK.

> +check_result 'F D B' C..F --first-parent
> +check_result 'F B' C..F --first-parent -- file

OK.  "-f-p C..F" is the same as "-f-p A..F", and C is outside our
graph, so these expectations look sensible.
