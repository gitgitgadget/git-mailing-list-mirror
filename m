From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/3] Remotes library, take 3
Date: Sat, 12 May 2007 03:25:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705120312570.18541@iabervon.org>
References: <Pine.LNX.4.64.0705112234520.18541@iabervon.org>
 <7viray5xfj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 09:25:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmlya-0000GE-0N
	for gcvg-git@gmane.org; Sat, 12 May 2007 09:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756435AbXELHZG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 03:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756491AbXELHZG
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 03:25:06 -0400
Received: from iabervon.org ([66.92.72.58]:1841 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756435AbXELHZF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 03:25:05 -0400
Received: (qmail 8447 invoked by uid 1000); 12 May 2007 07:25:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 May 2007 07:25:02 -0000
In-Reply-To: <7viray5xfj.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47024>

On Sat, 12 May 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > This series is the same as the previous version, except that it matches 
> > the current behavior of builtin-push with respect to treating names as 
> > literal URIs.
> 
> Thanks.
> 
>         diff --git a/remote.c b/remote.c
>         index 32a0acf..1dd2e77 100644
>         --- a/remote.c
>         +++ b/remote.c
>         @@ -189,12 +189,14 @@ struct remote *remote_get(const char *name)
>                 if (!name)
>                         name = default_remote_name;
>                 ret = make_remote(name, 0);
>         -	if (*name == '/')
>         -		add_uri(ret, name);
>         -	if (!ret->uri)
>         -		read_remotes_file(ret);
>         +	if (name[0] != '/') {
>         +		if (!ret->uri)
>         +			read_remotes_file(ret);
>         +		if (!ret->uri)
>         +			read_branches_file(ret);
>         +	}
>                 if (!ret->uri)
>         -		read_branches_file(ret);
>         +		add_uri(ret, name);
>                 if (!ret->uri)
>                         return NULL;
>                 return ret;
> 
> This is more similar to the original from builtin-push.c than
> your previous round, but it is still not identical.
> 
> The differences should not matter in real life, but I think we
> need to make it clear what the differences are to warn users.
> Here is my reading of the change (please correct me).
> 
> Earlier.
> 
>   - A name that does not begin with a slash could be a remote
>     shorthand.  Check remotes, config and branches in this order
>     and stop once a match is found.
> 
>   - Otherwise use the name as a literal URI.
> 
> This patch.
> 
>   - Config always wins.
> 
>   - A name that does not begin with a slash could be found in
>     remotes or branches; check them in this order.
> 
>   - Otherwise use it as is.
> 
> Theoretically people _could_ have had a config like
> 
> 	[remote "/pub"]
> 		url = blah
> 
> but it would never have matched.  This ``broken'' config file
> suddenly start to interfere when somebody does:
> 
> 	$ git push /pub

This is true, and I missed it before. Feel free to mention it in the 
appropriate commit message.

> Also people may have had a remotes and config of the same name,
> and currently what is defined in config is ignored, but with the
> new code, config takes precedence.  Which is unarguably good,
> but still a change I should remember to write down in the
> release notes, hence prefer to have it clearly described in the
> commit log message.

This is in the message for [1/3] already, along with the other change: it 
will use the current branch's remote, if there is one, instead of "origin" 
if no repository is given on the command line.

I was only claiming here (incorrectly, it turns out) that the configured 
remote vs. literal URI behavior is the same with this series.

> We probably would not care about the first difference, but it is
> easy enough to guard against, I think.  Perhaps with this patch?
> 
> -- >8 --
> diff --git a/remote.c b/remote.c
> index 1dd2e77..05df196 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -149,7 +149,24 @@ static int handle_config(const char *key, const char *value)
>  	subkey = strrchr(name, '.');
>  	if (!subkey)
>  		return error("Config with no key for remote %s", name);
> +	if (*subkey == '/')
> +		return error("Config remote shorthand cannot begin with '/': %s", name);

Maybe just return? If we change the behavior to give an error in this 
situation, we might as well make the config file actually take effect 
instead.

	-Daniel
*This .sig left intentionally blank*
