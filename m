From: Richard Weinberger <richard@nod.at>
Subject: Re: broken repo after power cut
Date: Mon, 22 Jun 2015 13:19:59 +0200
Message-ID: <5587EF5F.90207@nod.at>
References: <5585C1B6.50407@nod.at> <330ab8f498e1b435d5b210384200b649@www.dscho.org> <5586B71D.2070407@nod.at> <20150622003551.GP29480@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, David Gstir <david@sigma-star.at>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 22 13:20:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6zlp-0003vz-DZ
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 13:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932714AbbFVLUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 07:20:04 -0400
Received: from a.ns.miles-group.at ([95.130.255.143]:65276 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932968AbbFVLUC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 07:20:02 -0400
Received: (qmail 14947 invoked by uid 89); 22 Jun 2015 11:20:01 -0000
Received: by simscan 1.3.1 ppid: 14942, pid: 14945, t: 0.0532s
         scanners: attach: 1.3.1
Received: from unknown (HELO ?10.1.1.158?) (richard@nod.at@80.110.11.170)
  by radon.swed.at with ESMTPA; 22 Jun 2015 11:20:01 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150622003551.GP29480@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272333>

Am 22.06.2015 um 02:35 schrieb Theodore Ts'o:
> On Sun, Jun 21, 2015 at 03:07:41PM +0200, Richard Weinberger wrote:
> 
>>> I was then shocked to learn that ext4 apparently has a default
>>> setting that allows it to truncate files upon power failure
>>> (something about a full journal vs a fast journal or some such)
> 
> s/ext4/all modern file systems/
> 
> POSIX makes **no guarantees** about what happens after a power failure
> unless you use fsync() --- which git does not do by default (see below).

Thanks for pointing this out.

> The bottome lins is that if you care about files being written, you
> need to use fsync().  Should git use fsync() by default?  Well, if you
> are willing to accept that if your system crashes within a second or
> so of your last git operation, you might need to run "git fsck" and
> potentially recover from a busted repo, maybe speed is more important
> for you (and git is known for its speed/performance, after all. :-)
> 
> The actual state of the source tree would have been written using a
> text editor which tends to be paranoid about using fsync (at least, if
> you use a real editor like Emacs or Vi, as opposed to the toy notepad
> editors shipped with GNOME or KDE :-).  So as long as you know what
> you're doing, it's unlikely that you will actually lose any work.
> 
> Personally, I have core.fsyncobjectfiles set to yes in my .gitconfig.
> Part of this is because I have an SSD, so the speed hit really doesn't
> bother me, and needing to recover a corrupted git repository is a pain
> (although I have certainly done it in the past).

I think core.fsyncObjectFiles documentation really needs an update.
What about this one?

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 43bb53c..b08fa11 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -693,10 +693,16 @@ core.whitespace::
 core.fsyncObjectFiles::
 	This boolean will enable 'fsync()' when writing object files.
 +
-This is a total waste of time and effort on a filesystem that orders
-data writes properly, but can be useful for filesystems that do not use
-journalling (traditional UNIX filesystems) or that only journal metadata
-and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
+For performance reasons git does not call 'fsync()' after writing object
+files. This means that after a power cut your git repository can get
+corrupted as not all data hit the storage media. Especially on modern
+filesystems like ext4, xfs or btrfs this can happen very easily.
+If you have to face power cuts and care about your data it is strongly
+recommended to enable this setting.
+Please note that git's behavior used to be safe on ext3 with data=ordered,
+for any other filesystems or mount settings this is not the case as
+POSIX clearly states that you have to call 'fsync()' to make sure that
+all data is written.

 core.preloadIndex::
 	Enable parallel index preload for operations like 'git diff'

--
Thanks,
//richard
