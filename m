From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: tracking perms/ownership
Date: Thu, 23 Aug 2007 23:37:17 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708232327100.25853@woody.linux-foundation.org>
References: <1187716461.5986.71.camel@beauty> <20070821134030.b763e9d3.seanlkml@sympatico.ca>
 <1187817948.5986.159.camel@beauty> <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
 <1187905879.5986.199.camel@beauty> <7vtzqpsy3q.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0708231626580.30176@woody.linux-foundation.org>
 <85ir75h2zb.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Josh England <jjengla@sandia.gov>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 24 08:37:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOSnZ-0000aZ-D4
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 08:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760319AbXHXGhd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 02:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759033AbXHXGhd
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 02:37:33 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38291 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760121AbXHXGhc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2007 02:37:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7O6bI00023681
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 23 Aug 2007 23:37:19 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7O6bH5x014347;
	Thu, 23 Aug 2007 23:37:17 -0700
In-Reply-To: <85ir75h2zb.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-2.75 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.28__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56553>



On Fri, 24 Aug 2007, David Kastrup wrote:
> >
> > So handling ownership outside of the actual filesystem, in a
> > separate file that git tracks, actually allows you to do things that
> > you couldn't otherwise sanely do.
> 
> Well, about that "sane" bit: I don't see an application for tracking
> unrestorable ownership values.

Umm. Like an RPM spec file?

The thing you "don't see an application" for is exactly the kind of things 
that people very much ALREADY DO. 

There are tons of different setups for setting up user and group ownership 
(and things like permission) in almost any project. And I can pretty much 
*guarantee* you that none of them depend on actually having ownership on 
the files themselves.

In git, just for fun, do

	git grep defattr

or even just look into the Makefile, and think about what lines like that

	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(bindir_SQ)'

thing means, and why it has a "755" there, and why other Makefiles quite 
often have things like "-o bin" etc on such lines!

See? Those ownership things are restorable *as*root*, but that doesn't 
mean that everybody should do development as root. In fact, I'd argue that 
any system that is set up so that you have to develop and merge things 
while being root is pretty damn broken.

Which means that any such environment *has* to encode the owndership 
*separately* from the actual filesystem ownership. Because doing it in the 
filesystem simply isn't sane.

So yes, you could have an insane piece of crap that actually tracks file 
ownership in the filesystem, and requires people to be root.

Or you could use a ".gitattributes" file or similar _external_ tracking 
method that allows even people who cannot actually set ownership to work 
with it.

Your choice. But I know which one I'd choose.

			Linus
