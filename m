From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/4] Make 'unpack_trees()' have a separate source and
 destination index
Date: Fri, 7 Mar 2008 09:32:07 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0803070903080.12253@woody.linux-foundation.org>
References: <cover.1204856187.git.torvalds@linux-foundation.org> <8676ea8b0313abfc2e0946f45f636643e28aade8.1204856187.git.torvalds@linux-foundation.org> <alpine.LSU.1.00.0803071507510.19395@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 07 18:33:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXgRi-0006ge-NX
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 18:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194AbYCGRcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 12:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754633AbYCGRcr
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 12:32:47 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57149 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753769AbYCGRcq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Mar 2008 12:32:46 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m27HWY4G023664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Mar 2008 09:32:35 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m27HW7mJ008805;
	Fri, 7 Mar 2008 09:32:07 -0800
In-Reply-To: <alpine.LSU.1.00.0803071507510.19395@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.969 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76503>



On Fri, 7 Mar 2008, Johannes Schindelin wrote:
> 
> > @@ -221,27 +222,6 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
> >  	if ((opts.dir && !opts.update))
> >  		die("--exclude-per-directory is meaningless unless -u");
> >  
> > -	if (opts.prefix) {
> > -		int pfxlen = strlen(opts.prefix);
> > -		int pos;
> > -		if (opts.prefix[pfxlen-1] != '/')
> > -			die("prefix must end with /");
> > -		if (stage != 2)
> > -			die("binding merge takes only one tree");
> > -		pos = cache_name_pos(opts.prefix, pfxlen);
> > -		if (0 <= pos)
> > -			die("corrupt index file");
> > -		pos = -pos-1;
> > -		if (pos < active_nr &&
> > -		    !strncmp(active_cache[pos]->name, opts.prefix, pfxlen))
> > -			die("subdirectory '%s' already exists.", opts.prefix);
> > -		pos = cache_name_pos(opts.prefix, pfxlen-1);
> > -		if (0 <= pos)
> > -			die("file '%.*s' already exists.",
> > -					pfxlen-1, opts.prefix);
> > -		opts.pos = -1 - pos;
> > -	}
> > -
> 
> Was the wholesale removal intentional?  I think there are a few sanity 
> checks, and I did not see the checks moved to somewhere else.  But then, 
> there could be redundant checks somewhere else that I missed.

It was intentional. The "bind_merge()" function already checks for overlap 
in the individual entries, so those sanity checks don't actually buy you 
anything. And those games with "opt.pos" actualyl made the new model not 
work, because it would mean that we'd skip the old entries before that 
"pos" entirely (instead of moving them over to the new index).

However, you're right to point it out. The old checks are somewhat 
different from the new ones - "bind_merge()" will check for overlap in 
individual entries, but it doesn't disallow merging non-overlapping 
subdirectories. I thought that extending the functionality would be a 
feature, but maybe somebody really wants those checks to be there on 
purpose.

So maybe we could have left a few of those checks. I just thought it was 
pretty interesting how we disallowed doing

	- index:
		subdirectory/Makefile

	- tree:
		.. anything *but* a 'Makefile' entry ..

	- git-read-tree --prefix subdirectory/ <tree>

and without the checks it actually works fine (it creates a "union" of the 
index and the incoming tree).

If somebody doesn't want that, I think they should check up-front (easy 
enough: just test if "git ls-files subdirectory/" returns anything), so I 
actually think the sanity checks just remove capabilities rather than add 
anything.

> > @@ -360,7 +366,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
> >  	if (o->trivial_merges_only && o->nontrivial_merge)
> >  		return unpack_failed(o, "Merge requires file-level merging");
> >  
> > +	o->src_index = NULL;
> >  	check_updates(o);
> > +	if (o->dst_index)
> > +		*o->dst_index = o->result;
> >  	return 0;
> >  }
> >  
> 
> I wonder if you should discard_index(o->dst_index) if o->src_index == 
> o->dst_index (before you set it to NULL, of course).

Not quite yet. I _really_ wanted to, but we can't do it - there's a few 
users that want to use "the_index" that I was not ready to work out what 
the right thing to do was.

In particular, when we do write_entry() of the finished index, that one 
does:

    check_updates
      checkout_entry()
        write_entry
          convert_to_working_tree
            git_checkattr
              bootstrap_attr_stack
                read_attr
                  read_index_data
                    index_name_pos(&the_index)

and the thing is, if we discard the old "the_index()" early (like we 
*should* do), that callchain breaks because the attribute code will use 
"the_index" rather than the index we are actually using!

Now, the fact is, I think that's a bug in the attribute code (well, 
"historical artifact" from the fact that we always used to use just 
"the_index" for everything). It should no longer (in my opinion) just 
blindly use "the_index" when we are writing out something else than 
"the_index", but hey, that's what it does.

If you want to play with it, here's a patch that I did *not* post on top 
of the whole series that makes the issue more obvious. That "memset()" is 
just to poison any users of the index that isn't finalized yet, to make 
you get a nice SIGSEGV rather than just inexplicable failures.

Anyway, to fix that thing, we'd have to pass the correct index around all 
the way, which is definitely worth doing regardless, but it was kind of 
beyond the aim of _this_ particular patch series.

Here's the patch to get you started :)

		Linus

---
 unpack-trees.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 0cdf198..afa9c9d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -366,6 +366,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	if (o->trivial_merges_only && o->nontrivial_merge)
 		return unpack_failed(o, "Merge requires file-level merging");
 
+	if (o->dst_index) {
+		discard_index(o->dst_index);
+		memset(o->dst_index, 0x55, sizeof(*o->dst_index));
+	}
 	o->src_index = NULL;
 	check_updates(o);
 	if (o->dst_index)
