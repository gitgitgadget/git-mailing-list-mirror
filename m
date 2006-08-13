From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: recur status on linux-2.6
Date: Sun, 13 Aug 2006 20:16:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608132006510.10541@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0608131550290.10541@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64gwmv2j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 13 20:16:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCKVz-0007mH-82
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 20:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWHMSQc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 14:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWHMSQc
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 14:16:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:38594 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750707AbWHMSQb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Aug 2006 14:16:31 -0400
Received: (qmail invoked by alias); 13 Aug 2006 18:16:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp003) with SMTP; 13 Aug 2006 20:16:30 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64gwmv2j.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25287>

Hi,

On Sun, 13 Aug 2006, Junio C Hamano wrote:

> Recreating the tip of "next" (10a6653) might be fun.  I do not know why, 
> but it ended up having 14 merge bases.  The speed-up is about 6x, and 
> the resulting half-merge is worse than recursive (not using rerere 
> cache).

Well, my guess for these 14 merge bases is that you merge a lot between 
topic branches.

As for the worse half-merge: I get only this difference:

-100644 fad39ff609f3ea27981e7a9ffdfc29731d1065d0 1      upload-pack.c
+100644 b6cc43c3c89c68e950c6d86298c928e9aab25e70 1      upload-pack.c

So, after both -recur and -recursive, upload-pack.c is in the index in an 
unmerged state.

The difference between fad39ff6 (from -recur) and b6cc43c3 (from 
-recursive) is that this block

-- snip --

        if (nr_has < MAX_HAS) {
                struct object *o = lookup_object(sha1);
                if (!(o && o->parsed))
                        o = parse_object(sha1);
                if (!o)
                        die("oops (%s)", sha1_to_hex(sha1));
                if (o->type == OBJ_COMMIT) {
                        struct commit_list *parents;
                        if (o->flags & THEY_HAVE)
                                return 0;
                        o->flags |= THEY_HAVE;
                        for (parents = ((struct commit*)o)->parents;
                             parents;
                             parents = parents->next)
                                parents->item->object.flags |= THEY_HAVE;
                }
                memcpy(has_sha1[nr_has++], sha1, 20);

-- snap --

is inserted after (-recur), instead of before (-recursive), the clashing 
block

-- snip --

        o = lookup_object(sha1);
        if (!(o && o->parsed))
                o = parse_object(sha1);
        if (!o)
                die("oops (%s)", sha1_to_hex(sha1));
        if (o->type == TYPE_COMMIT) {
                struct commit_list *parents;
                if (o->flags & THEY_HAVE)
                        return 0;
                o->flags |= THEY_HAVE;
                for (parents = ((struct commit*)o)->parents;
                     parents;
                     parents = parents->next)
                        parents->item->object.flags |= THEY_HAVE;

-- snap --

So, the order is actually saner, since one expects the upstream (newer) 
version to come after the "====" line.

I fail to see how this is worse than -recursive...

Ciao,
Dscho
