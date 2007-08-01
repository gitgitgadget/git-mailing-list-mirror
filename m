From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] Clean up work-tree handling
Date: Wed, 1 Aug 2007 12:53:56 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708011250020.14781@racer.site>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
 <Pine.LNX.4.64.0708010058130.14781@racer.site> <Pine.LNX.4.64.0708010129530.14781@racer.site>
 <7vvebz7hpw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, matled@gmx.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 13:54:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGCmb-0003i5-Am
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 13:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759933AbXHALyW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 07:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759900AbXHALyW
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 07:54:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:42635 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758213AbXHALyV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 07:54:21 -0400
Received: (qmail invoked by alias); 01 Aug 2007 11:54:20 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp039) with SMTP; 01 Aug 2007 13:54:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18BcCJCO8gBELxCZrKSVbR6B8xOAfQ6cDtIRVP2W4
	iw20BLdvw2aYkE
X-X-Sender: gene099@racer.site
In-Reply-To: <7vvebz7hpw.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54431>

Hi,

On Wed, 1 Aug 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > diff --git a/builtin-ls-files.c b/builtin-ls-files.c
> > index 61577ea..d36181a 100644
> > --- a/builtin-ls-files.c
> > +++ b/builtin-ls-files.c
> > @@ -469,9 +469,11 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
> >  		break;
> >  	}
> >  
> > -	if (require_work_tree &&
> > -			(!is_inside_work_tree() || is_inside_git_dir()))
> > -		die("This operation must be run in a work tree");
> > +	if (require_work_tree && !is_inside_work_tree()) {
> > +		const char *work_tree = get_git_work_tree();
> > +		if (!work_tree || chdir(work_tree))
> > +			die("This operation must be run in a work tree");
> > +	}
> >  
> >  	pathspec = get_pathspec(prefix, argv + i);
> >  
> 
> Similarly to this change, I am wondering if we would want to fix
> verify_non_filename() in setup.c, which does this:
> 
> /*
>  * Verify a filename that we got as an argument for a pathspec
>  * entry. Note that a filename that begins with "-" never verifies
>  * as true, because even if such a filename were to exist, we want
>  * it to be preceded by the "--" marker (or we want the user to
>  * use a format like "./-filename")
>  */
> void verify_filename(const char *prefix, const char *arg)
> {
> ...
> }
> 
> /*
>  * Opposite of the above: the command line did not have -- marker
>  * and we parsed the arg as a refname.  It should not be interpretable
>  * as a filename.
>  */
> void verify_non_filename(const char *prefix, const char *arg)
> {
>         const char *name;
>         struct stat st;
> 
>         if (!is_inside_work_tree() || is_inside_git_dir())
>                 return;
>         if (*arg == '-')
>                 return; /* flag */
>         name = prefix ? prefix_filename(prefix, strlen(prefix), arg) : arg;
>         if (!lstat(name, &st))
>                 die("ambiguous argument '%s': both revision and filename\n"
>                     "Use '--' to separate filenames from revisions", arg);
>         if (errno != ENOENT)
>                 die("'%s': %s", arg, strerror(errno));
> }
> 
> At this point, we are given an ambiguous parameter, that could
> be naming a path in the work tree.  If we are not in the work
> tree, then it is understandable that we do not have to barf.
> The other check (i.e. "|| is_inside_git_dir()") does not hurt
> (iow, it is not an incorrect check per-se), because if you did
> "cd .git && git log HEAD" then the HEAD parameter cannot be
> naming the path ".git/HEAD" in the work tree, but (1) that is
> already covered by .git/ being "outside of work tree", and (2)
> it is not something this function wants to check anyway
> (i.e. "can the parameter be naming a file in the work tree?").
> 
> Am I mistaken and/or confused?

I think you are completely right.  Inside a bare repository, "git log 
FETCH_HEAD" should not need to complain.  And I think that the 
"is_inside_git_dir()" could be _replaced_ by "!is_inside_work_tree()", 
since that is the intent of that call.

Ciao,
Dscho
