From: Fengguang Wu <fengguang.wu@gmail.com>
Subject: Re: How git affects kernel.org performance
Date: Wed, 10 Jan 2007 22:07:30 +0800
Message-ID: <368438013.19600@ustc.edu.cn>
References: <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org> <20070107085526.GR24090@1wt.eu> <20070107011542.3496bc76.akpm@osdl.org> <20070108030555.GA7289@in.ibm.com> <20070108125819.GA32756@thunk.org> <368329554.17014@ustc.edu.cn> <Pine.LNX.4.64.0701090821550.3661@woody.osdl.org> <20070110015739.GA26978@mail.ustc.edu.cn> <1168399249.2585.6.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Theodore Tso <tytso@mit.edu>,
	Suparna Bhattacharya <suparna@in.ibm.com>,
	Andrew Morton <akpm@osdl.org>, Willy Tarreau <w@1wt.eu>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	"J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
X-From: linux-ext4-owner@vger.kernel.org Wed Jan 10 15:07:28 2007
Return-path: <linux-ext4-owner@vger.kernel.org>
Envelope-to: gcfe-linux-ext4@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4e6x-0005Q7-ON
	for gcfe-linux-ext4@gmane.org; Wed, 10 Jan 2007 15:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbXAJOH0 (ORCPT <rfc822;gcfe-linux-ext4@m.gmane.org>);
	Wed, 10 Jan 2007 09:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbXAJOH0
	(ORCPT <rfc822;linux-ext4-outgoing>);
	Wed, 10 Jan 2007 09:07:26 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:53868 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S964867AbXAJOHZ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
	Wed, 10 Jan 2007 09:07:25 -0500
Received: (eyou send program); Wed, 10 Jan 2007 22:06:53 +0800
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Received: from unknown (HELO localhost) (210.45.74.191)
 by 202.38.64.8 with SMTP; Wed, 10 Jan 2007 22:06:53 +0800
Received: from wfg by localhost with local (Exim 4.63)
	(envelope-from <wfg@localhost>)
	id 1H4e70-0002Bx-E8; Wed, 10 Jan 2007 22:07:30 +0800
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Message-ID: <20070110140730.GA986@mail.ustc.edu.cn>
Mail-Followup-To: Nigel Cunningham <nigel@nigel.suspend2.net>,
	Linus Torvalds <torvalds@osdl.org>, Theodore Tso <tytso@mit.edu>,
	Suparna Bhattacharya <suparna@in.ibm.com>,
	Andrew Morton <akpm@osdl.org>, Willy Tarreau <w@1wt.eu>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	"J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1168399249.2585.6.camel@nigel.suspend2.net>
X-GPG-Fingerprint: 53D2 DDCE AB5C 8DC6 188B  1CB1 F766 DA34 8D8B 1C6D
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 10, 2007 at 02:20:49PM +1100, Nigel Cunningham wrote:
> Hi.
> 
> On Wed, 2007-01-10 at 09:57 +0800, Fengguang Wu wrote:
> > On Tue, Jan 09, 2007 at 08:23:32AM -0800, Linus Torvalds wrote:
> > >
> > >
> > > On Tue, 9 Jan 2007, Fengguang Wu wrote:
> > > > >
> > > > > The fastest and probably most important thing to add is some readahead
> > > > > smarts to directories --- both to the htree and non-htree cases.  If
> > > >
> > > > Here's is a quick hack to practice the directory readahead idea.
> > > > Comments are welcome, it's a freshman's work :)
> > >
> > > Well, I'd probably have done it differently, but more important is whether
> > > this actually makes a difference performance-wise. Have you benchmarked it
> > > at all?
> > 
> > Yes, a trivial test shows a marginal improvement, on a minimal debian system:
> > 
> > # find / | wc -l
> > 13641
> > 
> > # time find / > /dev/null
> > 
> > real    0m10.000s
> > user    0m0.210s
> > sys     0m4.370s
> > 
> > # time find / > /dev/null
> > 
> > real    0m9.890s
> > user    0m0.160s
> > sys     0m3.270s
> > 
> > > Doing an
> > >
> > > 	echo 3 > /proc/sys/vm/drop_caches
> > >
> > > is your friend for testing things like this, to force cold-cache
> > > behaviour..
> > 
> > Thanks, I'll work out numbers on large/concurrent dir accesses soon.
> 
> I gave it a try, and I'm afraid the results weren't pretty.
> 
> I did:
> 
> time find /usr/src | wc -l
> 
> on current git with (3 times) and without (5 times) the patch, and got
> 
> with:
> real   54.306, 54.327, 53.742s
> usr    0.324, 0.284, 0.234s
> sys    2.432, 2.484, 2.592s
> 
> without:
> real   24.413, 24.616, 24.080s
> usr    0.208, 0.316, 0.312s
> sys:   2.496, 2.440, 2.540s
> 
> Subsequent runs without dropping caches did give a significant
> improvement in both cases (1.821/.188/1.632 is one result I wrote with
> the patch applied).

Thanks, Nigel.
But I'm very sorry that the calculation in the patch was wrong.

Would you give this new patch a run?

It produced pretty numbers here:

#!/bin/zsh

ROOT=/mnt/mnt
TIMEFMT="%E clock  %S kernel  %U user  %w+%c cs  %J"

echo 3 > /proc/sys/vm/drop_caches

# 49: enable dir readahead
# 50: disable
echo ${1:-50} > /proc/sys/vm/readahead_ratio

# time find $ROOT/a > /dev/null

time find /etch > /dev/null

# time find $ROOT/a > /dev/null&
# time grep -r asdf $ROOT/b > /dev/null&
# time cp /etch/KNOPPIX_V5.0.1CD-2006-06-01-EN.iso /dev/null&

exit 0

# collected results on a SATA disk:
# ./test-parallel-dir-reada.sh 49
4.18s clock  0.08s kernel  0.04s user  418+0 cs  find $ROOT/a > /dev/null
4.09s clock  0.10s kernel  0.02s user  410+1 cs  find $ROOT/a > /dev/null

# ./test-parallel-dir-reada.sh 50
12.18s clock  0.15s kernel  0.07s user  1520+4 cs  find $ROOT/a > /dev/null
11.99s clock  0.13s kernel  0.04s user  1558+6 cs  find $ROOT/a > /dev/null


# ./test-parallel-dir-reada.sh 49
4.01s clock  0.06s kernel  0.01s user  1567+2 cs  find /etch > /dev/null
4.08s clock  0.07s kernel  0.00s user  1568+0 cs  find /etch > /dev/null

# ./test-parallel-dir-reada.sh 50
4.10s clock  0.09s kernel  0.01s user  1578+1 cs  find /etch > /dev/null
4.19s clock  0.08s kernel  0.03s user  1578+0 cs  find /etch > /dev/null


# ./test-parallel-dir-reada.sh 49
7.73s clock  0.11s kernel  0.06s user  438+2 cs  find $ROOT/a > /dev/null
18.92s clock  0.43s kernel  0.02s user  1246+13 cs  cp /etch/KNOPPIX_V5.0.1CD-2006-06-01-EN.iso /dev/null
32.91s clock  4.20s kernel  1.55s user  103564+51 cs  grep -r asdf $ROOT/b > /dev/null

8.47s clock  0.10s kernel  0.02s user  442+4 cs  find $ROOT/a > /dev/null
19.24s clock  0.53s kernel  0.03s user  1250+23 cs  cp /etch/KNOPPIX_V5.0.1CD-2006-06-01-EN.iso /dev/null
29.93s clock  4.18s kernel  1.61s user  100425+47 cs  grep -r asdf $ROOT/b > /dev/null

# ./test-parallel-dir-reada.sh 50
17.87s clock  0.57s kernel  0.02s user  1244+21 cs  cp /etch/KNOPPIX_V5.0.1CD-2006-06-01-EN.iso /dev/null
21.30s clock  0.08s kernel  0.05s user  1517+5 cs  find $ROOT/a > /dev/null
49.68s clock  3.94s kernel  1.67s user  101520+57 cs  grep -r asdf $ROOT/b > /dev/null

15.66s clock  0.51s kernel  0.00s user  1248+25 cs  cp /etch/KNOPPIX_V5.0.1CD-2006-06-01-EN.iso /dev/null
22.15s clock  0.15s kernel  0.04s user  1520+5 cs  find $ROOT/a > /dev/null
46.14s clock  4.08s kernel  1.68s user  101517+63 cs  grep -r asdf $ROOT/b > /dev/null

Thanks,
Wu
---

Subject: ext3 readdir readahead

Do readahead for ext3_readdir().

Reasons to be aggressive:
- readdir() users are likely to traverse the whole directory,
  so readahead miss is not a concern.
- most dirs are small, so slow start is not good
- the htree indexing introduces some randomness,
  which can be helped by the aggressiveness.

So we do 128K sized readaheads, at twice the speed of reads.

The following actual readahead pages are collected for a dir with
110000 entries:
	32 31 30 31 28 29 29 28 27 25 29 22 25 30 24 15 19
That means a readahead hit ratio of
	454/541 = 84%

The performance is marginally better for a minimal debian system:
	command:	find /
	baseline:	4.10s	4.19s
	patched:	4.01s	4.08s

And considerably better for 100 directories, each with 1000 8K files:
	command:	find /throwaways
	baseline:	12.18s	11.99s
	patched:	 4.18s	 4.09s

And also noticable better for parallel operations:
					baseline	patched
	find /throwaways &		21.30s 22.15s    7.73s  8.47s 
	grep -r asdf /throwaways2 &     49.68s 46.14s   32.91s 29.93s 
	cp /KNOPPIX_CD.iso /dev/null &  17.87s 15.66s   18.92s 19.24s 

Signed-off-by: Fengguang Wu <wfg@mail.ustc.edu.cn>
---
 fs/ext3/dir.c           |   33 +++++++++++++++++++++++++++++++++
 fs/ext3/inode.c         |    2 +-
 include/linux/ext3_fs.h |    2 ++
 3 files changed, 36 insertions(+), 1 deletion(-)

--- linux.orig/fs/ext3/dir.c
+++ linux/fs/ext3/dir.c
@@ -94,6 +94,28 @@ int ext3_check_dir_entry (const char * f
 	return error_msg == NULL ? 1 : 0;
 }
 
+#define DIR_READAHEAD_BYTES  (128*1024)
+#define DIR_READAHEAD_PGMASK ((DIR_READAHEAD_BYTES >> PAGE_CACHE_SHIFT) - 1)
+
+static void ext3_dir_readahead(struct file * filp)
+{
+	struct inode *inode = filp->f_path.dentry->d_inode;
+	struct address_space *mapping = inode->i_sb->s_bdev->bd_inode->i_mapping;
+	int bbits = inode->i_blkbits;
+	unsigned long blk, end;
+
+	blk = filp->f_ra.prev_page << (PAGE_CACHE_SHIFT - bbits);
+	end = min(inode->i_blocks >> (bbits - 9),
+		  blk + (DIR_READAHEAD_BYTES >> bbits));
+
+	for (; blk < end; blk++) {
+		pgoff_t phy;
+		phy = generic_block_bmap(inode->i_mapping, blk, ext3_get_block)
+				>> (PAGE_CACHE_SHIFT - bbits);
+		do_page_cache_readahead(mapping, filp, phy, 1);
+	}
+}
+
 static int ext3_readdir(struct file * filp,
 			 void * dirent, filldir_t filldir)
 {
@@ -108,6 +130,17 @@ static int ext3_readdir(struct file * fi
 
 	sb = inode->i_sb;
 
+	/*
+	 * Reading-ahead at 2x the page fault rate, in hope of reducing
+	 * readahead misses caused by the partially random htree order.
+	 */
+	filp->f_ra.prev_page += 2;
+	filp->f_ra.prev_page &= ~1;
+
+	if (!(filp->f_ra.prev_page & DIR_READAHEAD_PGMASK) &&
+		filp->f_ra.prev_page < (inode->i_blocks >> (PAGE_CACHE_SHIFT-9)))
+		ext3_dir_readahead(filp);
+
 #ifdef CONFIG_EXT3_INDEX
 	if (EXT3_HAS_COMPAT_FEATURE(inode->i_sb,
 				    EXT3_FEATURE_COMPAT_DIR_INDEX) &&
--- linux.orig/fs/ext3/inode.c
+++ linux/fs/ext3/inode.c
@@ -945,7 +945,7 @@ out:
 
 #define DIO_CREDITS (EXT3_RESERVE_TRANS_BLOCKS + 32)
 
-static int ext3_get_block(struct inode *inode, sector_t iblock,
+int ext3_get_block(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh_result, int create)
 {
 	handle_t *handle = journal_current_handle();
--- linux.orig/include/linux/ext3_fs.h
+++ linux/include/linux/ext3_fs.h
@@ -814,6 +814,8 @@ struct buffer_head * ext3_bread (handle_
 int ext3_get_blocks_handle(handle_t *handle, struct inode *inode,
 	sector_t iblock, unsigned long maxblocks, struct buffer_head *bh_result,
 	int create, int extend_disksize);
+extern int ext3_get_block(struct inode *inode, sector_t iblock,
+			struct buffer_head *bh_result, int create);
 
 extern void ext3_read_inode (struct inode *);
 extern int  ext3_write_inode (struct inode *, int);
