From: Junio C Hamano <junkio@cox.net>
Subject: Re: maybe breakage with latest git-pull and http protocol
Date: Sat, 15 Oct 2005 10:13:08 -0700
Message-ID: <7v1x2mog9n.fsf@assigned-by-dhcp.cox.net>
References: <867jciz18w.fsf@blue.stonehenge.com>
	<864q7kqsa4.fsf@blue.stonehenge.com>
	<7vhdbkt8ad.fsf@assigned-by-dhcp.cox.net>
	<86achcoyvz.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0510141543030.23242@iabervon.org>
	<863bn3lypn.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 19:14:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQpb4-0000Z3-Li
	for gcvg-git@gmane.org; Sat, 15 Oct 2005 19:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVJORNL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 13:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbVJORNL
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 13:13:11 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:24473 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751187AbVJORNK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 13:13:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051015171301.ZFWA16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Oct 2005 13:13:01 -0400
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <863bn3lypn.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "15 Oct 2005 06:03:00 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10136>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Daniel" == Daniel Barkalow <barkalow@iabervon.org> writes:
>
> Daniel> Can you give a general description of what happens? I've
> Daniel> noticed that I sometimes get spurious error messages that
> Daniel> don't actually affect the download, which I haven't tracked
> Daniel> down yet.
>
> OK, it happened this morning.  While syncing to update from
> yesterday's version, I got:
>
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

Sorry for an empty message.

Could you do the following to establish a reliable way to
reproduce this problem in your setup, so we can diagnose it
better?

First please apply this patch to http-fetch.c and rebuild your
git.

diff --git a/http-fetch.c b/http-fetch.c
index 784aedf..2c1f72c 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1009,7 +1009,10 @@ static int fetch_object(struct alt_base 
 	}
 
 	if (request->curl_result != CURLE_OK && request->http_code != 416) {
-		ret = error("%s", request->errorstr);
+		ret = error("%s (curl_result = %d, http_code = %ld, sha1 = %s)",
+			    request->errorstr, request->curl_result,
+			    request->http_code,
+			    sha1_to_hex(request->sha1));
 		release_request(request);
 		return ret;
 	}

Then, using that:

$ cd ~/MIRROR
$ rm -fr git-BROKEN
$ git-clone -n http://www.kernel.org/pub/scm/git/git.git git-BROKEN

If you got any error here, then we know we already have a way
to reproduce.  Please give us a log.

If the above succeeds, then please run

$ git-fsck-objects --full

to make sure we got things OK.  This should not report
anything.

Now, I'd like to make this repository as close as I can make it
to "after yesterday's pull", by rewining its top commit back to 
this one:

    commit f7aac2eac96b637755c89c2405a41749c8f6033a
    Author: Linus Torvalds <torvalds@osdl.org>
    Date:   Thu Oct 13 15:38:29 2005 -0700
    Add "-l" flag for repacking only local packs

$ git-reset --hard f7aac2eac96b637755c89c2405a41749c8f6033a
$ git-update-ref refs/heads/origin f7aac2eac96b637755c89c2405a41749c8f6033a

Since proposed updates (pu) branch usually contains everything
that is in the master, we need to get rid of it for this
experiment:

$ rm -f .git/refs/heads/pu

and the we get rid of objects that were added since then:

$ git-prune
$ git-fsck-objects --full

Now we are hopefully as close as "after yesterday's pull" state.

$ git-http-fetch -a -v heads/master http://www.kernel.org/pub/scm/git/git.git/

This will start with something like:

        Getting alternates list
        got 4546738b58a0134eef154231b07d60fc174d56e3
        walk 4546738b58a0134eef154231b07d60fc174d56e3
        got d402d5566fdf226697a386dfb9858e5d954e9b91
        got 873d8e5652c06c3891278f33546c437efc209c2d
        walk d402d5566fdf226697a386dfb9858e5d954e9b91
        ...

if you see the same error, instead of the empty "error:" up
above, we may see a bit more information.
