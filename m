From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Give error when no remote is configured
Date: Mon, 16 Mar 2009 12:55:26 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903161204240.19665@iabervon.org>
References: <alpine.LNX.1.00.0903110139450.19665@iabervon.org> <7vocw2x7ob.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: bernie@codewiz.org, git@vger.kernel.org,
	Giovanni Bajo <rasky@develer.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 17:57:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjG7W-0004mZ-En
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 17:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756392AbZCPQz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 12:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755542AbZCPQz3
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 12:55:29 -0400
Received: from iabervon.org ([66.92.72.58]:41315 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689AbZCPQz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 12:55:28 -0400
Received: (qmail 30548 invoked by uid 1000); 16 Mar 2009 16:55:26 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Mar 2009 16:55:26 -0000
In-Reply-To: <7vocw2x7ob.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113343>

On Mon, 16 Mar 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > When there's no explicitly-named remote, we use the remote specified
> > for the current branch, which in turn defaults to "origin". But it
> > this case should require the remote to actually be configured, and not
> > fall back to the path "origin".
> 
> This is seriously broken.
> 
> > @@ -643,11 +656,22 @@ static int valid_remote_nick(const char *name)
> >  struct remote *remote_get(const char *name)
> >  {
> >  	struct remote *ret;
> > +	int name_given = 0;
> >  
> >  	read_config();
> > -	if (!name)
> > +	if (name)
> > +		name_given = 1;
> > +	else {
> >  		name = default_remote_name;
> > -	ret = make_remote(name, 0);
> > +		name_given = explicit_default_remote_name;
> > +	}
> > +	if (name_given)
> > +		ret = make_remote(name, 0);
> > +	else {
> > +		ret = get_remote_by_name(name);
> > +		if (!ret)
> > +			return NULL;
> > +	}
> 
> When you do not have any config entry to name your remotes but have been
> using .git/remotes/origin happily, you may have read config already at
> this point, but when you call get_remote_by_name() you haven't read
> anything from .git/remotes/* (nor .git/branches/* for that matter).  The
> caller will get NULL in such a case.  This happens for both fetch and
> push.

That's actually a simple bug; the block that's just after what you quoted 
should be just before it. I thought we had a test for having "origin" 
defined by one of the old methods, but I guess not. Your version is 
better, though; I'd forgotten that using the name as the URL was in 
remote_get() and not make_remote().

> Because you did not have any test to protect whatever you wanted to "fix"
> with your patch, I have no way knowing if I am breaking something else you
> wanted to do with your patch,

$ git init
$ git fetch

Shouldn't try fetching from ./origin/.git; I suppose the best test would 
be to do something like:

$ mkdir origin
$ (cd origin; git init; touch a; git add a; git commit -m "initial")
$ git init
$ git fetch

With test_must_fail. (But I'm more going for having it not give weird 
errors in an error situation, which is kind of fluffy to try to test.)

> but the patch below at least fixes the
> regression for me when running "git pull" in a repository I initialized
> long time ago that does not use the .git/config file to specify where my
> remote repositories are.
> 
> It applies on top of fa685bd (Give error when no remote is configured,
> 2009-03-11)
> 
> -- >8 --
> Subject: Remove total confusion from git-fetch and git-push
> 
> The config file is not the only place remotes are defined, and without
> consulting .git/remotes and .git/branches, you won't know if "origin" is
> configured by the user.  Don't give up too early and insult the user with
> a wisecrack "Where do you want to fetch from today?"

You actually wrote that message, in 853a3697. I think a better message 
would probably be something like:

No default remote is configured for your current branch, and the default 
remote "origin" is not configured either.

I think the message missed being made user-friendly in earlier passes due 
to being inaccessible at the time.

> Insulting is ok, but I personally get really pissed off if a tool is both
> confused and insulting.  At least be _correct_ and insulting.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  remote.c |   21 ++++-----------------
>  1 files changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/remote.c b/remote.c
> index 199830e..9f07dbc 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -105,16 +105,6 @@ static void add_url_alias(struct remote *remote, const char *url)
>  	add_url(remote, alias_url(url));
>  }
>  
> -static struct remote *get_remote_by_name(const char *name)
> -{
> -	int i;
> -	for (i = 0; i < remotes_nr; i++) {
> -		if (!strcmp(name, remotes[i]->name))
> -			return remotes[i];
> -	}
> -	return NULL;
> -}
> -
>  static struct remote *make_remote(const char *name, int len)
>  {
>  	struct remote *ret;
> @@ -665,19 +655,16 @@ struct remote *remote_get(const char *name)
>  		name = default_remote_name;
>  		name_given = explicit_default_remote_name;
>  	}
> -	if (name_given)
> -		ret = make_remote(name, 0);
> -	else {
> -		ret = get_remote_by_name(name);
> -		if (!ret)
> -			return NULL;
> -	}
> +
> +	ret = make_remote(name, 0);
>  	if (valid_remote_nick(name)) {
>  		if (!ret->url)
>  			read_remotes_file(ret);
>  		if (!ret->url)
>  			read_branches_file(ret);
>  	}
> +	if (!name_given && !ret->url)
> +		return NULL;
>  	if (!ret->url)
>  		add_url_alias(ret, name);
>  	if (!ret->url)
> 
