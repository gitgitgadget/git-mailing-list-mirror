From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing
 objects'
Date: Thu, 18 Oct 2007 21:21:55 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710182111030.26902@woody.linux-foundation.org>
References: <20071019004527.GA12930@spearce.org> <20071019021255.GD3290@coredump.intra.peff.net>
 <20071019022154.GY14735@spearce.org> <20071019023425.GB8298@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0710182251110.19446@xanadu.home>
 <20071019030749.GA9274@coredump.intra.peff.net> <alpine.LFD.0.9999.0710182312160.19446@xanadu.home>
 <20071019033228.GA10697@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0710182340550.19446@xanadu.home>
 <20071019035647.GA18717@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 06:22:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IijNZ-0007bt-3I
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 06:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbXJSEWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 00:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbXJSEWV
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 00:22:21 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41214 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750759AbXJSEWU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Oct 2007 00:22:20 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9J4LuKt000729
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Oct 2007 21:21:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9J4Lt2W014784;
	Thu, 18 Oct 2007 21:21:56 -0700
In-Reply-To: <20071019035647.GA18717@coredump.intra.peff.net>
X-Spam-Status: No, hits=-4.72 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61646>



On Thu, 18 Oct 2007, Jeff King wrote:
> 
> As for a shortcut notation, what about allowing '..' notation inside a
> reflog. I.e., <ref>@{a..b} is the same as <ref>@{a}..<ref>@{b}? So you
> could perhaps do origin/master@{1..}?

I'd love it, but the way our current SHA1 parser works, I don't think it 
can really do it.

Basically, we currently assume that a SHA1 expression always expands to a 
*single* SHA1.

And then, on top of that SHA1 expression parser, we then have a totally 
separate logic (which is *not* part of the SHA1 expression parser itself) 
that handles the "a..b" and "a...b" cases.

In other words, all the magic "head@{xyz}" logic is all in sha1_name.c, 
but that never handles any ranges at all.

And then the range handling is a separate thing in revision.c and 
builtin-rev-parse.c.

So I think your syntax is wonderful, but it would require moving the 
complex range handling into sha1_name.c, and would also require that file 
to get a more complex interface (right now all the sha1_name.c routines 
just take the "fill in this one SHA1 hash" approach, but ".." and "..." 
means that you have multiple objects *and* you can mark one of them as 
being "negated" etc..)

> I'm not sure if there are syntactic issues with parsing out the '..' (or
> '...') operator.

See above: I don't think we have syntax problems per se: it's just that 
right now the "complex" parser (the one that knows about ^, ~, and @{x} 
etc) simply cannot do anything but a single SHA1 due to internal interface 
issues.

		Linus
