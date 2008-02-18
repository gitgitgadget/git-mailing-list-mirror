From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add support for host aliases in config files
Date: Mon, 18 Feb 2008 14:29:38 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802181410120.5816@iabervon.org>
References: <alpine.LNX.1.00.0802171337000.5816@iabervon.org> <7vskzquarz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 20:30:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRBh5-0006X7-Hh
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 20:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbYBRT3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 14:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbYBRT3n
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 14:29:43 -0500
Received: from iabervon.org ([66.92.72.58]:48136 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752325AbYBRT3m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 14:29:42 -0500
Received: (qmail 29280 invoked by uid 1000); 18 Feb 2008 19:29:38 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Feb 2008 19:29:38 -0000
In-Reply-To: <7vskzquarz.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74335>

On Sun, 17 Feb 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > ..., but I'd like to get the 
> > code portion out there are reviewed, at least, since I think last time, 
> > the patch only got as far as a discussion of how I should explain what it 
> > does.
> 
> I actually think that is the most important part to get it right
> first.  I usually do not have to read the patch text to reject
> an ill-conceived idea if the description is unclear and/or
> unconvincing.
> 
> I think the documentation (I removed from the quote) shows the
> feature is unambiguously good.

What I meant by that was that you'd asked for some change in how this 
feature would get mentioned to people reading man pages on git commands 
that can use it.

> > diff --git a/remote.c b/remote.c
> > index 6b56473..59338a3 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -2,6 +2,15 @@
> >  #include "remote.h"
> >  #include "refs.h"
> >  
> > +struct host {
> > +	const char *name;
> > +
> > +	const char *base;
> > +
> > +	const char **alias;
> > +	int alias_nr;
> > +};
> 
> Extra blank lines?

I tend to like grouping related fields by having blank lines between 
unrelated ones, but it's not needed here.

> > @@ -11,9 +20,32 @@ static int allocated_branches;
> >  static struct branch *current_branch;
> >  static const char *default_remote_name;
> >  
> > +static struct host **hosts;
> > +static int allocated_hosts;
> 
> The allocation in remote.c file is unusual from the rest of git
> that usually follow the technical/api-allocation-growing
> convention (the comment unfortunately applies to the code we
> already have there).

I think I originally used an older style that never got converted, and 
this time matched the style of the rest of the file. I'll add an initial 
patch to convert the rest of the file to the standard thing, and use that 
style for this patch as well.

> > +static const char *alias_url(const char *url)
> > +{
> > +	int i, j;
> > +	for (i = 0; i < allocated_hosts; i++) {
> > +		if (!hosts[i])
> > +			continue;
> > +		for (j = 0; j < hosts[i]->alias_nr; j++) {
> > +			if (!prefixcmp(url, hosts[i]->alias[j])) {
> > +				char *ret = malloc(strlen(hosts[i]->base) -
> > +						   strlen(hosts[i]->alias[j]) +
> > +						   strlen(url) + 1);
> > +				strcpy(ret, hosts[i]->base);
> > +				strcat(ret, url + strlen(hosts[i]->alias[j]));
> > +				return ret;
> > +			}
> 
> First match semantics is fine during runtime but at some point
> we would want a "config file lint" that points out ambiguous
> aliases perhaps?

I think first match may actually be useful in dealing with sites where a 
subset of the web-served space is git-served or something. But I'm really 
not sure; maybe we want "longest base" or something.

> > @@ -154,7 +233,7 @@ static void read_remotes_file(struct remote *remote)
> >  
> >  		switch (value_list) {
> >  		case 0:
> > -			add_url(remote, xstrdup(s));
> > +			add_url_alias(remote, xstrdup(s));
> >  			break;
> >  		case 1:
> >  			add_push_refspec(remote, xstrdup(s));
> > @@ -206,7 +285,7 @@ static void read_branches_file(struct remote *remote)
> >  	} else {
> >  		branch = "refs/heads/master";
> >  	}
> > -	add_url(remote, p);
> > +	add_url_alias(remote, p);
> >  	add_fetch_refspec(remote, branch);
> >  	remote->fetch_tags = 1; /* always auto-follow */
> >  }
> 
> These two are logical and clean updates.
> 
> > @@ -236,6 +315,20 @@ static int handle_config(const char *key, const char *value)
> >  		}
> >  		return 0;
> >  	}
> > +	if (!prefixcmp(key, "host.")) {
> > +		struct host *host;
> > +		name = key + 5;
> > +		subkey = strrchr(name, '.');
> > +		if (!subkey)
> > +			return 0;
> 
> This "ignore this entry" is good.  We might later want to add
> host.<var> that is not about a specific host, and we would want
> to be able to read a configuration that is written for such a
> future version of git.
> 
> > +		host = make_host(name, subkey - name);
> > +		if (!value)
> > +			return 0;
> 
> This is not.
> 
>  (1) We should barf saying "host.<this-host>.<var> configuration
>      should be a string", for base and rewritebase, instead of
>      silently ignoring such a misconfiguration;

True. I'll look up the present best practices for config stuff.

>  (2) We should _not_ do such barfing for future variables that
>      are not base nor rewritebase, so this "return" is at a
>      wrong place.

I was intentionally careful to ignore unknown options.

	-Daniel
*This .sig left intentionally blank*
