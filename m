From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 10:40:52 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705241030440.26602@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0705240039370.4113@racer.site>
 <20070524072945.GO28023@spearce.org> <20070524073652.GH942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241039200.4648@racer.site> <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241201270.4648@racer.site> <20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241230410.4648@racer.site> <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241315290.4648@racer.site>
 <8c5c35580705240541j7f632fc4lbd308c9386c2bde6@mail.gmail.com>
 <7vabvuywix.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	skimo@liacs.nl, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org, Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 19:48:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrHQJ-0005z5-56
	for gcvg-git@gmane.org; Thu, 24 May 2007 19:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbXEXRsX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 13:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbXEXRsX
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 13:48:23 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:58344 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750729AbXEXRsX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2007 13:48:23 -0400
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 May 2007 13:48:22 EDT
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4OHes9n010512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 24 May 2007 10:40:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4OHeqD8031369;
	Thu, 24 May 2007 10:40:53 -0700
In-Reply-To: <7vabvuywix.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.545 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48282>



On Thu, 24 May 2007, Junio C Hamano wrote:
> 
> Why does this have to be out-of-tree and unversioned to begin
> with?

I _really_ think that the right approach is to

 - have the submodules information under version control (and I'd 
   personally call it the ".gitmodules" file, but whatever)

   This gives you the defaults, and the ability to change them. Remember: 
   if you get some "config" information at "git clone" time, you're 
   *screwed* if the thing ever changes!

   So being version-controlled is not just a good idea. It's a 
   _requirement_ for working well.

 - have a way to *override* the version-controlled information using a 
   local config file.

   This is what you'd use to say "ignore the official information, it's 
   either slow (because the "official" server is on another continent) or 
   outdated (because the server went away)".

I actually really liked Junio's suggestion of

	[subproject "git://git.kernel.org/pub/linux-2.4.git"]
		URL = http://www.kernel.org/pub/linux-2.4.git

except I would actually make it a bit more generic, in that I don't think 
this kind of "URL rewriting" is necessarily even subproject-specific, but 
could be useful in general. IOW, it might be a good idea to have

	[url "git://git.kernel.org/pub/linux-2.4.git"]
		rewrite = "ssh://master.kernel.org/pub/linux-2.4.git"

or something - which allows people to set up automatic rewriting rules in 
case they have alternate ways of getting to better repositories (ie people 
might send me a "please pull" request with a pointer to the _public_ site, 
because they also Cc: the kernel mailing list, but since I have direct SSH 
access to the master site, _I_ might want to rewrite it to use that 
instead!).

Note how that example had nothing to do with subprojects per se: the URL 
rewriting is really another issue. But yes, I think it might also be worth 
it to actually be able to override the whole subproject data, ie also have

	[subproject "kernel/"]
		url = ...
		branch = xyzzy

and allow that kind of information in .git/config to _override_ any such 
entry in .gitmodules!

		Linus
