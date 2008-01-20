From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Avoid running lstat(2) on the same cache entry.
Date: Sun, 20 Jan 2008 01:48:34 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801200142170.5731@racer.site>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org> <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 20 02:49:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGPJD-0006QI-Ha
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 02:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582AbYATBsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 20:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753334AbYATBsr
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 20:48:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:52581 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752805AbYATBsq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 20:48:46 -0500
Received: (qmail invoked by alias); 20 Jan 2008 01:48:44 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp027) with SMTP; 20 Jan 2008 02:48:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/8VftKi1f8OaC0oOX0eo+ZmXOHo8spDqe/MoWI99
	16J3d4qP689kw8
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0801191709380.2957@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71150>

Hi,

On Sat, 19 Jan 2008, Linus Torvalds wrote:


> Best time before:
> 
> 	[torvalds@woody linux]$ time git commit > /dev/null
> 	real    0m0.399s
> 	user    0m0.232s
> 	sys     0m0.164s
> 
> Best time after:
> 
> 	[torvalds@woody linux]$ time git commit > /dev/null
> 	real    0m0.254s
> 	user    0m0.140s
> 	sys     0m0.112s

Wow.

> I bet you'll see a much bigger performance improvement from this on 
> Windows in particular.

I bet so, too.  Traditionally, filesystem calls are painfully slow on 
Windows.

But I cannot test before Monday, so I would not be mad if somebody else 
could perform some tests on Windows.

Now, the changes you made are quite a ways off of my current knowledge of 
git codepaths, so I cannot really comment.  Although they look sane 
enough.

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
>  int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)

What about do_diff_cache()?  Shouldn't it get exactly the same treatment 
as run_diff_index()?

In which case, do_diff_cache() would not be needed anymore, too.

> diff --git a/unpack-trees.h b/unpack-trees.h
> index 5517faa..197a004 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -25,6 +25,7 @@ struct unpack_trees_options {
>  	int merge_size;
>  
>  	struct cache_entry *df_conflict_entry;
> +	void *unpack_data;

Maybe this should be called "cb_data", in line with similar places in 
git.git?

> diff --git a/wt-status.c b/wt-status.c
> index c0c2472..a18ed11 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -229,7 +229,6 @@ static void wt_status_print_initial(struct wt_status *s)
>  	struct strbuf buf;
>  
>  	strbuf_init(&buf, 0);
> -	wt_read_cache(s);

If I'm not mistaken, you removed all four call sites of wt_read_cache(), 
and it is static anyway, so it should be removed, no?

Ciao,
Dscho "who will try to wrap his head around what read_tree() && 
diff_cache() are supposed to do"
