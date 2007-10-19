From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing
 objects'
Date: Fri, 19 Oct 2007 14:57:26 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710191446440.26902@woody.linux-foundation.org>
References: <20071019021255.GD3290@coredump.intra.peff.net>
 <20071019022154.GY14735@spearce.org> <20071019023425.GB8298@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0710182251110.19446@xanadu.home>
 <20071019030749.GA9274@coredump.intra.peff.net> <alpine.LFD.0.9999.0710182312160.19446@xanadu.home>
 <20071019033228.GA10697@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0710182340550.19446@xanadu.home>
 <20071019035647.GA18717@coredump.intra.peff.net>
 <alpine.LFD.0.999.0710182111030.26902@woody.linux-foundation.org>
 <20071019042930.GA16487@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0710190753040.19446@xanadu.home>
 <alpine.LFD.0.999.0710191157560.26902@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 23:58:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iizr6-0003Cu-Mm
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 23:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967565AbXJSV55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 17:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967341AbXJSV54
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 17:57:56 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49811 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967565AbXJSV5z (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Oct 2007 17:57:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9JLvRCA002306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 19 Oct 2007 14:57:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9JLvQHr022056;
	Fri, 19 Oct 2007 14:57:27 -0700
In-Reply-To: <alpine.LFD.0.999.0710191157560.26902@woody.linux-foundation.org>
X-Spam-Status: No, hits=-4.42 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_28,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61769>



On Fri, 19 Oct 2007, Linus Torvalds wrote:
> 
> Could be done, but I almost think it would be better to just make the 
> sha1_name.c interfaces take some extended data structure which allows 
> looking up multiple SHA1's at the same time.

Btw, I knew I had wanted this in the past, but I had forgotten why. I now 
remembered.

The thing is, sometimes you want an expression for "all the parents of X". 
We don't have that, and again, the current internal implementation of 
sha1_name.c makes it essentially impossible to do within that interface 
(ie you can do it on *top* of that interface in revision.c, but it cannot 
be a general SHA1 expression).

So wouldn't it be nice to have a "commit^*" expression to go with 
"commit^" and "commit^2" etc? One that would name all the parents. It's 
useful, for example, for saying that you still want to see that commit, 
but not any of its parents:

	git log commit^*..

could basically work to show that commit (and all subsequent commits), but 
not the commits leading up to it. Right now, you can't easily say that in 
the git "sha1 expression algebra".

There are some other cases where you'd like to have things expand to more 
than one commit. We currently do those with special flags, like --all, but 
in many ways it would be really nice to be able to do SHA1 operations on 
them. If we were to make the SHA1 arithmetic able to handle multiple 
SHA1's (instead of just one), I could see us being able to do things like

	git diff {master,pu}:Makefile

as a way of saying

	git diff master:Makefile pu:Makefile

which already works - simply because we could make the ":name" be able to 
operate on multiple commit SHA1's and turn them into multiple blob (or 
tree) SHA1's.

(The above may not sound very useful, but

	git diff {ORIG_HEAD...MERGE_HEAD}:file

would essentially expand to "base version of file", ORIG_HEAD:file and 
MERGE_HEAD:file, and we could fairly easily teach diff to do a nice 
three-way diff for things like this! So it does have potential to be a 
reasonably powerful model)

			Linus
