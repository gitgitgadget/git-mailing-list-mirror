From: Junio C Hamano <junkio@cox.net>
Subject: Re: maybe breakage with latest git-pull and http protocol
Date: Sat, 15 Oct 2005 09:04:10 -0700
Message-ID: <7vd5m6py11.fsf@assigned-by-dhcp.cox.net>
References: <867jciz18w.fsf@blue.stonehenge.com>
	<864q7kqsa4.fsf@blue.stonehenge.com>
	<7vhdbkt8ad.fsf@assigned-by-dhcp.cox.net>
	<86achcoyvz.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0510141543030.23242@iabervon.org>
	<863bn3lypn.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Sat Oct 15 18:05:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQoWL-0002PY-L8
	for gcvg-git@gmane.org; Sat, 15 Oct 2005 18:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbVJOQEM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 12:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVJOQEM
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 12:04:12 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:62444 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751180AbVJOQEM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 12:04:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051015160352.OXWJ29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Oct 2005 12:03:52 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
cc: git@vger.kernel.org
In-Reply-To: <863bn3lypn.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "15 Oct 2005 06:03:00 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10133>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> OK, it happened this morning.  While syncing to update from
> yesterday's version, I got:

Thanks.

>     localhost:~/MIRROR/git-GIT % git-pull
>     Fetching refs/heads/master from http://www.kernel.org/pub/scm/git/git.git using http
>     Getting alternates list
>     got 4546738b58a0134eef154231b07d60fc174d56e3
>     walk 4546738b58a0134eef154231b07d60fc174d56e3
>     got d402d5566fdf226697a386dfb9858e5d954e9b91
>     got 873d8e5652c06c3891278f33546c437efc209c2d
>     walk d402d5566fdf226697a386dfb9858e5d954e9b91
>     error: 
>     Getting pack list
>     got 0207ab18a3876249a928e7539d8f594a4f6921f1

Here is the beginning of a session that succeeded:

    : siamese; GIT_DIR=. git-http-fetch -v -a heads/master \
               http://www.kernel.org/pub/scm/git/git.git/
    Getting alternates list
    got 4546738b58a0134eef154231b07d60fc174d56e3
    walk 4546738b58a0134eef154231b07d60fc174d56e3
    got d402d5566fdf226697a386dfb9858e5d954e9b91
    got 873d8e5652c06c3891278f33546c437efc209c2d
    got 5ad4a2766d34569f3a1278544ab64978fab14cc8
    walk d402d5566fdf226697a386dfb9858e5d954e9b91
    ...

The difference is that this log gets 5ad4a2 blob, before it
starts walking d402d5 commit, while Merlyn's log shows we tried
to walk that commit before getting the blob.  I think what is
happening is:

    - we request 454673 commit, and get it.

    - we start requesting trees, blobs, and parent commit
      reachable from it.  Especially, 5ad4a2 blob and d402d5
      commit are asked.

    - as soon as d402d5 commit arrives we walk and find out we
      need 5ad4a2 blob.  In the case that happened to work, that
      blob has already arrived because it was also part of the
      454673 commit, but in Merlyn's case that blob has not
      arrived yet. "Getting pack list" on the next line is an
      indication that the fetch_object incorrectly decided that
      the object we are waiting for is not available unpacked,
      which does not (and should not) happen in the case we got
      the blob object in time.

I have a suspicion that the recent multi-fetch work has some
interesting interaction with the assumption Sergey's fetch.c
optimization makes.
