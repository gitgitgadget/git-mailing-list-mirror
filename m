From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: git push origin error (1.6.3 new default functionality)
Date: Thu, 14 May 2009 10:57:32 +0200
Message-ID: <20090514085732.GA13642@pvv.org>
References: <81bfc67a0905111826y779555cer6679da11db787ab1@mail.gmail.com> <4A09594F.4040603@drmicha.warpmail.net> <7vprec4znj.fsf@alter.siamese.dyndns.org> <81bfc67a0905132030g39432e63ne72ace88edf79848@mail.gmail.com> <7vab5gz41o.fsf@alter.siamese.dyndns.org> <7vtz3oxnej.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Caleb Cushing <xenoterracide@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 10:57:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4WlD-0005fT-2j
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 10:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbZENI5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 04:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbZENI5l
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 04:57:41 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:48030 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbZENI5k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 04:57:40 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1M4Wku-0006X1-Qe; Thu, 14 May 2009 10:57:33 +0200
Content-Disposition: inline
In-Reply-To: <7vtz3oxnej.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119173>

On Wed, May 13, 2009 at 10:29:40PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Caleb Cushing <xenoterracide@gmail.com> writes:
> >
> >> On Wed, May 13, 2009 at 2:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >>> Thanks for saying this concisely, and saving me from repeating this.
> >>
> >> I just don't think one should have to explicitly set something to shut
> >> warnings up. defaults are there for a reason. next thing you know it's
> >> going to ask me if I'd like to continue, and then it will ask me to
> >> press n for next.
> >>
> >> Why even have them?
> >
> > Why do you waste other people's time after repeatedly told this was
> > discussed to death and everything is recoded in the list archive?
> 
> You know what is most frustrating for me with this whole thing?
> 
> As you might have guessed already, I am one of the oldest users of git, am
> accustomed to the way "matching push" works, and I like it as a sensible
> default behaviour for _my workflow_.  If I, Linus and you were the only
> git users, there won't be these half-page-full of warning messages.
> 
> But there are others, and one of them was motivated enough to write a
> patch series to introduce push.default that allows a setting that may be
> more suitable than 'matching' in certain workflows, even though I may not
> ever use that workflow in my projects myself.  This early vaccination
> approach was the least evil solution proposed back then (which I think was
> modelled after the already in-progress "deny git push from updating the
> current branch" topic), and you were not around to know that I even toned
> down the series not to make it too strongly suggest that the default will
> change.
> 
> No, "you were not around" part is not what is frustrating.  What is
> frustrating is that the original author who felt strongly enough against
> 'matching' default to write the patch is not defending the change in this
> thread, and I have to spend time writing responses like this that I
> otherwise could be using for something else to improve the project with.

I am sorry to be the primary source of your frustration.

Anyway, to summarize the old thread quickly from my point of view:

"git push" is a very dangerous operation if you are using multiple
remotes, and you are not the owner/maintaner of all of them. A very
common workflow where this is wrong is when using a shared pushable
repo.

Advanced users can configure push as they want, the default is most
important for new users.  From the discussions we had it seems that it
is not possible to make a default that works well for different
workflows, so I argue we should make the least dangerous default the
default.  I would like to change the default behaviour of "git push" to
do nothing at all, and to give a short message hinting at how to
configure it if you invoke git push without any arguments.

The current state of git as of 1.6.3.1, to push matching, but to
complain, is not a good terminal state I think.  I have also noticed
that printing long warnings (10+ lines) is not helpful for people,
they really need to be as short as possible or they will not be read
or understood. So, something like this as the next stage perhaps (this
is not complete, man-pages and some tests should be updated as well):

--8<--
diff --git a/builtin-push.c b/builtin-push.c
index 2eabcd3..80c81ea 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -65,18 +65,8 @@ static void setup_push_tracking(void)
 }
 
 static const char *warn_unconfigured_push_msg[] = {
-	"You did not specify any refspecs to push, and the current remote",
-	"has not configured any push refspecs. The default action in this",
-	"case is to push all matching refspecs, that is, all branches",
-	"that exist both locally and remotely will be updated.  This may",
-	"not necessarily be what you want to happen.",
-	"",
-	"You can specify what action you want to take in this case, and",
-	"avoid seeing this message again, by configuring 'push.default' to:",
-	"  'nothing'  : Do not push anything",
-	"  'matching' : Push all matching branches (default)",
-	"  'tracking' : Push the current branch to whatever it is tracking",
-	"  'current'  : Push the current branch"
+	"Nothing to push, and push.default is not configured.",
+	"See git-push(1) and git-config(1) for details."
 };
 
 static void warn_unconfigured_push(void)
@@ -92,7 +82,8 @@ static void setup_default_push_refspecs(void)
 	switch (push_default) {
 	case PUSH_DEFAULT_UNSPECIFIED:
 		warn_unconfigured_push();
-		/* fallthrough */
+		exit(EXIT_FAILURE);
+		break;
 
 	case PUSH_DEFAULT_MATCHING:
 		add_refspec(":");
--8<--

- Finn Arne
