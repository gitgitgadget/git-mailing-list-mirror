From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] sanity check in add_packed_git()
Date: Thu, 22 Dec 2005 01:39:24 -0800
Message-ID: <7v4q51qxmb.fsf@assigned-by-dhcp.cox.net>
References: <1135208829.15567.18.camel@dv>
	<7v7j9xvrf3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512212046340.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 10:39:34 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpMv4-0005Oa-FP
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 10:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbVLVJj0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 04:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbVLVJj0
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 04:39:26 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:27389 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S965147AbVLVJjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 04:39:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051222093928.XTFN25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Dec 2005 04:39:28 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13935>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I'd like to require it to be a hash, just because that makes it 
> prohibitively difficult to make something people will accept as
> pack-05f611b3b8198b262acdf678584d365f8e879aec.pack other than the one from 
> the git repository.

How about doing something like this, then?

I haven't tried this with http-fetch but with this I think we
can unconditionally assign p->sha1 in add_packed_git().

-- >8 --
Subject: [PATCH] Require packfiles to follow the naming convention.

With this, pack files must be named "pack-[0-9a-f]{40}.pack",
with corresponding .idx file, and the hexadecimal part must
match the SHA1 checksum git-pack-objects computed when the pack
was created originally (i.e. sum over sorted object names of all
the contained objects).  The core would ignore a valid packfile
in $GIT_OBJECT_DIRECTORY/packs that "git-unpack-objects" would
expand properly if it does not follow the naming convention.

[jc: this breaks existing test t5300.]

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 sha1_file.c |   38 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 37 insertions(+), 1 deletions(-)

4ff64a29401b28cfbd925cf86eed8b8e734ed24b
diff --git a/sha1_file.c b/sha1_file.c
index 6011473..01ac925 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -319,18 +319,33 @@ struct packed_git *packed_git;
 static int check_packed_git_idx(const char *path, unsigned long *idx_size_,
 				void **idx_map_)
 {
+	SHA_CTX ctx;
+	unsigned char sha1[20];
+	unsigned char packname[20];
 	void *idx_map;
 	unsigned int *index;
 	unsigned long idx_size;
 	int nr, i;
-	int fd = open(path, O_RDONLY);
+	int fd;
 	struct stat st;
+
+	fd = open(path, O_RDONLY);
 	if (fd < 0)
 		return -1;
 	if (fstat(fd, &st)) {
 		close(fd);
 		return -1;
 	}
+
+	/* We require "...../pack-XXXX{40}XXXX.idx" now.
+	 * 5-byte "pack-", 40-byte hex and 4-byte .idx.
+	 */
+	i = strlen(path);
+	if (i < 49 || strcmp(path + i - 4, ".idx") ||
+	    strncmp(path + i - 49, "pack-", 5) ||
+	    get_sha1_hex(path + i - 44, packname))
+		return error("non index file %s ignored", path);
+
 	idx_size = st.st_size;
 	idx_map = mmap(NULL, idx_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
@@ -362,6 +377,27 @@ static int check_packed_git_idx(const ch
 	if (idx_size != 4*256 + nr * 24 + 20 + 20)
 		return error("wrong index file size");
 
+	/*
+	 * File checksum and index name.
+	 */
+	SHA1_Init(&ctx);
+	SHA1_Update(&ctx, idx_map, idx_size-20);
+	SHA1_Final(sha1, &ctx);
+
+	if (memcmp(sha1, idx_map + idx_size - 20, 20))
+		return error("index checksum mismatch");
+
+	SHA1_Init(&ctx);
+	for (i = 0; i < nr; i++) {
+		unsigned char *ent = (idx_map + 4*256) + i * 24 + 4;
+		SHA1_Update(&ctx, ent, 20);
+	}
+	SHA1_Final(sha1, &ctx);
+	
+	if (memcmp(sha1, packname, 20))
+		return error("pack index name %s does not match contents %s",
+			     path, sha1_to_hex(sha1));
+
 	return 0;
 }
 
-- 
1.0.GIT
