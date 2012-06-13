From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 16/19] apply: register conflicted stages to the index
Date: Wed, 13 Jun 2012 12:32:57 -0700
Message-ID: <1339615980-19727-17-git-send-email-gitster@pobox.com>
References: <1339615980-19727-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 21:33:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SetK5-0000ae-CP
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 21:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802Ab2FMTdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 15:33:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32884 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754741Ab2FMTdd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 15:33:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 787E68742
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=1W1c
	P5ibrqyJXhko5CBu9u06QxU=; b=c06QbT6HTcIsoYQbav9+bftZ0adhaBB2o5MF
	5FvwMe1zLm7mumaI2YHoZg7FyvN7hjWy0Y096J555O/7NsKMpXudr3RP/DGnfL76
	ZiOgbDrZwIUPLf36uYi4CyB5kLnfxD+tugTAKFUDO7nvvsrIvEzmGcGPW2l1yfyE
	y2VCSWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=uGynlK
	cTO+Dea6PVSXgNRRTQLEtbZvT+cEWNOf2Dh03/AGi3Lp/8qAxAb0GjaozXcLyGSb
	RCWvPbn0xiT+lDSdb/13dJM3A6xmRCDYiflTAQ290aqsYZYpDMoVwzLaWWndAG02
	2anbVPKyQJqCcH493AMD1n3Gd40eyiPFL34/I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FC938741
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ADD7C873D for
 <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:32 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc3.30.g3bdace2
In-Reply-To: <1339615980-19727-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A93DDA08-B58E-11E1-8625-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199929>

Now we have all the necessary logic to fall back on three-way merge when
the patch does not cleanly apply, insert the conflicted entries to the
index as appropriate.  This obviously triggers only when the "--index"
option is used.

When we fall back to three-way merge and some of the merges fail, just
like the case where the "--reject" option was specified and we had to
write some "*.rej" files out for unapplicable patches, exit the command
with non-zero status without showing the diffstat and summary.  Otherwise
they would make the list of problematic paths scroll off the display.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c           | 65 +++++++++++++++++++++++++++++++++++----
 t/t4108-apply-threeway.sh | 78 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+), 6 deletions(-)
 create mode 100755 t/t4108-apply-threeway.sh

diff --git a/builtin/apply.c b/builtin/apply.c
index c3b9f76..8afba92 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3288,7 +3288,10 @@ static int try_threeway(struct image *image, struct patch *patch,
 
 	if (status) {
 		patch->conflicted_threeway = 1;
-		hashcpy(patch->threeway_stage[0], pre_sha1);
+		if (patch->is_new)
+			hashclr(patch->threeway_stage[0]);
+		else
+			hashcpy(patch->threeway_stage[0], pre_sha1);
 		hashcpy(patch->threeway_stage[1], our_sha1);
 		hashcpy(patch->threeway_stage[2], post_sha1);
 		fprintf(stderr, "Applied patch to '%s' with conflicts.\n", patch->new_name);
@@ -3846,6 +3849,32 @@ static void create_one_file(char *path, unsigned mode, const char *buf, unsigned
 	die_errno(_("unable to write file '%s' mode %o"), path, mode);
 }
 
+static void add_conflicted_stages_file(struct patch *patch)
+{
+	int stage, namelen;
+	unsigned ce_size, mode;
+	struct cache_entry *ce;
+
+	if (!update_index)
+		return;
+	namelen = strlen(patch->new_name);
+	ce_size = cache_entry_size(namelen);
+	mode = patch->new_mode ? patch->new_mode : (S_IFREG | 0644);
+
+	remove_file_from_cache(patch->new_name);
+	for (stage = 1; stage < 4; stage++) {
+		if (is_null_sha1(patch->threeway_stage[stage - 1]))
+			continue;
+		ce = xcalloc(1, ce_size);
+		memcpy(ce->name, patch->new_name, namelen);
+		ce->ce_mode = create_ce_mode(mode);
+		ce->ce_flags = create_ce_flags(namelen, stage);
+		hashcpy(ce->sha1, patch->threeway_stage[stage - 1]);
+		if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
+			die(_("unable to add cache entry for %s"), patch->new_name);
+	}
+}
+
 static void create_file(struct patch *patch)
 {
 	char *path = patch->new_name;
@@ -3856,7 +3885,11 @@ static void create_file(struct patch *patch)
 	if (!mode)
 		mode = S_IFREG | 0644;
 	create_one_file(path, mode, buf, size);
-	add_index_file(path, mode, buf, size);
+
+	if (patch->conflicted_threeway)
+		add_conflicted_stages_file(patch);
+	else
+		add_index_file(path, mode, buf, size);
 }
 
 /* phase zero is to remove, phase one is to create */
@@ -3958,6 +3991,7 @@ static int write_out_results(struct patch *list)
 	int phase;
 	int errs = 0;
 	struct patch *l;
+	struct string_list cpath = STRING_LIST_INIT_DUP;
 
 	for (phase = 0; phase < 2; phase++) {
 		l = list;
@@ -3966,12 +4000,28 @@ static int write_out_results(struct patch *list)
 				errs = 1;
 			else {
 				write_out_one_result(l, phase);
-				if (phase == 1 && write_out_one_reject(l))
-					errs = 1;
+				if (phase == 1) {
+					if (write_out_one_reject(l))
+						errs = 1;
+					if (l->conflicted_threeway) {
+						string_list_append(&cpath, l->new_name);
+						errs = 1;
+					}
+				}
 			}
 			l = l->next;
 		}
 	}
+
+	if (cpath.nr) {
+		struct string_list_item *item;
+
+		sort_string_list(&cpath);
+		for_each_string_list_item(item, &cpath)
+			fprintf(stderr, "U %s\n", item->string);
+		string_list_clear(&cpath, 0);
+	}
+
 	return errs;
 }
 
@@ -4094,8 +4144,11 @@ static int apply_patch(int fd, const char *filename, int options)
 	    !apply_with_reject)
 		exit(1);
 
-	if (apply && write_out_results(list))
-		exit(1);
+	if (apply && write_out_results(list)) {
+		if (apply_with_reject)
+			exit(1);
+		return 1;
+	}
 
 	if (fake_ancestor)
 		build_fake_ancestor(list, fake_ancestor);
diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
new file mode 100755
index 0000000..475dfb5
--- /dev/null
+++ b/t/t4108-apply-threeway.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+
+test_description='git apply --3way'
+
+. ./test-lib.sh
+
+create_file () {
+	for i
+	do
+		echo "$i"
+	done
+}
+
+sanitize_conflicted_diff () {
+	sed -e '
+		/^index /d
+		s/^\(+[<>][<>][<>][<>]*\) .*/\1/
+	'
+}
+
+test_expect_success setup '
+	test_tick &&
+	create_file >one 1 2 3 4 5 6 7 &&
+	cat one >two &&
+	git add one two &&
+	git commit -m initial &&
+
+	git branch side &&
+
+	test_tick &&
+	create_file >one 1 two 3 4 5 six 7 &&
+	create_file >two 1 two 3 4 5 6 7 &&
+	git commit -a -m master &&
+
+	git checkout side &&
+	create_file >one 1 2 3 4 five 6 7 &&
+	create_file >two 1 2 3 4 five 6 7 &&
+	git commit -a -m side &&
+
+	git checkout master
+'
+
+test_expect_success 'apply without --3way' '
+	git diff side^ side >P.diff &&
+
+	# should fail to apply
+	git reset --hard &&
+	git checkout master^0 &&
+	test_must_fail git apply --index P.diff &&
+	# should leave things intact
+	git diff-files --exit-code &&
+	git diff-index --exit-code --cached HEAD
+'
+
+test_expect_success 'apply with --3way' '
+	# Merging side should be similar to applying this patch
+	git diff ...side >P.diff &&
+
+	# The corresponding conflicted merge
+	git reset --hard &&
+	git checkout master^0 &&
+	test_must_fail git merge --no-commit side &&
+	git ls-files -s >expect.ls &&
+	git diff HEAD | sanitize_conflicted_diff >expect.diff &&
+
+	# should fail to apply
+	git reset --hard &&
+	git checkout master^0 &&
+	test_must_fail git apply --index --3way P.diff &&
+	git ls-files -s >actual.ls &&
+	git diff HEAD | sanitize_conflicted_diff >actual.diff &&
+
+	# The result should resemble the corresponding merge
+	test_cmp expect.ls actual.ls &&
+	test_cmp expect.diff actual.diff
+'
+
+test_done
-- 
1.7.11.rc3.30.g3bdace2
