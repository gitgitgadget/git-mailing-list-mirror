From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Refactoring git-rebase.sh and git-rebase--interactive.sh
Date: Tue, 2 Nov 2010 08:33:07 -0400
Message-ID: <AANLkTimeWDbJPor9PnKgW5sD7DLjqrm-vTzEtnARvP3M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
	trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 02 13:33:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDG39-0003F5-Lw
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 13:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753Ab0KBMdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 08:33:09 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62285 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab0KBMdI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 08:33:08 -0400
Received: by vws13 with SMTP id 13so4977129vws.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 05:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=J8vyLVuQZ+BRDGppLNra4WxD4u9giVj6bwPQ6gArhM0=;
        b=G9DgWquHOiM1Vgwd2JoyHqWsFAXjZ45F5/KAnZ/Vd2GAcq4aONcDvp9ff7850z3ayH
         XIQYsb9op0NlX87zD+zMvq9oJzfmKfFBu8Z0Zbi8q4ioEfgwbuLXNupxCUzj1tkCvGDd
         684pg2pbUvjGqd6wAJanJajHAF2b3U6ONGqAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=nx3pBwxlb8TPIYLP3KcJCcUr1WQRQT9wBLuMjcj2E1U1eg21B662gdKYEyqvLILpaa
         /J/fNmnlXVOad9uU/VvASmvV6i6H0XDFF2Fdwq/MWAQAm6eYT1gAAQ6JUF4TX8JGfrq4
         zBGq+mGJP10TTjSRm20YNDI0p2un10wQTj9AE=
Received: by 10.224.69.200 with SMTP id a8mr533054qaj.190.1288701187139; Tue,
 02 Nov 2010 05:33:07 -0700 (PDT)
Received: by 10.224.20.82 with HTTP; Tue, 2 Nov 2010 05:33:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160517>

(Resending as plain text. Sorry about the spam to the guys on the CC list.)

Hi,

I have now been using Git for something like 18 months, and I think it's
about time that I try to contribute.

So, after adding some features to git-rebase.sh (which I will send
separate mails about), I realized I would have to add them to
git-rebase--interactive.sh as well. Rather than doing that, I would
prefer to first extract the common parts of these scripts and add the
features in only one place. Since this is the first time I do anything
on Git, I will need a lot of advice.

My main goal is to extract the commonalities in command line parsing and
interpretation as well as validation (of command line and repository
state, and running the pre-rebase hook).

First of all, do you agree that this should be done and is now a good
time to do it (I'm thinking mostly about conflicts with other ongoing
efforts)? While at GitTogether, I talked briefly to Thomas Rast about
doing this, and he mentioned that resurrecting the git sequencer might
be a better idea. However, I *think* much of what I was thinking about
doing involves code that is run before the git sequencer is called. I
wouldn't mind working on the git sequencer afterwards, unless Christian
Couder or someone else is currently working on it.

While I did put 'refactoring' in the subject line, this is not
strictly true for I would like to do. There are currently quite some
functional differences between 'git rebase' and 'git rebase -i' (not
just the obvious one). While refactoring the code, it would be natural
to remove some of these differences, because I would guess that most of
them are not intentional. The following are some of the differences I
have found so far.

1. Several different error messages. For example, 'cannot rebase: you
   have unstaged changes' versus 'Working tree is dirty'.
2. Different order of validation of command line and current state. For
   example, if the working tree is dirty and the upstream is invalid,
   interactive rebase will report the dirty working tree, while non-
   interactive rebase will report the invalid upstream.
3. Different set of supported flags. For example, interactive rebase
   does not support the '--stat' flag (and rebase.stat configuration)
   and various versions of '--strategy'.

The above are just some examples, and it is probably most efficient to
decide which behavior to pick in each case while reviewing patches
(provided, of course, that you think it is worthwhile to extract the
shared functionality).


/Martin
