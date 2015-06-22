From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: broken repo after power cut
Date: Sun, 21 Jun 2015 20:35:51 -0400
Message-ID: <20150622003551.GP29480@thunk.org>
References: <5585C1B6.50407@nod.at>
 <330ab8f498e1b435d5b210384200b649@www.dscho.org>
 <5586B71D.2070407@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, David Gstir <david@sigma-star.at>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
X-From: linux-fsdevel-owner@vger.kernel.org Mon Jun 22 02:36:03 2015
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Envelope-to: lnx-linux-fsdevel@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-fsdevel-owner@vger.kernel.org>)
	id 1Z6piU-0003Kn-7l
	for lnx-linux-fsdevel@plane.gmane.org; Mon, 22 Jun 2015 02:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979AbbFVAf7 (ORCPT <rfc822;lnx-linux-fsdevel@m.gmane.org>);
	Sun, 21 Jun 2015 20:35:59 -0400
Received: from imap.thunk.org ([74.207.234.97]:47612 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723AbbFVAf5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
	Sun, 21 Jun 2015 20:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=nDPlivvcZC3bjFn/kl2c3xX+uOKIkcyH/Brq2OTclcI=;
	b=QQmFatT9A9D8YdtilaLWhMDUVydO7c9Tclha1SCEoSzR9LRidaawAq1mAp5zkFVhYps86OWDUdjcs3AwikCKJIMtCgmYvlEbpieujmhvAMMI+vAG43E5yEDJpsh9kFTsz9UUYSpuJjc2Huo3UA/Ks09iuUYkD2q0ExYdA1PnWKs=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.84)
	(envelope-from <tytso@thunk.org>)
	id 1Z6piK-0003hi-5Q; Mon, 22 Jun 2015 00:35:52 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 6C14E5803FF; Sun, 21 Jun 2015 20:35:51 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <5586B71D.2070407@nod.at>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272307>

On Sun, Jun 21, 2015 at 03:07:41PM +0200, Richard Weinberger wrote:

> > I was then shocked to learn that ext4 apparently has a default
> > setting that allows it to truncate files upon power failure
> > (something about a full journal vs a fast journal or some such)

s/ext4/all modern file systems/

POSIX makes **no guarantees** about what happens after a power failure
unless you use fsync() --- which git does not do by default (see below).

> You mean the ext4 delayed block allocation feature/issue?
> IIRC Ted added some hacks to ext4 to detect misbehaving applications (Gnome and KDE).
> But to my knowledge such an file corruption must not happen if the application behaves well. And it can happen on all file systems.
> Ted, maybe you can help us? BTW: I'm using ext4's default mount options from openSUSE, data=ordered.

The hacks (which were agreed upon by all of the major file system
developers --- ext4, btfs, xfs --- at the Linux File Systems and
Storage summit a couple of years ago --- protects against the default
text editors of GNOME and KDE which were saving file without using
fsync(), and in one particularly egregious example (although I don't
remember which program was doing this), updated files by opening the
file with O_TRUNC and then rewritng the new contents of the file.  So
if you crashed just after the open(2), and before the file data was
written, you were guaranteed to lose data.

The hack protects against data loss when programs updated a file
incompetently.  What we agreed to do was that upon renaming a fileA on
top of another fileB, there is an implicit writeback initiated of
fileA.  If the program properly called fsync(2) before closing the
file descriptor for fileA and doing the rename, this implicit
writeback would be no-op.  Simiarly, if a file descriptor was opened
with O_TRUNC, when the file descriptor is closed, we start an implicit
writeback at that point.  Note that this is not the same as a full
fsync; it merely closes the race window from 30 seconds down to a
second or so (depending on how busy the disk is).

But this hack does not protect against freshly written files, which is
the case of git object files or git pack files.  The basic idea here
is that you could have just as easily crashed before the commit as
after the commit, and doing an implicit writeback after all file
closes would have destroyed performance and penalized progams that
didn't really care so much about the file hitting disk.  (For example,
if you do a compile, and you crash, it's not such a big deal.)

The bottome lins is that if you care about files being written, you
need to use fsync().  Should git use fsync() by default?  Well, if you
are willing to accept that if your system crashes within a second or
so of your last git operation, you might need to run "git fsck" and
potentially recover from a busted repo, maybe speed is more important
for you (and git is known for its speed/performance, after all. :-)

The actual state of the source tree would have been written using a
text editor which tends to be paranoid about using fsync (at least, if
you use a real editor like Emacs or Vi, as opposed to the toy notepad
editors shipped with GNOME or KDE :-).  So as long as you know what
you're doing, it's unlikely that you will actually lose any work.

Personally, I have core.fsyncobjectfiles set to yes in my .gitconfig.
Part of this is because I have an SSD, so the speed hit really doesn't
bother me, and needing to recover a corrupted git repository is a pain
(although I have certainly done it in the past).

						- Ted
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
