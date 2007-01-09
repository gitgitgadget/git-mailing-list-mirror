From: Fengguang Wu <fengguang.wu@gmail.com>
Subject: Re: How git affects kernel.org performance
Date: Tue, 9 Jan 2007 15:59:46 +0800
Message-ID: <20070109075945.GA8799__43201.4260594316$1168330087$gmane$org@mail.ustc.edu.cn>
References: <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org> <20070107085526.GR24090@1wt.eu> <20070107011542.3496bc76.akpm@osdl.org> <20070108030555.GA7289@in.ibm.com> <20070108125819.GA32756@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 09 09:08:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4C1V-00014A-3C
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 09:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbXAIIHt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 03:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbXAIIHt
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 03:07:49 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:50662 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751146AbXAIIHs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 03:07:48 -0500
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jan 2007 03:07:44 EST
Received: (eyou send program); Tue, 09 Jan 2007 15:59:14 +0800
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Received: from unknown (HELO localhost) (210.45.71.196)
 by 202.38.64.8 with SMTP; Tue, 09 Jan 2007 15:59:14 +0800
Received: from wfg by localhost with local (Exim 4.63)
	(envelope-from <wfg@localhost>)
	id 1H4Bta-0002Iu-1o; Tue, 09 Jan 2007 15:59:46 +0800
To: Theodore Tso <tytso@mit.edu>,
	Suparna Bhattacharya <suparna@in.ibm.com>,
	Andrew Morton <akpm@osdl.org>, Willy Tarreau <w@1wt.eu>,
	Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Message-ID: <20070109075945.GA8799@mail.ustc.edu.cn>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Suparna Bhattacharya <suparna@in.ibm.com>,
	Andrew Morton <akpm@osdl.org>, Willy Tarreau <w@1wt.eu>,
	Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070108125819.GA32756@thunk.org>
X-GPG-Fingerprint: 53D2 DDCE AB5C 8DC6 188B  1CB1 F766 DA34 8D8B 1C6D
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36326>

On Mon, Jan 08, 2007 at 07:58:19AM -0500, Theodore Tso wrote:
> On Mon, Jan 08, 2007 at 08:35:55AM +0530, Suparna Bhattacharya wrote:
> > > Yeah, slowly-growing directories will get splattered all over the disk.
> > > 
> > > Possible short-term fixes would be to just allocate up to (say) eight
> > > blocks when we grow a directory by one block.  Or teach the
> > > directory-growth code to use ext3 reservations.
> > > 
> > > Longer-term people are talking about things like on-disk rerservations.
> > > But I expect directories are being forgotten about in all of that.
> > 
> > By on-disk reservations, do you mean persistent file preallocation ? (that
> > is explicit preallocation of blocks to a given file) If so, you are
> > right, we haven't really given any thought to the possibility of directories
> > needing that feature.
> 
> The fastest and probably most important thing to add is some readahead
> smarts to directories --- both to the htree and non-htree cases.  If

Here's is a quick hack to practice the directory readahead idea.
Comments are welcome, it's a freshman's work :)

Regards,
Wu
---
 fs/ext3/dir.c   |   22 ++++++++++++++++++++++
 fs/ext3/inode.c |    2 +-
 2 files changed, 23 insertions(+), 1 deletion(-)

--- linux.orig/fs/ext3/dir.c
+++ linux/fs/ext3/dir.c
@@ -94,6 +94,25 @@ int ext3_check_dir_entry (const char * f
 	return error_msg == NULL ? 1 : 0;
 }
 
+int ext3_get_block(struct inode *inode, sector_t iblock,
+			struct buffer_head *bh_result, int create);
+
+static void ext3_dir_readahead(struct file * filp)
+{
+	struct inode *inode = filp->f_path.dentry->d_inode;
+	struct address_space *mapping = inode->i_sb->s_bdev->bd_inode->i_mapping;
+	unsigned long sector;
+	unsigned long blk;
+	pgoff_t offset;
+
+	for (blk = 0; blk < inode->i_blocks; blk++) {
+		sector = blk << (inode->i_blkbits - 9);
+		sector = generic_block_bmap(inode->i_mapping, sector, ext3_get_block);
+		offset = sector >> (PAGE_CACHE_SHIFT - 9);
+		do_page_cache_readahead(mapping, filp, offset, 1);
+	}
+}
+
 static int ext3_readdir(struct file * filp,
 			 void * dirent, filldir_t filldir)
 {
@@ -108,6 +127,9 @@ static int ext3_readdir(struct file * fi
 
 	sb = inode->i_sb;
 
+	if (!filp->f_pos)
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
