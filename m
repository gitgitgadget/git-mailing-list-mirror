From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Implementing branch attributes in git config
Date: Tue, 9 May 2006 19:08:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605091854380.3718@g5.osdl.org>
References: <1147037659.25090.25.camel@dv>
 <Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
 <BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE> <Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
 <7virogc90u.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605081801360.3718@g5.osdl.org>
 <7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605081854190.3718@g5.osdl.org>
 <BAYC1-PASMTP04C9C4BF5B89E55B9D877AAEA90@CEZ.ICE> <Pine.LNX.4.64.0605082007100.3718@g5.osdl.org>
 <BAYC1-PASMTP05953E2B948CB07A171FD8AEA90@CEZ.ICE> <Pine.LNX.4.64.0605082100460.3718@g5.osdl.org>
 <e3p5om$djs$1@sea.gmane.org> <Pine.LNX.4.63.0605091321350.7652@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmhr3wje.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605091215340.3718@g5.osdl.org>
 <BAYC1-PASMTP02C02EAC2F64AC00BB5801AEA90@CEZ.ICE>
 <BAYC1-PASMTP04D623089E043F1C792A37AEA90@CEZ.ICE> <Pine.LNX.4.64.0605091543100.3718@g5.osdl.org>
 <BAYC1-PASMTP037EBB0237B35C5F92FB0BAEAE0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, Johannes.Schindelin@gmx.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 10 04:09:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fde8W-0000bj-2W
	for gcvg-git@gmane.org; Wed, 10 May 2006 04:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWEJCJI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 22:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWEJCJI
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 22:09:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8402 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751194AbWEJCJH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 22:09:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4A28jtH004308
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 9 May 2006 19:08:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4A28jkw031312;
	Tue, 9 May 2006 19:08:45 -0700
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP037EBB0237B35C5F92FB0BAEAE0@CEZ.ICE>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19867>



On Tue, 9 May 2006, sean wrote:
> On Tue, 9 May 2006 17:17:58 -0700 (PDT)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > And it's _not_ that hard to make repo-config do the right thing.
> > 
> > Here's a pretty lightly tested patch (on top of my previous one) that does 
> > exactly that.
> 
> So every mutli-part section is going to be of the form:
> 
>   [section "big long opaque string"]

That's what my stupid patch does now. It seems to work well for all cases, 
but if we were to care, we could have some special heuristics for 
different section names (ie "if subsection is all lower-case 
alphanumerics, and the section name is one of the following, use the 
old-fashioned format").

I don't see _why_ we'd ever do that, but we certainly _could_, if it were 
to make more sense that way for some section name.

However, if you already use a syntax like

	[section.subsection]
		key = 1

and then do

	git-repo-config --replace-all section.subsection.new 2

it will actually keep the old section header, so you'll end up with

	[section.subsection]
		key = 1
		new = 2

but if you create a _new_ subsection (and since subsections are now case 
sensitive, this example is a "new" subsection):

	git-repo-config --replace-all section.SubSection.new 3

you will now have

	[section.subsection]
		key = 1
		new = 2
	[section "SubSection"]
		new = 3

(ie notice how it did _not_ replace the old "section.subsection.new", 
because of how this is a _different_ subsection due to the subsectin 
rules, and notice how it will always create the new subsection with 
quotes).

So you _can_ continue to use the old subsection format, and it will work 
the way it always did, except for the fact that it would now be deprecated 
(if there were any multi-level users, which I don't think there are), and 
it is now case-sensitive (which makes sense in the new format with "" 
around it, but is illogical in the old deprecated one).

> It seems to handle everything, you have me convinced.

Hey, it was fun, and the only ugly part was the write-out of the quoted 
format.

And it should be perfectly easy to use. Modulo double-quotes in branch 
names, you can do trivial things like

	git repo-config "branch.$branchname.remote" "git://git.kernel.org/..."

and it will do the obvious thing.

My one complaint is that I think we should add an empty line for the case 
where we add a new sub-section to the end of a file. That's not a new 
problem, but that was really the only visually ugly part I noticed during 
testing.

You _can_ be user-friendly and machine-parseable at the same time!

			Linus
