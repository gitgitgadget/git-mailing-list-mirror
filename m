From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] send-pack: allow skipping delta when sending pack
Date: Sat, 20 May 2006 23:17:42 -0700
Message-ID: <7vy7wvx5o9.fsf@assigned-by-dhcp.cox.net>
References: <20060521054827.GA18530@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 08:18:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhhGO-0003Co-Ik
	for gcvg-git@gmane.org; Sun, 21 May 2006 08:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWEUGRo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 02:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWEUGRo
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 02:17:44 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:65250 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751490AbWEUGRn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 May 2006 02:17:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060521061743.VJIR27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 21 May 2006 02:17:43 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060521054827.GA18530@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 21 May 2006 01:48:27 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20433>

Jeff King <peff@peff.net> writes:

> The result is much better performance in my case. However, the method
> seems quite hack-ish, so I wanted to get comments on how this should be
> done. Possibilities I considered:

>   1. A command line option to git-send-pack. The problem with this is
>      that support is required from git-push and cg-push to pass the
>      option through.

When you pull from such a repository you would also need to be
able to control this.  The repository owner knows what's in the
repository a lot more than the downloader, so some repository
configuration that tells upload-pack to use such-and-such delta
window is also needed.  But as you say below:

>   3. Ideally, we could do some heuristic to see if deltification will
>      yield helpful results. In particular, we may already have a pack
>      with these commits in it (especially if we just repack before a
>      push). If we can re-use this information, it at least saves
>      deltifying twice (once to pack, once to push). In theory, I would
>      think the fact that we don't pass --no-reuse-delta to pack-objects
>      means that this would happen automatically, but it clearly doesn't.

The lack of --no-reuse-delta just means "if the object we are
going to send is a delta in the source, and its delta base is
also something we are going to send, then pretend that it is the
base delta for that object to skip computation".  What you want
here is "if the object we are going to send is not a delta in
the source, and there are sufficient number of other objects the
object could have been deltified against, then it is very likely
that it was not worth deltifying when it was packed; so it is
probably not worth deltifying it now".
