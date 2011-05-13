From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/8] revert: Make "commit" and "me" local variables
Date: Fri, 13 May 2011 15:32:43 +0530
Message-ID: <20110513100241.GF14272@ramkum.desktop.amazon.com>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com> <1305100822-20470-3-git-send-email-artagnon@gmail.com> <20110511103704.GB2676@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 12:02:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKpD0-0003n9-7H
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 12:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758322Ab1EMKCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 06:02:53 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:34414 "EHLO
	smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757023Ab1EMKCv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 06:02:51 -0400
X-IronPort-AV: E=Sophos;i="4.64,363,1301875200"; 
   d="scan'208";a="699833307"
Received: from smtp-in-9001.sea19.amazon.com ([10.186.144.32])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 May 2011 10:02:51 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-9001.sea19.amazon.com (8.13.8/8.13.8) with ESMTP id p4DA2njp031706;
	Fri, 13 May 2011 10:02:49 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id 55CD775483D; Fri, 13 May 2011 15:32:43 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <20110511103704.GB2676@elie>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173520>

Hi again,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> > Currently, "commit" and "me" are global static variables. Since we
> > want to develop the functionality to either pick/ revert individual
> > commits atomically later in the series, make them local variables.
> 
> I suppose the idea is that the current commit and whether we are
> cherry-picking or reverting is not global state and should be allowed
> to differ between threads, or that for easier debugging we would like
> to narrow their scope.
> 
> How does this relate to the sequencer series?  Maybe the idea is that
> they are explicit parameters in the functions that will be exposed
> rather than that they are local variables?

Right.  I'll attempt to reword this in the next iteration.

> >
> > Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> > ---
> >  The variable "me" is nowhere as fundamental as "commit" -- it's
> >  simply a string derived from a more fundamental "action".
> 
> That suggests to me that "action" should probably be made local at the
> same time.  On second thought, it looks like this commit is doing two
> unrelated things ---
> 
>  - simplifying the state that has to be kept by computing "me"
>    from "action" on the fly
> 
>  - narrowing the scope of "commit" and passing it around explicitly
> 
> and would be clearer as two separate commits.

Good idea -- I'll split this up into two distinct commits in the next
iteration.

> > --- a/builtin/revert.c
> > +++ b/builtin/revert.c
> [...]
> > @@ -51,7 +49,7 @@ static size_t xopts_nr, xopts_alloc;
> >  
> >  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
> >  
> > -static char *get_encoding(const char *message);
> > +static char *get_encoding(struct commit *commit, const char *message);
> 
> If the die is converted to an assert or die("BUG: ...") without
> specifying which commit then this first parameter is not needed.

Agreed.  It should probably be an assertion failure, since the caller
should use the get_encoding calling API responsibly.

> > @@ -187,7 +186,8 @@ static char *get_encoding(const char *message)
> >  	return NULL;
> >  }
> >  
> > -static void add_message_to_msg(struct strbuf *msgbuf, const char *message)
> > +static void add_message_to_msg(struct commit *commit, struct strbuf *msgbuf,
> > +			const char *message)
> 
> Perhaps the new parameter could be "const char *fallback" and the
> caller call sha1_to_hex unconditionally?  (Yes, it sounds like wasted
> computation, but it might be worth the clarity.)

and

> > @@ -200,7 +200,7 @@ static void add_message_to_msg(struct strbuf *msgbuf, const char *message)
> >  	strbuf_addstr(msgbuf, p);
> >  }
> >  
> > -static int write_cherry_pick_head(void)
> > +static int write_cherry_pick_head(struct commit *commit)
> 
> Ah, it might not be wasted computation.  This could take
> commit_sha1_hex as parameter so it only needs to be computed once.

Okay.

> > @@ -319,6 +319,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
> >  	int clean, index_fd;
> >  	const char **xopt;
> >  	static struct lock_file index_lock;
> > +	const char *me = (action == REVERT ? "revert" : "cherry-pick");
> 
> Style: I find this clearer without the parentheses (but feel free to
> ignore).
> 
> [...]
> > @@ -402,6 +403,7 @@ static int do_pick_commit(void)
> >  	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
> >  	char *defmsg = NULL;
> >  	struct strbuf msgbuf = STRBUF_INIT;
> > +	const char *me = (action == REVERT ? "revert" : "cherry-pick");
> >  	int res;
> >  
> >  	if (no_commit) {
> > @@ -458,9 +460,10 @@ static int do_pick_commit(void)
> >  		/* TRANSLATORS: The first %s will be "revert" or
> >  		   "cherry-pick", the second %s a SHA1 */
> >  		return error(_("%s: cannot parse parent commit %s"),
> > -		    me, sha1_to_hex(parent->object.sha1));
> > +			action == REVERT ? "revert" : "cherry-pick",
> > +			sha1_to_hex(parent->object.sha1));
> 
> I think one of the computations of "me" is left over.

Right; leaked into another patch -- rebase fail :|

> > @@ -562,10 +565,13 @@ static int prepare_revs(struct rev_info *revs)
> >  	return 0;
> >  }
> >  
> > -static int read_and_refresh_cache(const char *me)
> > +static int read_and_refresh_cache(void)
> 
> Since you seem to be moving towards having fewer statics and more
> explicit parameters, I think this part is a step backwards.  Maybe it
> should take "action" as a parameter instead.

I'll think about this.

> > @@ -583,10 +589,12 @@ static int read_and_refresh_cache(const char *me)
> >  static int revert_or_cherry_pick(int argc, const char **argv)
> >  {
> >  	struct rev_info revs;
> > +	struct commit *commit;
> > +	const char *me;
> >  	int res;
> >  
> >  	git_config(git_default_config, NULL);
> > -	me = action == REVERT ? "revert" : "cherry-pick";
> > +	me = (action == REVERT ? "revert" : "cherry-pick");
> 
> Why?

Consistency, mainly.  I can't remember operator precedence, and there
are three operators in that line.  Either way, I'll lose the
paranthesis if it's clear enough otherwise.

> >  	setenv(GIT_REFLOG_ACTION, me, 0);
> >  	parse_args(argc, argv);
> >  
> 
> Sorry, mostly nitpicks.  Still, hope that helps.

Yes.  Thanks.

-- Ram
