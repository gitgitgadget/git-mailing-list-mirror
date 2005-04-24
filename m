From: Andreas Gal <gal@uci.edu>
Subject: [PATCH] fix segfault in fsck-cache (2nd attempt)
Date: Sat, 23 Apr 2005 22:55:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504232250210.9799@sam.ics.uci.edu>
References: <20050424033554.GA23293@diku.dk> <Pine.LNX.4.58.0504232056160.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 07:51:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPa1c-0002Y3-Jx
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 07:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbVDXF4K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 01:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbVDXF4K
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 01:56:10 -0400
Received: from sam.ics.uci.edu ([128.195.38.141]:17816 "EHLO sam.ics.uci.edu")
	by vger.kernel.org with ESMTP id S262269AbVDXFz7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 01:55:59 -0400
Received: from sam.ics.uci.edu (localhost.localdomain [127.0.0.1])
	by sam.ics.uci.edu (8.12.11/8.12.11) with ESMTP id j3O5tseQ009946;
	Sat, 23 Apr 2005 22:55:54 -0700
Received: from localhost (gal@localhost)
	by sam.ics.uci.edu (8.12.11/8.12.8/Submit) with ESMTP id j3O5tsEm009942;
	Sat, 23 Apr 2005 22:55:54 -0700
X-Authentication-Warning: sam.ics.uci.edu: gal owned process doing -bs
X-X-Sender: gal@sam.ics.uci.edu
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504232056160.2344@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Here is how to trigger it:

echo blob 100 > .git/objects/00/ae4e8d3208e09f2cf7a38202a126f728cadb49

Then run fsck-cache. It will try to unpack after the header to calculate 
the hash, inflate returns total_out == 0 and memcpy() dies.

The patch below seems to work with ZLIB 1.1 and 1.2.

Signed-off-by: Andreas Gal <gal@uci.edu>

--- 97a515a073fec5870dfaaa279868ce9330853d3d/sha1_file.c
+++ sha1_file.c
@@ -155,6 +155,8 @@
 
        inflateInit(&stream);
        ret = inflate(&stream, 0);
+       if (ret < Z_OK)
+               return NULL;
        if (sscanf(buffer, "%10s %lu", type, size) != 2)
                return NULL;
 
On Sat, 23 Apr 2005, Linus Torvalds wrote:

> 
> 
> On Sun, 24 Apr 2005, Jonas Fonseca wrote:
> >
> > It seems by far the easiest to let diff-cache take care of skipping
> > files which have not been modified. The alternative is to keep
> > diff-cache's lazy checking and make cogito's diff jump through hoops.
> > Note, although the new SHA1 signature is derived, diff-cache still
> > prints the special no-SHA1 for the modified file.
> 
> The reason I don't want this is that if the commands keep on silently
> fixing things like this up, then performance will go down the toilet.
> 
> What _should_ happen is that you do an "update-cache --refresh" before    
> doing the diff-cache. That way you do _not_ end up having to check the    
> sha1 match over and over again if you just did a "touch" on the file.
> 
> In other words, you're adding bandage for a problem that shouldn't exist,
> and you're doing it in a way which means that _if_ the problem exists,    
> you'll never fix it, but you'll just rely on your bandage all the time.
> 
> So cogito definitely does not have to jump through any hoops at all. It
> should just make sure to keep the cache up-to-date if it ever cares (ie
> do "update-cache --refresh"). 
> 
> Some commands obviously won't care.
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
