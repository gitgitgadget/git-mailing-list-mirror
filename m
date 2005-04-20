From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] write-tree performance problems
Date: Tue, 19 Apr 2005 20:49:21 -0400
Message-ID: <200504192049.21947.mason@suse.com>
References: <200504191250.10286.mason@suse.com> <200504191708.23536.mason@suse.com> <Pine.LNX.4.58.0504191420060.19286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 02:46:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO3Lx-0002Yy-Sn
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 02:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVDTAtv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 20:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVDTAtv
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 20:49:51 -0400
Received: from mx1.suse.de ([195.135.220.2]:10404 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261179AbVDTAt2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 20:49:28 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id E06F316093C8;
	Wed, 20 Apr 2005 02:49:25 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.58.0504191420060.19286@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tuesday 19 April 2005 17:23, Linus Torvalds wrote:
> On Tue, 19 Apr 2005, Chris Mason wrote:
> > Regardless, putting it into the index somehow should be fastest, I'll see
> > what I can do.
>
> Start by putting it in at "read-tree" time, and adding the code to
> invalidate all parent directory indexes when somebody changes a file in
> the index (ie "update-cache" for anything but a "--refresh").
>
> That would be needed anyway, since those two are the ones that already
> change the index file.
>
> Once you're sure that you can correctly invalidate the entries (so that
> you could never use a stale tree entry by mistake), the second stage would
> be to update it at "write-tree" time.

This was much easier then I expected, and it seems to be working here.  It 
does slow down the write-tree slightly because we have to write out the index 
file, but I can get around that with the index file on tmpfs change.

The original write-tree needs .54 seconds to run

write-tree with the index speedup gets that down to .024s (same as my first 
patch) when nothing has changed.  When it has to rewrite the index file 
because something changed, it's .167s.

I'll finish off the patch once you ok the basics below.  My current code works 
like this:

1) read-tree will insert index entries for directories.  There is no index 
entry for the root.

2) update-cache removes index entries for all parents of the file you're 
updating.  So, if you update-cache fs/ext3/inode.c, I remove the index of fs 
and fs/ext3

3) If write-tree finds a directory in the index, it uses the sha1 in the cache 
entry and skips all files/dirs under that directory.

4) If write-tree detects a subdir with no directory in the index, it calls 
write_tree the same way it used to.  It then inserts a new cache object with 
the calculated sha1.

5) right before exiting, write-tree updates the index if it made any changes.

The downside to this setup is that I've got to change other index users to 
deal with directory entries that are there sometimes and missing other times.  
The nice part is that I don't have to "invalidate" the directory entry, if it 
is present, it is valid.

-chris
