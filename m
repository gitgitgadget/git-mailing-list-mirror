From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Keep rename/rename conflicts of intermediate merges
 while doing recursive merge
Date: Sat, 31 Mar 2007 09:07:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703310856070.6730@woody.linux-foundation.org>
References: <20070329141230.GB16739@hermes> <81b0412b0703290744h34b6ef01s4e6f90b1d7ed231b@mail.gmail.com>
 <81b0412b0703290804n13af6f40we79f7251562c540@mail.gmail.com>
 <20070329183237.GB2809@steel.home> <Pine.LNX.4.64.0703291232190.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703291237240.6730@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703302239050.4045@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0703301728510.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703301754590.6730@woody.linux-foundation.org>
 <20070331104947.GA4377@steel.home> <20070331114938.GB4377@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Tom Prince <tom.prince@ualberta.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 18:08:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXg7d-0007PT-Ux
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 18:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbXCaQIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 12:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753258AbXCaQIG
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 12:08:06 -0400
Received: from smtp.osdl.org ([65.172.181.24]:54374 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753247AbXCaQIF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 12:08:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2VG7vod011366
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 31 Mar 2007 09:07:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2VG7uGp025611;
	Sat, 31 Mar 2007 09:07:56 -0700
In-Reply-To: <20070331114938.GB4377@steel.home>
X-Spam-Status: No, hits=-2.463 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43561>



On Sat, 31 Mar 2007, Alex Riesen wrote:
> 
> The result seem to be at least predictable. Still, doesn't it mean
> that once a rename/rename conflict is in it has to be resolved
> manually forever?

No. It means that that particular rename/rename conflict has to be 
resolved *once*, since after that, the new merge will become the 
merge-base for future merges.

Now, that doesn't mean that you may not end up having that same conflict 
show up over and over again, because the new merge-base may (obviously) 
end up being a situation where the rename/rename conflict will continue to 
exist later on (because it conflicts with what the repo you pulled from 
will continue to have), but that's really no different from any other 
conflict..

The only way to resolve some conflicts in the long run is to either 
 - converge on some common case (ie normally by merging both ways 
   eventually, or just try to converge otherwise)
 - remember the conflict resolution and re-doing it automatically (ie 
   "git rerere" for rename conflicts)

That's very fundamental, btw. I don't think there *is* any other way to do 
automatic merges in the long run, it has nothing to do with this 
particular issue, it's a generic property of automatic merging.

Junio - I think Alex' patch is better than what we have right now (which 
is dying - whether with a SIGSEGV or a die() doesn't much matter), so it 
should be applied. It probably isn't perfect, and I bet we can tweak the 
resolution to something much better - Dscho seems to have ideas in that 
areas. But:

	Acked-by: Linus Torvalds <torvalds@linux-foundation.org>

in the meantime.

One thing we could/probably should do is to perhaps just add a flag about 
"intermediate merges had complex issues", and refuse to commit the result 
even if it looked "clean" in the end. It's better to make people perhaps 
have to do an "unnecessary" extra git-commit, than to silently commit 
something that might have been mis-merged. Just ask people to "please 
verify the end result" kind of thing..

		Linus
