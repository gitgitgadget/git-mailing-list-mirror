From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/6] git rm: Support for removing submodules
Date: Sat, 13 Sep 2008 00:24:29 +0200
Message-ID: <20080912222429.GE10360@machine.or.cz>
References: <20080912210817.31628.69014.stgit@localhost> <20080912210902.31628.7325.stgit@localhost> <7v8wtxniez.fsf@gitster.siamese.dyndns.org> <7v1vzpnhzj.fsf@gitster.siamese.dyndns.org> <20080912210817.31628.69014.stgit@localhost> <20080912210902.31628.7325.stgit@localhost> <7v8wtxniez.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 13 00:25:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeH59-0006Yp-9g
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 00:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756609AbYILWYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 18:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753641AbYILWYb
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 18:24:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48939 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752558AbYILWYa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 18:24:30 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 0EE0B3939B43; Sat, 13 Sep 2008 00:24:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v1vzpnhzj.fsf@gitster.siamese.dyndns.org> <7v8wtxniez.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95782>

I will collect your feedback on the whole series, then resend it from
scratch - sounds good?

On Fri, Sep 12, 2008 at 02:49:56PM -0700, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > @@ -20,7 +20,8 @@ and no updates to their contents can be staged in the index,
> >  though that default behavior can be overridden with the `-f` option.
> >  When '--cached' is given, the staged content has to
> >  match either the tip of the branch or the file on disk,
> > -allowing the file to be removed from just the index.
> > +allowing the file to be removed from just the index;
> > +this is always the case when removing submodules.
> 
> Sorry, I read this three times but "this" is unclear to me.  Different and
> mutually incompatible interpretations I tried to understand it are:
> 
>  (1) When removing submodules, whether --cached or not, the index can
>      match either HEAD or the work tree; this is different from removing
>      regular blobs where the index must match with HEAD without --cached
>      nor -f;
> 
>  (2) When removing submodules with --cached, the index can match either
>      HEAD or the work tree and it is removed only from the index.  You
>      cannot remove submodules without --cached;
> 
>  (3) When removing submodules, the index can match either HEAD or the work
>      tree and it is removed only from the index, even if you did not give
>      --cached;
> 
> It later becomes clear that you meant (3) in the second hunk, but the
> first time reader of the resulting document (not this patch) won't be
> reading from bottom to top.
> 
> This is a leftover issue from ealier documentation 25dc720 (Clarify and
> fix English in "git-rm" documentation, 2008-04-16), but the description is
> unclear what should happen while working towards the initial commit
> (i.e. no HEAD yet).  I think check_local_mod() allows removal in such a
> case.  Perhaps you can clarify the point while at it, please?

I will have a look.

> > diff --git a/builtin-rm.c b/builtin-rm.c
> > index 6bd8211..7475de2 100644
> > --- a/builtin-rm.c
> > +++ b/builtin-rm.c
> > ...
> > -static void add_list(const char *name)
> > +static void add_list(const char *name, int is_gitlink)
> >  {
> >  	if (list.nr >= list.alloc) {
> >  		list.alloc = alloc_nr(list.alloc);
> > -		list.name = xrealloc(list.name, list.alloc * sizeof(const char *));
> > +		list.info = xrealloc(list.info, list.alloc * sizeof(*list.info));
> >  	}
> 
> ALLOC_GROW()?

Neat thing!

> > @@ -38,6 +44,13 @@ static int remove_file(const char *name)
> >  	if (ret && errno == ENOENT)
> >  		/* The user has removed it from the filesystem by hand */
> >  		ret = errno = 0;
> > +	if (ret && errno == EISDIR) {
> > +		/* This is a gitlink entry; try to remove at least the
> > +		 * directory if the submodule is not checked out; we always
> > +		 * leave the checked out ones as they are */
> 
> 	/*
> 	 * Style?
>          * for a multi-line comment.
>          */

Right - I will have to get used to this. ;-)

> > +static void remove_submodule(const char *name)
> > +{
> > +	char *key = submodule_by_path(name);
> > +	char *sectend = strrchr(key, '.');
> > +
> > +	assert(sectend);
> > +	*sectend = 0;
> 
> Here is one caller I questioned in my comments on [1/6].  It is clear this
> caller wants to use "submodule.xyzzy" out of "submodule.xyzzy.path".  The
> function returning "submodule.xyzzy.path" does not feel like a clean and
> reusable interface to me.  I'd suggest either returning "submodule.xyzzy"
> (that's too specialized only for this caller to my taste, though), or just
> "xyzzy" and have the caller synthesize whatever string it wants to use
> (yes, it loses microoptimization but do we really care about it in this
> codepath?), if you have other callers that want different strings around
> "xyzzy".

This is still easier to use than explicit snprintf(), but in the long
run, you're right that returning just the submodule name is the right
thing. I will change the API.

> > @@ -140,7 +169,7 @@ static struct option builtin_rm_options[] = {
> >  
> >  int cmd_rm(int argc, const char **argv, const char *prefix)
> >  {
> > -	int i, newfd;
> > +	int i, newfd, subs;
> 
> Perhaps hoist "int removed" up one scope level and reuse it?  I misread
> that you are counting the number of gitlinks in the index, not the number
> of gitlinks that is being removed, on my first read.  The variable is used
> for the latter.

Sensible idea.

On Fri, Sep 12, 2008 at 02:59:12PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> +{
> >> +	char *key = submodule_by_path(name);
> >> +	char *sectend = strrchr(key, '.');
> >> +
> >> +	assert(sectend);
> >> +	*sectend = 0;
> >
> > Here is one caller I questioned in my comments on [1/6]...
> 
> Another thing --- can submodule_by_path() ever return NULL saying "I do
> not see one in the configuration"?

No, it would rather die().

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
