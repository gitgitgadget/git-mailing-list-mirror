From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and symlinks as tracked content
Date: Tue, 03 May 2005 13:23:51 -0700
Message-ID: <7vy8awt5wo.fsf@assigned-by-dhcp.cox.net>
References: <1115145234.21105.111.camel@localhost.localdomain>
	<Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 22:18:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT3pu-0000Tc-37
	for gcvg-git@gmane.org; Tue, 03 May 2005 22:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVECUX7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 16:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVECUX7
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 16:23:59 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:55707 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261681AbVECUXy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 16:23:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050503202353.SMIM7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 3 May 2005 16:23:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 3 May 2005 12:02:33 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Tue, 3 May 2005, Kay Sievers wrote:
>> Where can we store the link-target? In its own blob-object or directly
>> in the tree-object?

LT>  - directories: S_IFDIR (0040000) point to "tree" objects for contents
LT>  - symlinks: S_IFLNK (0120000) point to "blob" objects
LT>  - executables: S_IFREG | 0755 (0100755) point to "blob" objects
LT>  - regular files: S_IFREG | 0644 (0100644) point to "blob" objects

These and the device nodes you mention would work naturally on
the cache side and I generally like this idea.  You need to
update checkout-cache to (attempt to) create the right kind of
file, but that is about it.

On the diff side, things are a bit more interesting.  Both the
git-diff-tree-helper engine (diff.c) and git-apply-patch-script
need to be told about these new types of objects, or at least
tightened up to ignore them until they know how to support them.

LT> When you think of it that way, the "patch" ends up falling out very 
LT> naturally, I think. It would look like

LT> 	New file: filename (Mode: 0120000)
LT> 	--- /dev/null
LT> 	+++ filename
LT> 	@@ 0,0 1,1
LT> 	+symlink-value

LT> (or something, you get the idea).

I've always wanted to have this from the normal "diff -r"
output, but we have to be careful.  You do not want to
accidentally feed the normal patch that kind of output.  How
about doing something like this?

GIT: filename (mode:120000)
 --- /dev/null
 +++ filename
 @@ -0,0 +1 @@
 +symlink-value

GIT: filename (mode:120000)
 --- filename
 +++ /dev/null
 @@ -1 +0,0 @@
 -symlink-value

GIT: filename (mode:120000->120000)
 --- filename
 +++ filename
 @@ -1 +1 @@
 -old-symlink-value
 +new-symlink-value

That is, to indent them to keep patch from noticing them [*1*].

About the device nodes, the diffed contents would be major and
minor in decimal notation, and the real filesystem permission
bits and ownerships (e.g. changing /dev/audio from 0600 to 0660
or from root:root to root:audio).  I do not know if we would
want owner/group in symbolic or numeric yet.

GIT: filename (mode:0020000->0020000)
 --- dev/audio
 +++ dev/audio
 @@ -1,5 +1,5 @@
  major=14
  minor=4
  owner=root
 -group=root
 -perm=0600
 +group=audio
 +perm=0660

[Footnote]

*1* A careful but not careful enough reader would wonder if the use
of "--- /dev/null" or "+++ /dev/null" to represent an addition
and a deletion may hamper managing the device node "/dev/null",
but this is not a problem.  Such a device node managed by GIT
will appear as "--- dev/null" or "+++ dev/null", without the
leading slash.

