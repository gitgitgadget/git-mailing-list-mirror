From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow combined diff to ignore white-spaces
Date: Sat, 02 Mar 2013 23:45:57 -0800
Message-ID: <7v38wdc4ei.fsf@alter.siamese.dyndns.org>
References: <1362236658-17200-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 03 08:46:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UC3d0-0004ry-SC
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 08:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526Ab3CCHqC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 02:46:02 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39203 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233Ab3CCHqA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 02:46:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E354490AA;
	Sun,  3 Mar 2013 02:45:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IvQfOTUWGKNmz30vxxwsx89iRCQ=; b=GKthPj
	azsV3fREBSacz62AKyDaeJYga4OvwUHU1PFWYNUs4ZuS7TJHBkVxrZGXGPYs6aqD
	NfV3wGxmZtSXI/kvj/FdlAaqYydRDETFDpNBBA494ZgTJcAZoH8AZok0P1klMkZJ
	3nO8KIIxpVnDUFCcLTmK4YJ0hwXayUHQ6SE0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zf77v39NFOc9OBPG+0pHrQnkR6KucYqQ
	4vh+WbHM8Xil9yHwng8vVB8NHlan3zuhEL8a1ZQBZw5yNNvxiE5EVPeaY1RK4mzz
	BYSz/eGjA6S4i3jw3iWtIODyI5et4gZCefvuxgJ17rMWwUXuHX/EtO9otlOUxuDC
	QaQ8lFrXlwQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D82E490A9;
	Sun,  3 Mar 2013 02:45:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 160B590A7; Sun,  3 Mar 2013
 02:45:58 -0500 (EST)
In-Reply-To: <1362236658-17200-1-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Sat, 2 Mar 2013 16:04:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 638D4392-83D6-11E2-9D1D-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217341>

Antoine Pelisse <apelisse@gmail.com> writes:

> Currently, it's not possible to use the space-ignoring options (-b, -w,
> --ignore-space-at-eol) with combined diff. It makes it pretty impossible
> to read a merge between a branch that changed all tabs to spaces, and a
> branch with functional changes.
>
> Pass diff flags to diff engine, so that combined diff behaves as normal
> diff does with spaces.
>
> It also means that a conflict-less merge done using a ignore-* strategy
> option will not show any conflict if shown in combined-diff using the
> same option.
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---
> That should be reviewed carefully as I'm not exactly sure that does make
> sense with the way combined-diff works.
> Still it seems natural to me to be able to remove the space in combined
> diff as we do with normal diff. Especially as I unfortunately have to
> deal with many space + feature merges that are very hard to analyze/handle
> if space differences can't be hidden.

Assuming "That" at the beginning of the off-line comment refers to
"this patch", I actually I do not think this patch needs to be
reviewed carefully at all.

The change in your patch to make the internal pairwise diff to
ignore whitespaces is an obvious and a sensible first step for your
stated goal.  With it, a block of lines where the postimage makes no
change other than whitespace changes from one parent and matches
with the other parent will see no hunks in either of the pair-wise
diff, and such a hunk will not appear in the final output, which is
exactly what you want.

What needs to be audited carefully is the part of combine diff logic
that this patch does *not* touch.

An example.  After collecting pairwise diffs between the shared
postimage and individual parents, we align the hunks and coalesce
"identical" preimage lines to form shared "-" (removed) lines.  I
think that step is done with byte-for-byte comparison.  If the
postimage removes a line from one parent and a corresponding line
from another parent, and if these corresponding lines in the parents
differ only by whitespaces in a way the user told us to ignore with
-b/-w/etc., you would need to tweak the logic to coalesce
corresponding "lost" lines in the append_lost() function. Otherwise,
you will see two " -" and "- " lines that remove these corresponding
lines from the parents that are identical when you ignore
whitespaces.

You should add some tests; it would help you think about these
issues through.

For example, in this history:

       git init
       seq 11 >ten
       git add ten
       git commit -m initial

       seq 10 | sed -e 's/6/6 six/' -e 's/2/2 two/' >ten
       echo 11 >>ten
       git commit -m ten -a

       git checkout -b side HEAD^
       seq 10 | sed -e 's/^/  /' | sed -e 's/2/2 dos/' >ten
       echo 11 >>ten
       git commit -m indent -a

       git merge master

       seq 10 | sed -e 's/5/5 go/' -e 's/2/2 dois/' >ten
       git commit -m merged -a

one side indents the original and tweaks some lines, while the other
side tweaks some other lines without reindenting.  Most notably, the
fifth line on one side is "5" while on the other side is "  5", and
this line is rewritten to "5 go" in the final.  The lost lines are
not coalesced to a single "-- 5" (nor "--   5") but shows that two
preimages were different only by whitespaces.  Compare that with
what happens to the final line "11" that gets lost in the result.

Thanks.

> Cheers,
> Antoine
>
>  combine-diff.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/combine-diff.c b/combine-diff.c
> index 35d41cd..7ca0a72 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -215,7 +215,7 @@ static void combine_diff(const unsigned char *parent, unsigned int mode,
>  			 struct sline *sline, unsigned int cnt, int n,
>  			 int num_parent, int result_deleted,
>  			 struct userdiff_driver *textconv,
> -			 const char *path)
> +			 const char *path, long flags)
>  {
>  	unsigned int p_lno, lno;
>  	unsigned long nmask = (1UL << n);
> @@ -231,7 +231,7 @@ static void combine_diff(const unsigned char *parent, unsigned int mode,
>  	parent_file.ptr = grab_blob(parent, mode, &sz, textconv, path);
>  	parent_file.size = sz;
>  	memset(&xpp, 0, sizeof(xpp));
> -	xpp.flags = 0;
> +	xpp.flags = flags;
>  	memset(&xecfg, 0, sizeof(xecfg));
>  	memset(&state, 0, sizeof(state));
>  	state.nmask = nmask;
> @@ -962,7 +962,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
>  				     elem->parent[i].mode,
>  				     &result_file, sline,
>  				     cnt, i, num_parent, result_deleted,
> -				     textconv, elem->path);
> +				     textconv, elem->path, opt->xdl_opts);
>  	}
>
>  	show_hunks = make_hunks(sline, cnt, num_parent, dense);
> --
> 1.7.9.5
