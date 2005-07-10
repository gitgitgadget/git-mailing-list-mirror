From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/2] Support for packs in HTTP
Date: Sun, 10 Jul 2005 16:45:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507101637390.17536@g5.osdl.org>
References: <Pine.LNX.4.21.0507101539220.30848-100000@iabervon.org>
 <7vzmsus1eu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 01:51:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Drla6-0002zj-FI
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 01:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVGJXsi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 19:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbVGJXqT
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 19:46:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16280 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262164AbVGJXpe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 19:45:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6ANjKjA024498
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 10 Jul 2005 16:45:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6ANjJ52007570;
	Sun, 10 Jul 2005 16:45:19 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmsus1eu.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 10 Jul 2005, Junio C Hamano wrote:
>
> So I would suggest either:
> 
>   - droping the packname parameter from git-pack-objects.  Make
>     the packs always named pack-X{40}.pack (or just X{40}.pack);

Well, regardless, we want to be able to specify which directory to write 
them to. We don't necessarily want to write them to the current working 
directory, nor do we want to write them to their eventual destination in 
.git/objects/pack.

In fact, the main current user ("git repack") really wants to write them 
to a temporary file, and one that isn't even called "pack-xxx", since it 
ends up doing cleanup with 

	rm -f .tmp-pack-*

in case a previous re-pack was interrupted (in which case it simply cannor
know what the exact name was supposed to be).

So the "basename" ends up being necessary and meaningful regardless. We do 
_not_ want to remove that capability.

>     also have verify-pack to verify the name of the packfile,
>     and make sure X{40} part of the name matches what it claims
>     to contain;

Now, that would be fine, but it can't be done. Not the way things are laid 
out. A SHA1 checksum depends on the order the data was checksummed in, and 
we don't even save that.

>   - or drop sha1_pack_name() and let the user name the pack any
>     way he wants.

No, I do want to use a SHA1, because I want to make sure that you can mix 
packs in a rsync/wget environment where if two files are named the same, 
they'll have the same contents.

So we can make verify-pack check that the pack-name matches the style
"pack-xxxxx." naming convention, but we can't match up the sha1 with
anything.

		Linus
