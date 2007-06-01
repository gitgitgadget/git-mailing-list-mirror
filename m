From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Let .git/config specify the url for submodules
Date: Fri, 1 Jun 2007 09:29:58 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706010919360.3957@woody.linux-foundation.org>
References: <1180385483418-git-send-email-hjemli@gmail.com> 
 <8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com> 
 <20070601085705.GT955MdfPADPa@greensroom.kotnet.org> 
 <8c5c35580706010225p7c34c3ceu8bbfb9996388d673@mail.gmail.com> 
 <20070601093554.GV955MdfPADPa@greensroom.kotnet.org> 
 <8c5c35580706010745l76fc5410l21f2e3f385693ad9@mail.gmail.com> 
 <20070601145104.GY955MdfPADPa@greensroom.kotnet.org>
 <8c5c35580706010856s390b1157p3ea0d28cb2074cae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: skimo@liacs.nl, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 18:31:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuA1o-0000dY-2A
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 18:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761998AbXFAQaV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 12:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762006AbXFAQaU
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 12:30:20 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:40457 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761998AbXFAQaS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jun 2007 12:30:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l51GTxf3006262;
	Fri, 1 Jun 2007 09:30:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l51GTwZi013438;
	Fri, 1 Jun 2007 09:29:58 -0700
In-Reply-To: <8c5c35580706010856s390b1157p3ea0d28cb2074cae@mail.gmail.com>
X-Spam-Status: No, hits=-4.757 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48871>



On Fri, 1 Jun 2007, Lars Hjemli wrote:

> On 6/1/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> > 
> > Hmm.... I was thinking that the extra "path" level could be optional,
> > i.e., if there is no path.$path.submodule, then the name of the
> > submodule would simply be $path.
> 
> Yeah, that should also work out. Time for a quick poll?

Ack. I think the natural thing for a lot of cases is the trivial "module 
name == path" case, so having to have

	[path "kernel"]
		module = kernel

for that case just sounds unnecessary.

That said, I wonder if it wouldn't be more natural to do things the other 
way around, because quite often a "module" (under CVS conventions) is a 
*set* of directories, so with that in mind, it might be better to have the 
mapping be something like this:

	[module "infrastructure"]
		submodule = lib
		submodule = build

	[submodule "lib"]
		url = git://xyzzy/lib-1.2.3

	[submodule "build"]
		url = git://xyzzy/build-0.61


and make the rule be:
 - submodules are named by their paths (ie "path == submodule")
 - a module is a set of such submodules/paths
 - if no "module" is defined, the default is to just use the 
   path/submodule name

IOW, in the above case, we have *three* modules:

 - module "infrastructure", that is the union of submodules/paths "lib" 
   and "build"
 - module "lib" (== submodule/path "lib")
 - module "build" (== submodule/path "build")

and when you do a 

	git submodule checkout infrastructure

it would be basically equivalent to

	git submodule checkout lib
	git submodule checkout build

Hmm? That's how CVS users use modules (ie the "src" module may be much 
more than a single subdirectory)

		Linus
