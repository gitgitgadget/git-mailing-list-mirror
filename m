From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 16/19] apply: register conflicted stages to the index
Date: Tue, 10 Jul 2012 00:04:09 -0700
Message-ID: <1341903852-4815-17-git-send-email-gitster@pobox.com>
References: <1341903852-4815-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 09:05:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoUVa-0000bE-TI
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 09:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173Ab2GJHFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 03:05:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53337 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754163Ab2GJHE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 03:04:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B4D17DFF
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=vz5H
	OG6GmPlVU59HkVBTnVJ3PA4=; b=Nrr3NvZSA5dXznRHMvgqHhSeF6QVaPuBtwKb
	4DzTcQE3TNYPM4yqtuBjYydIH6gt1R4JXEYrnMbyrA9DAZ5AHjrvq3Wy0KVHRDTa
	6LvGQwZIFDG1+BHAJe6rp1TheqlKPVGx5I/eSa3hW1/NOYHkm+uwtHAMzpk3dAjX
	sM69C5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=CQ4xTB
	516ODSFT5EE3O3XzWOUXt/I4G5/RXRIWWEkyp9wsxGpT5kpo5bkhrYRsAJ4eOc2v
	B5abLumr4Donq1KVVTMVwkct3UGVAB/dAGJfGj5P4J/soDUNDWh0TCxR1h4v1euP
	HrIOql2zUg7rfYbQwnOI59g4czYBpDF430mEU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 930337DFE
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9F1A7DFC for
 <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:57 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.294.g68a9409
In-Reply-To: <1341903852-4815-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8F13A28C-CA5D-11E1-920A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201253>

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
 builtin/apply.c           | 66 +++++++++++++++++++++++++++++++++++----
 t/t4108-apply-threeway.sh | 78 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+), 6 deletions(-)
 create mode 100755 t/t4108-apply-threeway.sh

diff --git a/builtin/apply.c b/builtin/apply.c
index 24efb3f..dc52c94 100644
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
@@ -3852,6 +3855,32 @@ static void create_one_file(char *path, unsigned mode, const char *buf, unsigned
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
@@ -3862,7 +3891,11 @@ static void create_file(struct patch *patch)
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
@@ -3964,6 +3997,7 @@ static int write_out_results(struct patch *list)
 	int phase;
 	int errs = 0;
 	struct patch *l;
+	struct string_list cpath = STRING_LIST_INIT_DUP;
 
 	for (phase = 0; phase < 2; phase++) {
 		l = list;
@@ -3972,12 +4006,28 @@ static int write_out_results(struct patch *list)
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
 
@@ -4100,8 +4150,12 @@ static int apply_patch(int fd, const char *filename, int options)
 	    !apply_with_reject)
 		exit(1);
 
-	if (apply && write_out_results(list))
-		exit(1);
+	if (apply && write_out_results(list)) {
+		if (apply_with_reject)
+			exit(1);
+		/* with --3way, we still need to write the index out */
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
1.7.11.1.294.g68a9409
