From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive: introduce merge_options
Date: Sun, 24 Aug 2008 23:06:06 -0700
Message-ID: <7v7ia5iq7l.fsf@gitster.siamese.dyndns.org>
References: <1219628677-23903-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 08:07:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXVEX-0006FA-6T
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 08:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbYHYGGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 02:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbYHYGGO
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 02:06:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbYHYGGN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 02:06:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D10AF6EA77;
	Mon, 25 Aug 2008 02:06:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0A5E76EA75; Mon, 25 Aug 2008 02:06:08 -0400 (EDT)
In-Reply-To: <1219628677-23903-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Mon, 25 Aug 2008 03:44:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EB75AF5A-726B-11DD-BA21-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93600>

Miklos Vajna <vmiklos@frugalware.org> writes:

> 1) This applies on top of 1c868d4 (merge-recursive.c: Add more generic
> merge_recursive_generic()). I can rebase this (along with 1c868d4 and
> 1c868d4^) on top of current master, if this is a problem.

It probably is cleaner to treat this as a fresh topic from scratch on top
of 'master', as we do not have anything outstanding in 'next' around this
area.

> 2) I know that this patch is huge, but we want to have the verbosity
> flag in merge_options, so it has to be passed as an argument in many
> places.

Size of the patch that results purely from addition of the merge_options
parameter from top to bottom does not bother me too much.  The look quite
straightforward conversions, and getting rid of these many global
variables is a major step in the right direction.

It might however be a good idea to consistently have this at the same
place (either the beginning or at the end) of the parameter list of
functions that take one.

> @@ -1273,10 +1268,11 @@ int merge_recursive(struct commit *h1,
>  		 * "conflicts" were already resolved.
>  		 */
>  		discard_cache();
> -		merge_recursive(merged_common_ancestors, iter->item,
> -				"Temporary merge branch 1",
> -				"Temporary merge branch 2",
> -				NULL,
> +		memcpy(&opts, o, sizeof(struct merge_options));
> +		opts.branch1 = "Temporary merge branch 1";
> +		opts.branch2 = "Temporary merge branch 2";
> +		merge_recursive(&opts, merged_common_ancestors,
> +				iter->item, NULL,
>  				&merged_common_ancestors);
>  		call_depth--;

After suggesting to keep label in merge_options, I was wondering how this
part should be handled the best.  An alternative would be not to do copy
the structure but stash away only branch1 and branch2 members before
making the recursive call and restore them after it returns, like this:

		const char *saved_b1, *saved_b2;
		...
		saved_b1 = o->branch1;
		saved_b2 = o->branch2;
		o->branch1 = "Temporary merge branch 1";
		o->branch2 = "Temporary merge branch 2";
		merge_recursive(o, ...);
		o->branch1 = saved_b1;
		o->branch2 = saved_b2;
		call_depth--;
		...
		
This might be better in the longer run, as we may want to pass *back*
status from merge_recursive() to the caller in fields of merge_options in
the future.
