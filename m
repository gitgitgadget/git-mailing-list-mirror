From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] Make 'unpack_trees()' have a separate source and
 destination index
Date: Fri, 7 Mar 2008 15:13:17 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803071507510.19395@racer.site>
References: <cover.1204856187.git.torvalds@linux-foundation.org> <8676ea8b0313abfc2e0946f45f636643e28aade8.1204856187.git.torvalds@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 15:13:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXdKe-0006vB-0J
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 15:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbYCGONR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 09:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbYCGONR
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 09:13:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:38967 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750960AbYCGONQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 09:13:16 -0500
Received: (qmail invoked by alias); 07 Mar 2008 14:13:15 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp039) with SMTP; 07 Mar 2008 15:13:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/1m7wd1kP1d/Idk33QY6Lu+IuDwAeVNMfeK/+MGb
	5QYOtRYGL7wqaj
X-X-Sender: gene099@racer.site
In-Reply-To: <8676ea8b0313abfc2e0946f45f636643e28aade8.1204856187.git.torvalds@linux-foundation.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76494>

Hi,

On Thu, 6 Mar 2008, Linus Torvalds wrote:

> We will always unpack into our own internal index, but we will take the
> source from wherever specified, and we will optionally write the result
> to a specified index (optionally, because not everybody even _wants_ any
> result: the index diffing really wants to just walk the tree and index
> in parallel).
> 
> This ends up removing a fair number more lines than it adds, for the 
> simple reason that we can now skip all the crud that tried to be 
> oh-so-careful about maintaining our position in the index as we were 
> traversing and modifying it.  Since we don't actually modify the source 
> index any more, we can just update the 'o->pos' pointer without worrying 
> about whether an index entry got removed or replaced or added to.

Nice.  Although you could have done better on the account of remove/add 
ratio if you did not add empty lines ;-)  But then, you removed a few 
curly brackets around single lines, too ;-)

> @@ -221,27 +222,6 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
>  	if ((opts.dir && !opts.update))
>  		die("--exclude-per-directory is meaningless unless -u");
>  
> -	if (opts.prefix) {
> -		int pfxlen = strlen(opts.prefix);
> -		int pos;
> -		if (opts.prefix[pfxlen-1] != '/')
> -			die("prefix must end with /");
> -		if (stage != 2)
> -			die("binding merge takes only one tree");
> -		pos = cache_name_pos(opts.prefix, pfxlen);
> -		if (0 <= pos)
> -			die("corrupt index file");
> -		pos = -pos-1;
> -		if (pos < active_nr &&
> -		    !strncmp(active_cache[pos]->name, opts.prefix, pfxlen))
> -			die("subdirectory '%s' already exists.", opts.prefix);
> -		pos = cache_name_pos(opts.prefix, pfxlen-1);
> -		if (0 <= pos)
> -			die("file '%.*s' already exists.",
> -					pfxlen-1, opts.prefix);
> -		opts.pos = -1 - pos;
> -	}
> -

Was the wholesale removal intentional?  I think there are a few sanity 
checks, and I did not see the checks moved to somewhere else.  But then, 
there could be redundant checks somewhere else that I missed.

> @@ -360,7 +366,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  	if (o->trivial_merges_only && o->nontrivial_merge)
>  		return unpack_failed(o, "Merge requires file-level merging");
>  
> +	o->src_index = NULL;
>  	check_updates(o);
> +	if (o->dst_index)
> +		*o->dst_index = o->result;
>  	return 0;
>  }
>  

I wonder if you should discard_index(o->dst_index) if o->src_index == 
o->dst_index (before you set it to NULL, of course).

I cannot really comment on the rest, since the whole unpack_trees() logic 
was too complicated for me.  Maybe I have a chance after this patch.

Ciao,
Dscho

