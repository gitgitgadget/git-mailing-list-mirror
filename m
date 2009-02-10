From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: fact-import: failed to apply delta
Date: Tue, 10 Feb 2009 13:36:12 -0800
Message-ID: <20090210213612.GW30949@spearce.org>
References: <20090210155626.GM30949@spearce.org> <alpine.LNX.1.00.0902101118110.19665@iabervon.org> <20090210172212.GR30949@spearce.org> <alpine.LNX.1.00.0902101226580.19665@iabervon.org> <20090210191220.GT30949@spearce.org> <alpine.LNX.1.00.0902101427300.19665@iabervon.org> <20090210201203.GU30949@spearce.org> <alpine.LNX.1.00.0902101520240.19665@iabervon.org> <20090210212539.GV30949@spearce.org> <alpine.LNX.1.00.0902101628140.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 22:37:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX0IX-0007No-OE
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 22:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434AbZBJVgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 16:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755342AbZBJVgO
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 16:36:14 -0500
Received: from george.spearce.org ([209.20.77.23]:34877 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755271AbZBJVgN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 16:36:13 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id C500138210; Tue, 10 Feb 2009 21:36:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0902101628140.19665@iabervon.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109318>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Tue, 10 Feb 2009, Shawn O. Pearce wrote:
> > 
> > We should dump the cached_objects table in sha1_file.c during
> > a checkpoint in fast-import.
> 
> No, that one's keyed by sha1, and doesn't get collisions; it's the 
> delta_base_cache that's the issue; it's keyed by struct packed_git * and 
> offset.

Uh, yea, I realize that after I sent the message.  Does this patch
fix it for you?

--8<--
Clear the delta base cache during fast-import checkpoint

Otherwise we may reuse the same memory address for a totally
different "struct packed_git", and a previously cached object from
the prior occupant might be returned when trying to unpack an object
from the new pack.

Found-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 cache.h       |    1 +
 fast-import.c |    1 +
 sha1_file.c   |    7 +++++++
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 8dcc53c..7f1a6e8 100644
--- a/cache.h
+++ b/cache.h
@@ -830,6 +830,7 @@ extern unsigned char* use_pack(struct packed_git *, struct pack_window **, off_t
 extern void close_pack_windows(struct packed_git *);
 extern void unuse_pack(struct pack_window **);
 extern void free_pack_by_name(const char *);
+extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *, int, int);
 extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t);
 extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t);
diff --git a/fast-import.c b/fast-import.c
index 1935206..03b13e0 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -945,6 +945,7 @@ static void end_packfile(void)
 {
 	struct packed_git *old_p = pack_data, *new_p;
 
+	clear_delta_base_cache();
 	if (object_count) {
 		char *idx_name;
 		int i;
diff --git a/sha1_file.c b/sha1_file.c
index 8868b80..d2dbc96 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1663,6 +1663,13 @@ static inline void release_delta_base_cache(struct delta_base_cache_entry *ent)
 	}
 }
 
+void clear_delta_base_cache(void)
+{
+	unsigned long p;
+	for (p = 0; p < MAX_DELTA_CACHE; p++)
+		release_delta_base_cache(&delta_base_cache[p])
+}
+
 static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	void *base, unsigned long base_size, enum object_type type)
 {
-- 
1.6.2.rc0.186.g417c
