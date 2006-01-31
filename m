From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/3] Use struct tree in diff-tree
Date: Tue, 31 Jan 2006 08:53:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601310846380.7301@g5.osdl.org>
References: <Pine.LNX.4.64.0601291336420.25300@iabervon.org>
 <Pine.LNX.4.64.0601291405250.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jan 31 17:54:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3yli-0004FK-GE
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 17:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWAaQyK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 11:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWAaQyK
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 11:54:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41652 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751239AbWAaQyJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 11:54:09 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0VGrsDZ024231
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 Jan 2006 08:53:54 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0VGrrRK018711;
	Tue, 31 Jan 2006 08:53:54 -0800
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0601291405250.25300@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15322>



On Sun, 29 Jan 2006, Daniel Barkalow wrote:
>
> It had been open-coding a tree parser. This updates the programs that
> call diff_tree() to send it the struct tree instead of a buffer and
> size.

Please don't.

parse_tree() is extremely broken, and expensive. 

The "struct tree_desc" is a much better abstraction, and avoids all 
overhead. Yes, it's slightly more opaque, and the interfaces could be 
improved: for example, instead of having a

	desc.buf = read_object_with_reference(new, "tree", &desc.size, NULL);
	if (!desc.buf)
		die("unable to read tree");

it might make make sense to introduce a function that does this for you, 
ie just a

	if (populate_tree_descriptor(new, &desc) < 0)
		die("unable to read tree");
	...
	free_tree_descriptor(&desc);

which is perhaps more readable and maintainable.

The "diff_tree()" functions are _extremely_ performance-critical, arguably 
more so than _any_ other part of git. Diffing two trees is one of _the_ 
most common operations, especially so when you want to follow just a 
subset of files with "git-rev-list -- <filename>*", and it's extremely 
important that you don't do malloc()/free() all the time.

So using "struct tree" and the general tree-parsing functions is _wrong_. 
Really REALLY wrong.

>From what I can tell, your version doesn't even do the "free()". Which 
probably means that not only is it slower, but I bet that if you have a 
big repository like the kernel, and you do a slightly more complex 
git-rev-list with multiple files, you'll use up tons and tons and tons of 
memory.

Junio, please don't apply this.

		Linus
