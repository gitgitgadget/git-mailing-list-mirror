From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 03/18] notes.h/c: Clarify the handling of notes objects that are == null_sha1
Date: Wed, 6 Oct 2010 00:30:25 +0200
Message-ID: <201010060030.26335.johan@herland.net>
References: <1285719811-10871-1-git-send-email-johan@herland.net> <1285719811-10871-4-git-send-email-johan@herland.net> <20101005152120.GE12797@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, bebarino@gmail.com, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 00:30:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3G1k-0004pQ-EC
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 00:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757346Ab0JEWaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 18:30:20 -0400
Received: from mail.mailgateway.no ([82.117.37.108]:56020 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461Ab0JEWaT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 18:30:19 -0400
Received: from dslb-088-073-123-190.pools.arcor-ip.net ([88.73.123.190] helo=epsilon.localnet)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1P3G1Y-000MPA-0i; Wed, 06 Oct 2010 00:30:16 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.32-24-generic; KDE/4.4.2; i686; ; )
In-Reply-To: <20101005152120.GE12797@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158255>

On Tuesday 5. October 2010 17.21.20 Jonathan Nieder wrote:
> Johan Herland wrote:
> > The only functional changes in this patch concern the handling of
> > null_sha1 in notes_tree_insert(). Otherwise the patch consists solely of
> > reordering functions in notes.c to avoid use-before-declaration
> 
> Would it makes sense to split off that no-op as a separate patch?

Yes. This will be done in the next iteration.

> > --- a/notes.c
> > +++ b/notes.c
> > @@ -175,7 +248,10 @@ static void note_tree_insert(struct notes_tree *t, struct int_node *tree,
> > 
> >  	switch (GET_PTR_TYPE(*p)) {
> >  	
> >  	case PTR_TYPE_NULL:
> >  		assert(!*p);
> > 
> > -		*p = SET_PTR_TYPE(entry, type);
> > +		if (is_null_sha1(entry->val_sha1))
> > +			free(entry);
> > +		else
> > +			*p = SET_PTR_TYPE(entry, type);
> > 
> >  		return;
> >  	
> >  	case PTR_TYPE_NOTE:
> >  		switch (type) {
> 
> No note present, but the node for one is.  This skips insertion of
> empty notes, for consistency with:
> 
> > @@ -191,6 +267,9 @@ static void note_tree_insert(struct notes_tree *t, struct int_node *tree,
> > 
> >  					    sha1_to_hex(l->val_sha1),
> >  					    sha1_to_hex(entry->val_sha1),
> >  					    sha1_to_hex(l->key_sha1));
> > 
> > +
> > +				if (is_null_sha1(l->val_sha1))
> > +					note_tree_remove(t, tree, n, entry);
> 
> The note-present case, where the combine_notes() function can
> return a null sha1 to request that a note be removed.
> 
> >  				free(entry);
> >  				return;
> >  			
> >  			}
> > 
> > @@ -222,6 +301,10 @@ static void note_tree_insert(struct notes_tree *t, struct int_node *tree,
> > 
> >  	/* non-matching leaf_node */
> >  	assert(GET_PTR_TYPE(*p) == PTR_TYPE_NOTE ||
> >  	
> >  	       GET_PTR_TYPE(*p) == PTR_TYPE_SUBTREE);
> > 
> > +	if (is_null_sha1(entry->val_sha1)) { /* skip insertion of empty note */
> > +		free(entry);
> > +		return;
> > +	}
> 
> The more usual no-note-present case.  Again, this skips insertion
> of empty notes.

All correct.

> Do I understand correctly that the point of the main point of
> this patch is to allow combine_notes() functions to request
> that a note be deleted?  If so, it would be nice if the commit
> message said so.

Indeed, that is the main point. I believe the paragraph following the
commit subject did indeed explain this, but I will try to clarify this
further in the next iteration.

> Regardless, for what it's worth,
> Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks,

...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
