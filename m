From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How to not download objects more than needed?
Date: Tue, 21 Feb 2006 16:42:34 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602211635450.30245@g5.osdl.org>
References: <43FB6C42.5000208@gorzow.mm.pl> <BAYC1-PASMTP03A58A4F389365AC85DA68AEFC0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 01:43:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBi6T-0000eV-Pd
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 01:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWBVAnd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 19:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWBVAnd
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 19:43:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39389 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030275AbWBVAnc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 19:43:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1M0gdDZ021507
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 21 Feb 2006 16:42:39 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1M0gYRo014906;
	Tue, 21 Feb 2006 16:42:36 -0800
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP03A58A4F389365AC85DA68AEFC0@CEZ.ICE>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16575>



On Tue, 21 Feb 2006, sean wrote:
> 
> > I have linux-2.6 repository pulled and I'd like to download some branch
> > (say, netdev-2.6), which uses many of the same objects,
> > but not to get all the objects from the git server.
> 
> Just make sure you're not using the rsync protocol.   Using the
> native git protocol would be best.

Side note: the "automatic tag following" is broken wrt pulling unnecessary 
objects, even with the git protocol.

What happens is that if you don't explicitly have a branch for what you 
are pulling, and you do something like

	git pull git://git.kernel.org/....

and the automatic tag following kicks in, it will first have fetched the 
objects once, and then when it tries to fetch the tag objects, it will 
fetch the objects it already fetched _again_ (plus the tags), because it 
will do the same object pull, but the temporary branch (to be merged) will 
never have been written as a branch head.

So you'll see something like

	Generating pack...
	Done counting <x> objects.
	Packing <x> objects.......................
	Unpacking <x> objects
	 100% (<x>/<x>) done
	Auto-following refs/tags/v1.2.2
	Generating pack...
	Done counting <x+1> objects.
	Packing <x+1> objects.......................
	Unpacking <x+1> objects
	 100% (<x+1>/<x+1>) done
	* refs/tags/v1.2.2: storing tag 'v1.2.2' of master.kernel.org:/pub/scm/git/git

just because we hadn't updated any refs before we started re-fetching more 
objects.

So we do have cases where we fetch unnecessarily even with the native 
protocol.

		Linus
