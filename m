From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Handling renames.
Date: Thu, 14 Apr 2005 20:20:02 +0100
Message-ID: <1113506402.12012.218.camel@baythorne.infradead.org>
References: <1113501260.27227.26.camel@hades.cambridge.redhat.com>
	 <20050414181224.GA16126@elte.hu>
	 <Pine.LNX.4.58.0504141124220.7211@ppc970.osdl.org>
	 <20050414185841.GA16865@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@SteelEye.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 21:18:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM9pe-0006fA-6l
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 21:16:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVDNTUN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 15:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVDNTUN
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 15:20:13 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:41359 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261595AbVDNTUE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 15:20:04 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by baythorne.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DM9sg-0000at-OO; Thu, 14 Apr 2005 20:20:02 +0100
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050414185841.GA16865@elte.hu>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-04-14 at 20:58 +0200, Ingo Molnar wrote:
> The thing i tried to avoid was to list long filenames in the commit 
> (because of the tree hierarchy we'd need to do tree-absolute pathnames 
> or something like that, and escape things, and do lookups - duplicating 
> a VFS which is quite bad) - it would be better to identify the rename 
> source and target via its tree object hash and its offset within that 
> tree. Such information could be embedded in the commit object just fine.  
> Something like:

Actually I'm not sure that's true. Let's consider the two main users of
this information.

Firstly, because it's what I've been playing with: to list a given
file's revision history, I currently work with its filename -- walk the
commit objects, inspecting the tree and selecting those commits where
the file has changed. If my filename is 'fs/jffs2/inode.c' then I can
immediately skip over a commit where the 'fs' entry in the top-level
tree is identical to that in the parent, or I can skip a commit where
the 'jffs2' entry in the 'fs' subtree is identical to the parent... it's
all done on filename, and the {parent, entry} tuple wouldn't help much
here; I'd probably have to convert back to a filename anyway.

Secondly, there's merges. I've paid less attention to these (see mail 5
minutes ago) but I think they'd end up operating on the rename
information in a very similar way. To find a common ancestor for a given
file,, we want to track its name as it changed during history; at that
point it's all string compares.

-- 
dwmw2


