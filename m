From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/6] copy vs rename detection: avoid unnecessary O(n*m)
 loops
Date: Fri, 26 Oct 2007 16:10:09 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710261600510.30120@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.or
 g> <alpine.LFD.0.999.0710251119120.30120@woody.linux-foundation.org>
 <7vabq5wkri.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 01:10:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlYK3-0005m0-Bh
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 01:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774AbXJZXKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 19:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752801AbXJZXKX
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 19:10:23 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54494 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752651AbXJZXKW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Oct 2007 19:10:22 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9QNAAhN006693
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 26 Oct 2007 16:10:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9QNA9M5019258;
	Fri, 26 Oct 2007 16:10:10 -0700
In-Reply-To: <7vabq5wkri.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-3.234 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62450>



On Fri, 26 Oct 2007, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > @@ -2640,27 +2640,21 @@ static void diff_resolve_rename_copy(void)
> >  		 * either in-place edit or rename/copy edit.
> >  		 */
> >  		else if (DIFF_PAIR_RENAME(p)) {
> > +			/*
> > +			 * A rename might have re-connected a broken
> > +			 * pair up, causing the pathnames to be the
> > +			 * same again. If so, that's not a rename at
> > +			 * all, just a modification..
> > +			 *
> > +			 * Otherwise, see if this source was used for
> > +			 * multiple renames, in which case we decrement
> > +			 * the count, and call it a copy.
> >  			 */
> > +			if (!strcmp(p->one->path, p->two->path))
> > +				p->status = DIFF_STATUS_MODIFIED;
> > +			else if (--p->one->rename_used > 0)
> >  				p->status = DIFF_STATUS_COPIED;
> > +			else
> >  				p->status = DIFF_STATUS_RENAMED;
> >  		}
> >  		else if (hashcmp(p->one->sha1, p->two->sha1) ||
> 
> The interaction between the above and ...

Heh.

I'm pretty sure it's right, because:

> > @@ -338,15 +320,25 @@ void diffcore_rename(struct diff_options *options)
> >  				locate_rename_dst(p->two, 1);
> >  		}
> >  		else if (!DIFF_FILE_VALID(p->two)) {
> > +			/*
> > +			 * If the source is a broken "delete", and
> >  			 * they did not really want to get broken,
> >  			 * that means the source actually stays.
> > +			 * So we increment the "rename_used" score
> > +			 * by one, to indicate ourselves as a user
> > +			 */
> > +			if (p->broken_pair && !p->score)
> > +				p->one->rename_used++;
> > +			register_rename_src(p->one, p->score);
> > +		}
> > +		else if (detect_rename == DIFF_DETECT_COPY) {
> > +			/*
> > +			 * Increment the "rename_used" score by
> > +			 * one, to indicate ourselves as a user.
> >  			 */
> > +			p->one->rename_used++;
> > +			register_rename_src(p->one, p->score);
> >  		}
> >  	}
> >  	if (rename_dst_nr == 0 || rename_src_nr == 0)
> >  		goto cleanup; /* nothing to do */
> 
> ... this part feels a bit too subtle for a still-jet-lagged
> brain to grok.  I wonder what happens if the preimage of a
> broken pair is used as the rename source for more than two
> postimages.

The nice thing about the whole counting thing is that we really don't even 
care. What happens is:

 - *if* any rename at all happens, the rename detection will increment the 
   "rename_used" thing even more for the source (once for each rename)

 - so if the rename_used started out non-zero, it will never become zero 
   in diff_resolve_rename_copy(), and every single detected "rename" will 
   be considered a copy - exactly like we want.

 - in other words, a "rename_used++" before rename-detection guarantees 
   that you never see a rename, only a copy of the source.

The above is actually true *even*if* the 

	if (!strcmp(p->one->path, p->two->path))

code in diff_resolve_rename_copy() actually triggers, so we could have 
(and at one point I did) done the "--p->one->rename_used > 0" test before 
the strcmp() test, and it would all continue to work fine. However, the 
reason that I put the strcmp() first is that it needs to be done whether 
we decide to consider it a "copy" or a "rename" (so we cannot avoid it 
anyway), and *if* it triggers, we actually want to avoid the rename_used 
going down to zero anyway (not that it would, because I think it's bound 
to be one of the cases where we pre-incremented the count), so not doing 
the decrement there is equivalent to doing another pre-increment.

So I think it's all right, and more obviously right than it used to be. 
But hey, it's possible that I missed something.

		Linus
