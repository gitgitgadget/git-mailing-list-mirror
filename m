From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC] Design of name-addressed data portion
Date: Sun, 24 Apr 2005 14:17:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504241336250.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Apr 24 20:13:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPlat-000762-6e
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 20:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbVDXSRW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 14:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbVDXSRW
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 14:17:22 -0400
Received: from iabervon.org ([66.92.72.58]:40452 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262359AbVDXSRQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 14:17:16 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DPlfX-0005QU-00; Sun, 24 Apr 2005 14:17:23 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I think it has gotten to be time to have a standard mechanism for
name-addressed data in the .git directory. We currently have one
agreed-upon item, HEAD, as well as a number of items in cogito: heads,
tags, and, to a certain extent, remotes. (Even in core git, when we
support tags, we'll want a mapping from tag names to tag objects, even if
this mapping doesn't get transferred by push and pull operations; nobody's
going to want to cut and paste a hash from email every time they want to
refer to the tag, and fsck-cache could stand to know which tags you mean
to have so that it can report the rest to git-prune-script)

It would be useful to have a bit more structure to the repository, such
that there are a fixed number of paths that hold all of the information
about the state of the repository, while the rest of the directory has
information that is particular to a working directory's state (e.g.,
index).



I'd propose the following structure:

 objects/    the content-addressed repository portion
 references/ the name-addressed repository portion
   heads/    the heads that are being used out of this repository
     DEFAULT the head that people pulling this repository mean by default
     ...     other heads, by name, that fsck-cache should mark reachable
   tags/     the tags
     ...     files with the symbolic name of the tags, containing the hash
 info/       other per-repository information
   remotes   URLs of remote repositories
   complete  hashes that the repository contains all references from
   missing   hashes that the repository lacks but wants
   excluded  hashes that the repository doesn't want
 ...         other files are per .git directory, not shared on push/pull
 index       
 HEAD        symlink to the head that is the local default
 tracked     remote that this working directory tracks

All of the files in references/*/* contain hex for objects in the
database, and are not synced between repositories in situ (but some sync
operations will read some of them and write them under different
names). fsck-cache would use as its reachability starting point $(cat
references/*/*).

In info/ are, generically, other files that relate to operations which
work on the repository rather than a working directory. Transfer programs
would use and maintain this information.

I think we'd still eventually want some way of getting from a commit-id to
any tags about it (I think git log would do well to mention any tags you
have when it shows a commit), but I don't want to design this quite
yet. It should also work for going from the real history to cached delta
info, when we have comparison tools that are sufficiently smart,
expensive, and intermediate-dependant to want to cache this.

	-Daniel
*This .sig left intentionally blank*

