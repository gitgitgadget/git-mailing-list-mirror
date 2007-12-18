From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Tue, 18 Dec 2007 13:53:20 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712181347140.21557@woody.linux-foundation.org>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201> <20071218204623.GC2875@steel.home> <200712182224.28152.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dana How <danahow@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 22:54:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4kON-0000xv-Jv
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 22:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbXLRVxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 16:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbXLRVxp
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 16:53:45 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46276 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751767AbXLRVxo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Dec 2007 16:53:44 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBILrL30008195
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Dec 2007 13:53:22 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBILrKVX023681;
	Tue, 18 Dec 2007 13:53:20 -0800
In-Reply-To: <200712182224.28152.jnareb@gmail.com>
X-Spam-Status: No, hits=-2.414 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_34
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68824>



On Tue, 18 Dec 2007, Jakub Narebski wrote:
> 
> What cwd? <path> in <tree-ish>:<path> syntax is "relative" to <tree-ish>.
> IMHO "<tree-ish>:<path>" should be considered (and is considered) as
> one object: current working directory doesn't matter at all there,
> contrary to "<tree-ish> -- <pathspec>" where it is natural that <pathspec>
> is relative to current working directory.

Indeed.

The <treeish>:<path> syntax *is* relative, but it's relative to the exact 
*treeish* that is given. It has nothing what-so-ever to do with the 
current working directory, since the user has explicitly given an exact 
tree object, and trying to fake that out would be actively wrong.

That said, I can kind of understand the wish for something like this, and 
I suspect that we could make the "commit->tree" translation take the 
current path into account. In other words, maybe we should have something 
like this:

	/*
	 * This sequence currently works
	 */
	[torvalds@woody git]$ git rev-parse HEAD
	f9c5a80cdf2265f2df7712fad9f1fb7ef68b4768

	[torvalds@woody git]$ git rev-parse HEAD^{tree}
	051fb0c0dff4371f97f8ad9407f9f1fd335b1682

	[torvalds@woody git]$ git rev-parse HEAD^{tree}:t
	49d8bcd7a2df5c17193b1d002c4a8489d4fa990c

	/*
	 * .. but this would be new
	 */
	[torvalds@woody git]$ cd t
	[torvalds@woody t]$ git rev-parse HEAD^{tree}
	49d8bcd7a2df5c17193b1d002c4a8489d4fa990c

where the magic is *not* done by any "SHA1 path lookup" at all, but is 
simply done by the commit->tree lookup. At least at that point it would 
make logical sense (although it would probably be quite painful to 
implement).

			Linus
