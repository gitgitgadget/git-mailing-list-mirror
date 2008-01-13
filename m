From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] index: be careful when handling long names
Date: Sun, 13 Jan 2008 14:36:34 -0800
Message-ID: <7vhchhpd3h.fsf_-_@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org>
	<7vtzliqh3u.fsf@gitster.siamese.dyndns.org>
	<7vd4s6qal0.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801130922030.2806@woody.linux-foundation.org>
	<7vsl11plbe.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 13 23:37:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEBS8-00026d-Uu
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 23:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393AbYAMWgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 17:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754400AbYAMWgs
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 17:36:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366AbYAMWgr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 17:36:47 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E79B42B5;
	Sun, 13 Jan 2008 17:36:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A79C642B3;
	Sun, 13 Jan 2008 17:36:41 -0500 (EST)
In-Reply-To: <7vsl11plbe.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 13 Jan 2008 11:39:01 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70418>

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

 Junio C Hamano <gitster@pobox.com> writes:

 > About the CE_NAMEMASK limitation (and currently we do not check
 > it, so I think we would be screwed when a pathname that is
 > longer than (CE_NAMEMASK+1) and still fits under PATH_MAX is
 > given), I think we do not have to limit the maximum pathname
 > length.  Instead we can teach create_ce_flags() and ce_namelen()
 > that a name longer than 2k (or 4k) has the NAMEMASK bits that
 > are all 1 and ce->name[] must be counted if so (with an obvious
 > optimization to start counting at byte position 2k or 4k in
 > ce_namelen()).

 This should fix it.  Passes tests including the new test that
 the existing code fails.

 cache.h          |   17 +++++++++++++++--
 t/t0000-basic.sh |   18 ++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 39331c2..ad53acc 100644
--- a/cache.h
+++ b/cache.h
@@ -114,8 +114,21 @@ struct cache_entry {
 #define CE_VALID     (0x8000)
 #define CE_STAGESHIFT 12
 
-#define create_ce_flags(len, stage) htons((len) | ((stage) << CE_STAGESHIFT))
-#define ce_namelen(ce) (CE_NAMEMASK & ntohs((ce)->ce_flags))
+static inline unsigned create_ce_flags(size_t len, unsigned stage)
+{
+	if (len >= CE_NAMEMASK)
+		len = CE_NAMEMASK;
+	return htons(len | (stage << CE_STAGESHIFT));
+}
+
+static inline size_t ce_namelen(const struct cache_entry *ce)
+{
+	size_t len = ntohs((ce)->ce_flags) & CE_NAMEMASK;
+	if (len < CE_NAMEMASK) /* likely */
+		return len;
+	return strlen(ce->name + CE_NAMEMASK) + CE_NAMEMASK;
+}
+
 #define ce_size(ce) cache_entry_size(ce_namelen(ce))
 #define ce_stage(ce) ((CE_STAGEMASK & ntohs((ce)->ce_flags)) >> CE_STAGESHIFT)
 
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 4e49d59..40551a3 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -297,4 +297,22 @@ test_expect_success 'absolute path works as expected' '
 	test "$sym" = "$(test-absolute-path $dir2/syml)"
 '
 
+test_expect_success 'very long name in the index handled sanely' '
+
+	a=a && # 1
+	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 16
+	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 256
+	a=$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a$a && # 4096
+	a=${a}q
+
+	>path4 &&
+	git update-index --add path4 &&
+	(
+		git ls-files -s path4 |
+		sed -e "s/	.*/	/" |
+		tr -d "\012"
+		echo "$a"
+	) | git update-index --index-info
+'
+
 test_done
