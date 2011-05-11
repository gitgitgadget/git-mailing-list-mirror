From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/8] revert: Make "commit" and "me" local variables
Date: Wed, 11 May 2011 05:37:04 -0500
Message-ID: <20110511103704.GB2676@elie>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
 <1305100822-20470-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 18:07:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKBwU-0001Sg-OS
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 18:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756908Ab1EKQHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 12:07:06 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46551 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756865Ab1EKQHC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 12:07:02 -0400
Received: by gyd10 with SMTP id 10so215343gyd.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 09:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ME/xfkVm7OWqJP/Qg0yI17LuibOuczrFQO9ZhSRK6Us=;
        b=luddjd1Sor7viaOT2Z4Dez/Gv0mQt6eplGkrOHW2pJz8e6wzypnltdglpyi99Fx27P
         q38IwF9pu5JMymIU330tdDS3fjwUGblUQR0pJCQFDq93s4FF44B16kI+I97kJKxGOR0F
         gAsGVA+fvRzeusSlxmaNLEqhApgd79rMXqvco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hLhC0uIaMig3YCCW8wvDQPm8z7Va1kys8L7AJwuP63flHdj3iOeAgo7zR3YjOV44WI
         gVp9kjq/lPtqnDzO571M8L/8paIatVjdygEGX+XuodUMsAxiS+jn9MEz2g9esP5PYzCL
         LCF/OS1M9r0kDmcMAoHUNqgpItGsFKyh9mjgc=
Received: by 10.42.165.67 with SMTP id j3mr6580582icy.368.1305110228795;
        Wed, 11 May 2011 03:37:08 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.sbcglobal.net [69.209.56.134])
        by mx.google.com with ESMTPS id 14sm6147ibc.25.2011.05.11.03.37.06
        (version=SSLv3 cipher=OTHER);
        Wed, 11 May 2011 03:37:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305100822-20470-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173401>

Ramkumar Ramachandra wrote:

> Currently, "commit" and "me" are global static variables. Since we
> want to develop the functionality to either pick/ revert individual
> commits atomically later in the series, make them local variables.

I suppose the idea is that the current commit and whether we are
cherry-picking or reverting is not global state and should be allowed
to differ between threads, or that for easier debugging we would like
to narrow their scope.

How does this relate to the sequencer series?  Maybe the idea is that
they are explicit parameters in the functions that will be exposed
rather than that they are local variables?

>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  The variable "me" is nowhere as fundamental as "commit" -- it's
>  simply a string derived from a more fundamental "action".

That suggests to me that "action" should probably be made local at the
same time.  On second thought, it looks like this commit is doing two
unrelated things ---

 - simplifying the state that has to be kept by computing "me"
   from "action" on the fly

 - narrowing the scope of "commit" and passing it around explicitly

and would be clearer as two separate commits.

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
[...]
> @@ -51,7 +49,7 @@ static size_t xopts_nr, xopts_alloc;
>  
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>  
> -static char *get_encoding(const char *message);
> +static char *get_encoding(struct commit *commit, const char *message);

If the die is converted to an assert or die("BUG: ...") without
specifying which commit then this first parameter is not needed.

>  static const char * const *revert_or_cherry_pick_usage(void)
>  {
> @@ -116,7 +114,8 @@ struct commit_message {
>  	const char *message;
>  };
>  
> -static int get_message(const char *raw_message, struct commit_message *out)
> +static int get_message(struct commit *commit, const char *raw_message,
> +		struct commit_message *out)

Likewise.

[...]
> @@ -187,7 +186,8 @@ static char *get_encoding(const char *message)
>  	return NULL;
>  }
>  
> -static void add_message_to_msg(struct strbuf *msgbuf, const char *message)
> +static void add_message_to_msg(struct commit *commit, struct strbuf *msgbuf,
> +			const char *message)

Perhaps the new parameter could be "const char *fallback" and the
caller call sha1_to_hex unconditionally?  (Yes, it sounds like wasted
computation, but it might be worth the clarity.)

> @@ -200,7 +200,7 @@ static void add_message_to_msg(struct strbuf *msgbuf, const char *message)
>  	strbuf_addstr(msgbuf, p);
>  }
>  
> -static int write_cherry_pick_head(void)
> +static int write_cherry_pick_head(struct commit *commit)

Ah, it might not be wasted computation.  This could take
commit_sha1_hex as parameter so it only needs to be computed once.

> @@ -319,6 +319,7 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>  	int clean, index_fd;
>  	const char **xopt;
>  	static struct lock_file index_lock;
> +	const char *me = (action == REVERT ? "revert" : "cherry-pick");

Style: I find this clearer without the parentheses (but feel free to
ignore).

[...]
> @@ -402,6 +403,7 @@ static int do_pick_commit(void)
>  	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
>  	char *defmsg = NULL;
>  	struct strbuf msgbuf = STRBUF_INIT;
> +	const char *me = (action == REVERT ? "revert" : "cherry-pick");
>  	int res;
>  
>  	if (no_commit) {
> @@ -458,9 +460,10 @@ static int do_pick_commit(void)
>  		/* TRANSLATORS: The first %s will be "revert" or
>  		   "cherry-pick", the second %s a SHA1 */
>  		return error(_("%s: cannot parse parent commit %s"),
> -		    me, sha1_to_hex(parent->object.sha1));
> +			action == REVERT ? "revert" : "cherry-pick",
> +			sha1_to_hex(parent->object.sha1));

I think one of the computations of "me" is left over.

> @@ -562,10 +565,13 @@ static int prepare_revs(struct rev_info *revs)
>  	return 0;
>  }
>  
> -static int read_and_refresh_cache(const char *me)
> +static int read_and_refresh_cache(void)

Since you seem to be moving towards having fewer statics and more
explicit parameters, I think this part is a step backwards.  Maybe it
should take "action" as a parameter instead.

> @@ -583,10 +589,12 @@ static int read_and_refresh_cache(const char *me)
>  static int revert_or_cherry_pick(int argc, const char **argv)
>  {
>  	struct rev_info revs;
> +	struct commit *commit;
> +	const char *me;
>  	int res;
>  
>  	git_config(git_default_config, NULL);
> -	me = action == REVERT ? "revert" : "cherry-pick";
> +	me = (action == REVERT ? "revert" : "cherry-pick");

Why?

>  	setenv(GIT_REFLOG_ACTION, me, 0);
>  	parse_args(argc, argv);
>  

Sorry, mostly nitpicks.  Still, hope that helps.

Regards,
Jonathan
