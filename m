From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-daemon --inetd
Date: Thu, 15 Sep 2005 12:40:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509151225410.26803@g5.osdl.org>
References: <43290EFF.3070604@zytor.com> <Pine.LNX.4.58.0509150829090.26803@g5.osdl.org>
 <4329BDD9.4010507@zytor.com> <Pine.LNX.4.58.0509151142570.26803@g5.osdl.org>
 <4329C93D.2020701@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>,
	Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 21:42:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFzbn-0008QI-Bt
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 21:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965269AbVIOTlU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 15:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965276AbVIOTlU
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 15:41:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30951 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965269AbVIOTlU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 15:41:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8FJexBo013209
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Sep 2005 12:40:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8FJesTQ020360;
	Thu, 15 Sep 2005 12:40:56 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4329C93D.2020701@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8633>



On Thu, 15 Sep 2005, H. Peter Anvin wrote:
> 
> Could git-upload-pack be integrated into the git-daemon binary, so that 
> the exec isn't needed?

Hmm.. Looking a bit closer, that's not really very helpful. 

git-upload-pack ends up fork/exec'ing git-rev-list too, to generate the 
list of commits. And then it ends up finishing off with 
"git-pack-objects". 

Yes, we could make it all be one huge thing, and try to have lots of 
functional interfaces. But that would be really quite ugly and big changes 
(they'd have to be asynchronous and give incremental results etc etc).

Maybe a post-1.0 effort. For now, I think you need to have a minimal
execution environment inside the chroot. Not a lot: git-upload-pack,
git-rev-list and git-pack-objects.

Now, it turns out that git-rev-list really is the most complex of them 
all, largely due to --merge-order. If you define NO_OPENSSL, you'll get a 
much simpler execution environment.

Btw, I think --merge-order was cool, but its weaker cousin --topo-order is
what is actually _used_. Maybe we should deprecate --merge-order? Right
now the only real user is git-archimport, and I think that one too really
only wants topo-order too. For example, right now I think git-archimport 
won't actually work if you build without openssl.

Jon? Martin?

		Linus
