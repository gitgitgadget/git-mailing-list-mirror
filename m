From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 14:42:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org>
 <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org> <42C454B2.6090307@zytor.com>
 <Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org> <42C462CD.9010909@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 23:35:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do6gM-0004ux-Fc
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 23:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263157AbVF3Vlk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 17:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263091AbVF3VlR
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 17:41:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12737 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263094AbVF3Vke (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 17:40:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5ULeLjA029139
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 30 Jun 2005 14:40:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5ULeK36002505;
	Thu, 30 Jun 2005 14:40:21 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42C462CD.9010909@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 30 Jun 2005, H. Peter Anvin wrote:
> 
> It does that, but it only have to do that when the actual file has 
> changed.  That's acceptable, at least for the repository sizes we're 
> likely to deal with within the medium term.

Well, realize that "incremental packs" deltify a lot worse than a "big
pack", since pack-files don't do deltas to objects outside the pack-file.

So we'd get _some_ compression, but not as much as possible. The current
kernel compresses down to a single 63 MB pack-file (that's with the 2.6.11
tree too, not just the HEAD history), but without deltas it weights in at
about 177 MB.

So a "sum of incremental packs" should be somewhere in between those two
values, even today. For a single kernel archive.

So repository sizes aren't exactly trivial. I don't know how expensive
that rsync hash thing is, but one thing you lose is the ability to
hardlink objects, so if you have a few kernel repositories at some point
it doesn't fit in the cache any more, and then the rsync will have to read
that much pack object stuff from disk in addition to doing the hash. Ugh.

		Linus
