From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: fact-import: failed to apply delta
Date: Wed, 11 Feb 2009 13:33:21 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0902111323000.19665@iabervon.org>
References: <20090210191220.GT30949@spearce.org> <alpine.LNX.1.00.0902101427300.19665@iabervon.org> <20090210201203.GU30949@spearce.org> <alpine.LNX.1.00.0902101520240.19665@iabervon.org> <20090210212539.GV30949@spearce.org> <alpine.LNX.1.00.0902101628140.19665@iabervon.org>
 <20090210213612.GW30949@spearce.org> <7vprhqkjrr.fsf@gitster.siamese.dyndns.org> <7vfxillxiu.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0902111247300.19665@iabervon.org> <20090211181530.GO30949@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:34:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXJvE-0002gQ-TT
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755926AbZBKSd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755636AbZBKSd0
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:33:26 -0500
Received: from iabervon.org ([66.92.72.58]:51754 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751833AbZBKSdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:33:25 -0500
Received: (qmail 29003 invoked by uid 1000); 11 Feb 2009 18:33:21 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Feb 2009 18:33:21 -0000
In-Reply-To: <20090211181530.GO30949@spearce.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109476>

On Wed, 11 Feb 2009, Shawn O. Pearce wrote:

> Daniel Barkalow <barkalow@iabervon.org> wrote:
> > 
> > I think free_pack_by_name() also needs to drop the entries that are from 
> > the freed pack, to avoid having repack able to get the same problem, 
> > although I wouldn't be surprised if repack happened to never allocate a 
> > new pack after freeing an old pack with stale delta cache entries, or 
> > never used the delta cache after that, simply because it does one thing 
> > and then exits.
> 
> Oy.  I missed that we added this function.  Patch follows.

I think it would be more clear to do something below (instead of the 
original patch); I think there's a better chance of authors knowing when 
to use this function than knowing when to use a function based on what it 
actually does, and there's a better chance that any future optimizations 
that need to be flushed under the same conditions would get included.

--8<--
Provide a function to free a struct packed_git that may have been used

When we look up entries in a pack, we sometimes cache the results. If a 
struct packed_git is freed afterwards (and its memory could be allocated 
as a different struct packed_git later), we need to clear out anything 
that may mis-recognize the pack.

In particular, we flush the delta cache.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

diff --git a/cache.h b/cache.h
index 8d965b8..ecc55cf 100644
--- a/cache.h
+++ b/cache.h
@@ -822,6 +822,7 @@ extern unsigned char* use_pack(struct packed_git *, struct pack_window **, off_t
 extern void close_pack_windows(struct packed_git *);
 extern void unuse_pack(struct pack_window **);
 extern void free_pack_by_name(const char *);
+extern void free_used_pack(struct packed_git *);
 extern struct packed_git *add_packed_git(const char *, int, int);
 extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t);
 extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t);
diff --git a/fast-import.c b/fast-import.c
index f0e08ac..8ec9a4e 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -987,7 +987,7 @@ static void end_packfile(void)
 		close(old_p->pack_fd);
 		unlink(old_p->pack_name);
 	}
-	free(old_p);
+	free_used_pack(old_p);
 
 	/* We can't carry a delta across packfiles. */
 	strbuf_release(&last_blob.data);
diff --git a/sha1_file.c b/sha1_file.c
index fd4980d..5a45f51 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -696,7 +696,7 @@ void free_pack_by_name(const char *pack_name)
 				munmap((void *)p->index_data, p->index_size);
 			free(p->bad_object_sha1);
 			*pp = p->next;
-			free(p);
+			free_used_pack(p);
 			return;
 		}
 		pp = &p->next;
@@ -1663,6 +1663,14 @@ static inline void release_delta_base_cache(struct delta_base_cache_entry *ent)
 	}
 }
 
+void free_used_pack(struct packed_git *pack)
+{
+	unsigned long p;
+	for (p = 0; p < MAX_DELTA_CACHE; p++)
+		release_delta_base_cache(&delta_base_cache[p]);
+	free(pack);
+}
+
 static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	void *base, unsigned long base_size, enum object_type type)
 {
