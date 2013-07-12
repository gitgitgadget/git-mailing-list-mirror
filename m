From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [RFC PATCH] During a shallow fetch, prevent sending over
 unneeded objects
Date: Fri, 12 Jul 2013 09:11:57 +0200
Message-ID: <20130712071157.GL10217@login.drsnuggles.stderr.nl>
References: <20130711220127.GK10217@login.drsnuggles.stderr.nl>
 <7vsizkpv21.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 09:12:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxXWU-000544-0a
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 09:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757101Ab3GLHMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 03:12:06 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:46101 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756888Ab3GLHMF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 03:12:05 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1UxXWH-0004OF-Aj; Fri, 12 Jul 2013 09:12:00 +0200
Received: (nullmailer pid 16876 invoked by uid 1000);
	Fri, 12 Jul 2013 07:11:57 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vsizkpv21.fsf@alter.siamese.dyndns.org>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230183>

Hi Junio,

> [administrivia: you seem to have mail-followup-to that points at you
> and the list; is that really needed???]
I'm not subscribed to the list, so yes :-)

> > This happens when a client issues a fetch with a depth bigger or equal
> > to the number of commits the server is ahead of the client.
> 
> Do you mean "smaller" (not "bigger")?
Yes, I meant smaller (reworded this first sentence a few times and then messed
up :-)

> > diff --git a/upload-pack.c b/upload-pack.c
> > index 59f43d1..5885f33 100644
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -122,6 +122,14 @@ static int do_rev_list(int in, int out, void *user_data)
> >  	if (prepare_revision_walk(&revs))
> >  		die("revision walk setup failed");
> >  	mark_edges_uninteresting(revs.commits, &revs, show_edge);
> > +	/* In case we create a new shallow root, make sure that all
> > +	 * we don't send over objects that the client already has just
> > +	 * because their "have" revisions are no longer reachable from
> > +	 * the shallow root. */
> > +	for (i = 0; i < have_obj.nr; i++) {
> > +		struct commit *commit = (struct commit *)have_obj.objects[i].item;
> > +		mark_tree_uninteresting(commit->tree);
> > +	}
> 
> Hmph.
> 
> In your discussion (including the comment), you talk about "shallow
> root" (I think that is the same as what we call "shallow boundary"),
I think so, yes. I mean to refer to the commits referenced in
.git/shallow, that have their parents "hidden".

> but in this added block, there is nothing that checks CLIENT_SHALLOW
> or SHALLOW flags to special case that.
>
> Is it a good idea to unconditionally do this for all "have"
> revisions?
That's what I meant in my mail with "applying the fix unconditionally" -
there is probably some check needed (I discussed a few options in the
mail as well).

Note that this entire do_rev_list function is only called when there are
shallow revisions involved, so there is also a basic "only when shallow"
check in place.

> Also there is another loop that iterates over "have" revisions just
> above the precontext.  I wonder if this added code belongs in that
> loop.
I think we could add it there, yes. On the other hand, if we only want
to execute this code when there are shallow boundaries in the list of
revisions to send (as I suggested in my previous mail), then we can't
move this code up.

Gr.

Matthijs
