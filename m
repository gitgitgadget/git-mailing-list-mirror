From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] refs: ref entry with NULL sha1 is can be a dangling symref
Date: Tue, 16 Mar 2010 00:40:17 -0700
Message-ID: <7vsk80k93y.fsf_-_@alter.siamese.dyndns.org>
References: <OGVB8d37MB-s4H3VOECmd2htUvpq3B4NginojN-XskLyvHmnbfGA4Q@cipher.nrlssc.navy.mil> <7vwrxdueug.fsf@alter.siamese.dyndns.org> <7v7hpcvobt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Mar 16 08:40:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrROG-0008Cc-Ay
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 08:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757101Ab0CPHk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 03:40:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63330 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851Ab0CPHkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 03:40:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 87AB9A2122;
	Tue, 16 Mar 2010 03:40:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bgfL5um2zzGli2B8fZvWFV8lrpw=; b=kfVjJT
	lKMzP9NNc5Di8Tyfx6NGlNUvo69nKlG/tb0o3fGfc8Q/MPhkDvR2fM3N631wRusQ
	3iGYZKur+mSYR8WYohmYTShY+1X+xfHZdaGL+qhvAfJszfiD9iD2GHCIHwKSxCVe
	Jszyh+qUPFYBkWCH2XDAhw74S25I8f8E1ZVyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ay6rzSx11dI50L0eO2P/z0VJt+mmYuf2
	1hKSPoNtWzDpmsGb1zhAdqpCdj542hyjRRnkwHXaoTpFzbWMi1MtX2JO2gi66Vm1
	9B5Kaj9QGumx0XqklmmLC9mNTEg6/8xfCdx6qBPxLJShbR69XQUYvChs3sZlgD0e
	M+sg73llcRM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6059CA2121;
	Tue, 16 Mar 2010 03:40:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D25FA2120; Tue, 16 Mar
 2010 03:40:18 -0400 (EDT)
In-Reply-To: <7v7hpcvobt.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 15 Mar 2010 22\:16\:06 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2CDFE74E-30CF-11DF-8927-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142334>

Brandon Casey noticed that t5505 had accidentally broken its && chain,
hiding inconsistency between the code that writes the warning to the
standard output and the test that expects to see the warning on the
standard error, which was introduced by f8948e2 (remote prune: warn
dangling symrefs, 2009-02-08).

It turns out that the issue is deeper than that.  After f8948e2, a symref
that is dangling is marked with a NULL sha1, and the idea of using NULL
sha1 to mean a deleted ref was scrapped, but somehow a follow-up eafb452
(do_one_ref(): null_sha1 check is not about broken ref, 2009-07-22)
incorrectly reorganized do_one_ref(), still thinking NULL sha1 is never
used in the code.

Fix this by:

 - adopt Brandon's fix to t5505 test;

 - introduce REF_BROKEN flag to mark a ref that fails to resolve (dangling
   symref);

 - move the check for broken ref back inside the "if we are skipping
   dangling refs" code block.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I deliberately left hashclr() because other codepaths are likely to be
   using it as a signal that the ref is invalid.  They can be lazily
   converted to pay attention to REF_BROKEN bit instead of doing 20-byte
   comparison to null SHA-1.

 refs.c            |   11 +++++++----
 t/t5505-remote.sh |    6 +++---
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 63e30d7..a7518b6 100644
--- a/refs.c
+++ b/refs.c
@@ -6,6 +6,7 @@
 
 /* ISSYMREF=01 and ISPACKED=02 are public interfaces */
 #define REF_KNOWS_PEELED 04
+#define REF_BROKEN 010
 
 struct ref_list {
 	struct ref_list *next;
@@ -275,8 +276,10 @@ static struct ref_list *get_ref_dir(const char *base, struct ref_list *list)
 				list = get_ref_dir(ref, list);
 				continue;
 			}
-			if (!resolve_ref(ref, sha1, 1, &flag))
+			if (!resolve_ref(ref, sha1, 1, &flag)) {
 				hashclr(sha1);
+				flag |= REF_BROKEN;
+			}
 			list = add_ref(ref, sha1, flag, list, NULL);
 		}
 		free(ref);
@@ -539,10 +542,10 @@ static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 {
 	if (strncmp(base, entry->name, trim))
 		return 0;
-	/* Is this a "negative ref" that represents a deleted ref? */
-	if (is_null_sha1(entry->sha1))
-		return 0;
+
 	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN)) {
+		if (entry->flag & REF_BROKEN)
+			return 0; /* ignore dangling symref */
 		if (!has_sha1_file(entry->sha1)) {
 			error("%s does not point to a valid object!", entry->name);
 			return 0;
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index a82c5ff..2692050 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -507,15 +507,15 @@ test_expect_success 'remote prune to cause a dangling symref' '
 	(
 		cd seven &&
 		git remote prune origin
-	) 2>err &&
+	) >err 2>&1 &&
 	grep "has become dangling" err &&
 
-	: And the dangling symref will not cause other annoying errors
+	: And the dangling symref will not cause other annoying errors &&
 	(
 		cd seven &&
 		git branch -a
 	) 2>err &&
-	! grep "points nowhere" err
+	! grep "points nowhere" err &&
 	(
 		cd seven &&
 		test_must_fail git branch nomore origin
