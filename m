From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] bulk-checkin: do not write an object that already exists
Date: Thu, 17 Nov 2011 23:11:57 -0800
Message-ID: <1321600317-30546-4-git-send-email-gitster@pobox.com>
References: <1319846051-462-1-git-send-email-gitster@pobox.com>
 <1321600317-30546-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 08:12:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRIcQ-0007eY-Vt
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 08:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262Ab1KRHMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 02:12:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59617 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828Ab1KRHMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 02:12:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C0FB2315
	for <git@vger.kernel.org>; Fri, 18 Nov 2011 02:12:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xdhm
	vejofTakfn/6JKAVi1EKOfQ=; b=x+zFrtnncl5sEPsa+9R5XiKSBjRIdWrVGtFo
	0I4FyBf248LSVaVe3Rw1x7WSgFXTHYKe9OhQY40j5+bR4MzTR8KZZ5pzuVAzvULf
	gtT6BJEUbw9J1C6+JOQ7dWxQieRK/rs/E+xHOg+/1XSOKlaPEAZfQRC3zyRPCrgq
	3fTR91g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=HjZHZo
	hohz0CJm8RtbnYJsA1/vJpmaQzdqtfublhw7SdsaMJRPfRTKtiry0Kwj6KuFgc5R
	tjsa4BRbwcUIzgtir87dkBWB5v9w5LMTEN5b2o1b/dulQ+5zREA8uGaVi/ndc2ck
	A/Y1hEPfjUZIpzyuyIBYR58Ytaw/agjfDtrDw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04674230D
	for <git@vger.kernel.org>; Fri, 18 Nov 2011 02:12:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B250C230A for
 <git@vger.kernel.org>; Fri, 18 Nov 2011 02:12:04 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc3.111.g7d421
In-Reply-To: <1321600317-30546-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9E6A9F7C-11B4-11E1-BFAE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185642>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bulk-checkin.c   |   12 +++++++++++-
 t/t1050-large.sh |   18 +++++++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 82166ba..60178ef 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -29,7 +29,11 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 	if (!state->f)
 		return;
 
-	if (state->nr_written == 1) {
+	if (state->nr_written == 0) {
+		close(state->f->fd);
+		unlink(state->pack_tmp_name);
+		goto clear_exit;
+	} else if (state->nr_written == 1) {
 		sha1close(state->f, sha1, CSUM_FSYNC);
 	} else {
 		int fd = sha1close(state->f, sha1, 0);
@@ -45,6 +49,8 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
 			    &state->pack_idx_opts, sha1);
 	for (i = 0; i < state->nr_written; i++)
 		free(state->written[i]);
+
+clear_exit:
 	free(state->written);
 	memset(state, 0, sizeof(*state));
 
@@ -56,6 +62,10 @@ static int already_written(struct bulk_checkin_state *state, unsigned char sha1[
 {
 	int i;
 
+	/* The object may already exist in the repository */
+	if (has_sha1_file(sha1))
+		return 1;
+
 	/* Might want to keep the list sorted */
 	for (i = 0; i < state->nr_written; i++)
 		if (!hashcmp(state->written[i]->sha1, sha1))
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index fbd5ced..0726472 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -9,6 +9,7 @@ test_expect_success setup '
 	git config core.bigfilethreshold 200k &&
 	echo X | dd of=large1 bs=1k seek=2000 &&
 	echo X | dd of=large2 bs=1k seek=2000 &&
+	echo X | dd of=large3 bs=1k seek=2000 &&
 	echo Y | dd of=huge bs=1k seek=2500
 '
 
@@ -34,7 +35,22 @@ test_expect_success 'add a large file or two' '
 		test -f "$l" || continue
 		bad=t
 	done &&
-	test -z "$bad"
+	test -z "$bad" &&
+
+	# attempt to add another copy of the same
+	git add large3 &&
+	bad= count=0 &&
+	for p in .git/objects/pack/pack-*.pack
+	do
+		count=$(( $count + 1 ))
+		if test -f "$p" && idx=${p%.pack}.idx && test -f "$idx"
+		then
+			continue
+		fi
+		bad=t
+	done &&
+	test -z "$bad" &&
+	test $count = 1
 '
 
 test_expect_success 'checkout a large file' '
-- 
1.7.8.rc3.111.g7d421
