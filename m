X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's the meaning of `parenthood' in git commits?
Date: Tue, 7 Nov 2006 16:58:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611071644430.3667@g5.osdl.org>
References: <878ximbwm3.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 8 Nov 2006 00:58:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <878ximbwm3.fsf@hades.wkstn.nix>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31106>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhbmI-00063i-31 for gcvg-git@gmane.org; Wed, 08 Nov
 2006 01:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752916AbWKHA6v (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 19:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752503AbWKHA6v
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 19:58:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9621 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1752916AbWKHA6u (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 19:58:50 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kA80wioZ028166
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 7
 Nov 2006 16:58:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kA80wieh024734; Tue, 7 Nov
 2006 16:58:44 -0800
To: Nix <nix@esperi.org.uk>
Sender: git-owner@vger.kernel.org



On Wed, 8 Nov 2006, Nix wrote:
> 
> [ Nix explains what he's doing now with SCCS ]: you may be
> sick now.

Wow. You've got some strange setup there, Nix.

> After all that setup, my question's simple. Does a `parent' in git
> terminology simply mean `this commit was derived in some way from the
> commit listed here'?

Well, strictly speaking, git doesn't itself assign much any real meaning 
to "parent" at all. It has the obvious meanings:

 - the parent pointers act as reachability graph edges (so fsck cares 
   about it a lot, of course)

 - listing the "log" of a commit will show everything reachable from that 
   commit and it's parents, of course (with the commit date-stamp being 
   used as a "ordering" when having multiple choices of commits to show)

 - it has the obvious meanings for the "revision arithmetic", ie revision 
   name parsing (ie "commit~3^2")

 - parenthood will be used to show the diff ("git show", "git log -p" and 
   friends)

 - the "merge-base" algorithms obviously use it to find the most recent 
   common ancestor, and that in turn impacts the normal merge strategies, 
   of course.

so parenthood does obviously have a number of very specific technical 
meanings for different programs, but at the same time, no, git doesn't 
really "care". You can happily generate your own parenthood if you want 
to, and git will just continue to follow the above rules.

> If so, I suppose I can list heads/some-change-foo as one parent on these 
> merge commits, even though the `merging' mechanism is so odd that I 
> expect to be pelted with rotten vegetables as soon as I post this.

Yeah, git won't care. If you screw up parenthood, you have a few problems:

 - the diffs may look really strange. In particular, if you list multiple 
   parents, the git "diff" functions will all just assume that it's a 
   merge, and a "git show" will start showing the combined diff (which is 
   usually empty).

   So if you end up having multiple parents, not because it was "really" a 
   merge, but because you use the other parent pointer to point to some 
   "source" for the patch, things like "git log -p" won't give nice output 
   any more. You need to manually ask for the diff with something like

	# show diff from second parent
	git diff commit^2..commit

   instead.

 - listing too _few_ parents is potentially more serious, if you have 
   reachability issues (ie you wanted to keep the other source around, but 
   since you didn't list it as a parent, git won't know that it had 
   anything to do with your commit, so it may be pruned away unless you 
   have some other way to reach it)

but if you just have a really strange merge algorithm, and the _data_ 
associated with the parents is "surprising" from the standpoint of the 
default merge, git really won't care at all.

Your usage does sound a bit strange.

