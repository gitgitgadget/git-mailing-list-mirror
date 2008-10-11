From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] "git diff <tree>{3,}": do not reverse order of arguments
Date: Sat, 11 Oct 2008 04:29:09 -0700
Message-ID: <7vwsgfjrp6.fsf@gitster.siamese.dyndns.org>
References: <1223690175.2828.26.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Sat Oct 11 13:30:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kocg6-0001bS-Bm
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 13:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbYJKL3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 07:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbYJKL3X
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 07:29:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42970 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbYJKL3W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 07:29:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0BD9489409;
	Sat, 11 Oct 2008 07:29:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A927E893FE; Sat, 11 Oct 2008 07:29:11 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D9BCB024-9787-11DD-B2FD-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97971>

Matt McCutchen <matt@mattmccutchen.net> writes:

> diff --git a/builtin-diff.c b/builtin-diff.c
> index 35da366..9c8c295 100644
> --- a/builtin-diff.c
> +++ b/builtin-diff.c
> @@ -177,10 +177,8 @@ static int builtin_diff_combined(struct rev_info *revs,
>  	if (!revs->dense_combined_merges && !revs->combine_merges)
>  		revs->dense_combined_merges = revs->combine_merges = 1;
>  	parent = xmalloc(ents * sizeof(*parent));
> -	/* Again, the revs are all reverse */
>  	for (i = 0; i < ents; i++)
> -		hashcpy((unsigned char *)(parent + i),
> -			ent[ents - 1 - i].item->sha1);
> +		hashcpy((unsigned char *)(parent + i), ent[i].item->sha1);
>  	diff_tree_combined(parent[0], parent + 1, ents - 1,
>  			   revs->dense_combined_merges, revs);
>  	return 0;

Interesting.

Somehow 0fe7c1d (built-in diff: assorted updates., 2006-04-29) thought
that setup_revisions() give the ent[] list in reverse order.  This was a
thinko.  I somehow thought that setup_revisions() queued the revs in
reverse back then, and kept that misconception to this day, so I had to
look it up in the history.  It (meaning, the callchain from
setup_revisions to add_object) never did.

Perhaps the thinko was caused by discrepancy between the way internal
revision parser handles A..B and the way git-rev-parse parses it.  While
the internal revision parser parses it into "A ^B", rev-parse gives them
in reverse order, i.e. "B ^A" (which is not going to change).  In any
case, thanks for spotting this.

> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 1a6b522..fe6080d 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -258,6 +258,7 @@ diff --patch-with-stat -r initial..side
>  diff --patch-with-raw -r initial..side
>  diff --name-status dir2 dir
>  diff --no-index --name-status dir2 dir
> +diff master master^ side

As "diff master master^ side" would mean "the tip of master was made by
merging side into it, show that tip of master like 'git show' does", I
think this makes sense.
