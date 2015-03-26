From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] diff: align D/F handling of "diff --no-index" with that of normal Git
Date: Wed, 25 Mar 2015 23:20:32 -0700
Message-ID: <1427350832-17005-3-git-send-email-gitster@pobox.com>
References: <xmqqiodtd3b4.fsf@gitster.dls.corp.google.com>
 <1427350832-17005-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 07:20:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yb19u-00054c-J3
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 07:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbbCZGUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 02:20:41 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63770 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751342AbbCZGUk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 02:20:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 795713C8CD;
	Thu, 26 Mar 2015 02:20:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=DWAU
	8y/uUyX+UFaEv0nlNnlNXjs=; b=beX4gfD+UMVB+jeyEWrtm8vdqSOIvfW43fe0
	Sf2KTYn57zdkhkfZCaywYfn7vnpuXBUWIsQbL6Qa/dfYcKua3/VkgcW+BP0hwvRD
	FeryTAluNXoPNwLelmXDPGE76Cck/ZesWy6WdwegdpHsGDEaRmA8X0Vl9XRytHqk
	U7QKJEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=PuuqbQ
	As2WtO2jzeFDInml8LCT1lhrYHqmLpkwtEvHlTRXMSgHNm0x04vkEI+FPSO/wSnf
	fWaJySx6+uiFY5GTuBWTOP083JFtni5Jnmf7hQfZ2STURJjPo72AuereUDoH86sI
	z1HLSlSKyN0wA8JSU+33dsx8XUkqbG/UCMKIs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5AB2F3C8CC;
	Thu, 26 Mar 2015 02:20:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C4CE63C8CA;
	Thu, 26 Mar 2015 02:20:38 -0400 (EDT)
X-Mailer: git-send-email 2.3.4-477-g2c00653
In-Reply-To: <1427350832-17005-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 38AE6628-D380-11E4-A218-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266316>

When a commit changes a path P that used to be a file to a directory
and creates a new path P/X in it, "git show" would say that file P
was removed and file P/X was created for such a commit.

However, if we compare two directories, D1 and D2, where D1 has a
file D1/P in it and D2 has a directory D2/P under which there is a
file D2/P/X, and ask "git diff --no-index D1 D2" to show their
differences, we simply get a refusal "file/directory conflict".

Surely, that may be what GNU diff does, but we can do better and it
is easy to do so.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-no-index.c          | 23 +++++++++++++++++++++--
 t/t4053-diff-no-index.sh | 12 ++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 49c4536..0320605 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -97,8 +97,27 @@ static int queue_diff(struct diff_options *o,
 	if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
 		return -1;
 
-	if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
-		return error("file/directory conflict: %s, %s", name1, name2);
+	if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2)) {
+		struct diff_filespec *d1, *d2;
+
+		if (S_ISDIR(mode1)) {
+			/* 2 is file that is created */
+			d1 = noindex_filespec(NULL, 0);
+			d2 = noindex_filespec(name2, mode2);
+			name2 = NULL;
+			mode2 = 0;
+		} else {
+			/* 1 is file that is deleted */
+			d1 = noindex_filespec(name1, mode1);
+			d2 = noindex_filespec(NULL, 0);
+			name1 = NULL;
+			mode1 = 0;
+		}
+		/* emit that file */
+		diff_queue(&diff_queued_diff, d1, d2);
+
+		/* and then let the entire directory be created or deleted */
+	}
 
 	if (S_ISDIR(mode1) || S_ISDIR(mode2)) {
 		struct strbuf buffer1 = STRBUF_INIT;
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 01eca4c..596dfe7 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -77,4 +77,16 @@ test_expect_success 'diff D F and diff F D' '
 	)
 '
 
+test_expect_success 'turning a file into a directory' '
+	(
+		cd non/git &&
+		mkdir d e e/sub &&
+		echo 1 >d/sub &&
+		echo 2 >e/sub/file &&
+		printf "D\td/sub\nA\te/sub/file\n" >expect &&
+		test_must_fail git diff --no-index --name-status d e >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.3.4-475-g3180e2e
