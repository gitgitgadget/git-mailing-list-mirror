From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 00/22] cache cursors: an introduction
Date: Mon, 12 Sep 2005 17:17:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509121708430.3266@g5.osdl.org>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
 <7vaciiawrm.fsf@assigned-by-dhcp.cox.net> <43261675.10905@citi.umich.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 13 02:18:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEyUg-0004V6-SE
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 02:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbVIMARs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 20:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVIMARs
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 20:17:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36276 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932228AbVIMARr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 20:17:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8D0HdBo001242
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Sep 2005 17:17:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8D0HWvT030524;
	Mon, 12 Sep 2005 17:17:36 -0700
To: Chuck Lever <cel@citi.umich.edu>
In-Reply-To: <43261675.10905@citi.umich.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8458>



On Mon, 12 Sep 2005, Chuck Lever wrote:
> 
> heh.  well, i had something like this earlier, but i know linus doesn't 
> like void *, and it was really kind of ugly.  and as you observed, it's 
> used so rarely.  so i just decided to drop it.

Iterators are _much_ nicer if you can use them in-line instead of with a 
function pointer. It makes them a hundred times more powerful, and avoids 
all the crap with trying to pass a magic argument around.

That was why I mentioned the sparse "ptrlist" implementation: the data 
structure itself may not be all that exciting, but the syntax for _using_ 
it is incredibly powerful. Much better than any other list handling 
package I've ever seen, if I do say so myself.

So check out

	kernel.org:/pub/scm/devel/sparse/sparse.git

and look at how easy it is to iterate over a list. The _true_ power is how 
you can return out of a function in the middle of the iterator, ie

	int pseudo_in_list(struct pseudo_list *list, pseudo_t pseudo)
	{
	        pseudo_t old;
	        FOR_EACH_PTR(list,old) {
	                if (old == pseudo)
	                        return 1;
	        } END_FOR_EACH_PTR(old);
	        return 0;
	}

(and it's type-safe too!)

Now, nested iterators may sound easy, but they aren't easy if you want to 
actually break out of them in a nested way. Try to do _this_ with a 
function pointer interface without going crazy:

	        /* Remove the pseudos from the "defines" list that are used internally */
	        FOR_EACH_PTR(ep->bbs, bb) {
	                pseudo_t def;
	                FOR_EACH_PTR(bb->defines, def) {
	                        struct basic_block *child;
	                        FOR_EACH_PTR(bb->children, child) {
	                                if (pseudo_in_list(child->needs, def))
	                                        goto is_used;
	                        } END_FOR_EACH_PTR(child);
	                        DELETE_CURRENT_PTR(def);
	is_used:
	                ;
	                } END_FOR_EACH_PTR(def);
	                PACK_PTR_LIST(&bb->defines);
	        } END_FOR_EACH_PTR(bb);

all real examples from real code that implements an almost-real compiler.

Very dense code too, btw. It's incredible how expressive these iterators 
are: I started out with a function pointer interface, and it was painful 
as _hell_ to see what was going on.

		Linus
