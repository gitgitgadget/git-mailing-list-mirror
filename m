From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [RFC PATCH] During a shallow fetch, prevent sending over
 unneeded objects
Date: Wed, 7 Aug 2013 12:27:16 +0200
Message-ID: <20130807102716.GA10217@login.drsnuggles.stderr.nl>
References: <20130711220127.GK10217@login.drsnuggles.stderr.nl>
 <7vsizkpv21.fsf@alter.siamese.dyndns.org>
 <20130712071157.GL10217@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 07 12:27:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V70xp-0006D8-GU
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 12:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932772Ab3HGK1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 06:27:24 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:54999 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932662Ab3HGK1W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 06:27:22 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1V70xZ-0008L5-40; Wed, 07 Aug 2013 12:27:18 +0200
Received: (nullmailer pid 32055 invoked by uid 1000);
	Wed, 07 Aug 2013 10:27:17 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20130712071157.GL10217@login.drsnuggles.stderr.nl>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231818>

Hi Junio,

I haven't got a reply to my mail yet. Could you have a look, so I can
update and resubmit my patch?

On Fri, Jul 12, 2013 at 09:11:57AM +0200, Matthijs Kooijman wrote:
> > [administrivia: you seem to have mail-followup-to that points at you
> > and the list; is that really needed???]
> > In your discussion (including the comment), you talk about "shallow
> > root" (I think that is the same as what we call "shallow boundary"),
> I think so, yes. I mean to refer to the commits referenced in
> .git/shallow, that have their parents "hidden".
Could you confirm that I got the terms right here (or is the shallow
boundary the first hidden commit?)

> > but in this added block, there is nothing that checks CLIENT_SHALLOW
> > or SHALLOW flags to special case that.
> >
> > Is it a good idea to unconditionally do this for all "have"
> > revisions?
> That's what I meant in my mail with "applying the fix unconditionally" -
> there is probably some check needed (I discussed a few options in the
> mail as well).
>
> Note that this entire do_rev_list function is only called when there are
> shallow revisions involved, so there is also a basic "only when shallow"
> check in place.

My proposal was to only apply the fix for all have revisions when the
previous history traversal came across some shallow boundary commits. If
this happens, then that shallow boundary commit will be a "new" one and
it will have prevented the history traversal from finding the full list
of relevant "have" commits. In this case, we should just use all "have"
commits instead.

Now, looking at the code, I see a few options for detecting this case:

 1 Modify mark_edges_uninteresting to return a boolean (or have an
   output argument) if any of the commits in the list of commits to find
   (not the edges) is a shallow boundary.
 2 Modify mark_edges_uninteresting to have a "show_shallow" argument
   that gets called for every shallow boundary. The show_shallow
   function passed would then simply keep a boolean if it is passed at
   least once.
 3 Add another loop over the commits _after_ the call to
   mark_edges_uninteresting, that simply looks for any shallow boundary
   commit.

The last option seems sensible to me, since it prevents modifying the
somewhat generic mark_edges_uninteresting function for this specific
usecase. On the other hand, it does mean that the list of commits is
looped twice, not sure what that means for performance.

Before I go and implement one of these, which option seems best to you?

Gr.

Matthijs
