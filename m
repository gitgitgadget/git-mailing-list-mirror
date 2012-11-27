From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] diff --stat: do not count "unmerged" entries
Date: Tue, 27 Nov 2012 13:21:50 -0800
Message-ID: <1354051310-29093-6-git-send-email-gitster@pobox.com>
References: <1354051310-29093-1-git-send-email-gitster@pobox.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 22:22:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdSbk-00027f-CN
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 22:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756702Ab2K0VWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 16:22:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42056 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756498Ab2K0VWD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 16:22:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1069093E4;
	Tue, 27 Nov 2012 16:22:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=wOx6
	Ndy94f4cc5yEZ//Y4EHzdNg=; b=qUYMAkj27ouGiGO34fQcymKgky/KM6bNHP57
	ZfAz8yuyq3gRvB21t0vE0zy1ivbB5bA1AWYpD8bF+PTKbo4vsN3cmIDRWb4iU5LG
	w9UmXvKdAEkTtIGTZ9wloMe9Ho4v+GTxRnQyFykbJgcpMsxPYWXRLiFZsWutQ7eI
	vb/4Oe0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	a1GptTOYWitmhNRb6kYo5pb75l89Zi6xKLVVUss+crnU7W2amWKZ+z0VSV+6P35l
	oUciFsN3sUBN+XDCEZKQ7tx19ThDSkwAb2MdFTO6GRGdgtYGa5i494coiZjHNGkL
	9xP5o/1s0MW3KzKdJuS9ZBAMxHkrrj5D7XSlRDfFWHI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFDC293E3;
	Tue, 27 Nov 2012 16:22:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0BCA893E0; Tue, 27 Nov 2012
 16:22:01 -0500 (EST)
X-Mailer: git-send-email 1.8.0.1.331.g808d2af
In-Reply-To: <1354051310-29093-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7C17C246-38D8-11E2-B119-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210602>

Even though we show a separate *UNMERGED* entry in the patch and
diffstat output (or in the --raw format, for that matter) in
addition to and separately from the diff against the specified stage
(defaulting to #2) for unmerged paths, they should not be counted in
the total number of files affected---that would lead to counting the
same path twice.

The separation done by the previous step makes this fix simple and
straightforward.  Among the filepairs in diff_queue, paths that
weren't modified, and the extra "unmerged" entries do not count as
total number of files.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                     | 6 ++++--
 t/t4049-diff-stat-count.sh | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 4105260..26ede82 100644
--- a/diff.c
+++ b/diff.c
@@ -1669,12 +1669,14 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		struct diffstat_file *file = data->files[i];
 		uintmax_t added = file->added;
 		uintmax_t deleted = file->deleted;
-		if (!file->is_interesting && (added + deleted == 0)) {
+
+		if (file->is_unmerged ||
+		    (!file->is_interesting && (added + deleted == 0))) {
 			total_files--;
 			continue;
 		}
 
-		if (!file->is_binary && !file->is_unmerged) {
+		if (!file->is_binary) {
 			adds += added;
 			dels += deleted;
 		}
diff --git a/t/t4049-diff-stat-count.sh b/t/t4049-diff-stat-count.sh
index 70ee073..37f50cd 100755
--- a/t/t4049-diff-stat-count.sh
+++ b/t/t4049-diff-stat-count.sh
@@ -44,7 +44,7 @@ test_expect_success 'binary changes do not count in lines' '
 	test_i18ncmp expect actual
 '
 
-test_expect_failure 'exclude unmerged entries from total file count' '
+test_expect_success 'exclude unmerged entries from total file count' '
 	git reset --hard &&
 	echo a >a &&
 	echo b >b &&
-- 
1.8.0.1.331.g808d2af
