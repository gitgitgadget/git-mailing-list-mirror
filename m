From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH/RFC 2/2] Make path-limiting be incremental when possible.
Date: Thu, 30 Mar 2006 22:42:26 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603302225160.27203@g5.osdl.org>
References: <Pine.LNX.4.64.0603301648530.27203@g5.osdl.org>
 <Pine.LNX.4.64.0603301652531.27203@g5.osdl.org> <7vr74jxhp3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 31 08:42:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPDLF-0006WC-Fm
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 08:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWCaGmc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 01:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWCaGmc
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 01:42:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40616 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751145AbWCaGmb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Mar 2006 01:42:31 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2V6gRCo022877
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 30 Mar 2006 22:42:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2V6gR3A010566;
	Thu, 30 Mar 2006 22:42:27 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr74jxhp3.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18219>



On Thu, 30 Mar 2006, Junio C Hamano wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > The reason I put "RFC" in the subject line is that while I've validated it 
> > various ways, like doing
> >
> > 	git-rev-list HEAD -- drivers/char/ | md5sum 
> >
> > before-and-after on the kernel archive, it's "git-rev-list" after all. In 
> > other words, it's that really really subtle and complex central piece of 
> > software. So while I think this is important and should go in asap, I also 
> > think it should get lots of testing and eyeballs looking at the code.
> 
> Let me make sure I understand what is going on.
> 
> Currently, limit_list(), which is called when revs->limited is
> set, serves two different purposes:
> 
>  * traverse the ancestry chain and mark ancestors of
>    uninteresting commits also uninteresting;

Right.

We _also_ traverse the ancestry chain in the "walking" stage later in 
get_revision(), but if we have a "limit" case, we'll pre-traverse 
everything early in limit_list.

>  * "simplify" each commit that is still interesting, by
>    comparing the tree object of it and its parents.

Through "add_parent_to_list()", yes. 

> We used to call limit_list() when we are limiting the commits by
> paths, because that was what the latter does as a side effect of
> add_parents_to_list().  You made it streamable by moving the
> call to get_revision() and not calling limit_list() when you do
> not have other reasons to call it.

Yes, and by using "add_parent_to_list()" instead of the 
non-pathname-limit-aware "pop_most_recent_commit()".

So we don't call limit-list any more, because we do the same thing in 
get_revision() that it used to do at limit time.

> You currently do not do this streaming optimization when you
> have to show simplified parents, because the streaming version
> traverses ancestry chain one step at a time as it goes, and you
> cannot obviously see who the final "fake" parent is until you
> simplify the parents enouogh.

Yes. For exactly the same reason some other things ause us to do 
limit_list(): some ops simply need the fully connected end result in order 
to be able to work correctly.

>  * get_commit_reference() sets "limited" when the user gives ^exclude
>    commit.  no question about this --- we would need to see the
>    reachability in this case.

Right.

>  * when we are going to sort the result we are going to show,
>    we set "limited" -- we cannot sort without knowing the set we
>    are sorting.

Right.

>  * giving commit timestamp limits via --max-age, --min-age
>    etc. sets "limited".  I have doubts about this.

I agree. I looked at it when I did the "rev-list.c" vs "revision.c" split, 
but I wanted to do as few changes as possible, and for some reason we've 
always considered "time" to cause us to limit things.

However, I think your patch is wrong. Even if you don't limit things when 
we have a date specifier, you still want to stop doing traversal in 
limit_list when you hit that date. Why? Because it might be limited for 
some _other_ reason, eg due to --topo-order or or some other issue.

>  * As to handling of --unpacked, exactly the same comment as
>    "max-age" applies, but it might be even worse.  Marking an
>    unpacked one "uninteresting" means if a packed commit refers
>    to loose commit, the loose one will be also marked
>    uninteresting, I think.
> 
> "--objects --unpacked" is an idiom to repack objects that are
> still loose, but I suspect it would do interesting thing if the
> commit is in a pack but its trees and blobs are still loose.  Am
> I confused, or have I just spotted a potential (but hard to
> trigger) bug?

Regardless of where you do the "unpacked" test, it will always really end 
up stopping when it hits a packed commit. So you won't ever get away from 
that.

So same logic applies. Once you hit a packed commit, you should stop, both 
in limit_list _and_ in get_revision(). Otherwise you'll do too much work 
when trying to limit things, for no gain.

The fact is, "--unpacked" means that we traverse the part of the chain 
that hasn't been packed yet. Anything that is packed automatically cuts 
off parsing, whether there is anything else unpacked below it or not. It's 
not a bug, it's a feature, and if you want to pack everything, you should 
just do

	git repack -a -d

and not use --unpacked.

Same goes for dates, btw. We've always stopped when we reached a certain 
date, even though there _could_ be commits before it that are from a more 
recent date (due to clocks being set wrong). Neither --unpacked nor 
--since=xyzzy are meant to be any kind of "guarantees" that you get all 
commits that match some pattern. They are just "stop early" rules.

		Linus

So the following is wrong:

> diff --git a/revision.c b/revision.c
> index 0e3f074..a55c0d1 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -404,10 +404,6 @@ static void limit_list(struct rev_info *
>  		list = list->next;
>  		free(entry);
>  
> -		if (revs->max_age != -1 && (commit->date < revs->max_age))
> -			obj->flags |= UNINTERESTING;
> -		if (revs->unpacked && has_sha1_pack(obj->sha1))
> -			obj->flags |= UNINTERESTING;
>  		add_parents_to_list(revs, commit, &list);
>  		if (obj->flags & UNINTERESTING) {
>  			mark_parents_uninteresting(commit);
> @@ -415,8 +411,6 @@ static void limit_list(struct rev_info *
>  				break;
>  			continue;
>  		}
> -		if (revs->min_age != -1 && (commit->date > revs->min_age))
> -			continue;
>  		p = &commit_list_insert(commit, p)->next;
>  	}
>  	if (revs->boundary) {

..but the later part of the patch looks fine (modulo testing, of course):

> @@ -543,32 +537,26 @@ int setup_revisions(int argc, const char
>  			}
>  			if (!strncmp(arg, "--max-age=", 10)) {
>  				revs->max_age = atoi(arg + 10);
> -				revs->limited = 1;
>  				continue;
>  			}
>  			if (!strncmp(arg, "--min-age=", 10)) {
>  				revs->min_age = atoi(arg + 10);
> -				revs->limited = 1;
>  				continue;
>  			}
>  			if (!strncmp(arg, "--since=", 8)) {
>  				revs->max_age = approxidate(arg + 8);
> -				revs->limited = 1;
>  				continue;
>  			}
>  			if (!strncmp(arg, "--after=", 8)) {
>  				revs->max_age = approxidate(arg + 8);
> -				revs->limited = 1;
>  				continue;
>  			}
>  			if (!strncmp(arg, "--before=", 9)) {
>  				revs->min_age = approxidate(arg + 9);
> -				revs->limited = 1;
>  				continue;
>  			}
>  			if (!strncmp(arg, "--until=", 8)) {
>  				revs->min_age = approxidate(arg + 8);
> -				revs->limited = 1;
>  				continue;
>  			}
>  			if (!strcmp(arg, "--all")) {
> @@ -635,7 +623,6 @@ int setup_revisions(int argc, const char
>  			}
>  			if (!strcmp(arg, "--unpacked")) {
>  				revs->unpacked = 1;
> -				revs->limited = 1;
>  				continue;
>  			}
>  			*unrecognized++ = arg;
> @@ -786,7 +773,9 @@ struct commit *get_revision(struct rev_i
>  		if (revs->min_age != -1 && (commit->date > revs->min_age))
>  			continue;
>  		if (revs->max_age != -1 && (commit->date < revs->max_age))
> -			return NULL;
> +			continue;
> +		if (revs->unpacked && has_sha1_pack(commit->object.sha1))
> +			continue;
>  		if (revs->no_merges &&
>  		    commit->parents && commit->parents->next)
>  			continue;
> 
