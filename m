From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-repack question
Date: Fri, 17 Feb 2006 14:20:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602171414220.916@g5.osdl.org>
References: <20060217213824.5848.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Feb 17 23:21:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FADyP-0003bx-El
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 23:21:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbWBQWVG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 17:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbWBQWVF
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 17:21:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6117 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751846AbWBQWVB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Feb 2006 17:21:01 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1HMKgDZ018403
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 17 Feb 2006 14:20:43 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1HMKeEQ017313;
	Fri, 17 Feb 2006 14:20:41 -0800
To: linux@horizon.com
In-Reply-To: <20060217213824.5848.qmail@science.horizon.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16374>



On Fri, 17 Feb 2006, linux@horizon.com wrote:
>
> I'm trying to imagine when you'd want to run git-repack without the -d
> option, or without running git-prune-packed afterwards.
> (Isn't the idea behind packs to save space?)

Normally you'd always run git-prune-packed.

The reason it doesn't do that is simply being anally careful, and because 
conceptually the pruning phase is totally independent.

For example, in an environment that mirrors out git repositories by rsync, 
it can make sense to wait with pruning until the mirror cycle has 
finished, so that all mirrors always have all the objects.

(I don't do it for the kernel, because (a) I'm a lazy bastard, (b) I'm so 
confused that I sometimes forget my own name, much less to prune things a 
day after I've repacked them and (c) I don't care that much about rsync 
anyway, since you can't avoid some of the _other_ races).

As to whether you'd normally run "-d" - usually you'd run it whenever you 
pair it up with "-a". When you do an incremental re-pack, "-d" won't do 
anything anyway.

Again, it might make sense to not delete the old packs when repacking 
everything in a rsync'ing environment - or even in a shared repository, 
where removing a pack-file could race with somebody else working on it.

Basically, the default ends up being to never remove any objects at all, 
simply because that's the _safe_ thing to do.

In practice, I personally always do

	git repack -a -d
	git prune-packed

together, because the full repack isn't _that_ expensive for me (I tend to 
have lots of cpu power), and because I can't be bothered to worry too much 
about rsync and there are never any other users working on my git trees.

		Linus
