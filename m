From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Last mile for 1.0
Date: Sun, 5 Jun 2005 23:57:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506052351470.1876@ppc970.osdl.org>
References: <7voeak1o0q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org> <7vk6l8xue5.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0506051658100.1876@ppc970.osdl.org>
 <20050606054356.GB3669@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0506052300350.1876@ppc970.osdl.org>
 <20050606064456.GC3669@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 08:52:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfBSk-0007eA-Lt
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 08:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVFFGzX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 02:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVFFGzX
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 02:55:23 -0400
Received: from fire.osdl.org ([65.172.181.4]:49327 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261187AbVFFGzK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2005 02:55:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j566t3jA030513
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 5 Jun 2005 23:55:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j566t2Pt011843;
	Sun, 5 Jun 2005 23:55:02 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050606064456.GC3669@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 6 Jun 2005, Thomas Glanzmann wrote:
> 
> true. But I don't see the problem. Just ensure that there are no
> uncommitted data and no dirty files before proceeding with the merge by
> calling:

The thing is, I historically _often_ have uncommitted data, and it's been 
one of the biggest bummers for me that a merge of a totally unrelated 
thing will crap all over my debugging patch..

> > And now git-read-tree also tries to be very careful: if one of the files 
> > that needs to be updated is already dirty, or it doesn't match the 
> > original HEAD, then git-read-tree will just exit with an error and not do 
> > anything at all.
> 
> Now I see your point. And a cmp-and-xchg HEAD would be useful here, too.  What
> if a user tries to shoot himself in the head by pull from two trees
> simultaneous?

If he uses the same index file, he'll be protected by the index lock. 

> > And the "git-merge-one-file-script" thing needs to be updated to keep the
> > tree updated as it merges things by hand, since it can't depend on the
> > git-checkout-cache fixing things up any more. Anybody?
> 
> I can't follow you there. AFAIK it retrieves all his files from
> git-merge-cache and just calls git-update-cache to update the index.

Not exactly. It updates the index directly, without necessarily updating 
the working directory. For example:

	"$1.." | "$1.$1" | "$1$1.")
	        echo "Removing $4"
	        exec git-update-cache --force-remove "$4" ;;

it _says_ "removing $4", but it never actually does so, so the working 
directory still has the file ;)

Same goes with added files or even updated files, where it uses
"--cacheinfo" to update the cache without even touching the working
directory.

Anyway, git-resovle-script needs to be made to use "git-merge-cache -o" 
too, methinks. And it needs a test-case or two.

		Linus
