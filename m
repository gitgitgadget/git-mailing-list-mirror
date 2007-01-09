From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] sha1_name(): accept ':directory/' to get at the cache_tree
Date: Tue, 09 Jan 2007 15:47:01 -0800
Message-ID: <7vodp7iwzu.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701091502030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 00:47:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4QgN-0006Xy-Pr
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 00:47:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbXAIXrE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 18:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbXAIXrE
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 18:47:04 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:49607 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932557AbXAIXrD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 18:47:03 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109234702.QUAZ9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jan 2007 18:47:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9BmB1W0151kojtg0000000; Tue, 09 Jan 2007 18:46:12 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701091502030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 9 Jan 2007 15:03:08 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36429>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	'tis a resend of an earlier patch, but without support for the
> 	bogus ":." as equivalent to ":/".
>
> 	I find this feature highly convenient when I just want to see
> 	what files the index contains.

I do not understand; do you mean ls-files?

In any case, I wonder if this does a sane thing if you asked
"git show :3:t/" on a fully merged index.

> @@ -561,6 +562,23 @@ int get_sha1(const char *name, unsigned char *sha1)
>  			}
>  			pos++;
>  		}
> +		if (namelen > 0 && cp[namelen - 1] == '/')
> +			namelen--;
> +		if (namelen == 0 || (ce && ce_namelen(ce) > namelen &&
> +					ce->name[namelen] == '/' &&
> +					!memcmp(ce->name, cp, namelen))) {

I may be misreading the code, but what does ce point at?  Does
this get the index sort order correctly?  For example, would
this work?

	$ echo >t- && git add t-
        $ git show :t
	$ git show :t/

> +			struct cache_tree *tree =
> +				cache_tree_find(active_cache_tree, cp);
> +			if (!cache_tree_fully_valid(tree)) {
> +				ret = cache_tree_update(active_cache_tree,
> +						active_cache, active_nr, 0, 0);
> +				if (ret < 0)
> +					return ret;

This gracefully errs out when the index is unmerged but fails to
pretend the index knows about trees, if the unmerged part of
index is outside the directory the user specified.

In short, I am not sure if it is worth it, and especially if the
motivation is to pretend as if the index contains trees, I would
be opposed to it.  The index does _not_ contain trees, and
cache-tree is a pure optimization for the next write-tree.
Nothing more.

If it (pretending as if the index contains trees) is just a
means to achieve something else worthy, I would not necessarily
oppose to that goal, but I do not see what it is, and I do not
know if the approach is right...
