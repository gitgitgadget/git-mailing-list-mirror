From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Disconnect stash from its base commit
Date: Wed, 02 Jul 2008 12:01:35 -0700
Message-ID: <7vvdzo9kkw.fsf@gitster.siamese.dyndns.org>
References: <20080702195947.6117@nanako3.lavabit.com>
 <alpine.DEB.1.00.0807021447200.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Git Mailing List <git@vger.kernel.org>,
	Olivier Marin <dkr+ml.git@free.fr>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 02 21:02:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE7bI-00055C-NM
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 21:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbYGBTBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 15:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752268AbYGBTBr
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 15:01:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49404 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbYGBTBq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 15:01:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8E3C02BDED;
	Wed,  2 Jul 2008 15:01:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A6BF32BDEB; Wed,  2 Jul 2008 15:01:38 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 50D22626-4869-11DD-B165-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87180>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> This patch changes the structure of a stash to use a parentless new 
>> commit that has the same tree as the HEAD commit, in place of the HEAD 
>> commit. This way, a stash does not keep the history that leads to the 
>> HEAD commit reachable, even if the stash is kept forever.
>
> May I register my suspicion that this is the wrong direction to go?
>
> I actually find it quite nice that I can easily see in gitk where I 
> spawned off a certain stash, indeed, how the recent stash history 
> (manually specified with "stash@{0} stash@{1} stash@{2}" [*1*]), relates 
> to the current branch's history.

A stash may primarily be for applying the change to random place, but
where it was created is not a useless information.  The very original use
case that was in the discussion "git stash" (actually its original form
"git save") was first posted was "I am in the middle of something, and get
interrupted.  Stash the changes away to switch branches to deal with the
emergency for a while so that I can later come back to where I was, and I
want both saving away and coming back easy operations".  A stash _can_ be
applied to any random other state, but "coming back" is very much part of
what it should have supported, and not recording the base commit means we
would lose that capability.

	Side note.  In addition to the current "stash apply" and "stash
	pop", "stash branch $stash newbranchname" that does

        	git checkout -b newbranchanme $stash^

	(i.e. create a new branch starting from the state you were in)
	might be a good ingredient to support a more git-like workflow to
	resume.  If your original branch gained extra commits, was
	rewound, or was rebased during the emergency/distraction, you may
	not have anywhere to apply/pop the stash without conflicts when
	you want to "come back" with normal

        	git checkout somebranch && git stash pop

	But that imaginary "stash branch" command would always give you
	the exact state you were in and creates a clean fork to finish
	what you were doing, and continue.

So the base commit is an integral part of what a stash is, and I agree
with you that an unexpiring stash that pins the whole history beind it is
a feature.  It is not unncessary cruft that accumulates that we need to
worry about.
