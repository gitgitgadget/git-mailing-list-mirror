From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Unresolved issues
Date: Tue, 20 Feb 2007 16:21:22 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702201621050.4043@woody.linux-foundation.org>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702200934270.20368@woody.linux-foundation.org>
 <7vfy90v729.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 21 01:21:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJfEg-0004f7-NL
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 01:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965265AbXBUAV2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 19:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965271AbXBUAV2
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 19:21:28 -0500
Received: from smtp.osdl.org ([65.172.181.24]:57940 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965265AbXBUAV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 19:21:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1L0LNhB030914
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 20 Feb 2007 16:21:24 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1L0LMfC026606;
	Tue, 20 Feb 2007 16:21:22 -0800
In-Reply-To: <7vfy90v729.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.459 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40267>


On Tue, 20 Feb 2007, Junio C Hamano wrote:
> >
> > No, that would be pretty horrid. So just tell everybody that it's based on 
> > the working tree. I don't think it's likely to be a problem in practice.
> 
> Except for the initial checkout...

Yeah, that's true. That's indeed pretty nasty.

There's also a rather strange special case when you do merges: you can 
certainly always use the .gitattributes of the working tree, but it will 
cause some interesting issues if new files were added with new patterns.

However, we're a bit lucky here (or perhaps "lucky" is not the right word: 
we basically have a good design) where all these actions come down to "git 
read-tree", regardless of whether it's checking out the end result of a 
totally new clone, or a fast-forward update, or a merge. Or a "git 
checkout" or "git reset". They all boil down to one thing:

	git read-tree -u

and it should be fairly easy to add some simple logic just to 
"cmd_read_tree()" to do the right thing. It has the "main tree" to use, 
and the logic could be as simple as

	fd = open(".gitattributes", O_RDONLY);
	if (fd < 0) {
		.. try in "$tree:.gitattributes" instead ..


and it would do the right thing for all the common operations.

Again, the special case (as always) is
 - git cat-file
 - the file-level merger code (which uses the equivalent of git-cat-file)
which would need to add their own logic for this.

		Linus
