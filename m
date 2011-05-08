From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 01/11] revert: Avoid calling die; return error instead
Date: Sun, 8 May 2011 17:34:00 +0530
Message-ID: <20110508120358.GB3114@ramkum.desktop.amazon.com>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com> <1302448317-32387-2-git-send-email-artagnon@gmail.com> <20110410191458.GA28163@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 14:04:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ2ip-0004za-RV
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487Ab1EHMEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 08:04:07 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:52361 "EHLO
	smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab1EHMEF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:04:05 -0400
X-IronPort-AV: E=Sophos;i="4.64,334,1301875200"; 
   d="scan'208";a="74511769"
Received: from smtp-in-0191.sea3.amazon.com ([10.224.12.28])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 May 2011 12:04:03 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-0191.sea3.amazon.com (8.13.8/8.13.8) with ESMTP id p48C41rm007262;
	Sun, 8 May 2011 12:04:02 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id C8ACE754821; Sun,  8 May 2011 17:34:00 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <20110410191458.GA28163@elie>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173096>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> > [Subject: revert: Avoid calling die; return error instead]
> >
> > Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> 
> Presumably this is because the sequencer is going to pick up after the
> error and clean up a little (why doesn't the change description say
> so?).  Will it be resuming after that or just performing a little
> cleanup before the exit?

I didn't write commit messages for any of the patches in the previous
round -- I just wanted to show the idea quickly.  Anyway, it's fixed
in the next round (coming soon).

> > --- a/builtin/revert.c
> > +++ b/builtin/revert.c
> > @@ -265,23 +265,23 @@ static struct tree *empty_tree(void)
> >  	return tree;
> >  }
> >  
> > -static NORETURN void die_dirty_index(const char *me)
> > +static int error_dirty_index(const char *me)
> >  {
> >  	if (read_cache_unmerged()) {
> >  		die_resolve_conflict(me);
> 
> Won't that exit?  

Fixed.

> >  	} else {
> 
> This "else" could be removed (decreasing the indent of the rest by
> one tab stop) since the "if" case has already returned or exited.
> Not the subject of this patch, just an idea for earlier or later. ;-)

Fixed.

> [...]
> > @@ -331,7 +331,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
> >  	    (write_cache(index_fd, active_cache, active_nr) ||
> >  	     commit_locked_index(&index_lock)))
> >  		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
> > -		die(_("%s: Unable to write new index file"), me);
> > +		return error(_("%s: Unable to write new index file"), me);
> >  	rollback_lock_file(&index_lock);
> 
> What happens to index_lock in the error case?

Fixed.

> [...]
> > @@ -533,34 +533,39 @@ static void prepare_revs(struct rev_info *revs)
> >  		revs->reverse = 1;
> >  
> >  	argc = setup_revisions(commit_argc, commit_argv, revs, NULL);
> > -	if (argc > 1)
> > -		usage(*revert_or_cherry_pick_usage());
> > +	if (argc > 1) {
> > +		fprintf(stderr, "usage: %s", _(*revert_or_cherry_pick_usage()));
> > +		return 129;
> > +	}
> 
> Yuck.  Maybe the error can be returned to the caller somehow, but
> that seems somehow ambitious given that setup_revisions has all sorts
> of ways to die anyway.
> 
> So you are bending the assumptions of many existing git functions (in
> a good way).
> 
> I can think of at least three ways to go:
> 
>  1) Come up with a convention to give more information about the nature
>     of returned errors in the functions you are touching.  For
>     example, make sure errno is valid after the relevant functions, or
>     use multiple negative values to express the nature of the error.
> 
>     So a caller could do:
> 
> 	if (prepare_revs(...)) {
> 		if (errno == EINVAL)
> 			usage(*revert_or_cherry_pick_usage());
> 		die("BUG: unexpected error from prepare_revs");
> 	}
> 
>     Or:
> 
>  2) Use set_die_routine or sigchain_push + atexit to declare what cleanup
>     has to happen before exiting.  Keep using die().
> 
>  3) Provide a new facility to register cleanup handlers that will free
>     resources and otherwise return to a consistent state before
>     unwinding the stack.  This way, you'd still have to audit die()
>     calls to look for missing cleanup handlers, but they could stay as
>     die() rather than changing to "return error" and the worried
>     caller could use
> 
> 	set_die_routine(longjmp_to_here);
> 
>     to keep git alive.  I don't suggest doing this.  It is a pain to
>     get right and not obviously cleaner than "return error", and some
>     errors really are unrecoverable (rather than just being a symptom
>     of programmers to lazy to write error recovery code :)).

Hm, I'm a little confused about error handling now.  I'll defer this
part until my patches naturally establish some convention for error
handling -- designing one in advance isn't as easy as I thought.

Finally, thanks for the review!  I'll look forward to more reviews as
I post more iterations of the series.

-- Ram
