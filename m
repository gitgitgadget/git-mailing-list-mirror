From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Let .git/config specify the url for submodules
Date: Sat, 2 Jun 2007 09:34:26 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706020923170.23741@woody.linux-foundation.org>
References: <1180385483418-git-send-email-hjemli@gmail.com>
 <8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
 <20070601085705.GT955MdfPADPa@greensroom.kotnet.org>
 <8c5c35580706010225p7c34c3ceu8bbfb9996388d673@mail.gmail.com>
 <20070601093554.GV955MdfPADPa@greensroom.kotnet.org>
 <8c5c35580706010745l76fc5410l21f2e3f385693ad9@mail.gmail.com>
 <20070601145104.GY955MdfPADPa@greensroom.kotnet.org>
 <8c5c35580706010856s390b1157p3ea0d28cb2074cae@mail.gmail.com>
 <alpine.LFD.0.98.0706010919360.3957@woody.linux-foundation.org>
 <20070602074910.GB955MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat Jun 02 18:35:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuWZZ-0002ry-Gs
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 18:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757542AbXFBQfV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 12:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757953AbXFBQfU
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 12:35:20 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:49365 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757542AbXFBQfT (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jun 2007 12:35:19 -0400
Received: from localhost (phoenix.linux-foundation.org [207.189.120.27])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l52GYV6N030080;
	Sat, 2 Jun 2007 09:34:33 -0700
In-Reply-To: <20070602074910.GB955MdfPADPa@greensroom.kotnet.org>
Received-SPF: neutral (207.189.120.27 is neither permitted nor denied by domain of torvalds@linux-foundation.org)
X-Spam-Status: No, hits=-6.187 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48935>



On Sat, 2 Jun 2007, Sven Verdoolaege wrote:

> On Fri, Jun 01, 2007 at 09:29:58AM -0700, Linus Torvalds wrote:
> > 	[module "infrastructure"]
> > 		submodule = lib
> > 		submodule = build
> > 
> > 	[submodule "lib"]
> > 		url = git://xyzzy/lib-1.2.3
> > 
> > 	[submodule "build"]
> > 		url = git://xyzzy/build-0.61
> > 
> > 
> > IOW, in the above case, we have *three* modules:
> > 
> >  - module "infrastructure", that is the union of submodules/paths "lib" 
> >    and "build"
> >  - module "lib" (== submodule/path "lib")
> >  - module "build" (== submodule/path "build")
> 
> If there are three modules, then why is one in the "module" section
> and the other two in the "submodule" section?

Because there are:

 - *two* actual submodules (== path), namely "lib" and "build".

 - each submodule always is *implicitly* a module too

 - we have a *named* (aka explicit) module "infrastructure" that is a 
   higher-level name for one or more submodules (in this case two).

So the implicit modules could have been written out:

	[module "lib"]
		submodule = "lib" 	# aka 'path = "lib"'

	 [module "build"]
		submodule = "build"	# aka 'path = "build"'

but my suggestion was that if the module name and the path name are the 
same, you don't need to say it.

(And quite frankly, I think it reads better as "submodule" than as "path", 
but maybe that threw you).

> Why not allow a module to both contain smaller modules and be contained
> in a bigger module?

Because the "module" definition is _different_ from the "submodule" 
definition.

The "module" definition is just a level of indirection. It is what allows 
you to call your module "kernel" regardless of where in the tree it is 
(and regardless of whether it's actually built up on *one* directory or 
many). It allows what CVS users have long used the "alias" thing for (or 
whatever it's called in CVSROOT/modules. But it also allows you to name 
single modules *without* having to specify exactly where in the tree they 
are.

In contrast, the "submodule" thing actually would declare where the 
submodule can be found from an URL standpoint. 

And maybe you want to allow the CVS "alias" kind of thing separately, but 
I think it's very common (exactly because quite often you want to cluster 
a few submodules together as "src" or "docs" or something, even if they 
might be technically more than one actual subproject).

		Linus
