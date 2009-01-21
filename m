From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: valgrind patches, was Re: What's cooking in git.git (Jan 2009,
 #04; Mon, 19)
Date: Wed, 21 Jan 2009 02:26:56 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901210216440.19014@racer>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net>
 <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <20090120232439.GA17746@coredump.intra.peff.net> <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer>
 <20090121003739.GA18373@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 02:28:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPRtB-00060e-91
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 02:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755050AbZAUB0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 20:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754857AbZAUB0p
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 20:26:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:38145 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754634AbZAUB0p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 20:26:45 -0500
Received: (qmail invoked by alias); 21 Jan 2009 01:26:42 -0000
Received: from pD9EB302D.dip0.t-ipconnect.de (EHLO noname) [217.235.48.45]
  by mail.gmx.net (mp063) with SMTP; 21 Jan 2009 02:26:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/IgMYvWYHIFIwOuK7EFn/1XUjT6Sbv0N/ybXmVT/
	0OOzbEVVT8uHAW
X-X-Sender: gene099@racer
In-Reply-To: <20090121003739.GA18373@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106554>

Hi,

On Tue, 20 Jan 2009, Jeff King wrote:

> On Wed, Jan 21, 2009 at 01:28:01AM +0100, Johannes Schindelin wrote:
> 
> > Actually, I test first if it is there, and only if it is not, try to 
> > create the symlink.
> > 
> > Now, there is still a very minor chance for a race, namely if two 
> > processes happen to test the existence of the missing symlink at exactly 
> > the same time, and both do not find it, so both processes will try to 
> > create it.
> 
> Yep. Though I find "minor chance" when it comes to races to really mean
> "annoying to debug". But...

Well, in this case, you will find that the "bug" is _at most_ some 
binaries not being found.

And really, the chance is so small as to be forgotten in the clutter: 
after the valgrind setup, there are so many other things which are done 
that by the time we actually use the Git binaries, everything should be 
okay.

And keep in mind, this _only_ matters if you do make -j _and_ you haven't 
run --valgrind _ever_.  Once the symlinks are there, they are there.

(Actually, with my new patch, the may be replaced, but _only_ if 
necessary, and the same thing would apply as I said earlier: the binary 
would not be found, or a binary from the PATH would be run without 
valgrind; but the next runs will not have the problem.)

> > However, the symlink creation is not checked for success, so the 
> > processes will still both run just fine.
> 
> Yes, so there is no race in what is there currently. It's just sad that 
> we can't detect any actual errors.

Now we can.  I actually check for the correct link target now (which means 
I also check for a link), and if it is incorrect, the link is recreated 
(and the deletion is checked for errors).

> > There is a very subtle problem, though.  If you screw with your 
> > configuration, replacing a link in t/valgrind/ by a script, my code 
> > will not try to undo it.  However, I think that's really asking for 
> > trouble, and you can get out of the mess by "rm -r t/valgrind/git*".
> 
> I think we can safely ignore such mucking about in the valgrind
> directory as craziness.

You'll find that v2 copes with that, too.

> > Another problem which is potentially much more troublesome is this: 
> > when there was a script by a certain name, my code would symlink it to 
> > $GIT_DIR/$BASENAME (actually a relative path, but you get the idea).  
> > If that script is turned into a builtin -- this list has certainly 
> > known a certain person to push for that kind of conversion :-) -- that 
> > fact is not picked up.
> 
> Yes. One way around this is to generate a "want" and a "have" list, and
> then just operate on the differences. Something like (totally untested):
> 
>   (cd $GIT_VALGRIND && ls) | sort >have
>   (cd $TEST_DIRECTORY/.. && ls git git-*) | sort >want
>   comm -23 have want | xargs -r rm -v
>   comm -13 have want | while read f; do ln -s ../../$f $GIT_VALGRIND/$f; done
> 
> and then you are also cleaning every time you create.

The script will now pick up on those changes, and recreate the symlink 
correctly.

We don't need cleaning, as we only link to $TEST_DIRECTORY/.. (at least 
via valgrind.sh), and if the binary does not exist there, well, it does 
not exist there, and the script will error out, saying so.

Ciao,
Dscho
