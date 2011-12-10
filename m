From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/7] some sequencer loose ends (Re: Fix revert --abort on
 Windows)
Date: Sat, 10 Dec 2011 06:46:44 -0600
Message-ID: <20111210124644.GA22035@elie.hsd1.il.comcast.net>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
 <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
 <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net>
 <7vr50zd5x0.fsf@alter.siamese.dyndns.org>
 <20111123012721.GA14217@elie.hsd1.il.comcast.net>
 <4ECCB3A2.5030102@viscovery.net>
 <20111123100452.GA30629@elie.hsd1.il.comcast.net>
 <4ECCC935.7010407@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Dec 10 13:47:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZMKR-0000lF-OK
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 13:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935Ab1LJMqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 07:46:55 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41574 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab1LJMqy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 07:46:54 -0500
Received: by iaeh11 with SMTP id h11so187416iae.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 04:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4BX2THh3z+69OI1wXbtmO8IeTxVSDzHOBMB5vTQkAQE=;
        b=wr4llVrPdZS2m6faxC2+CqhHU1GyG+CcVJFs60nHllUWUQKEQqf2WF6cRdmI8Oocl0
         yNGMlN7iLjxAERYjM7BAB48Es6+nQnlptTNxaCSRuZlQl8WJzPdVRCrFCK2eGlxTwZwl
         togOEV3AwSiCJ6atkrUAUdgKlrifH8rbel2xA=
Received: by 10.42.168.202 with SMTP id x10mr5845741icy.4.1323521213482;
        Sat, 10 Dec 2011 04:46:53 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id b31sm23124823ibh.9.2011.12.10.04.46.51
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Dec 2011 04:46:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4ECCC935.7010407@viscovery.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186766>

(-cc: Phil)
Johannes Sixt wrote:

> IMO, it doesn't make sense that git-reset aborts a cherry-pick sequence:
> When I messed up a difficult conflict in the middle of a cherry-pick
> sequence, it might be useful to be able to 'git reset --hard && git
> cherry-pick that-one-commit' to restart the conflict resolution.
>
> (But does a single-commit cherry-pick during a multi-commit cherry-pick
> work to begin with?)

It should, I think.

Here are patches to address some UI warts (such as that one) in
current cherry-pick code.

Patch 1 cleans up to prepare for patch 2, which in turn makes "git
cherry-pick --continue" act like "git rebase --continue" by commiting
a conflict resolution if it has not already been committed.  This
brings us closer to a less confusing world in which all commands that
can exit and ask the user to help to get closer to their goal provide
a --continue option as a standard interface to resume (I guess "git
merge --continue" is all that's left to do afterwards).

Patch 3 is from Ram's rr/revert-cherry-pick series.  It doesn't have
much to do with this series, but I'd rather work on a codebase with
this particular patch applied, so I applied it before working on
patch 4.

Patch 4 uses Junio's cmdline_info API to distinguish single-picks
from multi-picks.  This is the title feature.  For a while I thought
something like this was the only sane thing to do, but laziness won
out.

Patches 5-7 remove hacks that patch 4 makes superfluous.

Patch 7 has the downside that if anyone had a .git/sequencer-old
directory lying around, then git will not care after applying the
patch and it will sit just taking up its few bytes and distracting
people that run "ls .git".  I'm not sure whether that's worth fixing,
and if so how.

Anyway, I hope you enjoy the series.  Thoughts and bug reports
appreciated as usual.

Jonathan Nieder (7):
  revert: give --continue handling its own function
  revert: allow cherry-pick --continue to commit before resuming
  revert: pass around rev-list args in already-parsed form
  revert: allow single-pick in the middle of cherry-pick sequence
  revert: do not remove state until sequence is finished
  Revert "reset: Make reset remove the sequencer state"
  revert: stop creating or removing sequencer-old directory

 branch.c                        |    2 -
 builtin/revert.c                |  138 ++++++++++++++++++++++-----------
 sequencer.c                     |   10 +--
 sequencer.h                     |   12 +---
 t/t3510-cherry-pick-sequence.sh |  162 +++++++++++++++++++++++++++++++++++++--
 t/t7106-reset-sequence.sh       |   52 -------------
 6 files changed, 251 insertions(+), 125 deletions(-)
 delete mode 100755 t/t7106-reset-sequence.sh
