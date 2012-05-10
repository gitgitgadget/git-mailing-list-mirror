From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 8/8] apply: register conflicted stages to the index
Date: Wed,  9 May 2012 23:02:25 -0700
Message-ID: <1336629745-22436-9-git-send-email-gitster@pobox.com>
References: <1336629745-22436-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 08:03:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSMSw-0002NM-60
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 08:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755953Ab2EJGDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 02:03:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63087 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755798Ab2EJGCu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 02:02:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CAAD5FE9
	for <git@vger.kernel.org>; Thu, 10 May 2012 02:02:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xTC+
	pMZdxGeOKna3cV3vL+cz4vU=; b=KsbDET0+klnNtRTGyh4bVfeY/XU/lLO63K5L
	n2LZqXlqN/+ghyrTpf9Y31OcMGg8nOT0b117J3tslyOYN6NsrnK6HWAB9BPfruYY
	KX8dmrW/rly82qzI23rxPjR4GEgY/1HwM7ef6pVOX+h8Hpx90FTZ28PXJGHU//o6
	2twUeYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=pwj6Kx
	ztIqD0OmwSMP9TBbrUQJM/uzw9UDei7QFCh1QOh7Uq3HofiruN4C+gNv/ZAtnD8f
	AOKlILnc569HJaSERT5NVNINiw7KccWuTmKpzsOODKR+h/astJRrKgQ26ZH7RhWh
	AO20Jx4YdZg3rXTkAbZ8R6ZlmM73+SGaRI5t8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 548A95FE8
	for <git@vger.kernel.org>; Thu, 10 May 2012 02:02:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88ACC5FE7 for
 <git@vger.kernel.org>; Thu, 10 May 2012 02:02:49 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.1.562.gfc79b1c
In-Reply-To: <1336629745-22436-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C59E550E-9A65-11E1-B5D8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197542>

Now we have all the necessary logic to fall back on three-way merge when
the patch does not cleanly apply, insert the conflicted entries to the
index as appropriate.  This obviously triggers only when the "--index"
option is used.

When we fall back to three-way merge and some of the merges fail, just
like the case where the "--reject" option was specified and we had to
write some "*.rej" files out for unapplicable patches, exit the command
with non-zero status without showing the diffstat and summary.  Otherwise
they would make the list of problematic paths scroll off the display.

This wraps up the series, at least for now.  We might want to also arrange
to call into the rerere machinery to clean things up, but that is left for
later updates.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c           | 65 +++++++++++++++++++++++++++++++++++----
 t/t4108-apply-threeway.sh | 78 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+), 6 deletions(-)
 create mode 100755 t/t4108-apply-threeway.sh

diff --git a/builtin/apply.c b/builtin/apply.c
index e090e18..d8c201b 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3130,6 +3130,9 @@ static int try_threeway_fallback(struct image *image, struct patch *patch,
 	if (get_sha1(patch->old_sha1_prefix, pre_sha1) ||
 	    read_blob_object(&buf, pre_sha1, patch->old_mode))
 		return error("repository lacks necessary blobs to fall back on 3-way merge.");
+
+	fprintf(stderr, "Falling back to three-way merge...\n");
+
 	img = strbuf_detach(&buf, &len);
 	prepare_image(&tmp_image, img, len, 1);
 	/* Apply the patch to get the post image */
@@ -3148,8 +3151,10 @@ static int try_threeway_fallback(struct image *image, struct patch *patch,
 	/* in-core three-way merge between post and our using pre as base */
 	status = three_way_merge(image, patch->new_name,
 				 pre_sha1, our_sha1, post_sha1);
-	if (status < 0)
+	if (status < 0) {
+		fprintf(stderr, "Failed to fall back on three-way merge...\n");
 		return status;
+	}
 
 	patch->did_threeway = 1;
 	if (status) {
@@ -3157,6 +3162,9 @@ static int try_threeway_fallback(struct image *image, struct patch *patch,
 		hashcpy(patch->threeway_stage[0], pre_sha1);
 		hashcpy(patch->threeway_stage[1], our_sha1);
 		hashcpy(patch->threeway_stage[2], post_sha1);
+		fprintf(stderr, "Applied patch to '%s' with conflicts.\n", patch->new_name);
+	} else {
+		fprintf(stderr, "Applied patch to '%s' cleanly.\n", patch->new_name);
 	}
 	return 0;
 }
@@ -3702,6 +3710,27 @@ static void create_one_file(char *path, unsigned mode, const char *buf, unsigned
 	die_errno(_("unable to write file '%s' mode %o"), path, mode);
 }
 
+static void add_conflicted_stages_file(struct patch *patch)
+{
+	int stage, namelen;
+	unsigned ce_size, mode;
+
+	if (!update_index)
+		return;
+	namelen = strlen(patch->new_name);
+	ce_size = cache_entry_size(namelen);
+	mode = patch->new_mode ? patch->new_mode : (S_IFREG | 0644);
+	for (stage = 1; stage < 4; stage++) {
+		struct cache_entry *ce = xcalloc(1, ce_size);
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
@@ -3712,7 +3741,11 @@ static void create_file(struct patch *patch)
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
@@ -3814,6 +3847,7 @@ static int write_out_results(struct patch *list)
 	int phase;
 	int errs = 0;
 	struct patch *l;
+	struct string_list cpath = STRING_LIST_INIT_DUP;
 
 	for (phase = 0; phase < 2; phase++) {
 		l = list;
@@ -3822,12 +3856,28 @@ static int write_out_results(struct patch *list)
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
 
@@ -3950,8 +4000,11 @@ static int apply_patch(int fd, const char *filename, int options)
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
index 0000000..521c114
--- /dev/null
+++ b/t/t4108-apply-threeway.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+
+test_description='git apply --threeway'
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
+test_expect_success 'apply without --threeway' '
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
+test_expect_success 'apply with --threeway' '
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
+	test_must_fail git apply --index --threeway P.diff &&
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
1.7.10.1.562.gfc79b1c
