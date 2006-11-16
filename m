X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 09:17:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
 <455C412D.1030408@xs4all.nl> <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org>
 <455C94FA.3050903@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 16 Nov 2006 17:18:34 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <455C94FA.3050903@xs4all.nl>
X-MIMEDefang-Filter: osdl$Revision: 1.156 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31601>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkksR-0007Z7-FG for gcvg-git@gmane.org; Thu, 16 Nov
 2006 18:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030941AbWKPRRl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 12:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031113AbWKPRRl
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 12:17:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19410 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1030941AbWKPRRk (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 12:17:40 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAGHHXoZ014533
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 16
 Nov 2006 09:17:34 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAGHHW88031089; Thu, 16 Nov
 2006 09:17:33 -0800
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org



On Thu, 16 Nov 2006, Han-Wen Nienhuys wrote:
> 
> Actually, only a 2 weeks ago, you suggested that I share the website
> and main source code for my project in a single repository for reasons
> of organization.
> 
> In this setup I find it logical to do
> 
>   git init-db
>   git pull ..url.. website/master

I don't disagree per se. It should be easy to support, it's just that it's 
not traditionally been something we've ever done.

So the way you'd normally set up a single repo that contains multiple 
other existing repositories is to basically start with one ("git clone") 
and then add the other branches and "git fetch" them.

So again, instead of "git init-db" + "git pull", you'd just use "git 
clone" instead.

Note that there _is_ another difference between "git pull" and 
"fetch+merge". The difference being that "git pull" implicitly does the 
checkout for you (I say "implicitly", because that's the way the git 
merge conceptually works: we always merge in the working tree. That's not 
the only way it _could_ be done, though - for trivial merges, we could do 
them without any working tree at all, but we don't suppotr that).

And that "git pull" semantic actually means that if you want a _bare_ 
repository, I think "git --bare init-db" + "git --bare fetch" actually 
does exactly the right thing right now too. But "git pull" would not be 
the right thing to use.

Btw, another normal way to generate a central "multi-headed repo" for is 
to not use "pull" or "fetch" or "clone" at ALL, but I would likely do 
something like

	mkdir central-repo
	cd central-repo
	git --bare init-db

and that's it. You now have a central repository, and you _never_ touch it 
again in the central place except to repack it and do other "maintenance" 
(eg pruning, fsck, whatever).

Instead, from the _outside_, you'd probably just do

	git push central-repo mybranch:refs/heads/central-branch-name

(actually, you'd probably set up that branch-name translation of 
"mybranch:refs/heads/central-branch-name" in your remote description, but 
I'm writing it out in full as an example).

So there are many ways to do it. It just happens that "git init-db" 
followed by "git pull" is not one of them ;)

(And the real reason for that is simple: "git pull" simply wants to have 
something to _start_ with. It's not hugely fundamental, it's just how it 
was written).

