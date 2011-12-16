From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: How to commit incomplete changes?
Date: Fri, 16 Dec 2011 13:15:28 +0100
Message-ID: <hbf.20111216xubv@bombur.uio.no>
References: <4cfc9cf0515b1bc751f6aa0de4f55e2a@ulrik.uio.no>
	<4EEA79E0.4070700@gmail.com>
	<7v8vmdl62s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 13:15:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbWhM-0006hJ-NR
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 13:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893Ab1LPMPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 07:15:32 -0500
Received: from mail-out1.uio.no ([129.240.10.57]:52586 "EHLO mail-out1.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921Ab1LPMPb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 07:15:31 -0500
Received: from mail-mx2.uio.no ([129.240.10.30])
	by mail-out1.uio.no with esmtp (Exim 4.75)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RbWhF-0003TL-5E; Fri, 16 Dec 2011 13:15:29 +0100
Received: from bombur.uio.no ([129.240.6.233])
	by mail-mx2.uio.no with esmtp  (Exim 4.76)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RbWhE-0002Xd-N7; Fri, 16 Dec 2011 13:15:29 +0100
Received: by bombur.uio.no (Postfix, from userid 2112)
	id 89908DE9; Fri, 16 Dec 2011 13:15:28 +0100 (CET)
In-Reply-To: <7v8vmdl62s.fsf@alter.siamese.dyndns.org>
X-Mailer: VM 7.19 under Emacs 23.1.1
X-UiO-Ratelimit-Test: rcpts/h 4 msgs/h 1 sum rcpts/h 5 sum msgs/h 1 total rcpts 2044 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RP_MATCHES_RCVD=-2.023,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 55A2994BD5CF9B54F91CF96F7DA6B91061A1FEA8
X-UiO-SPAM-Test: remote_host: 129.240.6.233 spam_score: -69 maxlevel 80 minaction 1 bait 0 mail/h: 1 total 879 max/h 5 blacklist 0 greylist 1 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187273>

[Neal Kreitzinger]
> I assume by 'generated changes' you mean the automerge in git...

No.  And to your questions of why I want this with unpublished work:
No.  Like I wrote, I'm talking about published commits.

[Junio C Hamano]
> My reading of the "need to split" example was not "bulk of work plus fixes
> to mistakes".  Imagine you are working on somebody else's code and for some
> reason you want to do
> 
> 	s/setenv/xsetenv/g
> 
> all over the code, and also add a wrapper to implement xsetenv() function.

Yes - except there is no "mistakes" since it's deliberate.  I'd do
s/setenv/xsetenv/g, which does too little (misses some preprocessor
stuff) or is too greedy, then commit anyway and clean up in next commit.

I could make and commit a much more complicated script to do it all, but
that's unhelpful when trying to read what the heck the change is doing.
And who knows what it'd do when run on a somewhat different codebase.

That example matches a future internal API change.  My current issue
is changes generated with 'autoreconf' - after cleaning up an utter
libtool/automake mess by hand, which will break things if I don't
autoreconf in the same commmit.

> You _could_ do it in one single commit, but what happens when you try to
> adjust to the updated upstream code, which may have added new callsites to
> setenv()?

Indeed.  In this case, it'd be when cherry-picking from the devel branch
to the release branch.  These still differ too much, a legacy of our old
CVS workflow.

> If you keep it as two patches, one is mechanical (i.e. s/setenv/xsetenv/g)
> and the other is manual (i.e. implementation of xsetenv()), then you can
> discard the text of the "mechanical" one from the old series and instead
> run the substitution on the updated code, and then cherry-pick the
> "manual" one.

Yes.  I'd order it in a sequence which never broke anything if I could.

Well, come to think of it: Possibly I could introduce some new code
which would only exist for the sake of patching over the temporary
breakage, and then delete that code again 2-3 commits later.  In this
case, I'd among other things create an obsolete libtool.m4 which is
currently hiding inside aclocal.m4.  Not sure if that makes more sense
than just having a few broken commits.

-- 
Hallvard
