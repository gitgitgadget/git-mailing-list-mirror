X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Wed, 25 Oct 2006 19:29:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610251912220.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <45349162.90001@op5.se> <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com>
 <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
 <vpq4ptz2uh8.fsf@ecrins.imag.fr> <453DAC87.8050203@research.canon.com.au>
 <Pine.LNX.4.64.0610232318200.3962@g5.osdl.org>
 <Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 26 Oct 2006 02:29:27 +0000 (UTC)
Cc: Lachlan Patrick <loki@research.canon.com.au>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30130>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcuzj-0003aZ-Is for gcvg-git@gmane.org; Thu, 26 Oct
 2006 04:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750832AbWJZC3U (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 22:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWJZC3U
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 22:29:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21661 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1750832AbWJZC3T (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 22:29:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9Q2T6Po016418
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 25
 Oct 2006 19:29:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9Q2T5ux031907; Wed, 25 Oct
 2006 19:29:05 -0700
To: David Rientjes <rientjes@cs.washington.edu>
Sender: git-owner@vger.kernel.org



On Mon, 23 Oct 2006, David Rientjes wrote:
> 
> Some of the internal commands that have been coded in C are actually much 
> better handled by the shell in the first place.

Others have answered this, but the thing is, it was a _wonderful_ way to 
prototype things, and to add obvious (and nice) early UI issues that made 
git much more usable.

But no, things are not better handled in shell.

Shell tends to make some things really _hard_ to do. A fair chunk of the 
rewrite was because core functionality made things easier. For example, 
the whole internal revision partsing library is really actually a lot more 
capable than we could easily expose as a simple pipeline: the original 
"git log" pipeline worked very well, and you can actually still use those 
kinds of pipelines for a lot of work, but at the same time, some things 
really just work better when you have "deeper" interfaces.

For example, the revision parsing library not only makes "git log" trivial 
as C, it's also needed for an efficient "git annotate/blame/pickaxe" kind 
of thing. There are also things that are just ludicrously hard to do in 
shell-script, like exclusive and atomic file operations.

We used perl and python for some things, but finding people who know them 
tends to be problematic, and python in particular was also a dependency 
problem too, so the fact that the default recursive merge was python 
wasn't wonderful.

So I think the shell-scripts are great (and some of them quite likely will 
remain around for the forseeable future) for prototyping, but for core 
functionality they were not wonderful. 

They are sometimes good examples of how powerful a scripting language git 
can be, though. Scripting is still very important, even though a lot of 
the core stuff doesn't necessarily depend on being scripts itself. 

But error handling in scripting is very hard or inconvenient, especially 
in pipelines. So some things were actively problematic (ie "git-rev-list 
--all --objects | git-pack-objects") and moving it to use the internal 
library interface was simply technically the right thing to do.

Others had real performance issues, eg the new merge in C is a lot faster. 
It was fast before, it's much faster still.

