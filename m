From: Tim Olsen <tim@brooklynpenguin.com>
Subject: Re: git-merge segfault in 1.6.6 and master
Date: Thu, 21 Jan 2010 16:56:33 -0500
Message-ID: <4B58CD91.5000903@brooklynpenguin.com>
References: <hj7abm$5vc$1@ger.gmane.org> <7vocko3802.fsf@alter.siamese.dyndns.org> <4B577C3F.7040608@brooklynpenguin.com> <20100121140057.GP12429@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 21 22:57:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY51d-0003KN-A2
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 22:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240Ab0AUV5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 16:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754960Ab0AUV5E
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 16:57:04 -0500
Received: from lo.gmane.org ([80.91.229.12]:39367 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752860Ab0AUV5B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 16:57:01 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NY51O-0003EV-15
	for git@vger.kernel.org; Thu, 21 Jan 2010 22:56:58 +0100
Received: from nyc01.limewire.com ([38.108.107.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Jan 2010 22:56:57 +0100
Received: from tim by nyc01.limewire.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Jan 2010 22:56:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: nyc01.limewire.com
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090707)
In-Reply-To: <20100121140057.GP12429@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137695>

Miklos Vajna wrote:
> Two ideas to help debugging:
> 
> - Can you try if this happens in a new repo as well? (If not, is the
>   repo public?) If yes, can you write a script that shows your problem?

The problem still happens in any clone of the repository, but I have not
attempted to reproduce the problem in a fresh repository.  I've put our
repository up at git://les.limebits.net/site (warning: the repo is about
 364MB).  The following 3 commands will reproduce the problem:

git clone git://les.limebits.net/site
cd site
git merge origin/deployed

The problem starts with commit 9079b71b6f.  I can merge its ancestors
with no problem into the default branch (build-dav-sync-05).  But commit
9079b71b6f and its descendents cause a segfault when merging into
build-dav-sync-05.

> - Can you see if this happens with v1.6.0? If yes, can you bisect it?

With 1.6.0, the merge still fails but it doesn't outright segfault.

$ git merge origin/deployed
Merge with strategy recursive failed.
$

The output appears to be from line 1098 of builtin-merge.c.  Bisecting
finds that the outright segfaulting starts with commit 18668f53:

tolsen@neurofunk:~/git/git [git:NO BRANCH*]$ git bisect good
18668f5319b079cce29e19817bc352b1413e0908 is first bad commit
commit 18668f5319b079cce29e19817bc352b1413e0908
Author: Miklos Vajna <vmiklos@frugalware.org>
Date:   Thu Aug 28 15:43:00 2008 +0200

    builtin-merge: avoid run_command_v_opt() for recursive and subtree

    The try_merge_strategy() function always ran the strategy in a separate
    process, though this is not always necessary. The recursive and subtree
    strategy can be called without a fork(). This patch adds a check, and
    calls recursive in the same process without wasting resources.

    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

:100644 100644 9ad9791068c9330f28413ac67315246989c8d96d
b857cf6246978846e0c19895fd6f66266cf6a6f4 M      builtin-merge.c
tolsen@neurofunk:~/git/git [git:NO BRANCH*]$

This leads me to believe the segfault may still be occurring in v1.6.0,
but in a separate process.

Tim

> 
> Thanks.
