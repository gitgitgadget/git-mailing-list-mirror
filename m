From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/3] Remove more parsers
Date: Tue, 31 Jan 2006 09:16:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601310905000.7301@g5.osdl.org>
References: <Pine.LNX.4.64.0601291336420.25300@iabervon.org>
 <7vk6ciixv0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0601291645060.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 18:16:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3z73-0002Lu-DV
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 18:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWAaRQM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 12:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWAaRQM
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 12:16:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43449 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751271AbWAaRQK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 12:16:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0VHG3DZ025561
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 Jan 2006 09:16:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0VHG0K9019720;
	Tue, 31 Jan 2006 09:16:01 -0800
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0601291645060.25300@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15324>



On Sun, 29 Jan 2006, Daniel Barkalow wrote:
> 
> I'll look into discarding the struct trees after use (since we're not 
> keeping flags on them, or storing references to them long-term), so we can 
> use the same parser without worse memory behavior. It does seem to take a 
> bunch more memory (and, oddly, be very slow) as I currently have it.

Really, trying to use "struct tree" just is _broken_.

Even if you start freeing the memory, performance will absolutely _suck_. 
You'll be using a "malloc()" (and eventually, a "free()") and copying the 
tree entries around for absolutely zero gain. You'll make things follow 
pointers and have indirection, instead of just walking the data structure 
directly.

IOW, it will be about ten times more expensive in CPU time, in the most 
performance-critical part of git.

I would actually argue that if you want to use a common structure, try to 
convert existing users of "struct tree" to the "struct tree_desc" 
iterators. Yes, their use is a little awkward, but there's really no way 
you can use anything but the fast ones for tree diffing.

The "struct tree_desc" can only be used for traversing a tree linearly in 
one order, but I bet that nobody really ever does anything else.

To make "struct tree_desc" more generic, you'd obviously have to export 
the "update_tree_entry()" and "extract()" functions (and the latter would 
probably need to be re-named to "extract_tree_entry()").

Oh, and to make freeign the tree entry a bit simpler, you'd probably want 
to replace

	void *buf
	unsigned int size;

with a

	const void *const tree_base;
	const unsigned int tree_size;
	unsigned int offset;

so that you'd just update "offset" and leave tree_base/size untouched (to 
make freeing easier - right now the person who populates the "struct 
tree_desc" has to free the thing by hand).

		Linus
