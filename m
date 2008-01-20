From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Avoid running lstat(2) on the same cache entry.
Date: Sun, 20 Jan 2008 02:42:06 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801200231250.5731@racer.site>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org> <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 20 03:43:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGQ9J-0006e8-7e
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 03:43:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754631AbYATCmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 21:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754376AbYATCmZ
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 21:42:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:50509 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754213AbYATCmY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 21:42:24 -0500
Received: (qmail invoked by alias); 20 Jan 2008 02:42:22 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp008) with SMTP; 20 Jan 2008 03:42:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+KOls3xXKKZuNRiyN5MVAmoR4STSLrMUhnviEP0l
	KLv6biGnjTWfhf
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71153>

Hi,

On Sat, 19 Jan 2008, Linus Torvalds wrote:

> @@ -687,13 +732,20 @@ int run_diff_index(struct rev_info *revs, int cached)
>  	tree = parse_tree_indirect(ent->sha1);
>  	if (!tree)
>  		return error("bad tree object %s", tree_name);
> -	if (read_tree(tree, 1, revs->prune_data))
> -		return error("unable to read tree object %s", tree_name);
> -	ret = diff_cache(revs, active_cache, active_nr, revs->prune_data,
> -			 cached, match_missing);
> +
> +	memset(&opts, 0, sizeof(opts));
> +	opts.head_idx = 1;
> +	opts.index_only = cached;
> +	opts.merge = 1;
> +	opts.fn = oneway_diff;
> +	opts.unpack_data = revs;
> +
> +	init_tree_desc(&t, tree->buffer, tree->size);
> +	unpack_trees(1, &t, &opts);
> +	
>  	diffcore_std(&revs->diffopt);
>  	diff_flush(&revs->diffopt);
> -	return ret;
> +	return 0;
>  }
>

Two problems I see (before I go to bed): match_missing is now ignored, and 
the return value is set to 0, whereas it was the return value of 
diff_cache() before.

The first is easily fixed, by replacing the two "0"s in the calls to 
show_new_file() and show_modified() with "!revs->ignore_merges".  Unless I 
am missing something, of course.

And the second is not _that_ bad, as it seems that diff_cache() has only 
one return statement, and it returns 0, AFAICS.  But it had to be said 
somewhere. 

Ciao,
Dscho
