From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Feature request - discard hunk in add --patch mode
Date: Wed, 15 Aug 2012 11:39:38 +0200
Message-ID: <87txw41okl.fsf@thomas.inf.ethz.ch>
References: <BLU0-SMTP37070ADBEC060E1EA15944693B60@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Mina Almasry <almasry.mina@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 11:39:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1a4q-0001po-3k
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 11:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558Ab2HOJjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 05:39:42 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:12704 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248Ab2HOJjl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 05:39:41 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 15 Aug
 2012 11:39:34 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 15 Aug
 2012 11:39:38 +0200
In-Reply-To: <BLU0-SMTP37070ADBEC060E1EA15944693B60@phx.gbl> (Mina Almasry's
	message of "Wed, 15 Aug 2012 04:36:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203467>

Mina Almasry <almasry.mina@hotmail.com> writes:

> I frequently stage files using git add --patch command and I almost 
> always come across debug code I want to discard, but there is no option 
> for that in the prompt. The result is that I have to run an extra 
> command after the dialogue ends.
>
> I would like to add a feature to allow users to discard hunks using a 
> command like r! or d!

This has come up before, and actually led to the introduction of
'checkout -p' and 'reset -p':

  http://thread.gmane.org/gmane.comp.version-control.git/123854

Judging by the '!' above, you are already aware that this is a dangerous
option that needs some safeguards.  I imagine that would largely account
for Junio's safety concerns.  So you could pick up from the general
direction of Pierre's post, and try to work out something.

However, life has become rather more complicated since 2009.  Whatever
you do also needs to fit nicely with checkout/reset/stash -p.  The first
two also take commit arguments, resulting in a total of seven modes of
operation, defined in %patch_modes.

I imagine one good angle of attack would be to proceed as follows:

* Optionally make add--interactive.perl more aware of what the patches
  say.  Ideally there would be a way to reverse the direction of a diff
  (or otherwise manipulate it) in the program itself, instead of having
  to decide this when fetching the patches.

* Change things so that the actions in %patch_modes are a hunk property
  instead of a global state.  Of course the actual mode still needs to
  be global state.  Not all actions should be possible in all modes;
  figure out a clean way to implement this.

* Design commands in some modes that switch to another mode, and/or set
  another action than the default in the current mode.

Note that r! commands need to also work in singlekey mode, where the 'r'
is read immediately and you would have to read for another
(confirmation) key to get the '!'.

Good luck!

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
