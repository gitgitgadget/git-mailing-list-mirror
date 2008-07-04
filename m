From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [RFC/PATCH 1/4] Add git-sequencer shell prototype
Date: Fri, 4 Jul 2008 03:53:26 +0200
Message-ID: <20080704015326.GI6677@leksak.fem-net>
References: <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807031142540.9925@racer> <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <1214879914-17866-2-git-send-email-s-beyer@gmx.net> <7vbq1f68rh.fsf@gitster.siamese.dyndns.org> <20080703210950.GC6677@leksak.fem-net> <alpine.DEB.1.00.0807040138090.2849@eeepc-johanness> <20080704003857.GG6677@leksak.fem-net> <alpine.DEB.1.00.0807040252490.2849@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 04 03:54:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEaVK-0000Zn-Su
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 03:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338AbYGDBxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 21:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754047AbYGDBxd
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 21:53:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:33017 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754007AbYGDBxc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 21:53:32 -0400
Received: (qmail invoked by alias); 04 Jul 2008 01:53:31 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp029) with SMTP; 04 Jul 2008 03:53:31 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18KtuU0dlMKjiKUpFEaloTXgscXkAMkYsmpzPUxi+
	GjWWWUO9L9Gguf
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KEaUI-0001qG-Si; Fri, 04 Jul 2008 03:53:26 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807040252490.2849@eeepc-johanness>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87356>

Hi,

On Fri, Jul 04, 2008 at 03:03:37AM +0200, Johannes Schindelin wrote:
> On Fri, 4 Jul 2008, Stephan Beyer wrote:
> > On Fri, Jul 04, 2008 at 01:53:21AM +0200, Johannes Schindelin wrote:
> > > On Thu, 3 Jul 2008, Stephan Beyer wrote:
> > > > Btw, another root commit problem is btw that it's not possible to 
> > > > cherry-pick root commits.
> > > 
> > > That is a problem to be fixed in cherry-pick, not in sequencer.  Care 
> > > to take care of that?
> > 
> > Not at the moment but that's one of the things I note down for later ;-)
> 
> Well, logically, it should come _before_ you use it in sequencer.  And you 
> should use it in sequencer.

Yet nobody seems to have asked for a cherry-pick that is able to pick
root commits and sequencer is not closed source after GSoC, so this can
be added whenever there is need and time for it.
That's what I wanted to say with "note down for later". ;-)

> > I don't get the light bulb.  You're talking about "the merge", I am
> > talking about fast-forward on picks.
> 
> Ooops.  I think I was talking about a later comment of Junio's.
> 
> The thing is, if you try to pick a commit, and the current revision is 
> already the parent of that commit, I think it would be wrong to redo the 
> commit, pretending that the current time and committer were applying that 
> commit.

Right.

> IMO the --signoff should check if the sign off is present (must be the 
> last one, as if we redid that commit), and if it is, fast-forward.
> 
> If it is missing, we need to redo the commit.

That's a good point.
Checked that and it's even a bug in the sequencer: on fast-forwards, no
signoff is added.

This should fix that:
--- a/git-sequencer.sh
+++ b/git-sequencer.sh
@@ -219,8 +219,6 @@ pick_one () {
 		fi
 		;;
 	esac
-	test -n "$SIGNOFF" &&
-		what="$what -s"
 	$use_perform git $what "$@"
 }
 
@@ -973,16 +971,21 @@ insn_pick () {
 		$use_perform git commit --amend $EDIT $signoff --no-verify \
 			--author "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" \
 			--message="$MESSAGE"
-	else
+	elif test -n "$AUTHOR"
+	then
 		# correct author if AUTHOR is set
-		test -n "$AUTHOR" &&
-			$use_perform git commit --amend $EDIT --no-verify -C HEAD \
-				--author "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>"
-		# XXX: a git-cherry-pick --author could be nicer here
+		$use_perform git commit --amend $EDIT --no-verify -C HEAD \
+			--author "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>"
+	elif test -n "$MESSAGE"
+	then
 		# correct commit message if MESSAGE is set
-		test -n "$MESSAGE" &&
-			$use_perform git commit --amend $EDIT $signoff --no-verify \
-				-C HEAD --message="$MESSAGE"
+		$use_perform git commit --amend $EDIT $signoff --no-verify \
+			-C HEAD --message="$MESSAGE"
+	elif test -n "$SIGNOFF"
+	then
+		# only add signoff
+		$use_perform git commit --amend $EDIT $signoff --no-verify \
+			-C HEAD
 	fi
 
 	return 0
###

Ah, and that is poorly tested, but not untested. :) See:
	$ git checkout -b seq-proto-dev3 HEAD^
	Switched to a new branch "seq-proto-dev3"
	$ git sequencer
	mark :1
	pick seq-proto-dev2
	ref refs/test/no
	reset :1
	pick --signoff seq-proto-dev2
Now: seq-proto-dev3 has signoff and seq-proto-dev2 and refs/test/no have the
same SHA1.  And the test suite passes.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
