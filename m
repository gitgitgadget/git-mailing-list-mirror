From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: git pull on Linux/ACPI release tree
Date: Mon, 9 Jan 2006 08:47:39 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601090835580.3169@g5.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13706@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Luck, Tony" <tony.luck@intel.com>, Junio C Hamano <junkio@cox.net>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751510AbWAIQsQ@vger.kernel.org Wed Feb 01 10:09:28 2006
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751510AbWAIQsQ@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from mail-relay.eunet.no ([193.71.71.242])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4DxI-0006W2-1C
	for glk-linux-kernel-3@gmane.org; Wed, 01 Feb 2006 10:07:12 +0100
Received: from vger.kernel.org (vger.kernel.org [209.132.176.167])
	by mail-relay.eunet.no (8.13.1/8.13.1/GN) with ESMTP id k09GtXtO090744
	for <glk-linux-kernel-3@gmane.org>; Mon, 9 Jan 2006 17:55:55 +0100 (CET)
	(envelope-from linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751510AbWAIQsQ@vger.kernel.org)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWAIQsQ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 9 Jan 2006 11:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWAIQsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:48:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51126 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751237AbWAIQsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:48:14 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k09GlfDZ012929
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 9 Jan 2006 08:47:42 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k09Gldru009228;
	Mon, 9 Jan 2006 08:47:40 -0800
To: "Brown, Len" <len.brown@intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005A13706@hdsmsx401.amr.corp.intel.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15398>



On Mon, 9 Jan 2006, Brown, Len wrote:
> >
> >The huge majority of my "automatic update from upstream" merges
> >go into my test branch ... which never becomes part of the real
> >history as I never ask Linus to pull from it.
> >
> >-Tony
> >
> >[1] Sometimes I goof on this because I forget that I've applied
> >a trivial patch directly to the release branch without going through
> >a topic branch.  I think I'll fix my update script to check 
> >for this case.
> 
> I figured that checking some trivial patches directly into "release"
> would be a convenient way to make sure I didn't forget to push them --
> as they didn't depend on anything else in my tree.  Okay.

One thing we could do is to make it easier to apply a patch to a 
_non_current_ branch.

In other words, let's say that we want to encourage the separation of a 
"development branch" and a "testing and use" branch (which I'd definitely 
personally like to encourage people to do).

And one way to do that might be to teach "git-apply" to apply patches to a 
non-active branch, and then you keep the "testing and use" branch as your 
_checked_out_ branch (and it's going to be really dirty), but when you 
actually apply patches you could do that to the "development" branch with 
something like

	git-apply -b development < patch-file

(Now, of course, that's only if you apply somebody elses patch - if you 
actually do development _yourself_, you'd either have to check out the 
development branch and do it there, or you'd move the patch you have in 
your "ugly" checked-out testing branch into the development branch with

	git diff | git-apply -b development

or something similar..)

Then you could always do "git pull . development" to pull in the 
development stuff into your working branch - keeping the development 
branch clean all the time.

Do you think that kind of workflow would be more palatable to you? It 
shouldn't be /that/ hard to make git-apply branch-aware... (It was part of 
my original plan, but it is more work than just using the working 
directory, so I never finished the thought).

> I'm hopeful that gitk users will not be irritated also
> by the liberal use of topic branches.

"gitk" is actually pretty good at showing multiple branches. Try doing a

	gitk --all -d

and you'll see all the topic branches in date order. The "-d" isn't 
strictly necessary, and to some degree makes the output messier by 
interleaving the commits from different branches, so you may not want to 
do it, but it is sometimes nice to see the "relative dates" of individual 
commits rather than the denser format that gitk defaults to.

> In the case where a topic branch is a single commit, gitk users
> will see both the original commit, as well as the merge commit
> back into "release".

Yes, topic branches will always imply more commits, but I think they are 
of the "nice" kind.

I definitely encourage people to use git as a distributed concurrent 
development system ratehr than the "collection of patches" thing. Quilt is 
much better at the collection of patches. 

So I'd encourage topic branches - even within something like ACPI, you 
might have separate topics ("interpreter" branch vs "x86" branch vs 
"generic-acpi" branch).

And yes, that will make history sometimes messier too, and it will cause 
more merges, but the difference there is that the merges will be 
meaningful (ie merging the "acpi interpreter" branch into the generic ACPI 
branch suddenly has _meaning_, even if there only ends up being a couple 
of commits per merge).

Ok?

		Linus
