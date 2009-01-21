From: Jeff King <peff@peff.net>
Subject: Re: valgrind patches, was Re: What's cooking in git.git (Jan 2009,
	#04; Mon, 19)
Date: Tue, 20 Jan 2009 19:37:39 -0500
Message-ID: <20090121003739.GA18373@coredump.intra.peff.net>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net> <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <20090120232439.GA17746@coredump.intra.peff.net> <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 01:39:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPR7a-0003aj-De
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 01:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757719AbZAUAhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 19:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756953AbZAUAhl
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 19:37:41 -0500
Received: from peff.net ([208.65.91.99]:44575 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753518AbZAUAhl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 19:37:41 -0500
Received: (qmail 6414 invoked by uid 107); 21 Jan 2009 00:37:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 20 Jan 2009 19:37:46 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Jan 2009 19:37:39 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901210119510.19014@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106550>

On Wed, Jan 21, 2009 at 01:28:01AM +0100, Johannes Schindelin wrote:

> Actually, I test first if it is there, and only if it is not, try to 
> create the symlink.
> 
> Now, there is still a very minor chance for a race, namely if two 
> processes happen to test the existence of the missing symlink at exactly 
> the same time, and both do not find it, so both processes will try to 
> create it.

Yep. Though I find "minor chance" when it comes to races to really mean
"annoying to debug". But...

> However, the symlink creation is not checked for success, so the processes 
> will still both run just fine.

Yes, so there is no race in what is there currently. It's just sad that
we can't detect any actual errors.

> There is a very subtle problem, though.  If you screw with your 
> configuration, replacing a link in t/valgrind/ by a script, my code will 
> not try to undo it.  However, I think that's really asking for trouble, 
> and you can get out of the mess by "rm -r t/valgrind/git*".

I think we can safely ignore such mucking about in the valgrind
directory as craziness.

> Another problem which is potentially much more troublesome is this: 
> when there was a script by a certain name, my code would symlink it 
> to $GIT_DIR/$BASENAME (actually a relative path, but you get the 
> idea).  If that script is turned into a builtin -- this list has certainly 
> known a certain person to push for that kind of conversion :-) -- that 
> fact is not picked up.

Yes. One way around this is to generate a "want" and a "have" list, and
then just operate on the differences. Something like (totally untested):

  (cd $GIT_VALGRIND && ls) | sort >have
  (cd $TEST_DIRECTORY/.. && ls git git-*) | sort >want
  comm -23 have want | xargs -r rm -v
  comm -13 have want | while read f; do ln -s ../../$f $GIT_VALGRIND/$f; done

and then you are also cleaning every time you create.

-Peff
