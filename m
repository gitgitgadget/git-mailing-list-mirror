From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Wed, 11 Apr 2007 17:13:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704111659240.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
 <200704101828.37453.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0704101122510.6730@woody.linux-foundation.org>
 <200704102129.04548.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0704101235160.6730@woody.linux-foundation.org>
 <461D73AD.9000205@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 02:14:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbmx1-0006xL-Ae
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 02:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161351AbXDLAOI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 20:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030572AbXDLAOI
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 20:14:08 -0400
Received: from smtp.osdl.org ([65.172.181.24]:37846 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030528AbXDLAOF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 20:14:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3C0DvVZ027773
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 11 Apr 2007 17:13:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3C0DtJD018769;
	Wed, 11 Apr 2007 17:13:56 -0700
In-Reply-To: <461D73AD.9000205@vilain.net>
X-Spam-Status: No, hits=-0.957 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44289>



On Thu, 12 Apr 2007, Sam Vilain wrote:
> 
> Also, in the Perl 5 Perforce conversion there are a number of
> "submodules" (ie, bundled modules with their own history) that move
> around a lot. In some tree representations used during the conversion
> process they might even appear twice in a given tree with differing
> versions.

That should actually be something that is fairly natural to handle with 
the current git submodule design - there's absolutely no problem with 
having the same subproject showing up in multiple different places in the 
tree (and each place obviously will have its own commit).

However, it causes some questions at two points:

 - What do you do in the ".gitmodules" file, where you describe the 
   submodule setup?

   This is not so much a _problem_ as a "how do you want to handle it" 
   issue.

   Would people want such a module to show up as "one module" that is just 
   visible in the tree in multiple places? Or do people prefer to think of 
   of it as completely separate modules that just happen to have the same 
   base repository?

   I don't think it's clear that one or the other is the "right way" to 
   see things, and I don't think git really should care. I suspect it's 
   more likely to be a detail that some importer script just has to 
   resolve one way or the other.

   The core git infrastructure needs to be able to have one module show up 
   in multiple places over time anyway, so I don't think there is any real 
   reason not to allow the same module to show up in multiple places even 
   within one single commit.. (Ie it's really mostly about the .gitmodules 
   file *syntax* - but if we use the config file syntax, it's actually 
   very natural to allow multiple entries for the module directory name)

   At the same time, there are reasons why you might want to consider them 
   separate modules too - maybe you want to *descibe* them separately, and 
   maybe one of the copies is used for "legacy support", and you might be 
   in a situation where you want to check out only one of the copies and 
   not the other (and thus describing them as two *different* modules 
   rather than two versions of the *same* module actually makes sense!).

   So I think this is something where we are technically neutral, but 
   where we may have non-technical issues to choose one representation 
   over another (and those issues may have more to do with the *importer* 
   than with any git issues - if importing from Perforce, it probably 
   makes most sense to make the import behave as much as possible the way 
   Perforce did in that case, and I have *no* idea what that is ;)

 - After a conversion is done, and you're no longer talking about a 
   historical archive, but a "going forward" concern, exactly how 
   automatic is subproject movement going to be, and what are downstream 
   developers that pull these things supposed to do when a subproject that 
   they have checked out is moved?

   This is mostly a UI issue. I suspect that the initial answer is: "you 
   may have to un-check-out a subproject, then pull the superproject, and 
   then re-check-it-out to get it in the new location". Simply because 
   it's going to be a lot easier to do than actually having "git pull" 
   notice when subprojects move.

   IOW, that is more of a "just how nice do we want to be to people", and 
   I _think_ the answer is: "as nice as possible, but some things are more 
   important than others, and some things might take longer before they 
   are really pleasant to do" ;)

Hmm?

		Linus
