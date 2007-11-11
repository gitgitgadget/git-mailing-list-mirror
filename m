From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 01/11] Fix memory leak in traverse_commit_list
Date: Sun, 11 Nov 2007 00:17:42 -0500
Message-ID: <20071111051742.GT14735@spearce.org>
References: <20071109110610.GA19368@spearce.org> <7vmytnqbu2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 06:18:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir5Cs-0000Nl-AI
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 06:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbXKKFRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 00:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbXKKFRr
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 00:17:47 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38227 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbXKKFRq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 00:17:46 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ir5Cb-0005RJ-Hs; Sun, 11 Nov 2007 00:17:45 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7B02320FBAE; Sun, 11 Nov 2007 00:17:42 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vmytnqbu2.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64401>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > diff --git a/list-objects.c b/list-objects.c
> > index e5c88c2..713bef9 100644
> > --- a/list-objects.c
> > +++ b/list-objects.c
> > @@ -170,4 +170,11 @@ void traverse_commit_list(struct rev_info *revs,
> >  	}
> >  	for (i = 0; i < objects.nr; i++)
> >  		show_object(&objects.objects[i]);
> > +	free(objects.objects);
> > +	if (revs->pending.nr) {
> > +		revs->pending.nr = 0;
> > +		revs->pending.alloc = 0;
> > +		revs->pending.objects = NULL;
> > +		free(revs->pending.objects);
> > +	}
> >  }
> 
> It is locally verifiable that objects.objects are no longer
> needed after this point, but it made me a bit nervous about
> freeing of revs->pending.objects.
> 
> I think the existing callers are all Ok, but somebody else
> should double check.

There are 5 calllers:

* builtin-fetch.c:

   This one I added with my series.  It doesn't care about the
   pending object list.

* builtin-pack-objects.c:

   This doesn't care about the pending list after the call to
   traverse_commit_list.

* builtin-rev-list.c (2):

   Two calls; the first one is for the bisect case where we print
   bisect stats and then return 0 and the second is the end of
   the program for the non-bisect case.  Neither cares about the
   pending list.

* upload-pack.c:

   This is called in the async thread spawned by upload-pack to
   feed pack-objects.  The last thing the async thread does is run
   traverse_commit_list, at which point it exits.  I actually have
   to wonder why we didn't just teach this trick to pack-objects
   so we could avoid the async complexity here in upload-pack.

So yea, the cleanup here is safe, assuming I didn't make the
extremely obvious leak of setting to NULL then calling free()
(as Dscho pointed out).

-- 
Shawn.
