From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] index: be careful when handling long names
Date: Fri, 18 Jan 2008 23:42:00 -0800
Message-ID: <7vk5m69s8n.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 19 08:42:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JG8Lj-0008SW-7Z
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 08:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbYASHmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 02:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbYASHmK
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 02:42:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46313 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbYASHmI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 02:42:08 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D7232521F;
	Sat, 19 Jan 2008 02:42:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C4BD8521D;
	Sat, 19 Jan 2008 02:42:02 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 18 Jan 2008 19:25:58 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71083>

We currently use lower 12-bit (masked with CE_NAMEMASK) in the
ce_flags field to store the length of the name in cache_entry,
without checking the length parameter given to
create_ce_flags().  This can make us store incorrect length.

Currently we are mostly protected by the fact that many
codepaths first copy the path in a variable of size PATH_MAX,
which typically is 4096 that happens to match the limit, but
that feels like a bug waiting to happen.  Besides, that would
not allow us to shorten the width of CE_NAMEMASK to use the bits
for new flags.

This redefines the meaning of the name length stored in the
cache_entry.  A name that does not fit is represented by storing
CE_NAMEMASK in the field, and the actual length needs to be
computed by actually counting the bytes in the name[] field.
This way, only the unusually long paths need to suffer.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is rebased on your "Updated in-memory index" patch.

   When we read on-disk index, I fear that we trust the name
   length a bit too much.  With or without this patch, you could
   craft a malicious index file that records a namelen that is
   longer than the real string name length for the last entry to
   cause us to go beyond the mmaped area.  Maybe we would want
   to make sure that (1) the name lengths are sane; (2) names
   have NUL at the place we expect them to be; and (3) names are
   sorted in the proper cache order, while we iterate over the
   ondisk structure and convert it to incore structure.

 cache.h          |   17 +++++++++++++++--
 read-cache.c     |   12 +++++++++++-
 t/t0000-basic.sh |   20 ++++++++++++++++++++
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 4a054c5..9eaffde 100644
--- a/cache.h
+++ b/cache.h
@@ -131,8 +131,21 @@ struct cache_entry {
 #define CE_UPDATE    (0x10000)
 #define CE_REMOVE    (0x20000)
 
-#define create_ce_flags(len, stage) ((len) | ((stage) << CE_STAGESHIFT))
-#define ce_namelen(ce) (CE_NAMEMASK & (ce)->ce_flags)
+static inline unsigned create_ce_flags(size_t len, unsigned stage)
+{
+	if (len >= CE_NAMEMASK)
+		len = CE_NAMEMASK;
+	return (len | (stage << CE_STAGESHIFT));
+}
+
+static inline size_t ce_namelen(const struct cache_entry *ce)
+{
+	size_t len = ce->ce_flags & CE_NAMEMASK;
+	if (len < CE_NAMEMASK)
+		return len;
+	return strlen(ce->name + CE_NAMEMASK) + CE_NAMEMASK;
+}
+
 #define ce_size(ce) cache_entry_size(ce_namelen(ce))
 #define ondisk_ce_size(ce) ondisk_cache_entry_size(ce_namelen(ce))
 #define ce_stage(ce) ((CE_STAGEMASK & (ce)->ce_flags) >> CE_STAGESHIFT)
diff --git a/read-cache.c b/read-cache.c
index f5f9c3d..f98f57c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -927,6 +927,8 @@ int read_index(struct index_state *istate)
 
 static void convert_from_disk(struct ondisk_cache_entry *ondisk, struct cache_entry *ce)
 {
+	size_t len;
+
 	ce->ce_ctime = ntohl(ondisk->ctime.sec);
 	ce->ce_mtime = ntohl(ondisk->mtime.sec);
 	ce->ce_dev   = ntohl(ondisk->dev);
@@ -938,7 +940,15 @@ static void convert_from_disk(struct ondisk_cache_entry *ondisk, struct cache_en
 	/* On-disk flags are just 16 bits */
 	ce->ce_flags = ntohs(ondisk->flags);
 	hashcpy(ce->sha1, ondisk->sha1);
-	memcpy(ce->name, ondisk->name, ce_namelen(ce)+1);
+
+	len = ce->ce_flags & CE_NAMEMASK;
+	if (len == CE_NAMEMASK)
+		len = strlen(ondisk->name);
+	/*
+	 * NEEDSWORK: If the original index is crafted, this copy could
+	 * go unchecked.
+	 */
+	memcpy(ce->name, ondisk->name, len + 1);
 }
 
 /* remember to discard_cache() before reading a different cache! */
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 4e49d59..9f84b8d 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -297,4 +297,24 @@ test_expect_success 'absolute path works as expected' '
 	test "$sym" = "$(test-absolute-path $dir2/syml)"
 '
 
+test_expect_success 'very long name in the index handled sanely' '
+
+	a=a && # 1
+	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 16
+	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 256
+	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 4096
+	a=${a}q &&
+
+	>path4 &&
+	git update-index --add path4 &&
+	(
+		git ls-files -s path4 |
+		sed -e "s/	.*/	/" |
+		tr -d "\012"
+		echo "$a"
+	) | git update-index --index-info &&
+	len=$(git ls-files "a*" | wc -c) &&
+	test $len = 4098
+'
+
 test_done
-- 
1.5.4.rc3.37.gfdcf3
