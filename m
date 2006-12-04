X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Mon, 4 Dec 2006 12:41:23 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612041234390.3476@woody.osdl.org>
References: <20061130170625.GH18810@admingilde.org> 
 <200612012306.41410.Josef.Weidendorfer@gmx.de>  <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org>
  <4570AF8F.1000801@stephan-feder.de>  <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org>
  <4570BFA4.8070903@stephan-feder.de>  <e7bda7770612021057mc9f3eb9q7fc047dd1b5c235f@mail.gmail.com>
  <Pine.LNX.4.64.0612021114270.3476@woody.osdl.org> 
 <e7bda7770612030119v197cbc95h6b3fa9e22b78c058@mail.gmail.com> 
 <Pine.LNX.4.64.0612030946150.3476@woody.osdl.org>
 <e7bda7770612041226j4d4a5584m279afa9a2d7dfe74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 4 Dec 2006 20:42:16 +0000 (UTC)
Cc: sf-gmane@stephan-feder.de, sf <sf@b-i-t.de>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <e7bda7770612041226j4d4a5584m279afa9a2d7dfe74@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33243>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrKdc-0001g3-O9 for gcvg-git@gmane.org; Mon, 04 Dec
 2006 21:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966393AbWLDUmF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 15:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966417AbWLDUmF
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 15:42:05 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44025 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S966393AbWLDUmC
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 15:42:02 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB4KfOID009110
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 4
 Dec 2006 12:41:26 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB4KfNkJ002703; Mon, 4 Dec
 2006 12:41:23 -0800
To: Torgil Svensson <torgil.svensson@gmail.com>
Sender: git-owner@vger.kernel.org



On Mon, 4 Dec 2006, Torgil Svensson wrote:
> 
> Okay, missed that part.  I wasn't familiar with contents of the CVS
> modules files and misinterpreted your suggestion.
> 
> MODULE [OPTIONS] [&OTHERMODULE...] [DIR] [FILES]
> 
> So all this is UI only and the "normal" operations on the supermodule
> will just ignore what's behind the commit-links?

Right. That's how CVS modules work (although in the case of CVS modules, 
the "dir" thing is obviously there in the "modules" file, so it's not 
_purely_ UI in CVS - this would likely be different in a git 
implementation, because the "tree" object ends up telling not just the 
exact version, but the location too).

So my suggestion basically boils down to:

 - "fetch" and "clone" etc will just look at the "modules" file, and 
   recursively fetch/clone whatever the module files talks about. This is 
   the "thin veneer to make it _look_ like git actually understands 
   submodules" part. It woudln't really - they're very much tacked on.

 - the tree entries are what makes the "once you have all the submodule 
   objects, this is how you can do 'diff' and 'checkout' on them, and this 
   is what tells you the exact version that goes along with a particular 
   supermodule version".

In other words, the simple and stupid way to do this is to just consider 
these two things two totally independent issues, and have different 
mechanisms for telling different operations what to do.

Is it "pretty"? No. The whole sub-module thing wouldn't be a tightly 
integrated low-level thing, it would very much be all about tracking 
multiple _separate_ git repositories, and just make them work well 
together. They'd very much still be separate, with just some simple 
infrastructure glue to make them look somewhat integrated.

So yeah, it's a bit hacky, but for the reasons I've tried to outline, I 
actually think that users _want_ hacky. Exactly because "deep integration" 
ends up having so many _bad_ features, so it's better to have a thin and 
simple layer that you can actually see past if you want to.

