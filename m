From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] diff --stat: move the "total count" logic to the last
 loop
Date: Tue, 27 Nov 2012 13:21:49 -0800
Message-ID: <1354051310-29093-5-git-send-email-gitster@pobox.com>
References: <1354051310-29093-1-git-send-email-gitster@pobox.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 22:22:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdSbs-0002H6-Lf
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 22:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756734Ab2K0VWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 16:22:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42016 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756647Ab2K0VWB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 16:22:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF93993DC;
	Tue, 27 Nov 2012 16:22:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=2HS2
	u4lWCXdzkHbfF5SE2Xn9sSA=; b=ZHJaR3lhtw3QehqWF1+xtfSBIAJjCQDj/3vz
	9yuFo2QUiAbJsVZV4nLuGYIsmaxrAWQD190r5wzbwMpFsi56VLZeItk7NOQA/rHY
	ag9Q+LmsOpQybVWRE3HMlGh1O3yPS3yEjRC0bycsEvYvMOikwNWuQk3MmAGdGR1p
	MKcHf88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Tqwshw9BmbLr5zAlUheFW21nkvbXPA5fs9qemhWdlzWok8HZSpy/u0P78WEwGSuU
	zvpo6eGjtzwnzVTxlqJALDw0LmbIR1CWO6NAEcrKidLNTqdjJ7b4Eh7JmK+gDPKG
	I/edHbPa6Rbw1jx+4LI3KimjbjiFK9FB7YQ2Qp4cesk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A89BD93DB;
	Tue, 27 Nov 2012 16:22:00 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB1BA93DA; Tue, 27 Nov 2012
 16:21:59 -0500 (EST)
X-Mailer: git-send-email 1.8.0.1.331.g808d2af
In-Reply-To: <1354051310-29093-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 7AC56A92-38D8-11E2-9A92-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210604>

The diffstat generation logic, with --stat-count limit, is
implemented as three loops.

 - The first counts the width necessary to show stats up to
   specified number of entries, and notes up to how many entries in
   the data we need to iterate to show the graph;

 - The second iterates that many times to draw the graph, adjusts
   the number of "total modified files", and counts the total
   added/deleted lines for the part that was shown in the graph;

 - The third iterates over the remainder and only does the part to
   count "total added/deleted lines" and to adjust "total modified
   files" without drawing anything.

Move the logic to count added/deleted lines and modified files from
the second loop to the third loop.

This incidentally fixes a bug.  The third loop was not filtering
binary changes (counted in bytes) from the total added/deleted as it
should.  The second loop implemented this correctly, so if a binary
change appeared earlier than the --stat-count cutoff, the code
counted number of added/deleted lines correctly, but if it appeared
beyond the cutoff, the number of lines would have mixed with the
byte count in the buggy third loop.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                     | 21 ++++++++++++---------
 t/t4049-diff-stat-count.sh |  2 +-
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index e4e70e5..4105260 100644
--- a/diff.c
+++ b/diff.c
@@ -1498,7 +1498,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		if (max_change < change)
 			max_change = change;
 	}
-	count = i; /* min(count, data->nr) */
+	count = i; /* where we can stop scanning in data->files[] */
 
 	/*
 	 * We have width = stat_width or term_columns() columns total.
@@ -1592,10 +1592,9 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		uintmax_t deleted = file->deleted;
 		int name_len;
 
-		if (!file->is_interesting && (added + deleted == 0)) {
-			total_files--;
+		if (!file->is_interesting && (added + deleted == 0))
 			continue;
-		}
+
 		/*
 		 * "scale" the filename
 		 */
@@ -1640,8 +1639,6 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		 */
 		add = added;
 		del = deleted;
-		adds += add;
-		dels += del;
 
 		if (graph_width <= max_change) {
 			int total = add + del;
@@ -1667,7 +1664,8 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		show_graph(options->file, '-', del, del_c, reset);
 		fprintf(options->file, "\n");
 	}
-	for (i = count; i < data->nr; i++) {
+
+	for (i = 0; i < data->nr; i++) {
 		struct diffstat_file *file = data->files[i];
 		uintmax_t added = file->added;
 		uintmax_t deleted = file->deleted;
@@ -1675,8 +1673,13 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			total_files--;
 			continue;
 		}
-		adds += added;
-		dels += deleted;
+
+		if (!file->is_binary && !file->is_unmerged) {
+			adds += added;
+			dels += deleted;
+		}
+		if (i < count)
+			continue;
 		if (!extra_shown)
 			fprintf(options->file, "%s ...\n", line_prefix);
 		extra_shown = 1;
diff --git a/t/t4049-diff-stat-count.sh b/t/t4049-diff-stat-count.sh
index e212b11..70ee073 100755
--- a/t/t4049-diff-stat-count.sh
+++ b/t/t4049-diff-stat-count.sh
@@ -28,7 +28,7 @@ test_expect_success 'limit output to 2 (simple)' '
 	test_i18ncmp expect actual
 '
 
-test_expect_failure 'binary changes do not count in lines' '
+test_expect_success 'binary changes do not count in lines' '
 	git reset --hard &&
 	chmod +x c d &&
 	echo a >a &&
-- 
1.8.0.1.331.g808d2af
