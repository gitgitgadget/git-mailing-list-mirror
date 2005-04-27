From: Wout <git@bliepbliep.net>
Subject: Re: enforcing DB immutability
Date: Wed, 27 Apr 2005 10:15:23 +0200
Message-ID: <20050427081523.GA23726@moon>
References: <20050413171052.GA22711@elte.hu> <Pine.LNX.4.58.0504131027210.4501@ppc970.osdl.org> <20050413182909.GA25221@elte.hu> <Pine.LNX.4.58.0504131144160.4501@ppc970.osdl.org> <20050413200237.GA26635@elte.hu> <425D7C0F.2050109@zytor.com> <20050413201523.GC27088@elte.hu> <Pine.LNX.4.58.0504131404380.4501@ppc970.osdl.org> <20050420074053.GA22436@elte.hu> <20050420074948.GA22620@elte.hu>
Reply-To: Wout <git@bliepbliep.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 10:11:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQhcs-0002tA-Q7
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 10:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVD0IPo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 04:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVD0IPn
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 04:15:43 -0400
Received: from adsl160-10.dsl.uva.nl ([146.50.160.10]:11587 "EHLO
	moon.bliepbliep.net") by vger.kernel.org with ESMTP id S261154AbVD0IP0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 04:15:26 -0400
Received: by moon.bliepbliep.net (Postfix, from userid 500)
	id 7BA7CD73CC; Wed, 27 Apr 2005 10:15:23 +0200 (CEST)
To: Ingo Molnar <mingo@elte.hu>
Mail-Followup-To: Wout <git@bliepbliep.net>,
	Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050420074948.GA22620@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 20, 2005 at 09:49:48AM +0200, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > perhaps having a new 'immutable hardlink' feature in the Linux VFS 
> > would help? I.e. a hardlink that can only be readonly followed, and 
> > can be removed, but cannot be chmod-ed to a writeable hardlink. That i 
> > think would be a large enough barrier for editors/build-tools not to 
> > play the tricks they already do that makes 'readonly' files virtually 
> > meaningless.
> 
> immutable hardlinks have the following advantage: a hardlink by design 
> hides the information where the link comes from. So even if an editor 
> wanted to play stupid games and override the immutability - it doesnt 
> know where the DB object is. (sure, it could find it if it wants to, but 
> that needs real messing around - editors wont do _that_)
> 
> i think this might work.
> 
> (the current chattr +i flag isnt quite what we need though because it 
> works on the inode, and it's also a root-only feature so it puts us back 
> to square one. What would be needed is an immutability flag on 
> hardlinks, settable by unprivileged users.)
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Slightly off-topic for this list. Apologies to those offended.

Would a filesystem that allows sharing of blocks between inodes
be useful here? Each block would need a reference count (refco).
Writing a block would be impossible once refco > 1. If someone
attempts to write to such a block, a new block is allocated for
that particular inode and the refco of the original is decreased.

Next to this there would have to be a clone_file() function:
    clone_file(src-file, dst-file, mode)

This function would create file dst-file with a new inode that
references the blocks belonging to src-file (increasing the
blocks' reference counts). The owner/group of dst-file are the
caller, not the owner of src-file.

Things to check for are:
    - read permissions for src-file
    - write permissions for dst-file
    - are src-file and dst-file in the same filesystem (if not,
      one could implement copy)
    - ...?


Suppose I have a file foo:

    foo -> inode1(blk1[1], blk2[1], blk3[1], blk4[1])

The [n] value on the blocks is the reference count.
I now call clone_file("foo", "bar", 0644):

    foo -> inode1(blk1[2], blk2[2], blk3[2], blk4[2])
    bar -> inode2(blk1[2], blk2[2], blk3[2], blk4[2])

Next I modify blk2 of bar (write):

    foo -> inode1(blk1[2], blk2[1], blk3[2], blk4[2])
    bar -> inode2(blk1[2], blk5[1], blk3[2], blk4[2])


I see the following uses:

- Checking out a tree of (uncompressed) files with git could be
  done using the clone_file() call on each file. This means no
  extra disk space is used unless files are edited later.

- Easy way to freeze files for backups. A database (mysql, ...)
  could bring its files into an acceptable state, call clone_file()
  on them and proceed with its work.

- It could be used to protect user files from external tampering.
  Someone mentioned the problems with malware killing his files.
  The impact of this could be reduced by having a script that did
  a clone_file() on everything as root periodically. If files are
  deleted, root would have a backup.


Notes:

- Small changes to files would probably cause all the blocks to
  be copied as programs (editors) usually write out the complete
  file.

- I don't know anything about implementing filesystems so all of
  the above could be complete nonsense.

- The idea isn't mine, I've come across this before under the name
  of 'snapshot filesystems' and I think it was patented. I've never
  heard of anyone doing this for individual files though.

Wout
