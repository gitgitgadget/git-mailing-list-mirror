From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] sha1_name.c: signal if @{-N} was a true branch nameor a detached head
Date: Wed, 08 May 2013 14:12:29 -0700
Message-ID: <7vk3n9dvlu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 08 23:12:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaBfK-0004fQ-Bg
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 23:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491Ab3EHVMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 17:12:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41646 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195Ab3EHVMc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 17:12:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79B6B1C23E;
	Wed,  8 May 2013 21:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=m
	AO+awkhe+9u2gYBLaCKe9eDKVs=; b=iGm3lTPXJQBeYi+eSkZMo7fZxleXgTGSP
	RINngS1oRpaeHiCpQREZEz8LGJV1tRY/wgfDkJfoLWUuH2fjJHoaywHFf1CG2+kH
	RTG16GV/BF7gr7gdfIcJjF8+diLkeOMnlk49gj+RotZnXc2e7Je66G2PzdUz7kCe
	iJLzpfoWCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=XEcNqyyhbG+o/8Tvb/crXKT3jNZL8Z9M93gL1d5KEUMsJdPfbpMkM8gT
	hccd/AbS3yRofE6pLfZHnQue4UglbfNaOLmjckdk2MPImBd8epY11XYRGbna7LwN
	LL4nUm9qCA4euxbkHXlwAxBlh4KdXZvys5udsMLM2Du+jvyNcEg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EF5F1C23D;
	Wed,  8 May 2013 21:12:31 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B09431C239;
	Wed,  8 May 2013 21:12:30 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE7A242A-B823-11E2-B63F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223686>

The original API read "checkout: moving from (.*) to ..." from the
reflog of the HEAD, and returned the substring between "from" and
"to", but there was no way, if the substring was a 40-hex string, to
tell if we were on a detached HEAD at that commit object, or on a
branch whose name happened to be the 40-hex string.

At this point, we cannot afford to change the format recorded in the
reflog, so introduce a heuristics to see if the 40-hex matches the
object name of the commit we are switching out of.  This will
unfortunately mishandle this case:

	HEX=$(git rev-parse master)
	git checkout -b $HEX master
	git checkout master

where we were indeed on a non-detached $HEX branch (i.e. HEAD was
pointing at refs/heads/$HEX, not storing $HEX), of course, but
otherwise should be fairly reliable.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is a preparatory step for the beginning of a much larger
   series.  Peff is Cc'ed because one of the most tricky issue
   involves what d46a8301930a (fix parsing of @{-1}@{u} combination,
   2010-01-28) did.

 sha1_name.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 3820f28..1473bb6 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -862,6 +862,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
 struct grab_nth_branch_switch_cbdata {
 	int remaining;
 	struct strbuf buf;
+	int detached;
 };
 
 static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
@@ -880,9 +881,14 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 	if (!match || !target)
 		return 0;
 	if (--(cb->remaining) == 0) {
+		unsigned char sha1[20];
+
 		len = target - match;
 		strbuf_reset(&cb->buf);
 		strbuf_add(&cb->buf, match, len);
+		cb->detached = (len == 40 &&
+				!get_sha1_hex(match, sha1) &&
+				!hashcmp(osha1, sha1));
 		return 1; /* we are done */
 	}
 	return 0;
@@ -891,8 +897,12 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 /*
  * Parse @{-N} syntax, return the number of characters parsed
  * if successful; otherwise signal an error with negative value.
+ * The string in buf.buf is either a branch name (needs to be
+ * prefixed with "refs/heads/" if the caller wants to make it
+ * a fully spelled refname) or 40-hex object name of the detached
+ * HEAD, and *detached is set to true for the latter.
  */
-static int interpret_nth_prior_checkout(const char *name, struct strbuf *buf)
+static int interpret_nth_prior_checkout(const char *name, struct strbuf *buf, int *detached)
 {
 	long nth;
 	int retval;
@@ -917,6 +927,8 @@ static int interpret_nth_prior_checkout(const char *name, struct strbuf *buf)
 	if (0 < for_each_reflog_ent_reverse("HEAD", grab_nth_branch_switch, &cb)) {
 		strbuf_reset(buf);
 		strbuf_add(buf, cb.buf.buf, cb.buf.len);
+		if (detached)
+			*detached = cb.detached;
 		retval = brace - name + 1;
 	}
 
@@ -992,7 +1004,7 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 	char *cp;
 	struct branch *upstream;
 	int namelen = strlen(name);
-	int len = interpret_nth_prior_checkout(name, buf);
+	int len = interpret_nth_prior_checkout(name, buf, NULL);
 	int tmp_len;
 
 	if (!len)
-- 
1.8.3-rc1-182-gc61d106
