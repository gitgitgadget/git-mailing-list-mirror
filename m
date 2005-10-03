From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Honor extractor's umask in git-tar-tree.
Date: Mon, 3 Oct 2005 10:45:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510031028370.31407@g5.osdl.org>
References: <20050930160353.F025C352B7B@atlas.denx.de>
 <Pine.LNX.4.64.0510010934290.3378@g5.osdl.org> <7vr7b53y0n.fsf@assigned-by-dhcp.cox.net>
 <7vk6gx3vkt.fsf_-_@assigned-by-dhcp.cox.net> <433F52DC.5090906@zytor.com>
 <pan.2005.10.02.09.55.52.564046@smurf.noris.de> <4340B73B.1090409@zytor.com>
 <7virwfuqwv.fsf@assigned-by-dhcp.cox.net> <43415C9A.1090502@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 19:48:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMUON-0004Gy-Nc
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 19:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbVJCRpy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 13:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbVJCRpy
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 13:45:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10987 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932485AbVJCRpx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2005 13:45:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j93Hjl4s024210
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 3 Oct 2005 10:45:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j93Hjkvt009283;
	Mon, 3 Oct 2005 10:45:46 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43415C9A.1090502@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9641>



On Mon, 3 Oct 2005, H. Peter Anvin wrote:
> 
> If the old-format (with random write bits) is out of circulation -- which I
> can't tell for sure they it is, but Linus' kernel tree doesn't seem to have
> any of these objects

Oh, it does.

Run "git-fsck-cache --full --strict", and you'll get several trees that 
the strict checker marks as bad. I think it's mostly all one entry, namely 
arch/i386/kernel/vsyscall-note.S being marked 0664.

Git itself has even more of them - the kernel actually has fewer, because 
most work was done with a consistent umask of 022 (ie mostly mine), and by 
the time others started using git actively, we'd already changed the git 
rules.

However, there's nothing that says that we couldn't use one more bit in 
the "mode" flag to just say "this is an _exact_ mode, please preserve it". 
A kind of "sticky mode" for git. We've got _bits_ plenty: it's an ASCII 
text-mode representation in the trees (infinite bits), and even in the 
index it's a 32-bit thing that we only use 12 bits of (9 bits for 
permissions, 3 bits for the sparsely represented directory/symlink/regular 
file)

We'd have to be a bit careful to preserve that bit when doing an index 
refresh, but it's really not very hard. The hardest part is actually doing 
so for directories, since we don't keep the directories in the index at 
_all_.

But the fact is, it wouldn't solve the git-tar-tree thing. We can 
_represent_ exact masks, but we don't _want_ to, because normally it just 
leads to horrible problems with different people having different umasks. 
So in order to avoid having mode change merges, we'd _still_ have to make 
the current "0666/0777 + umask" be the normal one, and you'd use this 
"exact mode" thing only for very special cases (ie for backing up your 
home directory or similar, _not: for a distributed SCM).

As to tar: I think the current

        if (S_ISDIR(mode) || S_ISREG(mode))
                mode |= (mode & 0100) ? 0777 : 0666;

is wrong. It makes things world-writable by default, and that's just 
dangerous. "tar" normally won't apply umask when untarring (there's a flag 
for it, but I have never ever used it myself, and I doubt anybody else 
really does either - it's called "--no-same-permissions" in GNU tar).

I think a "0775" or "0664" might be acceptable (an umask of 002 is at 
least _normal_), but I suspect 0755/0644 is really better. Doing a simple 

	chmod -R +w

afterwards is better (and takes umask into account) than a "chmod -R o-w", 
since the latter leaves the tree writable for a while.

Ie default permissions are better off being too strict than too lax. Basic 
security.

Of course, if we were to add the "exact mode" bit, then git-tar-tree 
should obviously honor that for any files that have that bit set.

		Linus
