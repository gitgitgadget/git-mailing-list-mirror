From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 4/8] Add a function to set a non-default work tree
Date: Sun, 20 Apr 2008 15:52:30 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804201546340.19665@iabervon.org>
References: <alpine.LNX.1.00.0804171931550.19665@iabervon.org> <7vprslcdxf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 21:53:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnfbC-0001L7-2K
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 21:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755833AbYDTTwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 15:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756137AbYDTTwc
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 15:52:32 -0400
Received: from iabervon.org ([66.92.72.58]:55250 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755730AbYDTTwb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 15:52:31 -0400
Received: (qmail 10236 invoked by uid 1000); 20 Apr 2008 19:52:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Apr 2008 19:52:30 -0000
In-Reply-To: <7vprslcdxf.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79982>

On Sat, 19 Apr 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > ---
> >  cache.h       |    1 +
> >  environment.c |    6 ++++++
> >  2 files changed, 7 insertions(+), 0 deletions(-)
> >
> > diff --git a/cache.h b/cache.h
> > index 96dcb49..d88a4e2 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -311,6 +311,7 @@ extern char *get_index_file(void);
> >  extern char *get_graft_file(void);
> >  extern int set_git_dir(const char *path);
> >  extern const char *get_git_work_tree(void);
> > +extern void set_git_work_tree(const char *tree);
> >  
> >  #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
> >  
> > diff --git a/environment.c b/environment.c
> > index 6739a3f..d6c6a6b 100644
> > --- a/environment.c
> > +++ b/environment.c
> > @@ -81,6 +81,12 @@ const char *get_git_dir(void)
> >  	return git_dir;
> >  }
> >  
> > +void set_git_work_tree(const char *new_work_tree)
> > +{
> > +	get_git_work_tree(); /* make sure it's initialized */
> > +	work_tree = xstrdup(make_absolute_path(new_work_tree));
> > +}
> > +
> 
> Somehow this feels wrong.  Maybe you would need to move that "static int"
> variable inside get_git_work_tree() outside so that you can reset from
> this new function at will?

Yeah, that's better.

> How should the setting of new work tree from sideways using this interface
> interact with bareness of the repository?

I'm only using it before any initialization and when I'm going to force 
the repository (which doesn't even exist yet; I haven't set git_dir let 
alone created it, let alone looked at its configuration) to be bare, so I 
hadn't considered that.

> Should it reset is_bare_repository_cfg to zero?  Should it refuse to set a
> work tree if is_bare_repository_cfg is true already?

is_bare_repository_cfg starts out -1 (not yet specified); this should 
probably set it to false and require that it not have been specified 
previously.

	-Daniel
*This .sig left intentionally blank*
