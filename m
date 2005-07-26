From: Linus Torvalds <torvalds@osdl.org>
Subject: Linux BKCVS kernel history git import..
Date: Tue, 26 Jul 2005 11:57:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507261136280.19309@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 26 21:02:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxUfz-0003np-2A
	for gcvg-git@gmane.org; Tue, 26 Jul 2005 21:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVGZTAl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jul 2005 15:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVGZS6a
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jul 2005 14:58:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6291 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262032AbVGZS5r (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2005 14:57:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6QIvjjA007860
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Jul 2005 11:57:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6QIviar006195;
	Tue, 26 Jul 2005 11:57:44 -0700
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Ok, I'm uploading my current git CVS import results to kernel.org right
now, which is my current best effort (meaning: I may try to improve on it
even if there aren't any more cvsps bugs/features I have to fix, and
obviously I'll re-create it if there _are_ cvsps or cvsimport bugs that
cause the import to have problems).

I've "verified" it in the sense that I've done a "git-whatchanged -p" at
various stages of the import, and it looked sane. I also compared doing a
tar-tree-export of the 2.6.12-rc2 release, which exists both in my current
git tree _and_ in the old bkcvs tree, and they compared identically apart
from the fact that the bkcvs tree has the BitKeeper/ directory and a
ChangeSet file.

It's also pretty aggressively packed - I used "--window=50 --depth=50"  
(rather than the default 10 for both) to make the archive smaller, so it's
going to be somewhat more CPU-intensive to use (due to the possibly longer
delta chains), but it got the pack-file down from 204MB to 166MB, which I
think is pretty damn good for three years of history or whatever it is.

Especially considering that a gzip -9'd tar-file of the 2.6.12-rc2 release
is 45MB all on its own, that archive is just 3.6 times a single tree.

Of course, this _is_ the cvs import, which means that it's basically just
a straight-line linearization of the real BK history, but it's a pretty
good linearization and so it's certainly useful.

If somebody adds some logic to "parse_commit()" to do the "fake parent"
thing, you can stitch the histories together and see the end result as one
big tree. Even without that, you can already do things like

	git diff v2.6.10..v2.6.12

(which crosses the BK->git transition) by just copying the 166MB pack-file 
over, along with the tags that come with the thing. I've not verified it, 
but if that doesn't work, then it's a git bug. It _should_ work.

BIG NOTE! This is definitely one archive you want to "rsync" instead of
closing with a git repack. The unpacked archive is somewhere in the 2.4GB
region, and since I actually used a higher compression ratio than the
default, you'll transfer a smaller pack that way anyway.

It will probably take a while to mirror out (in fact, as I write this, the
DSL upload just from my local machine out still has fifteen minutes to
go), but it should be visible out there soonish. Please holler if you find
any problems with the conversion, or if you just have suggestions for
improvments.

It actually took something like 16 hours to do the conversion on my
machine (most of it appears to have been due to CVS being slow, the git
parts were quick), so I won't re-convert for any trivial things.

I'm planning on doing the 2.4 tree too some day - either as a separate
branch in the same archive, or as a separate git archive, I haven't quite
decided yet. But I was more interested int he 2.6.x tree (for obvious
reasons), and before I do the 2.4.x one I'd like to give that tree some
time for people to check if the conversion was ok.

One thing that could be verified, for example (but that I have _not_
done), is to do a few random "git diff v2.6.x..v2.6.y" and comparing the
result with the standard diffs that are out there. Just to verify that the
archive looks ok. I assume there is some "diff-compare" out there that can
handle the fact that the files are diffed in a different order (and with
different flags) etc.

		Linus
