From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] git add --intent-to-add: fix removal of cached emptiness
Date: Fri, 28 Nov 2008 19:55:25 -0800
Message-ID: <7vprkf2nki.fsf_-_@gitster.siamese.dyndns.org>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0811272347010.30769@pacific.mpi-cbg.de>
 <7vtz9s8uzu.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0811281225040.30769@pacific.mpi-cbg.de>
 <20081128192033.GF23984@spearce.org>
 <7voczz4cfb.fsf@gitster.siamese.dyndns.org>
 <7vk5an4cba.fsf_-_@gitster.siamese.dyndns.org>
 <7vvdu72nq9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 29 04:58:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6Gy7-0007Nw-8c
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 04:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbYK2Dzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 22:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbYK2Dzu
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 22:55:50 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47798 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbYK2Dzt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 22:55:49 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BFFA5827BC;
	Fri, 28 Nov 2008 22:55:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E2197827B8; Fri,
 28 Nov 2008 22:55:26 -0500 (EST)
In-Reply-To: <7vvdu72nq9.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 28 Nov 2008 19:51:58 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9B9BECC0-BDC9-11DD-8C01-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101898>

This uses the extended index flag mechanism introduced earlier to mark
the entries added to the index via "git add -N" with CE_INTENT_TO_ADD.

The logic to detect an "intent to add" entry for the purpose of allowing
"git rm --cached $path" is tightened to check not just for a staged empty
blob, but with the CE_INTENT_TO_ADD bit.  This protects an empty blob that
was explicitly added and then modified in the work tree from being dropped
with this sequence:

	$ >empty
	$ git add empty
	$ echo "non empty" >empty
	$ git rm --cached empty

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-rm.c  |    2 +-
 cache.h       |    3 ++-
 read-cache.c  |    2 ++
 t/t3600-rm.sh |    4 ++--
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin-rm.c b/builtin-rm.c
index 3d03da0..c11f455 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -115,7 +115,7 @@ static int check_local_mod(unsigned char *head, int index_only)
 		 * "intent to add" entry.
 		 */
 		if (local_changes && staged_changes) {
-			if (!index_only || !is_empty_blob_sha1(ce->sha1))
+			if (!index_only || !(ce->ce_flags & CE_INTENT_TO_ADD))
 				errs = error("'%s' has staged content different "
 					     "from both the file and the HEAD\n"
 					     "(use -f to force removal)", name);
diff --git a/cache.h b/cache.h
index ef2e7f9..f15b3fc 100644
--- a/cache.h
+++ b/cache.h
@@ -176,10 +176,11 @@ struct cache_entry {
 /*
  * Extended on-disk flags
  */
+#define CE_INTENT_TO_ADD 0x20000000
 /* CE_EXTENDED2 is for future extension */
 #define CE_EXTENDED2 0x80000000
 
-#define CE_EXTENDED_FLAGS (0)
+#define CE_EXTENDED_FLAGS (CE_INTENT_TO_ADD)
 
 /*
  * Safeguard to avoid saving wrong flags:
diff --git a/read-cache.c b/read-cache.c
index abc627b..fa30a0f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -546,6 +546,8 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	ce->ce_flags = namelen;
 	if (!intent_only)
 		fill_stat_cache_info(ce, st);
+	else
+		ce->ce_flags |= CE_INTENT_TO_ADD;
 
 	if (trust_executable_bit && has_symlinks)
 		ce->ce_mode = create_ce_mode(st_mode);
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 5b4d6f7..b7d46e5 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -187,8 +187,8 @@ test_expect_success 'but with -f it should work.' '
 	test_must_fail git ls-files --error-unmatch baz
 '
 
-test_expect_failure 'refuse to remove cached empty file with modifications' '
-	touch empty &&
+test_expect_success 'refuse to remove cached empty file with modifications' '
+	>empty &&
 	git add empty &&
 	echo content >empty &&
 	test_must_fail git rm --cached empty
-- 
1.6.0.4.850.g6bd829
