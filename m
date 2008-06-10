From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Recovering from repository corruption
Date: Tue, 10 Jun 2008 15:45:05 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806101518590.3101@woody.linux-foundation.org>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>  <m3abhtp42o.fsf@localhost.localdomain>  <6dbd4d000806101238v2bb975abqd39916e45d4bf866@mail.gmail.com>  <200806102159.02875.jnareb@gmail.com>  <6dbd4d000806101303j4b2032ajc6e004e0a82e4db5@mail.gmail.com>
  <alpine.LFD.1.10.0806101317100.3101@woody.linux-foundation.org>  <6dbd4d000806101328k1fc913f2ia55c3e44273ec5ad@mail.gmail.com>  <alpine.LFD.1.10.0806101403080.3101@woody.linux-foundation.org>  <6dbd4d000806101422j39709906x1b4b03b82b504e62@mail.gmail.com>
  <alpine.LFD.1.10.0806101431410.3101@woody.linux-foundation.org> <6dbd4d000806101509l516cf467me06fadee6ead0964@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Denis Bueno <dbueno@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 00:46:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6CbP-0006SB-0v
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 00:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324AbYFJWpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 18:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752102AbYFJWpM
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 18:45:12 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39288 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754585AbYFJWpJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 18:45:09 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5AMj6pN019369
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Jun 2008 15:45:07 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5AMj51u000991;
	Tue, 10 Jun 2008 15:45:06 -0700
In-Reply-To: <6dbd4d000806101509l516cf467me06fadee6ead0964@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.381 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84557>



On Tue, 10 Jun 2008, Denis Bueno wrote:
> 
> > Do you have some odd filesystem in play? Was the current corruption in a
> > similar environment as the old one? IOW, I'm trying to find a pattern
> > here, to see if there might be something we can do about it..
> 
> I can't remember if the old one happened after a panic or not, but I'd
> bet it did.  The filesystem is HFS+, as indeed most OS X 10.4
> installations are.  Maybe the HD has been going south?  However, that
> doesn't seem likely, since when I got the computer it was new, and
> that was around Jun 2007.

Yeah, it's almost certainly not the disk. Disks do go bad, but the 
behavior tends to be rather different when they do (usually you will get 
read errors with uncorrectably CRC failures, and you'd know that _very_ 
clearly).

Sure, I could imagine something like the sector remapping could be flaking 
out on you, but that sounds really unlikely. Especially since:

> > But it *sounds* like the objects you lost were literally old ones, no? Ie
> > the lost stuff wasn't something you had committed in the last five minutes
> > or so? If so, then you really do seem to have a filesystem that corrupts
> > *old* files when it crashes. That's fairly scary. What FS is it?
> 
> No, in fact I had just committed those changes not 10 minutes before
> the panic.  Last time they were also fresh changes, although perhaps
> older than 10 minutes.  I can't remember.

Oh, ok. If so, then this is much less worrisome, and is in fact almost 
"normal" HFS+ behaviour. It is a journaling filesystem, but it only 
journals metadata, so the filenames and inodes will be fine after a crash, 
but the contents will be random.

[ Yeah, yeah, I know - it sounds rather stupid, but it's a common kind of 
  stupidity. The journaling essentially protects the only thing that fsck 
  can find. Ext3 does similar things in "writeback" mode - but you should 
  use "data=ordered" which writes out the data before metadata.

  Basically, such journaling doesn't help data integrity per se, but it 
  does mean that the metadata is ok, and that in turn means that while the 
  file contents won't be dependable, at least things like free block 
  bitmaps etc hopefully are.

  That in turn hopefully means that new file allocations won't be 
  crapping out all over old ones etc due to bad resource allocations, so 
  while it doesn't mean that the data is trust-worthy, it at least means 
  that you can trust _some_ things ]

If your machine crashes often, you could trivially add a "sync" to your 
commit hook. That would make things better. And maybe we should have a 
"safe mode" that does these things more carefully. You would definitely 
want to turn it on on that machine.

Are you doing something special to make the machine crash so much? Or do 
OS X machines always crash, and Apple PR is just so good that people 
aren't aware of it?

Anyway, I'll think about sane ways to add a "safe" mode without making it 
_too_ painful. In the meantime, here's a trial patch that you should 
probably use. It does slow things down, but hopefully not too much.

(I really don't much like it - but I think this is a good change, and I 
just need to come up with a better way to do the fsync() than to be 
totally synchronous about it.)

It's going to make big "git add" calls *much* slower, so I'm not very 
happy about it (especially since we don't actually care that deeply about 
the files really being there until much later, so doing something 
asynchronous would be perfectly acceptable), but for you this is 
definitely worth-while.

			Linus

---
 sha1_file.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index adcf37c..86a653b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2105,6 +2105,15 @@ int hash_sha1_file(const void *buf, unsigned long len, const char *type,
 	return 0;
 }
 
+/* Finalize a file on disk, and close it. */
+static void close_sha1_file(int fd)
+{
+	fsync_or_die(fd, "sha1 file");
+	fchmod(fd, 0444);
+	if (close(fd) != 0)
+		die("unable to write sha1 file");
+}
+
 static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 			      void *buf, unsigned long len, time_t mtime)
 {
@@ -2170,9 +2179,7 @@ static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
 
 	if (write_buffer(fd, compressed, size) < 0)
 		die("unable to write sha1 file");
-	fchmod(fd, 0444);
-	if (close(fd))
-		die("unable to write sha1 file");
+	close_sha1_file(fd);
 	free(compressed);
 
 	if (mtime) {
@@ -2350,9 +2357,7 @@ int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
 	} while (1);
 	inflateEnd(&stream);
 
-	fchmod(local, 0444);
-	if (close(local) != 0)
-		die("unable to write sha1 file");
+	close_sha1_file(local);
 	SHA1_Final(real_sha1, &c);
 	if (ret != Z_STREAM_END) {
 		unlink(tmpfile);
