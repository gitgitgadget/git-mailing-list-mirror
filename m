From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Cross-Platform Version Control
Date: Wed, 13 May 2009 09:26:19 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905130915540.3343@localhost.localdomain>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <20090512151403.GS30527@spearce.org> <20090512161638.GB29566@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 13 18:29:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4HKb-0007Au-2D
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 18:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760597AbZEMQ3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 12:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760539AbZEMQ3I
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 12:29:08 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51446 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760498AbZEMQ3H (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 12:29:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4DGQK8x014328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 May 2009 09:26:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4DGQJXw030836;
	Wed, 13 May 2009 09:26:19 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090512161638.GB29566@coredump.intra.peff.net>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.464 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119065>



On Tue, 12 May 2009, Jeff King wrote:
>
> Or they use a single encoding like utf8 so that there are no surprises.
> You can still run into normalization problems with filenames on some
> filesystems, though.  Linus's name_hash code sets up the framework to
> handle "these two names are actually equivalent", but right now I think
> there is just code for handling case-sensitivity, not utf8 normalization
> (but I just skimmed the code, so I might be wrong).

utf-8 normalization was one goal, and shouldn't be _that_ hard to do. But 
quite frankly, the index is only part of it, and probably not the worst 
part.

The real pain of filename handling is all the "read tree recursively with 
readdir()" issues. Along with just an absolute sh*t-load of issues about 
what to do when people ended up using different versions of the "same" 
name in different branches.

There's also the issue that "cross-platform" really can be a pretty damn 
big pain. What do you do for platforms that simply are pure shit? I 
realize that OS X people have a hard time accepting it, but OS X 
filesystems are generally total and utter crap - even more so than 
Windows.

Yes, yes, you can tell OS X that case matters, but that's not the normal 
case - and what do you do with projects that simply _do_ care about case. 
The kernel is one such project.

Sure, you can "encode" the filenames on such broken filesystems in a way 
that they'd be different - but that won't really help the project, since 
makefiles etc won't work anyway.

So one reason I didn't bother with utf-8 is that the much more fundamental 
issues are simply in plain old 7-bit US-ASCII. 

That said, if the only issue is that you want to encode regular utf-8 in a 
coherent way (and ignore the case issues), then we could probably do that 
part fairly easily with a "convert_to_internal()" and 
"convert_to_filename()" thing that acts very much like the CRLF conversion 
(except on filenames, not data).

And yes, it's probably worth doing, since we'd need that for fuller case 
support anyway.

It's just a fair amount of churn - not fundamentally _hard_, but not 
trivial either. And it needs a _lot_ of care, and a fair amount of 
testing that is probably hard to do on sane filesystems (ie the case where 
the filesystem actually _changes_ the name is going to be hard to test on 
anything sane).

			Linus
