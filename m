From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Last mile for 1.0
Date: Mon, 6 Jun 2005 07:47:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506060738170.1876@ppc970.osdl.org>
References: <7voeak1o0q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org> <7vk6l8xue5.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0506051658100.1876@ppc970.osdl.org>
 <20050606054356.GB3669@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0506052300350.1876@ppc970.osdl.org> <7vis0sugp7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0506052358330.1876@ppc970.osdl.org> <7vacm4ufnl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 16:46:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfIoc-00084X-Ht
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 16:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVFFOq2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 10:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVFFOq2
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 10:46:28 -0400
Received: from fire.osdl.org ([65.172.181.4]:40422 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261399AbVFFOp7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2005 10:45:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j56EjljA010576
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 6 Jun 2005 07:45:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j56EjlR1029516;
	Mon, 6 Jun 2005 07:45:47 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacm4ufnl.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


[ git list added back in, since I migth as well explain the thinking here ]

On Mon, 6 Jun 2005, Junio C Hamano wrote:
>
> I've sent you a reply in another thread, but I really think you
> need to make this "new merge world order" a bit more explicit.
> My understanding of your (earlier) wish was that you wanted the
> merge not to touch and look at any work tree material, but it
> appears to me that this round you actually expect the work tree
> be populated and more-or-less match the first head being merged.

Actually, no. I expect the old _index_ to be at least not _more_ populated 
than the trees I merge. That's not a working tree issue, that's a "we 
don't want to drop information from the index".

And yes, if you use "-u", it will populate the working tree too, but 
that's really totally unimportant from the algorithm itself.

But you can very much do everything in-index as before, if you want to. A 
pure index merge would be done usually in a new temporary index file, 
something like

  rm -f .git/tmp_index
  GIT_INDEX_FILE=.git/tmp_index git-read-tree -m <base> <merge1> <merge2>

and the new changes don't change that.

HOWEVER, it's all set up to be very clever indeed. My immediate goal is to 
make the current git-resolve-script be more easily usable, and that 
implies that it has to work in the current working directory and resolve 
conflicts there. I still think that the _long-term_ plan is to make sure 
that we don't do that, and the new thing actually supports that too.

For example, notice how I lifted all the "checkout" code from the 
checkout-cache thing? Including very much the code that supports 
"--prefix"? I didn't add the command line, but imagine just adding that, 
which updates "state.base_dir", and doing

	mkdir -p MERGE_DIR/.git
	cp .git/index MERGE_DIR/.git/index
	GIT_INDEX_FILE=MERGE_DIR/.git/index git-read-tree -u --prefix=MERGE_DIR/ <base> <merge1> <merge2>

and voila, you're basically now 75% of the way to where I wanted the thing
to be in a separate directory.

So I've given up on the separate directory for 1.0 - because it's clearly 
not going to happen - but I've not given up on the basic idea.

			Linus
