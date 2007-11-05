From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [bug in next ?] git-fetch/git-push issue
Date: Mon, 5 Nov 2007 13:17:14 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711051259580.7357@iabervon.org>
References: <20071105175654.GD6205@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Jeff King <peff@peff.net>,
	Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 19:18:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip6WK-0008Rd-Hh
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 19:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbXKESRQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 13:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753264AbXKESRQ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 13:17:16 -0500
Received: from iabervon.org ([66.92.72.58]:38650 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069AbXKESRP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 13:17:15 -0500
Received: (qmail 18843 invoked by uid 1000); 5 Nov 2007 18:17:14 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Nov 2007 18:17:14 -0000
In-Reply-To: <20071105175654.GD6205@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63532>

On Mon, 5 Nov 2007, Pierre Habouzit wrote:

> With the current tip of next[0], I have this bizare issue:
> 
>   * I have two branches say master, and next, I'm on next.
> 
>   * my master lags behind origin/master, but next is a fast-forward wrt
>     origin/next.
> 
> Now I git push:
> 
>     error: remote 'refs/heads/master' is not an ancestor of
>      local  'refs/heads/master'.
>      Maybe you are not up-to-date and need to pull first?
>     updating 'refs/heads/next'
>       from xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
>       to   yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
>     Counting objects: 24, done.
>     Compressing objects: 100% (14/14), done.
>     Writing objects: 100% (14/14), done.
>     Total 14 (delta 12), reused 0 (delta 0)
>     refs/heads/next: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -> yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
>     updating local tracking ref 'refs/remotes/origin/master'

I think this is the bit that's wrong. I blame Jeff, in 334f4831. :)

The issue is that, in the previous version, we'd hit a continue on the 
not-an-ancestor message and not reach the update_tracking_ref() section 
for that ref. In 334f4831, all of the updating is after the loop, and it 
doesn't filter out the refs that didn't actually get pushed.

Probably, all of the "continue;"s in do_send_pack() should also strip off 
the peer_ref. Something like (totally untested):

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 947c42b..6141672 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -254,12 +254,16 @@ static int do_send_pack(int in, int out, struct remote *remote, int nr_refspec,
 		if (will_delete_ref && !allow_deleting_refs) {
 			error("remote does not support deleting refs");
 			ret = -2;
+			free(ref->peer_ref);
+			ref->peer_ref = NULL;
 			continue;
 		}
 		if (!will_delete_ref &&
 		    !hashcmp(ref->old_sha1, ref->peer_ref->new_sha1)) {
 			if (args.verbose)
 				fprintf(stderr, "'%s': up-to-date\n", ref->name);
+			free(ref->peer_ref);
+			ref->peer_ref = NULL;
 			continue;
 		}
 
@@ -303,6 +307,8 @@ static int do_send_pack(int in, int out, struct remote *remote, int nr_refspec,
 				      ref->name,
 				      ref->peer_ref->name);
 				ret = -2;
+				free(ref->peer_ref);
+				ref->peer_ref = NULL;
 				continue;
 			}
 		}
