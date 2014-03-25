From: Kirill Smelkov <kirr@navytux.spb.ru>
Subject: Re: [PATCH v2 14/19] tree-diff: rework diff_tree interface to be
 sha1 based
Date: Tue, 25 Mar 2014 13:22:15 +0400
Organization: NAVYTUX.SPB.RU
Message-ID: <20140325092215.GB3777@mini.zxlink>
References: <cover.1393257006.git.kirr@mns.spb.ru>
 <0b82e2de0edee4a590e7b4165c65938aef7090f5.1393257006.git.kirr@mns.spb.ru>
 <xmqqa9cfp9d5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kirr@mns.spb.ru, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 10:24:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSNar-00075j-G2
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 10:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbaCYJYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 05:24:21 -0400
Received: from forward9l.mail.yandex.net ([84.201.143.142]:58197 "EHLO
	forward9l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbaCYJYT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 05:24:19 -0400
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Mar 2014 05:24:19 EDT
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net [37.140.190.26])
	by forward9l.mail.yandex.net (Yandex) with ESMTP id B1489E610F3;
	Tue, 25 Mar 2014 13:18:52 +0400 (MSK)
Received: from smtp1o.mail.yandex.net (localhost [127.0.0.1])
	by smtp1o.mail.yandex.net (Yandex) with ESMTP id 397C9DE1515;
	Tue, 25 Mar 2014 13:18:52 +0400 (MSK)
Received: from unknown (unknown [78.25.121.154])
	by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id D6dMXgBVOU-InQK7FO9;
	Tue, 25 Mar 2014 13:18:49 +0400
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 5e2af6fc-2b0e-4e5b-858a-80a429f476d0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navytux.spb.ru; s=mail;
	t=1395739131; bh=H52CQcFo7B96lqnIehHjQPcHAztZl9S3kyEvemc9rpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:Organization:
	 User-Agent;
	b=RNUJez4vgYjp1+qfvmRb9+m762Vq9qZmhl+cremEiMk8CAtQ8NzQWm+ij1mKAu0ql
	 YnMbhRw/vfyi6WMEW/oFdDI94JKZSwK1/FjCNC9i6kS6YWuzAwaXp+ybHAz5xT9llD
	 ZPlvvblsDveZ5AquLp1ZExuDbXFzz8UAesMTvjyQ=
Authentication-Results: smtp1o.mail.yandex.net; dkim=pass header.i=@navytux.spb.ru
Received: from kirr by mini.zxlink with local (Exim 4.82)
	(envelope-from <kirr@mini.zxlink>)
	id 1WSNYl-0002z8-Ns; Tue, 25 Mar 2014 13:22:15 +0400
Content-Disposition: inline
In-Reply-To: <xmqqa9cfp9d5.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245020>

On Mon, Mar 24, 2014 at 02:36:22PM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@mns.spb.ru> writes:
> 
> > The downside is that try_to_follow_renames(), if active, we cause
> > re-reading of 2 initial trees, which was negligible based on my timings,
> 
> That would depend on how often the codepath triggered in your test
> case, but is totally understandable.  It fires only when the path we
> have been following disappears from the parent, and the processing
> of try-to-follow itself is very compute-intensive (it needs to run
> find-copies-harder logic) that will end up reading many subtrees of
> the two initial trees; two more reading of tree objects will be
> dwarfed by the actual processing.

I agree and thanks for the explanation.

> > and which is outweighed cogently by the upsides.
> 
> > Changes since v1:
> >
> >  - don't need to touch diff.h, as diff_tree() became static.
> 
> Nice.  I wonder if it is an option to let the function keep its name
> diff_tree() without renaming it to __diff_tree_whatever(), though.

As I see it, in Git for functions operating on trees, there is convention
to accept either `struct tree_desc *` and be named simply, or sha1 and
be named with _sha1 suffix. From this point of view for new diff_tree()
accepting sha1's and staying with its old name would be confusing.

Besides, in the end we'll have two function with high-level wrapper, and
lower-lever worker:

    - diff_tree_sha1(), and
    - diff_tree_paths().

So it's not about this only particular case.  Both do some simple
preparation, call worker, and perform some cleanup.

So the question is how to name the worker?

In Linux they use "__" prefix. We could also use some other prefix or
suffix, e.g. "_bh" (for bottom-half), "_worker", "_low", "_raw", etc...


To me, personally, the cleanest is "__" prefix, but maybe I'm too used
to Linux etc... I'm open to other naming scheme, only it should be
consistent.

What are the downsides of "__" prefix by the way?


> >  tree-diff.c | 60 ++++++++++++++++++++++++++++--------------------------------
> >  1 file changed, 28 insertions(+), 32 deletions(-)
> >
> > diff --git a/tree-diff.c b/tree-diff.c
> > index b99622c..f90acf5 100644
> > --- a/tree-diff.c
> > +++ b/tree-diff.c
> > @@ -137,12 +137,17 @@ static void skip_uninteresting(struct tree_desc *t, struct strbuf *base,
> >  	}
> >  }
> >  
> > -static int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
> > -		     const char *base_str, struct diff_options *opt)
> > +static int __diff_tree_sha1(const unsigned char *old, const unsigned char *new,
> > +			    const char *base_str, struct diff_options *opt)
> >  {
> > +	struct tree_desc t1, t2;
> > +	void *t1tree, *t2tree;
> >  	struct strbuf base;
> >  	int baselen = strlen(base_str);
> >  
> > +	t1tree = fill_tree_descriptor(&t1, old);
> > +	t2tree = fill_tree_descriptor(&t2, new);
> > +
> >  	/* Enable recursion indefinitely */
> >  	opt->pathspec.recursive = DIFF_OPT_TST(opt, RECURSIVE);
> >  
> > @@ -155,39 +160,41 @@ static int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
> >  		if (diff_can_quit_early(opt))
> >  			break;
> >  		if (opt->pathspec.nr) {
> > -			skip_uninteresting(t1, &base, opt);
> > -			skip_uninteresting(t2, &base, opt);
> > +			skip_uninteresting(&t1, &base, opt);
> > +			skip_uninteresting(&t2, &base, opt);
> >  		}
> > -		if (!t1->size && !t2->size)
> > +		if (!t1.size && !t2.size)
> >  			break;
> >  
> > -		cmp = tree_entry_pathcmp(t1, t2);
> > +		cmp = tree_entry_pathcmp(&t1, &t2);
> >  
> >  		/* t1 = t2 */
> >  		if (cmp == 0) {
> >  			if (DIFF_OPT_TST(opt, FIND_COPIES_HARDER) ||
> > -			    hashcmp(t1->entry.sha1, t2->entry.sha1) ||
> > -			    (t1->entry.mode != t2->entry.mode))
> > -				show_path(&base, opt, t1, t2);
> > +			    hashcmp(t1.entry.sha1, t2.entry.sha1) ||
> > +			    (t1.entry.mode != t2.entry.mode))
> > +				show_path(&base, opt, &t1, &t2);
> >  
> > -			update_tree_entry(t1);
> > -			update_tree_entry(t2);
> > +			update_tree_entry(&t1);
> > +			update_tree_entry(&t2);
> >  		}
> >  
> >  		/* t1 < t2 */
> >  		else if (cmp < 0) {
> > -			show_path(&base, opt, t1, /*t2=*/NULL);
> > -			update_tree_entry(t1);
> > +			show_path(&base, opt, &t1, /*t2=*/NULL);
> > +			update_tree_entry(&t1);
> >  		}
> >  
> >  		/* t1 > t2 */
> >  		else {
> > -			show_path(&base, opt, /*t1=*/NULL, t2);
> > -			update_tree_entry(t2);
> > +			show_path(&base, opt, /*t1=*/NULL, &t2);
> > +			update_tree_entry(&t2);
> >  		}
> >  	}
> >  
> >  	strbuf_release(&base);
> > +	free(t2tree);
> > +	free(t1tree);
> >  	return 0;
> >  }
> >  
> > @@ -202,7 +209,7 @@ static inline int diff_might_be_rename(void)
> >  		!DIFF_FILE_VALID(diff_queued_diff.queue[0]->one);
> >  }
> >  
> > -static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, const char *base, struct diff_options *opt)
> > +static void try_to_follow_renames(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
> >  {
> >  	struct diff_options diff_opts;
> >  	struct diff_queue_struct *q = &diff_queued_diff;
> > @@ -240,7 +247,7 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
> >  	diff_opts.break_opt = opt->break_opt;
> >  	diff_opts.rename_score = opt->rename_score;
> >  	diff_setup_done(&diff_opts);
> > -	diff_tree(t1, t2, base, &diff_opts);
> > +	__diff_tree_sha1(old, new, base, &diff_opts);
> >  	diffcore_std(&diff_opts);
> >  	free_pathspec(&diff_opts.pathspec);
> >  
> > @@ -301,23 +308,12 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
> >  
> >  int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const char *base, struct diff_options *opt)
> >  {
> > -	void *tree1, *tree2;
> > -	struct tree_desc t1, t2;
> > -	unsigned long size1, size2;
> >  	int retval;
> >  
> > -	tree1 = fill_tree_descriptor(&t1, old);
> > -	tree2 = fill_tree_descriptor(&t2, new);
> > -	size1 = t1.size;
> > -	size2 = t2.size;
> > -	retval = diff_tree(&t1, &t2, base, opt);
> > -	if (!*base && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename()) {
> > -		init_tree_desc(&t1, tree1, size1);
> > -		init_tree_desc(&t2, tree2, size2);
> > -		try_to_follow_renames(&t1, &t2, base, opt);
> > -	}
> > -	free(tree1);
> > -	free(tree2);
> > +	retval = __diff_tree_sha1(old, new, base, opt);
> > +	if (!*base && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename())
> > +		try_to_follow_renames(old, new, base, opt);
> > +
> >  	return retval;
> >  }
