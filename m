X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS7018 12.0.0.0/9
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Mon, 11 Jul 2005 18:43:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507111833380.17536@g5.osdl.org>
References: <20050708230750.GA23847@buici.com> <Pine.LNX.4.58.0507081842550.17536@g5.osdl.org>
 <20050711222046.GA21376@buici.com> <7vll4dndwu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507111646000.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Jul 2005 01:44:03 +0000 (UTC)
Cc: Marc Singer <elf@buici.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0507111646000.17536@g5.osdl.org>
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-Report-Spam: http://spam.gmane.org/gmane.comp.version-control.git:6000
Received: from vger.kernel.org ([12.107.209.244]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ds9o8-00025L-NV for gcvg-git@gmane.org; Tue, 12 Jul
 2005 03:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S261750AbVGLBnb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Jul 2005
 21:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVGLBnb
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 21:43:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51941 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S261750AbVGLBna (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 21:43:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6C1hOjA010681
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 11
 Jul 2005 18:43:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6C1hNaj014824; Mon, 11 Jul
 2005 18:43:23 -0700
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Mon, 11 Jul 2005, Linus Torvalds wrote:
>
> No, git-checkout-script _shouldn't_ have done that. It will do the 
> read-tree on the tag (which will do the right thing), but it won't change 
> the HEAD itself.

In preparation of actually updating the HEAD, I just made "git checkout" 
verify that it only checks out a commit, not a tree tag or something like 
that. Too late for Marc, but next time around a "git checkout v2.6.11" 
will result in

	[torvalds@g5 linux]$ git checkout v2.6.11
	error: Object 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c is a tree, not a commit
	Needed a single revision

That's not exactly _obvious_ either, but hey, it's at least a half-way
readable and understandable error, and it's obviously correct to somebody
who knows how git works.

That still leaves the question about what to do when you do

	git checkout v2.6.12

which _is_ a valid operation. Right now it will "check out" that tag, in 
the sense that it will make the working tree correspond to v2.6.12, but it 
won't actually touch HEAD at all. The question is, what _should_ it do to 
head?

Should it just reset HEAD to point to .git/refs/master, and then write the
commit ID to it? That may actually sometimes be exactly what you want, and
at least it will result in a consistent state (ie the next commit will
have the right parent). On the other hand, it will blow away whatever the
old "master" branch contained, and thus likely leave an unreachable
commit.

On the other hand, creating a new branch might be a but surprising to 
people: "But I just wanted to check it out". But as far as I can see, it's 
the only safe thing to do, and it has the advantage that you can then go 
back to the old state with a simple "git checkout master".

But what about the branch name? Should we just ask the user? Together with 
a flag, like

	git checkout -b new-branch v2.6.12

for somebody who wants to specify the branch name? Or should we pick a 
random name and add a helper function to rename a branch later?

Opinions?

