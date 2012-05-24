From: Jeff King <peff@peff.net>
Subject: Re: t4014 broken by 43ae9f47ab: format-patch: use default email for
 generating message ids
Date: Thu, 24 May 2012 16:15:53 -0400
Message-ID: <20120524201553.GA19990@sigill.intra.peff.net>
References: <4FBE2335.2090903@jpk.com>
 <20120524171640.GB3161@sigill.intra.peff.net>
 <7vtxz5wdg8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <haggerty@jpk.com>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 24 22:16:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXeS0-0004lp-F9
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 22:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758601Ab2EXUP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 16:15:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54165
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756132Ab2EXUPz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 16:15:55 -0400
Received: (qmail 31876 invoked by uid 107); 24 May 2012 20:16:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 16:16:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 16:15:53 -0400
Content-Disposition: inline
In-Reply-To: <7vtxz5wdg8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198415>

On Thu, May 24, 2012 at 01:07:03PM -0700, Junio C Hamano wrote:

> > The only setup that _would_ care is if the generated default is bogus
> > and you set $GIT_COMMITTER_EMAIL in the environment and relied on that
> > to get a sane value. Which is exactly what the test environment does.
> 
> Or they worked to create their series in a good machine, pull it down to
> another machine during their lunch break, and run format-patch to send it
> out after the final eyeballing.  Perhaps they are not supposed to be
> working on the project in question during the day at work, so the work
> machine does not have user.email set up correctly yet.

True. Although the chances that they have set GIT_COMMITTER_EMAIL in
their environment seem unlikely in that case. In other words, it was
broken before, and it is broken now.

> > The question is, is what it is doing sane and something we should care
> > about? Or is the test broken (it fails to parse the message-id that
> > contains ".(none)", but I am not even sure that is intentional and not
> > simply lazy regex writing in the test).
> 
> I doubt that it was carefully written to try to exclude ".(none)".
> 
> It somewhat curious---it seems to want to grab everything after "<" up to
> the first occurrence of ">"---why isn't this pattern matching?

I think it is even grosser than that. We follow-up that match with a
search-and-replace using the message-ids we have found as regular
expressions, but we do not bother to quote them. So the ()
metacharacters get interpreted as regular expressions. I suspect
something like this would fix it:

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index b473b6d..3171c06 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -251,7 +251,7 @@ check_threading () {
 		}
 		if ($printing) {
 			$h{$1}=$i++ if (/<([^>]+)>/ and !exists $h{$1});
-			for $k (keys %h) {s/$k/$h{$k}/};
+			for $k (keys %h) {s/\Q$k\E/$h{$k}/};
 			print;
 		}
 		print "---\n" if /^From /i;

> > It also strikes me as a little ugly that this code path
> > needs to care about $GIT_COMMITTER_EMAIL at all.
> 
> Do you mean "why committer and not author"?  It primarily is because we
> want to see "who is this person who wants a unique token tied to his
> identity" and author and committer ident are both equally reasonable
> choices.  But we have picked to use committer in these cases long time
> ago.
> 
> If you mean "why environment and not an API call?", then I would have to
> agree.  ident_committer_email() call, that returns a sanitized version,
> would have been a natural way to write this, if it were available.

I meant the latter. There is no such call, but I can make one. Let me
see how awkward it is.

-Peff
