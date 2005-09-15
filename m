From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Fix fetch completeness assumptions
Date: Thu, 15 Sep 2005 12:54:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509151243020.23242@iabervon.org>
References: <Pine.LNX.4.63.0509142120020.23242@iabervon.org>
 <20050915150205.65378a65.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 18:51:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFwwY-0001Dc-DM
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 18:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbVIOQuf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 12:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030535AbVIOQuf
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 12:50:35 -0400
Received: from iabervon.org ([66.92.72.58]:13575 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1030424AbVIOQue (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 12:50:34 -0400
Received: (qmail 14090 invoked by uid 1000); 15 Sep 2005 12:54:44 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Sep 2005 12:54:44 -0400
To: Sergey Vlasov <vsu@altlinux.ru>
In-Reply-To: <20050915150205.65378a65.vsu@altlinux.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8616>

On Thu, 15 Sep 2005, Sergey Vlasov wrote:

> On Wed, 14 Sep 2005 21:31:42 -0400 (EDT) Daniel Barkalow wrote:
> 
> > Don't assume that any commit we have is complete; assume that any ref
> > we have is complete.
> > 
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > 
> > ---
> > Only lightly tested, but it seems to work. Marks all of the commits in 
> > refs, and their ancestors back as far as the date of the commit it's 
> > processing. If the commit it's processing is marked, it doesn't recurse 
> > into it.
> 
> Seems to work here too (however, previous playing with git-fetch and
> old git-http-fetch left .git/refs/heads/origin.remote pointing to an
> incomplete commit, and this greatly confused the new git-http-fetch).
> 
> Junio, probably you can throw away my patches adding --recover (also I
> forgot to add Signed-off-by for them...) - the automatic recovery
> provided by this patch is better.  Still there is some room for
> improvement...
> 
> > This should make it very difficult to get it to produce a situation where 
> > it completes without giving you complete information, and it shouldn't 
> > process commits that are accessible from refs.
> > 
> >  fetch.c |   28 ++++++++++++++++++++++++++--
> >  1 files changed, 26 insertions(+), 2 deletions(-)
> > 
> > 39216139abc4f2759f7b55d11fa2f7e7c155898c
> > diff --git a/fetch.c b/fetch.c
> > --- a/fetch.c
> > +++ b/fetch.c
> > @@ -62,11 +62,21 @@ static int process_tree(struct tree *tre
> >  	return 0;
> >  }
> >  
> > +struct commit_list *complete = NULL;
> 
> static

Yup.

> > +	if (commit->object.flags & 1)
> > +		return 0;
> 
> Hmm, I would define some constant for this flag at the top of file:
> 
> /* Object flags */
> #define COMPLETE	(1U << 0)
> 
> Otherwise it is hard to see what object flags are used in the code
> (only one flag is used currently, but we may need more in the future).

Yup.

> > +static int mark_complete(const char *path, const unsigned char *sha1)
> > +{
> > +	struct object *obj = parse_object(sha1);
> > +	while (obj->type == tag_type) {
> > +		obj = ((struct tag *) obj)->tagged;
> > +		parse_object(obj->sha1);
> > +	}
> > +	if (obj->type == commit_type) {
> > +		obj->flags |= 1;
> > +		insert_by_date((struct commit *) obj, &complete);
> > +	}
> 
> Dereferencing of tags is already implemented:
> 
> 	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
> 	if (commit) {
> 		commit->object.flags |= 1;
> 		insert_by_date(commit, &complete);
> 	}

Yup. I think I want to untangle some of the functions in commit.c, though, 
because it wasn't sufficiently clear to me how those functions worked for 
me to actually use the right one.

	-Daniel
*This .sig left intentionally blank*
