From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sat, 17 Mar 2007 14:45:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151955150.4998@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160913361.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703160920030.13402@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703160934070.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161216510.13732@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
 <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 22:46:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSgj7-0007fn-5Y
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 22:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbXCQVqK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 17:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbXCQVqK
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 17:46:10 -0400
Received: from smtp.osdl.org ([65.172.181.24]:46681 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626AbXCQVqI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 17:46:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2HLjocD012044
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 17 Mar 2007 14:45:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2HLjnSD010452;
	Sat, 17 Mar 2007 13:45:49 -0800
In-Reply-To: <Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.978 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42453>



On Sat, 17 Mar 2007, Linus Torvalds wrote:
> 
> Instead of always re-generating the delta bases (possibly over and over 
> and over again), just cache the last few ones. They often can get re-used.

Not just to compare actual timings, this shows the difference in the 
traces I did. Remember, before we had:

	[torvalds@woody linux]$ grep Needs delta-base-trace | wc -l
	469334
	[torvalds@woody linux]$ grep Needs delta-base-trace |sort -u | wc -l
	21933

and now with the simple cache, I get:

	[torvalds@woody linux]$ grep Needs delta-base-trace-new | wc -l
	28688
	[torvalds@woody linux]$ grep Needs delta-base-trace-new | sort -u | wc -l
	21933

ie, we still re-generate some of the objects multiple times, but now, 
rather than generating them (on average) 20+ times each, we now generate 
them an average of just 1.3 times each. Which explains why the wall-time 
goes down by over a factor of two.

Changing the (statically sized) cache from 256 entries to 1024 (and 
updating the hash function appropriately of course) gets the number down 
to 23953 delta-base lookups (the number of unique ones obviously stays the 
same), for an average of just 1.1 object generates per unique object, and 
also means that you occasionally get sub-second times for my test-case of 
logging drivers/usb/.

It all also means that libz isn't really even the top entry in the 
profiles any more, although it's still pretty high. But the profile now 
says:

	samples  %        app name                 symbol name
	41527    15.6550  git                      strlen
	30215    11.3905  git                      inflate
	27504    10.3685  git                      inflate_table
	20321     7.6607  git                      find_pack_entry_one
	16892     6.3680  git                      interesting
	16259     6.1294  vmlinux                  __copy_user_nocache
	16010     6.0355  git                      inflate_fast
	9240      3.4833  git                      get_mode
	8863      3.3412  git                      tree_entry_extract
	7145      2.6935  git                      strncmp
	7131      2.6883  git                      memcpy
	6863      2.5872  git                      diff_tree
	6113      2.3045  git                      adler32
	4515      1.7021  git                      _int_malloc
	3022      1.1392  git                      update_tree_entry
	...

(Adding up all of libz is still ~31%, but it's lower as a percentage *and* 
it's obviously a smaller percentage of a much lower absolute time, so the 
zlib overhead went down much more than any other git overheads did)

In general, this all seems very cool. The patches are simple enough that I 
think this is very safe to merge indeed: the only question I have is that 
somebody should verify that the "struct packed_git *p" is stable over the 
whole lifetime of a process - so that we can use it as a hash key without 
having to invalidate hashes if we unmap a pack (I *think* we just unmap 
the virtual mapping, and "struct packed_git *" stays valid, but Junio 
should ack that for me).

Here's the trivial patch to extend the caching to 1k entries if somebody 
cares. I don't know if the small added performance is worth it.

		Linus
---
diff --git a/sha1_file.c b/sha1_file.c
index a7e3a2a..372af60 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1352,7 +1352,7 @@ static void *unpack_compressed_entry(struct packed_git *p,
 	return buffer;
 }
 
-#define MAX_DELTA_CACHE (256)
+#define MAX_DELTA_CACHE (1024)
 
 static struct delta_base_cache_entry {
 	struct packed_git *p;
@@ -1367,8 +1367,8 @@ static unsigned long pack_entry_hash(struct packed_git *p, off_t base_offset)
 	unsigned long hash;
 
 	hash = (unsigned long)p + (unsigned long)base_offset;
-	hash += (hash >> 8) + (hash >> 16);
-	return hash & 0xff;
+	hash += (hash >> 10) + (hash >> 20);
+	return hash & (MAX_DELTA_CACHE-1);
 }
 
 static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
