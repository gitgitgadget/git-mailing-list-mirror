From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/7] Foreign VCS support
Date: Thu, 18 Jun 2009 14:07:43 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0906181349090.2147@iabervon.org>
References: <alpine.LNX.2.00.0905271328160.2147@iabervon.org> <20090615162641.GA14735@padd.com> <alpine.LNX.2.00.0906151429220.2147@iabervon.org> <20090616123712.GA3954@arf.padd.com> <alpine.LNX.2.00.0906161121590.2147@iabervon.org>
 <20090618115341.GC18449@arf.padd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 20:07:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHM1h-0006S8-7B
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 20:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469AbZFRSHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 14:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752993AbZFRSHm
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 14:07:42 -0400
Received: from iabervon.org ([66.92.72.58]:37457 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752871AbZFRSHm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 14:07:42 -0400
Received: (qmail 13344 invoked by uid 1000); 18 Jun 2009 18:07:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Jun 2009 18:07:43 -0000
In-Reply-To: <20090618115341.GC18449@arf.padd.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121864>

On Thu, 18 Jun 2009, Pete Wyckoff wrote:

> barkalow@iabervon.org wrote on Tue, 16 Jun 2009 13:29 -0400:
> > On Tue, 16 Jun 2009, Pete Wyckoff wrote:
> > > //depot/path/to/project/dir/foo.txt
> > > ... #1 change 555 branch on 2001/02/03 by x@y (ktext) 'Branch oldproj @444'
> > > ... ... branch into //depot/path/to/branch1/dir/foo.txt#1
> > > ... ... branch into //depot/path/to/branch2/dir/foo.txt#1
> > > ... ... branch into //depot/path/to/branch3/dir/foo.txt#1
> > > ... ... branch from //depot/oldproj/dir/main/foo.txt#1,#28
> > >
> > > The name and the "into" branches are in current use.  The last
> > > "from" branch is the historic location from where everything was
> > > moved recently.  Note the extra "main/" directory in there.  This
> > > pattern is common throughout the historic depot format, but it
> > > confuses get_related_file(), which complains and returns NULL.
> > 
> > So you've got a per-project mainline, which is integrated into branches. 
> > My depot used to have mainlines, but eventually ditched them in favor of 
> > only having branches, where 1.2 integrates into 1.3, and 1.3 integrates 
> > into 1.4, and so on.
> > 
> > I'm surprised that the "main" is confusing get_related_file(); I'd think 
> > that it would decide that //depot/oldproj/dir/main/foo.txt is foo.txt in 
> > the codeline //depot/oldproj/dir/main/.
> 
> Because I'm trying to get it to fetch //depot/path/to/project
> so the base->name is "/dir/foo.txt" and the path is
> "//depot/oldproj/dir/main/foo.txt".
> 
> I hacked the code to look for the basename as well.  It worked
> further, but added a codeline for every directory that had ever
> existed.

Yeah, that's going to be a problem. If everything in a project could
systematically move, there's no way to determine that the codeline used 
to be //depot/oldproj/ as opposed to anything else. But I suppose it could 
notice that /dir/foo.txt came from (...)/dir/(...)/foo.txt. That is, the 
base name matches, and there's a unique occurence of the name of the 
subdirectory of the root for the file.

> > > I don't particularly want to maintain this historic codeline
> > > information, even if vcs-p4 could figure it out.  Is there a way
> > > just to import the history of the file without having it be part of
> > > a discovered codeline?  Perhaps always call get_codeline() and let
> > > me use ignore_codelines to skip the oldproj ones by hand?  I do want
> > > git to know about the "branch1" and similar, though, eventually.
> > 
> > In general, I just write my fetch rules so that the old codelines get 
> > discovered and imported (so that the history is there), but then they 
> > aren't fetched. That is, they're junk in refs/p4/* (which lets git keep 
> > track of the fact that it imported them), but they don't end up in 
> > refs/remotes/origin/*.
> 
> I ended up using a codelineformat regex to pick out just the recent
> branches, ignoring all the history.  This did mostly work, like how
> the git-p4 script would do things.  That's okay for me, as I didn't
> need the gobs of history anyway.  I do need to handle cross-codeline
> integrates that happen in the future nicely, though.  Maybe now I
> can relax the regexp and have it discover new codelines only if
> they appear in future integrates.

You might be able to set up a codelineformat regex to match any codeline 
in the current depot layout, and then use the findBranches setting.

> Here's the combined patch that I ended up with.  Don't bother
> preserving this, just roll the good bits into your patches in the
> future.

Thanks!

> If you make any nice changes, please send out the patches again.  I
> would like to give it another spin once I have some recent
> integrates to play with.
> 
> 		-- Pete
> 
> 
> diff --git a/vcs-p4/vcs-p4.c b/vcs-p4/vcs-p4.c
> index b1cff2f..dcbda78 100644
> --- a/vcs-p4/vcs-p4.c
> +++ b/vcs-p4/vcs-p4.c
> @@ -96,6 +96,7 @@ static struct p4_codeline *get_codeline(struct p4_depot *depot, const char *path
>  	struct p4_codeline **posn, *codeline;
>  	int i;
>  	unsigned char sha1[20];
> +	char *refname;
>  
>  	if (codeline_regex && regexec(codeline_regex, path, 0, NULL, 0))
>  		return NULL;
> @@ -103,6 +104,12 @@ static struct p4_codeline *get_codeline(struct p4_depot *depot, const char *path
>  	for (posn = &depot->codelines; *posn; posn = &(*posn)->next)
>  		if (!strcmp(path, (*posn)->path))
>  			return *posn;
> +
> +	refname = codeline_to_refname(path);
> +	if (refname == NULL) {
> +		fprintf(stderr, "%s: invalid codeline %s\n", __func__, path);
> +		return NULL;
> +	}

What sorts of invalid codelines was this turning up?

>  	codeline = xcalloc(1, sizeof(*codeline));
>  	codeline->depot = depot;
>  	codeline->path = xstrdup(path);
> @@ -111,7 +118,7 @@ static struct p4_codeline *get_codeline(struct p4_depot *depot, const char *path
>  		if (!strcmp(path, ignore_codelines[i]))
>  			codeline->ignore = 1;
>  
> -	codeline->refname = codeline_to_refname(path);
> +	codeline->refname = refname;
>  	if (!get_sha1(codeline->refname, sha1)) {
>  		struct commit *commit = lookup_commit(sha1);
>  		char *field;
> @@ -129,6 +136,7 @@ static struct p4_codeline *get_codeline(struct p4_depot *depot, const char *path
>  		}
>  	}
>  	*posn = codeline;
> +	fprintf(stderr, "added codeline %s\n", codeline->path);
>  	return codeline;
>  }
>  
> @@ -210,27 +218,51 @@ static struct p4_file *get_file_by_full(struct p4_codeline *codeline,
>  	return *posn;
>  }
>  
> +#define dfprintf(fp, ...)
> +/* #define dfprintf fprintf */
> +
>  static struct p4_file *get_related_file(struct p4_file *base, const char *path)
>  {
> -	int basenamelen = strlen(base->name);
> -	int reldirlen = strlen(path) - basenamelen;
> +	int basenamelen, reldirlen;
>  	struct p4_codeline *codeline;
> -	if (reldirlen > 0 && !strcmp(path + reldirlen, base->name)) {
> +	const char *cp;
> +
> +	cp = base->name;
> +strip:
> +	basenamelen = strlen(cp);
> +	reldirlen = strlen(path) - basenamelen;
> +	dfprintf(stderr, "consider base %s in path %s\n", cp, path);
> +	if (reldirlen > 0 && !strcmp(path + reldirlen, cp)) {
>  		/* File with the same name in another codeline */
> -		char *other = xstrndup(path, reldirlen);
> -		//printf("# find %s in %s\n", path, other);
> +		char *other;
> +
> +		/* else later filelog will add another / and fail */
> +		if (path[reldirlen-1] == '/')
> +			--reldirlen;
> +		other = xstrndup(path, reldirlen);
> +		dfprintf(stderr, "look for %s in %s\n", path, other);
>  		codeline = get_codeline(base->codeline->depot, other);
> -		free(other);
> -		if (codeline)
> +		if (codeline) {
> +			dfprintf(stderr, "found %s in %s\n", path, other);
> +			free(other);
>  			return get_file_by_full(codeline, path);
> -		return NULL;
> +		} else {
> +			free(other);
> +		}
> +	}
> +	/* strip just the basename and try again to find it */
> +	cp = strrchr(cp, '/');
> +	if (cp) {
> +		++cp;
> +		goto strip;
>  	}
> +	dfprintf(stderr, "look for %s directly\n", path);
>  	codeline = find_codeline(base->codeline->depot, path);
>  	if (codeline) {
>  		/* File with a different name in some known codeline */
>  		return get_file_by_full(codeline, path);
>  	}
> -	fprintf(stderr, "Trying to identify %s\n", path);
> +	dfprintf(stderr, "failed to find codeline for %s\n", path);
>  	/* Not in any known codeline; need to recheck this after
>  	 * discovering codelines completes.
>  	 */
> @@ -615,7 +647,7 @@ static void p4_filelog_cb(struct p4_filelog_data *data,
>  			rev = strtoul(posn, &posn, 10);
>  			if (*posn != ',')
>  				break;
> -			posn += 2;
> +			posn += 2;  /* skip ,# */
>  		} while (1);
>  		if (from) {
>  			struct p4_file *rel_file =
> @@ -1168,11 +1200,6 @@ int main(int argc, const char **argv)
>  		} else if (!strcmp(buf.buf, "list")) {
>  			int i;
>  
> -			git_config(handle_config, remote);
> -
> -			ALLOC_GROW(env, env_nr + 1, env_alloc);
> -			env[env_nr++] = NULL;
> -
>  			if (find_new_codelines) {
>  				struct p4_codeline *codeline;
>  				save_commit_buffer = 1;
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
