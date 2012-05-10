From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/9] apply: register conflicted stages to the index
Date: Thu, 10 May 2012 15:32:51 -0700
Message-ID: <1336689173-15822-8-git-send-email-gitster@pobox.com>
References: <1336689173-15822-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 00:33:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSbvB-0006Aa-4r
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 00:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602Ab2EJWdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 18:33:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36731 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932569Ab2EJWdK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 18:33:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACEBD8439
	for <git@vger.kernel.org>; Thu, 10 May 2012 18:33:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=T/PH
	HHRgAly0WXoN5jKsqmEA/YM=; b=mUifkNf8/QVavkLWlBoyH2N1aVefF6CifxvU
	t1bvcre+7c825mqecyCrkotCxevLbqAJqfdHuh80jU8rVsi3YEcjK0num/EyYVnO
	tysQEZ1h2DwrDZa2ZYG1AYfswqnOoGKB/rQrTfMF3RGoz6Dz6zzPVQKiqdx2EyAi
	eW/9IhE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=dJBBxb
	LpC7FRGqM1mOzvR+NfVF3+mUwaRTNyLdm1XNV88fc4tE7H+6PIRXQ4c/Ax9tBqd9
	RnyYI/pl7UfWXxIsCYV7qljEargi2yaMkOEiyNPZs9YWEIZKDQzWhgoj/SyeQtvD
	0hYtrTR3oWed3eIytUczN8iKkHmIQi4m9CvRQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A48618438
	for <git@vger.kernel.org>; Thu, 10 May 2012 18:33:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F08108437 for
 <git@vger.kernel.org>; Thu, 10 May 2012 18:33:08 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.1.574.g840b38f
In-Reply-To: <1336689173-15822-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1E5B1A58-9AF0-11E1-A9D5-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197640>

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
 builtin/apply.c           | 55 ++++++++++++++++++++++++++++++---
 t/t4108-apply-threeway.sh | 78 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+), 5 deletions(-)
 create mode 100755 t/t4108-apply-threeway.sh

diff --git a/builtin/apply.c b/builtin/apply.c
index ac53ecf..9f376b5 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3708,6 +3708,27 @@ static void create_one_file(char *path, unsigned mode, const char *buf, unsigned
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
@@ -3718,7 +3739,11 @@ static void create_file(struct patch *patch)
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
@@ -3820,6 +3845,7 @@ static int write_out_results(struct patch *list)
 	int phase;
 	int errs = 0;
 	struct patch *l;
+	struct string_list cpath = STRING_LIST_INIT_DUP;
 
 	for (phase = 0; phase < 2; phase++) {
 		l = list;
@@ -3828,12 +3854,28 @@ static int write_out_results(struct patch *list)
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
 
@@ -3956,8 +3998,11 @@ static int apply_patch(int fd, const char *filename, int options)
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
1.7.10.1.574.g840b38f
