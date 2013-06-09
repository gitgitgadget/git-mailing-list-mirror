From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: add --ignore-blank-lines option
Date: Sun, 09 Jun 2013 13:07:52 -0700
Message-ID: <7vsj0roxnr.fsf@alter.siamese.dyndns.org>
References: <7v61xt7gej.fsf@alter.siamese.dyndns.org>
	<1370724291-30088-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 22:08:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlluC-0006e7-Ua
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 22:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036Ab3FIUH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 16:07:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48528 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822Ab3FIUH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 16:07:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5783925AD2;
	Sun,  9 Jun 2013 20:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=32RRzmFGZmO5p6+KNSIIeNpRUm4=; b=oTHPLP
	dEjdrBAUJnrxI7QgitndGYh7cr6niHIVh3QlMwd1u2mQysO45Iz8kqHyJXq5vkzf
	3kDmRicILI/vmgIhu0gI1hiJft24gROKyF8WV5uCyc7zCgQ4FfxNukC6U+gH4zHK
	3ZlzHUBxzUK0SLy8wU/1ZDkHjB3ENPC63t2/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aPcL7ty/qXb9VT1j01jRaTOzkbZJPZ8R
	RNc8mFn/le4zUUB8OOqmfwsPtE0F+ASd4fziMX6AOGLo6Z/mpTg09uYOqLp0uEnC
	dvPrURcdIaMuwFRQGwQ4nXbWajS/q4+Nzf0WXsVPpzthFZoSRvXaamBSaOkZDvHj
	a9tYJoU6nO8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C12425AD1;
	Sun,  9 Jun 2013 20:07:55 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80F7C25ACE;
	Sun,  9 Jun 2013 20:07:54 +0000 (UTC)
In-Reply-To: <1370724291-30088-1-git-send-email-apelisse@gmail.com> (Antoine
	Pelisse's message of "Sat, 8 Jun 2013 22:44:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 454D8998-D140-11E2-902F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227161>

Antoine Pelisse <apelisse@gmail.com> writes:

> The goal of the patch is to introduce the GNU diff
> -B/--ignore-blank-lines as closely as possible. The short option is not
> available because it's already used for "break-rewrites".
>
> When this option is used, git-diff will not create hunks that simply
> adds or removes empty lines, but will still show empty lines
> addition/suppression if they are close enough to "valuable" changes.
>
> There are two differences between this option and GNU diff -B option:
> - GNU diff doesn't have "--inter-hunk-context", so this must be handled
> - The following sequence looks like a bug (context is displayed twice):
>
>     $ seq 5 >file1
>     $ cat <<EOF >file2
>     change
>     1
>     2
>
>     3
>     4
>     5
>     change
>     EOF
>     $ diff -u -B file1 file2
>     --- file1	2013-06-08 22:13:04.471517834 +0200
>     +++ file2	2013-06-08 22:13:23.275517855 +0200
>     @@ -1,5 +1,7 @@
>     +change
>      1
>      2
>     +
>      3
>      4
>      5
>     @@ -3,3 +5,4 @@
>      3
>      4
>      5
>     +change

Yes, this is a bug in the previous round, and the approach I
outlined in the previous message was also designed to address it by
coalescing adjacent hunks by measuring the distance correctly.

> Actually it doesn't quite work like that because we don't totally ignore
> "blank lines". We want to keep them if they are close enough to other
> changes.

A new test vector in your patch is a good illustration of this.

> +test_expect_success 'ignore-blank-lines: after change' '
> +	test_seq 7 >x &&
> +	git update-index x &&
> +	cat <<-\EOF >x &&
> +	change
> +	1
> +	2
> +
> +	3
> +	4
> +
> +	5
> +	6
> +	7
> +
> +	EOF

The test makes the original with 1 thru 7 to the above shape.  The
argument for the behaviour in this patch is that additions of these
new blank lines are close enough to the real change of inserting the
first line with "change".  

If you are not interested in changes in additions of blank lines (by
the way, do we also handle deletions and do your new tests check
them?), one could however argue that the user would want not to see
the addition of the blank between 4 and 5 or after 7.

At first glance, it seems impossible to express that if we need to
show three lines of context, in other words, this output

	@@ -1,2 +1,3 @@
	+change
         1
         2

cannot be a correct patch output --ignore-blank-lines-change output
because it does not show enough context lines after the real change
(we want 3 lines).
 
However, let's step back and think what other ignore blank options do.

When any ignore blank option is used, there will be lines that
actually has changes (hence should be shown with +/-) but we
deliberately ignore their changes (hence, if they ever appear in the
hunk, they do so as context lines prefixed with SP not +/-).  When
we do so, we show the lines from the postimage in the context.

So in that sense, showing this would actually be acceptable (the
last postcontext line in this hunk is a blank line).

	@@ -1,3 +1,4 @@
	+change
         1
         2
	  

We are showing the new blank line the change added after 2 as a
shared context, following the same principle to show from the
postimage when we turned a line with a real change into a
non-change.

> +	git diff --inter-hunk-context=100 --ignore-blank-lines >out.tmp &&
> +	cat <<-\EOF >expected &&
> +	diff --git a/x b/x
> +	--- a/x
> +	+++ b/x
> +	@@ -1,7 +1,10 @@
> +	+change
> +	 1
> +	 2
> +	+
> +	 3
> +	 4
> +	+
> +	 5
> +	 6
> +	 7
> +	EOF
> +	compare_diff_patch expected out.tmp
> +'

And from that point of view, this expected output may be excessively
noisy.

So I dunno.
