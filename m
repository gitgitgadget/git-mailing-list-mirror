X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file
 permission bits)
Date: Mon, 11 Dec 2006 22:45:25 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612111837210.20138@iabervon.org>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 03:45:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34058>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtyaA-0003Qa-6i for gcvg-git@gmane.org; Tue, 12 Dec
 2006 04:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751069AbWLLDp1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 22:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWLLDp1
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 22:45:27 -0500
Received: from iabervon.org ([66.92.72.58]:3792 "EHLO iabervon.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751069AbWLLDp1
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 22:45:27 -0500
Received: (qmail 13481 invoked by uid 1000); 11 Dec 2006 22:45:25 -0500
Received: from localhost (sendmail-bs@127.0.0.1) by localhost with SMTP; 11
 Dec 2006 22:45:25 -0500
To: Kyle Moffett <mrmacman_g4@mac.com>
Sender: git-owner@vger.kernel.org

On Sun, 10 Dec 2006, Kyle Moffett wrote:

> I've recently become somewhat interested in the idea of using GIT to store the
> contents of various folders in /etc.  However after a bit of playing with
> this, I discovered that GIT doesn't actually preserve all permission bits
> since that would cause problems with the more traditional software development
> model.  I'm curious if anyone has done this before; and if so, how they went
> about handling the permissions and ownership issues.
> 
> I spent a little time looking over how GIT stores and compares permission
> bits; trying to figure out if it's possible to patch in a new configuration
> variable or two; say "preserve_all_perms" and "preserve_owner", or maybe even
> "save_acls".  It looks like standard permission preservation is fairly basic;
> you would just need to patch a few routines which alter the permissions read
> in from disk or compare them with ones from the database.  On the other hand,
> it would appear that preserving ownership or full POSIX ACLs might be a bit of
> a challenge.

The first thing you'd want to do is correct the fact that the index 
doesn't keep full permissions. We decided long ago that we don't want to 
track more than 0100, but we're discarding the rest between the filesystem 
and the index, rather than between the index and the tree. (This is weird 
of us, since we keep gid and uid in the index, as changedness heuristics, 
but don't keep permissions; of course, we'd have to apply umask to the 
index when we check it out to sync what we expect to be there with what 
has actually been created.)

I think that would be the only change needed to the index and 
index/working directory connection, although it might be necessary to 
support longer values for uid/gid/etc, since they'd be important data now.

Note that git only stores content, not incidental information. But a lot 
of information which is incidental in a source tree is content in /etc. 
This implies that /etc and working/linux-2.6 are fundamentally different 
sorts of things, because different aspects of them are content.

I'd suggest a new object type for a directory with permissions, ACLs, and 
so forth. It should probably use symbolic owner and group, too. My guess 
is that you'll want to use "commit"s, the new object type, and "blob"s. 
Everything that uses trees would need to have a version that uses the new 
type. But I think that you generally want different behavior anyway, so 
that's not a major issue.

	-Daniel
