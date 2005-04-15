From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 07:53:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504150740310.7211@ppc970.osdl.org>
References: <20050414002902.GU25711@pasky.ji.cz>  <20050413212546.GA17236@64m.dyndns.org>
  <20050414004504.GW25711@pasky.ji.cz>  <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
  <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
  <7v64ypsqev.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
  <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>  <20050414121624.GZ25711@pasky.ji.cz>
  <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
 <1113556448.12012.269.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 16:49:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMS7Q-0006If-F0
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 16:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVDOOvy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 10:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVDOOvy
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 10:51:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:10463 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261819AbVDOOvn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 10:51:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3FEpKs4019717
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Apr 2005 07:51:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3FEpIOe026884;
	Fri, 15 Apr 2005 07:51:19 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1113556448.12012.269.camel@baythorne.infradead.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 15 Apr 2005, David Woodhouse wrote:
> 
> I suspect that finding the common commit is actually a per-file thing;
> it's not just something you do for the _commit_ graph, then use for
> merging each file in the two branches you're trying to merge.

I disagree.

Conceptually, you should never do _anything_ on a file level. Why? Because
individual files don't matter. You shouldn't merge two files cleanly just
because they look fine - they _depend_ on the other files in the archive, 
and that's quite fundamentally why per-file tracking is really wrong from 
a project standpoint.

So if you can't merge two files cleanly because the "project" history 
ended up being further back than the "file" history, then that's a _good_ 
thing. You don't know what the hell happened to the other files that this 
file depended on. Merging one file independently of the others is WRONG.

Also, I suspect that you'll find that if you do cross-merges, you'll 
basically always end up in:

> (I think it's a coincidence that in my example the useful files 'A2' and
> 'B2' actually do end up in a single tree together at some point.)

nope, I don't think that's coincidence. I think that's the normal case. 
Your file-based history is the one that can _incorrectly_ and 
coincidentally happen to have a single file at some point, but since that 
file doesn't stand alone, that's really not a fundamentally good reason to 
merge it.

Really, this "individual files matter" approach is a _disease_. They 
don't. Individual files DO NOT EXIST. Files always exist as part of the 
project, and the _only_ time you track a single file is when the project 
is a single file (and then that will be very very obvious in a git 
archive, thank you very much).

So the single-file mentality is a disease brought on by decades of _crap_. 
And by the fact that it ends up limiting the problem scope, so you can do 
certain things easier.

For example, just doing intra-file diffs is a lot _easier_ and less 
time-consuming than doing inter-file diffs. Bit it is _absolutely_ not 
better. In fact, it is clearly inferior to anybody who spends even five 
seconds thinking about it - yet we still do it, because of the historical 
(and INCORRECT) mindset that "files matter".

Files DO NOT matter. Never have. It's an implementation limitation to 
think they do. You'll screw yourself up, and when somebody comes up with a 
half-way efficient way to generate inter-fiel diffs, your architecture is 
totally and utterly unable to handle it.

I don't care what you do at an SCM level, and if the crud you put on top
of git wants to perpetuate mistakes of yesteryear, that's _your_ issue.  
But dammit, git is designed to do the right thing, and I will fight tooth
and nail against anybody who thinks individual files matter.

		Linus
