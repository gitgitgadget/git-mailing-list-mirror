X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 05 Dec 2006 11:38:06 +0100
Message-ID: <45754C0E.3070904@op5.se>
References: <20061130170625.GH18810@admingilde.org>  <200612012306.41410.Josef.Weidendorfer@gmx.de>  <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org>  <4570AF8F.1000801@stephan-feder.de>  <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org>  <4570BFA4.8070903@stephan-feder.de>  <e7bda7770612021057mc9f3eb9q7fc047dd1b5c235f@mail.gmail.com>  <Pine.LNX.4.64.0612021114270.3476@woody.osdl.org>  <e7bda7770612030119v197cbc95h6b3fa9e22b78c058@mail.gmail.com>  <Pine.LNX.4.64.0612030946150.3476@woody.osdl.org> <e7bda7770612041226j4d4a5584m279afa9a2d7dfe74@mail.gmail.com> <Pine.LNX.4.64.0612041234390.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 5 Dec 2006 10:38:15 +0000 (UTC)
Cc: Torgil Svensson <torgil.svensson@gmail.com>,
	sf-gmane@stephan-feder.de, sf <sf@b-i-t.de>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <Pine.LNX.4.64.0612041234390.3476@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33334>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrXgi-0001L1-Ls for gcvg-git@gmane.org; Tue, 05 Dec
 2006 11:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968100AbWLEKiJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 05:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968106AbWLEKiJ
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 05:38:09 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:56989 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S968100AbWLEKiI (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 05:38:08 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id CBCA56BCBE; Tue,  5 Dec 2006 11:38:06 +0100 (CET)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 4 Dec 2006, Torgil Svensson wrote:
>> Okay, missed that part.  I wasn't familiar with contents of the CVS
>> modules files and misinterpreted your suggestion.
>>
>> MODULE [OPTIONS] [&OTHERMODULE...] [DIR] [FILES]
>>
>> So all this is UI only and the "normal" operations on the supermodule
>> will just ignore what's behind the commit-links?
> 
> Right. That's how CVS modules work (although in the case of CVS modules, 
> the "dir" thing is obviously there in the "modules" file, so it's not 
> _purely_ UI in CVS - this would likely be different in a git 
> implementation, because the "tree" object ends up telling not just the 
> exact version, but the location too).
> 
> So my suggestion basically boils down to:
> 
>  - "fetch" and "clone" etc will just look at the "modules" file, and 
>    recursively fetch/clone whatever the module files talks about. This is 
>    the "thin veneer to make it _look_ like git actually understands 
>    submodules" part. It woudln't really - they're very much tacked on.
> 
>  - the tree entries are what makes the "once you have all the submodule 
>    objects, this is how you can do 'diff' and 'checkout' on them, and this 
>    is what tells you the exact version that goes along with a particular 
>    supermodule version".
> 
> In other words, the simple and stupid way to do this is to just consider 
> these two things two totally independent issues, and have different 
> mechanisms for telling different operations what to do.
> 
> Is it "pretty"? No. The whole sub-module thing wouldn't be a tightly 
> integrated low-level thing, it would very much be all about tracking 
> multiple _separate_ git repositories, and just make them work well 
> together. They'd very much still be separate, with just some simple 
> infrastructure glue to make them look somewhat integrated.
> 
> So yeah, it's a bit hacky, but for the reasons I've tried to outline, I 
> actually think that users _want_ hacky. Exactly because "deep integration" 
> ends up having so many _bad_ features, so it's better to have a thin and 
> simple layer that you can actually see past if you want to.
> 

Indeed. With the "tight" integration option we'd also have to have the 
mechanism to rewrite the tree-entries with the location where the 
submodule is located in the working tree. This might be needed anyways, 
but it sure as hell seems a lot easier to just tack that part on when 
doing a checkout and actually creating all the files.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
