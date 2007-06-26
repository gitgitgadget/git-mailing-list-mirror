From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: error: wrong index file size in
 /usr/local/src/jffs2_mtd_patches/.git/objects/pack/pack-da39a3ee5e6b4b0d32
 55bfef95601890afd80709.idx
Date: Tue, 26 Jun 2007 13:45:07 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706261341190.8675@woody.linux-foundation.org>
References: <001401c7b82d$106f30b0$0e67a8c0@Jocke>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Tjernlund <tjernlund@tjernlund.se>
X-From: git-owner@vger.kernel.org Tue Jun 26 22:45:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Huh-0003ZN-60
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 22:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757738AbXFZUp0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 16:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757647AbXFZUpZ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 16:45:25 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38807 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756665AbXFZUpZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2007 16:45:25 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5QKjD7b026718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Jun 2007 13:45:14 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5QKj7PB001766;
	Tue, 26 Jun 2007 13:45:08 -0700
In-Reply-To: <001401c7b82d$106f30b0$0e67a8c0@Jocke>
X-Spam-Status: No, hits=-2.615 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50973>



On Tue, 26 Jun 2007, Tjernlund wrote:
>
> Did this and got a small error that I don't think should be there:

Heh. I think I see what's wrong..

> Indexing 0 objects...
> remote: Total 0 (delta 0), reused 0 (delta 0)

Ok, there were no objects that weren't in the reference repo. So far so 
good.

But:

> error: wrong index file size in /usr/local/src/jffs2_mtd_patches/.git/objects/pack/pack-da39a3ee5e6b4b0d3255bfef95601890afd80709.idx

I think this is because of that zero size:

                /*
                 * Minimum size:
                 *  - 8 bytes of header
                 *  - 256 index entries 4 bytes each
                 *  - 20-byte sha1 entry * nr
                 *  - 4-byte crc entry * nr
                 *  - 4-byte offset entry * nr
                 *  - 20-byte SHA1 of the packfile
                 *  - 20-byte SHA1 file checksum
                 * And after the 4-byte offset table might be a
                 * variable sized table containing 8-byte entries
                 * for offsets larger than 2^31.
                 */
                unsigned long min_size = 8 + 4*256 + nr*(20 + 4 + 4) + 20 + 20;
                if (idx_size < min_size || idx_size > min_size + (nr - 1)*8) {

Notice the "(nr - 1)*8" thing. And notice how "nr-1" underflows when nr is 
zero..

I bet it goes away if you remove the "-1", or if you do something like 
this (totally untested!) patch.

		Linus

---
diff --git a/sha1_file.c b/sha1_file.c
index 7628ee9..f2b1ae0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -510,7 +510,10 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
 		 * for offsets larger than 2^31.
 		 */
 		unsigned long min_size = 8 + 4*256 + nr*(20 + 4 + 4) + 20 + 20;
-		if (idx_size < min_size || idx_size > min_size + (nr - 1)*8) {
+		unsigned long max_size = min_size;
+		if (nr)
+			max_size += (nr - 1)*8;
+		if (idx_size < min_size || idx_size > max_size) {
 			munmap(idx_map, idx_size);
 			return error("wrong index file size in %s", path);
 		}
