From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-mv: Keep moved index entries inact
Date: Mon, 21 Jul 2008 02:23:54 +0200
Message-ID: <20080721002354.GK10151@machine.or.cz>
References: <20080717130651.GU32184@machine.or.cz> <20080717223036.20680.9672.stgit@localhost> <7vej5pwhub.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 02:24:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKjCx-0001Xs-KL
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 02:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364AbYGUAX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 20:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755047AbYGUAX4
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 20:23:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43647 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754475AbYGUAXz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 20:23:55 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 55282393B32D; Mon, 21 Jul 2008 02:23:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vej5pwhub.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89278>

On Sat, Jul 19, 2008 at 04:54:20PM -0700, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > diff --git a/read-cache.c b/read-cache.c
> > index 1648428..70e5f57 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -38,6 +38,21 @@ static void replace_index_entry(struct index_state *istate, int nr, struct cache
> >  	istate->cache_changed = 1;
> >  }
> >  
> > +void rename_index_entry_at(struct index_state *istate, int nr, const char *new_name)
> > +{
> > +	struct cache_entry *old = istate->cache[nr], *new;
> > +	int namelen = strlen(new_name);
> > +
> > +	new = xmalloc(cache_entry_size(namelen));
> > +	copy_cache_entry(new, old);
> > +	new->ce_flags = (new->ce_flags & ~CE_NAMEMASK) | namelen;
> > +	memcpy(new->name, new_name, namelen);
> > +
> > +	cache_tree_invalidate_path(istate->cache_tree, old->name);
> > +	remove_index_entry_at(istate, nr);
> > +	add_index_entry(istate, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
> > +}
> 
> Hmm, would this use of copy_cache_entry() kosher, I have to wonder.  This
> new copy of cache entry begins its life unhashed, doesn't it?  Shouldn't
> we be not copying its hashed/unhashed bits from the old one?
> 
> Also setting of that ce_flags looks wrong when namelen does not fit within
> the width of CE_NAMEMASK.  Shouldn't it be doing the same thing as
> create_ce_flags()?

I have to admit that I don't clearly understand all the index entry
intricacies. It is good you didn't see my earlier misguided attempts.
:-) I have patched the two mistakes you pointed out. It is too bad I
cannot simply use existing functions for this, but I want to keep a
different set of traits that either copy_cache_entry() or
create_ce_flags() assumes.

> > diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> > index 336cfaa..6b615f8 100755
> > --- a/t/t7001-mv.sh
> > +++ b/t/t7001-mv.sh
> > @@ -156,4 +156,61 @@ test_expect_success 'absolute pathname outside should fail' '(
> >  
> >  )'
> >  
> > +# git mv meets angry Git maintainer
> 
> What's this comment about?

Oh. Well, you sounded agitated in your original mail, but this actually
just slipped through. :-)

> > +test_expect_success 'git mv should not change sha1 of moved cache entry' '
> > +
> > +	rm -fr .git &&
> > +	git init &&
> > +	echo 1 >dirty &&
> > +	git add dirty &&
> > +	entry="$(git ls-files --stage dirty | cut -f 1)"
> 
> "rev-parse :dirty"?

I want to make sure the whole index entry is intact, not just the sha1.

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
