From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] diff-files: show unmerged entries correctly
Date: Sun, 24 Apr 2011 13:51:29 -0700
Message-ID: <1303678289-27627-5-git-send-email-gitster@pobox.com>
References: <1303678289-27627-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 22:51:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QE6HZ-00079d-Uy
	for gcvg-git-2@lo.gmane.org; Sun, 24 Apr 2011 22:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757806Ab1DXUvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2011 16:51:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33131 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757773Ab1DXUvm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2011 16:51:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2DCF746CF
	for <git@vger.kernel.org>; Sun, 24 Apr 2011 16:53:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=CXYY
	TBCgJGDl/A+MOg8HO2040iU=; b=lquJWDRycNLA4e2UJ7UJ1PZlXjUuYOphQtaZ
	uA1RY+EqEU0xztv2ZVt+DkwastxeomygT9SE1G+Y6tj7YlBqhS5rXXSaO3weTg82
	7BYXPyZmPNSdN92UYSSMMLixv8svGJsrBaquhYG+9ESFXaiVpveY6yRjwuHgF2+P
	NTpm8yo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=IXn11H
	neAg3rliwjV5YwJ2W5TV7vCSc4JVVgOe6VSLvCQA6o8Oxum0BfyHtSu30z4DufUk
	4yOZSRA4LpnkbaxiqL4+yXKiB8yAuw3ak+p0jJbB9d0F+vSuLFfMeWXtskZh2Mhd
	Q5gy4WxvjBjvSRfZS1QOk9GnDweA3kYHER9U4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 27FD346C8
	for <git@vger.kernel.org>; Sun, 24 Apr 2011 16:53:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 41FA746C3 for
 <git@vger.kernel.org>; Sun, 24 Apr 2011 16:53:42 -0400 (EDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1303678289-27627-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F098A65C-6EB4-11E0-B6E3-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172002>

Earlier, e9c8409 (diff-index --cached --raw: show tree entry on the LHS
for unmerged entries., 2007-01-05) taught the command to show the object
name and the mode from the entry coming from the tree side when comparing
a tree with an unmerged index.

This is a belated companion patch that teaches diff-files to show the mode
from the entry coming from the working tree side, when comparing an
unmerged index and the working tree.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-lib.c               |   10 ++++-
 t/t4046-diff-unmerged.sh |   87 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 2 deletions(-)
 create mode 100755 t/t4046-diff-unmerged.sh

diff --git a/diff-lib.c b/diff-lib.c
index a983855..b782476 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -111,6 +111,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 
 		if (ce_stage(ce)) {
 			struct combine_diff_path *dpath;
+			struct diff_filepair *pair;
+			unsigned int wt_mode = 0;
 			int num_compare_stages = 0;
 			size_t path_len;
 
@@ -129,7 +131,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 
 			changed = check_removed(ce, &st);
 			if (!changed)
-				dpath->mode = ce_mode_from_stat(ce, st.st_mode);
+				wt_mode = ce_mode_from_stat(ce, st.st_mode);
 			else {
 				if (changed < 0) {
 					perror(ce->name);
@@ -137,7 +139,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				}
 				if (silent_on_removed)
 					continue;
+				wt_mode = 0;
 			}
+			dpath->mode = wt_mode;
 
 			while (i < entries) {
 				struct cache_entry *nce = active_cache[i];
@@ -183,7 +187,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			 * Show the diff for the 'ce' if we found the one
 			 * from the desired stage.
 			 */
-			diff_unmerge(&revs->diffopt, ce->name);
+			pair = diff_unmerge(&revs->diffopt, ce->name);
+			if (wt_mode)
+				pair->two->mode = wt_mode;
 			if (ce_stage(ce) != diff_unmerged_stage)
 				continue;
 		}
diff --git a/t/t4046-diff-unmerged.sh b/t/t4046-diff-unmerged.sh
new file mode 100755
index 0000000..25d50a6
--- /dev/null
+++ b/t/t4046-diff-unmerged.sh
@@ -0,0 +1,87 @@
+#!/bin/sh
+
+test_description='diff with unmerged index entries'
+. ./test-lib.sh
+
+test_expect_success setup '
+	for i in 0 1 2 3
+	do
+		blob=$(echo $i | git hash-object --stdin) &&
+		eval "blob$i=$blob" &&
+		eval "m$i=\"100644 \$blob$i $i\"" || break
+	done &&
+	paths= &&
+	for b in o x
+	do
+		for o in o x
+		do
+			for t in o x
+			do
+				path="$b$o$t" &&
+				case "$path" in ooo) continue ;; esac
+				paths="$paths$path " &&
+				p="	$path" &&
+				case "$b" in x) echo "$m1$p" ;; esac &&
+				case "$o" in x) echo "$m2$p" ;; esac &&
+				case "$t" in x) echo "$m3$p" ;; esac ||
+				break
+			done || break
+		done || break
+	done >ls-files-s.expect &&
+	git update-index --index-info <ls-files-s.expect &&
+	git ls-files -s >ls-files-s.actual &&
+	test_cmp ls-files-s.expect ls-files-s.actual
+'
+
+test_expect_success 'diff-files -0' '
+	for path in $paths
+	do
+		>"$path" &&
+		echo ":000000 100644 $_z40 $_z40 U	$path"
+	done >diff-files-0.expect &&
+	git diff-files -0 >diff-files-0.actual &&
+	test_cmp diff-files-0.expect diff-files-0.actual
+'
+
+test_expect_success 'diff-files -1' '
+	for path in $paths
+	do
+		>"$path" &&
+		echo ":000000 100644 $_z40 $_z40 U	$path" &&
+		case "$path" in
+		x??) echo ":100644 100644 $blob1 $_z40 M	$path"
+		esac
+	done >diff-files-1.expect &&
+	git diff-files -1 >diff-files-1.actual &&
+	test_cmp diff-files-1.expect diff-files-1.actual
+'
+
+test_expect_success 'diff-files -2' '
+	for path in $paths
+	do
+		>"$path" &&
+		echo ":000000 100644 $_z40 $_z40 U	$path" &&
+		case "$path" in
+		?x?) echo ":100644 100644 $blob2 $_z40 M	$path"
+		esac
+	done >diff-files-2.expect &&
+	git diff-files -2 >diff-files-2.actual &&
+	test_cmp diff-files-2.expect diff-files-2.actual &&
+	git diff-files >diff-files-default-2.actual &&
+	test_cmp diff-files-2.expect diff-files-default-2.actual
+'
+
+test_expect_success 'diff-files -3' '
+	for path in $paths
+	do
+		>"$path" &&
+		echo ":000000 100644 $_z40 $_z40 U	$path" &&
+		case "$path" in
+		??x) echo ":100644 100644 $blob3 $_z40 M	$path"
+		esac
+	done >diff-files-3.expect &&
+	git diff-files -3 >diff-files-3.actual &&
+	test_cmp diff-files-3.expect diff-files-3.actual
+'
+
+test_done
-- 
1.7.5
