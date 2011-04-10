From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/11] revert: Avoid calling die; return error instead
Date: Sun, 10 Apr 2011 14:14:58 -0500
Message-ID: <20110410191458.GA28163@elie>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
 <1302448317-32387-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 21:15:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q906K-0001Wa-C5
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 21:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754395Ab1DJTPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 15:15:06 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37834 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142Ab1DJTPF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 15:15:05 -0400
Received: by gyd10 with SMTP id 10so1932044gyd.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 12:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=NPWs53dG+JbIM97OapNTKby45/jZVC/UfisVxxIxHX0=;
        b=KehSWY+OFdNMUwoEXBqshsOg0vtWWAOVOnaB8O8mGjCkeO0Fv/peg/f+1/HwlS9pOF
         rwBa/jJTdIDZ5CpZknvGVeQ8lPV4uG5X2uCWd7/T26wfY3ejmir0x5pqsRFUptm7cDVq
         dphFn+5ZkM0k8QBJUiewfSV4cej4/OsWBUwmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DMsJF+0HOzvAqVFTaN9h6LRpekhHW2swiWlelkXNDe4YU3/UpBko3YJOXZZx240MRt
         bjxoRbXBeF3+mTvdbZWI60AkH87Sle2mXSZ3Ze72QKEVxqejdeVIL/fit5RYtg7LM2Ka
         MUK9Z7M5Cl2/FIPTE3FEIQ36m0Ifc+pSXA1LI=
Received: by 10.150.103.10 with SMTP id a10mr4042347ybc.417.1302462904310;
        Sun, 10 Apr 2011 12:15:04 -0700 (PDT)
Received: from elie (adsl-69-209-51-92.dsl.chcgil.ameritech.net [69.209.51.92])
        by mx.google.com with ESMTPS id 23sm5250050ano.33.2011.04.10.12.15.02
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 12:15:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1302448317-32387-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171271>

Ramkumar Ramachandra wrote:

> [Subject: revert: Avoid calling die; return error instead]
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

Presumably this is because the sequencer is going to pick up after the
error and clean up a little (why doesn't the change description say
so?).  Will it be resuming after that or just performing a little
cleanup before the exit?

Might make sense, but:

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -265,23 +265,23 @@ static struct tree *empty_tree(void)
>  	return tree;
>  }
>  
> -static NORETURN void die_dirty_index(const char *me)
> +static int error_dirty_index(const char *me)
>  {
>  	if (read_cache_unmerged()) {
>  		die_resolve_conflict(me);

Won't that exit?  

>  	} else {

This "else" could be removed (decreasing the indent of the rest by
one tab stop) since the "if" case has already returned or exited.
Not the subject of this patch, just an idea for earlier or later. ;-)

[...]
> @@ -331,7 +331,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>  	    (write_cache(index_fd, active_cache, active_nr) ||
>  	     commit_locked_index(&index_lock)))
>  		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
> -		die(_("%s: Unable to write new index file"), me);
> +		return error(_("%s: Unable to write new index file"), me);
>  	rollback_lock_file(&index_lock);

What happens to index_lock in the error case?

[...]
> @@ -533,34 +533,39 @@ static void prepare_revs(struct rev_info *revs)
>  		revs->reverse = 1;
>  
>  	argc = setup_revisions(commit_argc, commit_argv, revs, NULL);
> -	if (argc > 1)
> -		usage(*revert_or_cherry_pick_usage());
> +	if (argc > 1) {
> +		fprintf(stderr, "usage: %s", _(*revert_or_cherry_pick_usage()));
> +		return 129;
> +	}

Yuck.  Maybe the error can be returned to the caller somehow, but
that seems somehow ambitious given that setup_revisions has all sorts
of ways to die anyway.

So you are bending the assumptions of many existing git functions (in
a good way).

I can think of at least three ways to go:

 1) Come up with a convention to give more information about the nature
    of returned errors in the functions you are touching.  For
    example, make sure errno is valid after the relevant functions, or
    use multiple negative values to express the nature of the error.

    So a caller could do:

	if (prepare_revs(...)) {
		if (errno == EINVAL)
			usage(*revert_or_cherry_pick_usage());
		die("BUG: unexpected error from prepare_revs");
	}

    Or:

 2) Use set_die_routine or sigchain_push + atexit to declare what cleanup
    has to happen before exiting.  Keep using die().

 3) Provide a new facility to register cleanup handlers that will free
    resources and otherwise return to a consistent state before
    unwinding the stack.  This way, you'd still have to audit die()
    calls to look for missing cleanup handlers, but they could stay as
    die() rather than changing to "return error" and the worried
    caller could use

	set_die_routine(longjmp_to_here);

    to keep git alive.  I don't suggest doing this.  It is a pain to
    get right and not obviously cleaner than "return error", and some
    errors really are unrecoverable (rather than just being a symptom
    of programmers to lazy to write error recovery code :)).

Okay, I'm stopping here.  Hope that helps.

Thanks,
Jonathan
