From: Chris Wright <chrisw@osdl.org>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Mon, 11 Jul 2005 13:30:42 -0700
Message-ID: <20050711203042.GR5324@shell0.pdx.osdl.net>
References: <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> <20050707221443.GB7151@pasky.ji.cz> <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org> <12c511ca05070716526954edd@mail.gmail.com> <Pine.LNX.4.58.0507071658460.25104@g5.osdl.org> <12c511ca050707170964a2cc92@mail.gmail.com> <Pine.LNX.4.58.0507071720330.25104@g5.osdl.org> <20050709225818.A31045@flint.arm.linux.org.uk> <20050710090914.B11765@flint.arm.linux.org.uk> <20050710145954.GB24249@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Russell King <rmk@arm.linux.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 22:33:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds4y7-0007Cu-UR
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 22:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbVGKUcT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 16:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbVGKUcO
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 16:32:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29087 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262604AbVGKUbX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 16:31:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6BKUhjA019904
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Jul 2005 13:30:45 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6BKUgWY030227;
	Mon, 11 Jul 2005 13:30:42 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j6BKUgS7030226;
	Mon, 11 Jul 2005 13:30:42 -0700
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20050710145954.GB24249@pasky.ji.cz>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Petr Baudis (pasky@suse.cz) wrote:
> Ok, cg-pull didn't quite handle this. I've fixed it so that it should
> reasonably handle it now. Hopefully.

Is this plus the zero-sized fix worth making cogito-0.12-2 rpm release?

IOW, these two patches...

diff-tree 291ec0f2d2ce65e5ccb876b46d6468af49ddb82e (from 72347a233e6f3c176059a28f0817de6654ef29c7)
tree a1d3a4e01516f1d924c407a9e42a6df0d13b43b6
parent 72347a233e6f3c176059a28f0817de6654ef29c7
author Linus Torvalds <torvalds@g5.osdl.org> 1120608369 -0700
committer Linus Torvalds <torvalds@g5.osdl.org> 1120608369 -0700

    Don't special-case a zero-sized compression.
    
    zlib actually writes a header for that case, and while ignoring that
    header will get us the right data, it will also end up messing up our
    stream position.  So we actually want zlib to "uncompress" even an empty
    object.

diff --git a/unpack-objects.c b/unpack-objects.c
--- a/unpack-objects.c
+++ b/unpack-objects.c
@@ -55,8 +55,6 @@ static void *get_data(unsigned long size
 	z_stream stream;
 	void *buf = xmalloc(size);
 
-	if (!size)
-		return buf;
 	memset(&stream, 0, sizeof(stream));
 
 	stream.next_out = buf;
diff-tree 7b754d7f0800117cd97afa5e806e50c7fd16d8c1 (from a2503fd85e6bb7f25d134a5634a1d8efc93fee5f)
Author: Petr Baudis <pasky@suse.cz>
Date:   Sun Jul 10 16:59:28 2005 +0200

    Fix cg-pull to handle packed tags properly
    
    If the objects referenced by refs/tags/ are packed, it wouldn't detect
    them properly and instead try to refetch them, but they are likely to
    be packed on the other side as well and that makes them impossible to
    be fetched explicitly (which isn't a problem as long as they are the
    same branch).
    
    Also, the fetch failure message was confusing.
    
    Reported by Russel King.

diff --git a/cg-pull b/cg-pull
--- a/cg-pull
+++ b/cg-pull
@@ -294,13 +294,14 @@ $fetch -i -s -u -d "$uri/refs/tags" "$_g
 	for tag in *; do
 		[ "$tag" = "*" ] && break
 		tagid=$(cat $tag)
-		tagfile=objects/${tagid:0:2}/${tagid:2}
-		[ -s "../../$tagfile" ] && continue
+		GIT_DIR=../../../$_git git-cat-file -t "$tagid" >/dev/null 2>&1 && continue
 		echo -n "Missing object of tag $tag... "
+		# In case it's not in a packfile...
+		tagfile=objects/${tagid:0:2}/${tagid:2}
 		if $fetch -i -s "$uri/$tagfile" "../../$tagfile" 2>/dev/null >&2; then
 			echo "retrieved"
 		else
-			echo "different source (obsolete tag?)"
+			echo "unable to retrieve"
 		fi
 	done
 )
