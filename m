From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Finding file revisions
Date: Thu, 28 Apr 2005 08:24:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504280815120.18901@ppc970.osdl.org>
References: <200504271251.00635.mason@suse.com>  <Pine.LNX.4.58.0504271027460.18901@ppc970.osdl.org>
 <1114627268.20916.8.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Mason <mason@suse.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 17:19:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRAlz-0003EL-78
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 17:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVD1PXN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 11:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVD1PXN
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 11:23:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:56812 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262127AbVD1PXE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 11:23:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3SFMus4011069
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Apr 2005 08:22:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3SFMsw8022508;
	Thu, 28 Apr 2005 08:22:55 -0700
To: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1114627268.20916.8.camel@tglx.tec.linutronix.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 27 Apr 2005, Thomas Gleixner wrote:
>
> On Wed, 2005-04-27 at 10:34 -0700, Linus Torvalds wrote:
> > 
> > With more history, "rev-list" should do basically the right thing: it will
> > be constant-time for _recent_ commits, and it is linear time in how far
> > back you want to go. Which seems quite reasonable.
> 
> Which is quite horrible, if you have a 500k+ blobs repo.

It's _not_ linear in blobs. It doesn't care at all about them, in fact. 

It's linear in how many revisions you go backwards. And I claim that you 
can't do any better than that, without doing _really_ bad things.

> I know you are database allergic, but there a database is the correct
> solution.

I disagree. I'm not database allergic, I just don't believe in the notion 
that databases solve all the worlds problems.

> Having stored all the relations of those file/tree/commit
> blobs in a database it takes <20ms to have a list of all those file
> blobs in historical order with some context information retrieved.

.. and such an SCM will _suck_ for anything else.

You just made creating a commit etc much slower. You now have to update 
per-file information that you never updated before, and look at 
information that git simply doesn't _care_ about. 

Right now, when we create a new version, it's pretty much instantaneous.  
Exactly becaue we do not look at a _single_ file, and we don't care how
they changed from the "previous" version. We just write out the knowledge
about what the files are now.

Doing a database of file changes would absolutely _suck_. Anybody who
thinks that databases are magically faster than not using a database
doesn't understand basic physics. Things don't go faster just because you
call it a database. Things go faster by _doing_less_.

Normally, a database does less by keeping indexes etc around, and the 
indexes require less work than the data itself. But git _does_ all of that 
already. Git very much _is_ a database, it's just a specialized one.

I dare you to show me wrong. I don't _care_ of you can show the revision
history of a single file in 20ms. The easiest way to do that is with a
delta format, where the file information basically is single-file in the
first place, and you just open the file and print out the results. Guess
what? We've had that. It's called RCS/SCCS/CVS, and it's a piece of total
and absolute crap. Exactly because single-file revisions simply do not
matter.

If you want to use a database, go wild. But use it as a _cache_. Then you 
can build up the database of file revisions "after the fact", and always 
know that your database is not the real data, it's just an index, and can 
be thrown away and regenerated at will.

That way you don't add overhead to the stuff that actually matters, and 
that git does a lot better than a general-purpose database could ever do.

			Linus
