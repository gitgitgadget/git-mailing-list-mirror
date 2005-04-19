From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [1/4] Report info from trees
Date: Tue, 19 Apr 2005 01:31:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504190123180.30848-100000@iabervon.org>
References: <7vsm1nqr6x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 07:27:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNlGY-0005IQ-Jl
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 07:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVDSFbU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 01:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVDSFbU
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 01:31:20 -0400
Received: from iabervon.org ([66.92.72.58]:63495 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261328AbVDSFbN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 01:31:13 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNlKV-0004Qw-00; Tue, 19 Apr 2005 01:31:23 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsm1nqr6x.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 18 Apr 2005, Junio C Hamano wrote:

> ... what about names?  When somebody other than connectivity
> checker walks a tree, it would be more likely than not that 
> it wants to know what each entry is called, wound't it?

Yes; just add the name to the tree_entry_list.

> I can get the type of the object, either tree or blob, from
> tree->object.type, so I do not think the single-bit are needed.

You still need the mode bit (executable or not); also, the current code
can't create an object without being told in advance what it is, so you
need to use the directory bit.

> Instead, how about something simpler like this?
> 
>     struct tree {
>         struct object object; /* the tree node itself as an object */
>         unsigned child_nr;
>         unsigned child_alloc;
>         struct {
>             struct object *object;
>             char *name;
>         } **child;
>     };

I think the linked list is easier to deal with, and matches the other code
better.

> The tree->child[n].object would point at the same object as one
> of the object_list elements in tree->object.refs chain (i.e. you
> do not need to read the same object twice). 

The object code handles causing lookup_* to return the same object every
time, so this isn't an issue. Note that each struct object has to be
embedded in a struct <type> of the appropriate type, which means that we
can only create a struct object by either knowing what type it is supposed
to be or actually reading the file to find out what it actually is.

	-Daniel
*This .sig left intentionally blank*

