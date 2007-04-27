From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-svn failure when symlink added in svn
Date: Fri, 27 Apr 2007 11:03:50 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704271100321.9964@woody.linux-foundation.org>
References: <m2647zh2zc.fsf@gmail.com> <20070414201003.GA28389@muzzle>
 <m2slb1c8ps.fsf@fhcrc.org> <loom.20070427T005115-751@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Klink <ak-git@cynops.de>
X-From: git-owner@vger.kernel.org Fri Apr 27 20:04:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhUnc-00053I-L1
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 20:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756336AbXD0SD5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 14:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756968AbXD0SD5
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 14:03:57 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:48686 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756962AbXD0SD4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Apr 2007 14:03:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3RI3pnM012476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 Apr 2007 11:03:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3RI3oTO004030;
	Fri, 27 Apr 2007 11:03:50 -0700
In-Reply-To: <loom.20070427T005115-751@post.gmane.org>
X-Spam-Status: No, hits=-3.009 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45739>



On Thu, 26 Apr 2007, Alexander Klink wrote:
> 
> Same here (this is a MacBook Pro, for what it's worth, BTW). As said, I've
> investigated this a bit further. The empty filename in new seems to come from
> trying to read the wrong SHA1 file. If one outputs ce->sha1 before
>         void *new = read_sha1_file(ce->sha1, &type, size);
> is called, one gets different output on Linux and Mac OS X.
> For Seth's example, I get 5f34b0af07646aa529b5b005cde3a9559e606210 on Linux
> and e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 on Mac OS X ...

Well, 5f34b0af0 is the "bar.txt" blob, while e69de29b is the empty blob

(Eg do

	[torvalds@woody git]$ echo -en "blob 7\0bar.txt" | sha1sum
	5f34b0af07646aa529b5b005cde3a9559e606210  -

	[torvalds@woody git]$ echo -en "blob 0\0" | sha1sum
	e69de29bb2d1d6434b8b29ae775ad8c2e48c5391  -

to verify: git objects not only contain the data, but embed the object 
type and size too).

So yeah, the printout matches the SHA1's, and the SHA1's are clearly not 
corrupted: they are just a sign of the fact that the data that was fed to 
whoever generated the SHA1's was simply different.

But why git-svn would act differently under OS X than under Linux I have 
no idea.

		Linus
