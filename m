From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "failed to read delta base object at..."
Date: Wed, 27 Aug 2008 12:48:00 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808271222250.3363@nehalem.linux-foundation.org>
References: <20080825164602.GA2213@fieldses.org> <alpine.LFD.1.10.0808251153210.3363@nehalem.linux-foundation.org> <20080825213104.GI2213@fieldses.org> <alpine.LFD.1.10.0808251435540.3363@nehalem.linux-foundation.org> <20080825221321.GL2213@fieldses.org>
 <alpine.LFD.1.10.0808251616240.3363@nehalem.linux-foundation.org> <48B46B04.70102@gmail.com> <48B46F46.9090302@gmail.com> <alpine.LFD.1.10.0808270937340.3363@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808271458320.1624@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jason McMullan <jason.mcmullan@gmail.com>, git@vger.kernel.org,
	bfields@fieldses.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 21:50:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYR1n-0003Zt-Qh
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 21:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbYH0Tsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 15:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbYH0Tsw
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 15:48:52 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58524 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750765AbYH0Tsv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Aug 2008 15:48:51 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7RJm2f0009301
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Aug 2008 12:48:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7RJm0HF019049;
	Wed, 27 Aug 2008 12:48:01 -0700
In-Reply-To: <alpine.LFD.1.10.0808271458320.1624@xanadu.home>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.429 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93932>



On Wed, 27 Aug 2008, Nicolas Pitre wrote:
> 
> And isn't the bad data block size and alignment a bit odd for a 
> filesystem crash corruption?

Yes. If it was a filesystem issue, I'd expect it to be at least disk block 
aligned (512 bytes, most of the time) and more likely filesystem block 
aligned (ie mostly 4kB).

However, if we were to re-write the file afterwards, it could still get 
non-block-aligned corruption - simply because there was a 
non-block-aligned rewrite that got lost. But we don't actually ever do 
that, except for the header and the SHA1 at the end in some unusual cases.

> However, in the pack-objects case, it is almost impossible to have such 
> a corruption since the data is SHA1 summed immediately before being 
> written out.

Yes. Anything that uses the "sha1write()" model (which includes the 
regular pack-file _and_ the index) should generally be pretty safe. 

However, we do have this odd case of fixing up the pack after-the-fact 
when we receive it from somebody else (because we get a thin pack and 
don't know how many objects the final result will have). And that case 
seems to be not as safe, because it

 - re-reads the file to recompute the SHA1

   This is understandable, and it's fairly ok, but it does mean that there 
   is a bigger chance of the SHA1 matching if something has corrupted the 
   file in the meantime!

   (That was not the case of this corruption, obviously, since the SHA1 
   didn't match)

 - but it also forgets to fsync the result, because it only did that in 
   one path rather in all cases of fixup.

   Again, this wasn't actually the cause of this corruption, because the 
   corruption wasn't near the header or tail, so if it had been due to a 
   missed write due to missing an fsync, the pattern would have been 
   different.

Anyway, we should fix the latter problem regardless, even if it's (a) damn 
unlikely and (b) definietly not the case in this thing.

The fix is trivial - just move the "fsync_or_die()" into the fixup routine 
rather than doing it in one of the callers.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

		Linus

---
 builtin-pack-objects.c |    1 -
 pack-write.c           |    1 +
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 2dadec1..d394c49 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -499,7 +499,6 @@ static void write_pack_file(void)
 		} else {
 			int fd = sha1close(f, NULL, 0);
 			fixup_pack_header_footer(fd, sha1, pack_tmp_name, nr_written);
-			fsync_or_die(fd, pack_tmp_name);
 			close(fd);
 		}
 
diff --git a/pack-write.c b/pack-write.c
index a8f0269..ddcfd37 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -179,6 +179,7 @@ void fixup_pack_header_footer(int pack_fd,
 
 	SHA1_Final(pack_file_sha1, &c);
 	write_or_die(pack_fd, pack_file_sha1, 20);
+	fsync_or_die(pack_fd, pack_name);
 }
 
 char *index_pack_lockfile(int ip_out)
