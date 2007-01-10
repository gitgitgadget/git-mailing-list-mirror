From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] sha1_name(): accept ':directory/' to get at the cache_tree
Date: Wed, 10 Jan 2007 01:22:44 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701100108460.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701091502030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vodp7iwzu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 01:22:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4REv-0007Qi-8A
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 01:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbXAJAWr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 19:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbXAJAWr
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 19:22:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:60856 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932581AbXAJAWq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 19:22:46 -0500
Received: (qmail invoked by alias); 10 Jan 2007 00:22:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 10 Jan 2007 01:22:44 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodp7iwzu.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36439>

Hi,

On Tue, 9 Jan 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	'tis a resend of an earlier patch, but without support for the
> > 	bogus ":." as equivalent to ":/".
> >
> > 	I find this feature highly convenient when I just want to see
> > 	what files the index contains.
> 
> I do not understand; do you mean ls-files?

It is the same as ls-files, except "show" is shorter, is labeled as 
porcelain, easier to remember, _and_ it runs the pager automatically.

> In any case, I wonder if this does a sane thing if you asked
> "git show :3:t/" on a fully merged index.

No. That slipped through. The code will just ignore the stage (if 
specified) for trees.

> > @@ -561,6 +562,23 @@ int get_sha1(const char *name, unsigned char *sha1)
> >  			}
> >  			pos++;
> >  		}
> > +		if (namelen > 0 && cp[namelen - 1] == '/')
> > +			namelen--;
> > +		if (namelen == 0 || (ce && ce_namelen(ce) > namelen &&
> > +					ce->name[namelen] == '/' &&
> > +					!memcmp(ce->name, cp, namelen))) {
> 
> I may be misreading the code, but what does ce point at?  Does
> this get the index sort order correctly?

It is still at what cache_name_pos(cp, namelen) pointed to, or NULL if 
the entry does not exist (e.g. there is no cache entry, or all cache 
entries are lexicographically smaller).

> For example, would this work?
> 
> 	$ echo >t- && git add t-
>         $ git show :t
> 	$ git show :t/

I think so: The code explicitely checks for a trailing '/'. (See second 
last line of the hunk you quoted.)

> > +			struct cache_tree *tree =
> > +				cache_tree_find(active_cache_tree, cp);
> > +			if (!cache_tree_fully_valid(tree)) {
> > +				ret = cache_tree_update(active_cache_tree,
> > +						active_cache, active_nr, 0, 0);
> > +				if (ret < 0)
> > +					return ret;
> 
> This gracefully errs out when the index is unmerged but fails to
> pretend the index knows about trees, if the unmerged part of
> index is outside the directory the user specified.

That is correct. But in that case, we cannot sanely ask the question "what 
would the tree object look like if we committed right now?"

> In short, I am not sure if it is worth it, and especially if the 
> motivation is to pretend as if the index contains trees, I would be 
> opposed to it.  The index does _not_ contain trees, and cache-tree is a 
> pure optimization for the next write-tree. Nothing more.

Well, it _is_ the method to construct tree objects for committing them.

> If it (pretending as if the index contains trees) is just a means to 
> achieve something else worthy, I would not necessarily oppose to that 
> goal, but I do not see what it is, and I do not know if the approach is 
> right...

I wanted to have it for teaching purposes. And maybe a little bit for 
completeness.

But then it turned out that I even use it before committing, like when I 
ask "what files would be in my next revision?" It is not a question 
arising daily, but sometimes it is interesting to see _before_ committing 
them. (Note that I am not only interested in the _modified_ files.)

But if you feel strongly about that feature, don't take the patch.

Ciao,
Dscho
