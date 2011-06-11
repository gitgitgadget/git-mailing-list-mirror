From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH v2] revert: Implement --abort processing
Date: Sat, 11 Jun 2011 06:22:13 -0500
Message-ID: <20110611112213.GA25268@elie>
References: <1307774186-14207-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 11 13:26:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVMKW-0002yo-R5
	for gcvg-git-2@lo.gmane.org; Sat, 11 Jun 2011 13:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547Ab1FKLWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jun 2011 07:22:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53280 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423Ab1FKLWX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2011 07:22:23 -0400
Received: by iwn34 with SMTP id 34so2759914iwn.19
        for <git@vger.kernel.org>; Sat, 11 Jun 2011 04:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=d1iTNjC2oe9RvwP0ENKh+Phm48zNIjgp8Dm8q5x6YzY=;
        b=d5AdM+9qWn3QMeafqDoxHsRU9JYjZuzCTHodrcqXi4ksoJ+S0KEP0sPVJzACGEeVGf
         BnGwyDOFgGoQmsGU1POKfFNDLb6n/NSWyhP73AxZFUURBuNpZObW+rgZ72d9sJQg5Fco
         ifHA1uhQv4MP53tCAn+YyDVXXetGo9jbxinhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OQf6cDWJrOgp97XxnRSu9ssThSWKSK/ooDyGLn6WkKjcsZtp8Wo652Y3ZzhEUm7IHM
         ucjzs/vA8buMC+LNz1XabTGUJVsmMUY6O7X8S1kpEk4JyXWt9VWNW5GNxExjdbd6QT02
         2pt+WfMgGIIiOKyltEFRNlDBhPGdC2rjq9TKw=
Received: by 10.42.155.130 with SMTP id u2mr4037428icw.291.1307791341840;
        Sat, 11 Jun 2011 04:22:21 -0700 (PDT)
Received: from elie (adsl-68-255-107-108.dsl.chcgil.sbcglobal.net [68.255.107.108])
        by mx.google.com with ESMTPS id y1sm3045227ica.16.2011.06.11.04.22.19
        (version=SSLv3 cipher=OTHER);
        Sat, 11 Jun 2011 04:22:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1307774186-14207-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175639>

Ramkumar Ramachandra wrote:

>  I've persisted the TODO early, and made it complain when an existing
>  cherry-pick/ revert is in progress.  Further, as Junio suggested,
>  I've made no attempt to touch the index or the worktree during the
>  --abort operation: I simply update HEAD and leave the user to do the
>  rest.

Is that what Junio was suggesting?  I thought he was saying that
cherry-pick shouldn't support an --abort option at all, since the
"right" semantics are hard to find.

I have sympathy for that point of view, too, but it's hard to
come up with the right choice.

On one hand: "git am" has an --abort option so you can say, "Forget
it; I'm going to go back to my mailer and make a better mailbox."
"git rebase" has an --abort option to let you to walk away in a
comfortable state, instead of leaving the HEAD detached and halfway
through replaying your work.  "git bisect" has a reset subcommand for
a similar reason.  All of the abort actions just mentioned take a
somewhat weird state (e.g., patch series partially applied, maybe with
conflicts) and go back to something more familiar.  Which is useful,
especially for people just starting out.

It applies equally to cherry-pick: a user doing something crazy like

	git cherry-pick HEAD..linux-next

to incorporate all patches from linux-next on top of her local changes
is creating a mess; there is appeal in having a way to say "clear that
away and take me back to something I knew".

On the other hand: all three of the above "abort" actions can be a
pain in the neck in practice.  The worst case is when I forget about
the sequence in progress and do something else, and only later want to
clear the state:

 http://thread.gmane.org/gmane.comp.version-control.git/164002/focus=164046

There are other cases, too, like when after partially rebasing I
decide this isn't a good direction for the original branch after all
but I want to end the rebase and develop HEAD as a new branch instead.
The --abort command is quite destructive and not very flexible.

I guess if I were in your shoes, I'd be tempted to start by saving the
old HEAD and making it visible as a pseudo-ref or something,
advertising that, and then observing people's behavior with the hope
of using that knowledge to come up with good semantics for a command
to cancel cherry-picks of commit ranges.  Do people use "reset --hard"
or "reset --merge"?  Do they throw away all the commits cherry-picked
or just a few?  Do they ever intend to abort like this even after
veering from the standard sequence, like in Linus's example?  After
aborting a multiple cherry-pick, what does a person generally do next?

The documentation could say:

	To wipe out everything and get back to where you started, use:

		git reset --hard PRE_CHERRY_PICK_HEAD

What if instead of --abort something else were simpler to think about?
As a random example, I can imagine a "git sequencer --edit" command
that would present the sequence in an editor and let me revise the
plan --- would that do the trick?

	1
	2
	3
	4
	* YOU ARE HERE
	5
	6
	7
	8

 - Remove lines 5-8: removes sequencer state, leaves HEAD as is
 - Remove everything: rewinds to abort sequence
 - Add a line 2.5 between 2 and 3: rewind to 2, cherry-pick 2.5,
   continue.

And having said that, I personally start to see an --abort command as
interesting, because it is a specific case that could help flesh out a
more general behavior of rewinding some day years from now.

Which is to say: if you have a story about what --abort will be used
for, the life of others evaluating the thing becomes better and the
upsides and downsides can be seen in perspective.  A story like "am
and rebase have --abort, so cherry-pick should have one, too" is
harder to think about.

Hope that helps.
