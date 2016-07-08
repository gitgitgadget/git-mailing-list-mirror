Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 344C72070D
	for <e@80x24.org>; Fri,  8 Jul 2016 20:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755736AbcGHUu2 (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 16:50:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53816 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752314AbcGHUu0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2016 16:50:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E117829B2E;
	Fri,  8 Jul 2016 16:50:24 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ilFa8LrwqiR/
	gRwhly1cykomCw0=; b=NXkVDjMMCEWUS9iTc0Ss0WIZr8KJvOaoxS0DZCg+WrjR
	0XJbHXOGp+8W/n0xx7ycHNnt233keIPIgVvxqsbp9P8gywZhbaxa2qYJ9E3xb8D0
	WV0rjcvlmumSbJWzwvlkzb+wGzsDoFzFqKVuHiwz9rJiVwqmCqwguAKM3LBf5Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fVFAzZ
	15VOPtU5l1tp7pg129VKBl9JdXH9V8QRNn0lUr545Jk7pjDZspeVjPuFCtgZi2JZ
	4ONsa1NHWJ0iRfEHoFtekdWOngJEKI7CIu6HS8axXPdhIBK00IQNwbFB7WX/c3b7
	zp79YQbFidnXp5UPJ/Qy6Uily7pZAECFQhVvY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D7EDB29B2D;
	Fri,  8 Jul 2016 16:50:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 448E429B26;
	Fri,  8 Jul 2016 16:50:24 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] correct ce_compare_data() in a middle of a merge
References: <xmqq37nyb4kp.fsf@gitster.mtv.corp.google.com>
	<1467100876-2803-1-git-send-email-tboegi@web.de>
	<xmqqh9cc55wm.fsf@gitster.mtv.corp.google.com>
	<62eb3d75-126e-427b-8701-d490e80e3501@web.de>
	<xmqq8txlvwip.fsf@gitster.mtv.corp.google.com>
	<574692d1-c8ae-9c2f-6b99-a01545b15051@telia.com>
	<xmqqa8huvmpv.fsf@gitster.mtv.corp.google.com>
	<c36fe487-b8dc-9767-7fae-bee513dac0b2@web.de>
	<xmqqr3b5p9v0.fsf@gitster.mtv.corp.google.com>
	<2cbf12a6-2dca-8180-323b-f79638aa03bd@web.de>
	<xmqqmvlsm6hu.fsf@gitster.mtv.corp.google.com>
	<f78fa94d-abd2-05a2-c411-15e2ffdb7dae@web.de>
	<xmqqoa68kl7n.fsf@gitster.mtv.corp.google.com>
Date:	Fri, 08 Jul 2016 13:50:22 -0700
In-Reply-To: <xmqqoa68kl7n.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 08 Jul 2016 12:01:48 -0700")
Message-ID: <xmqqk2gvlur5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 97CBF3A6-454D-11E6-B605-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I've tentatively queued the following (it's the same as "Here is
> another approach." I sent earlier, but with a real log message) on
> 'pu'.

And here is yet another approach, which probably is even less
intrusive.

Whatever alternative we would end up picking, in the longer term, I
think we should just get rid of the "safer crlf" hack from the
codebase, instead of adding the conditional disabling to work it
around.  The "safe crlf" that inspects the contents being added and
decides that it is not a good idea to turn CRLF in the contents
being added into LF was sensible.  The "safer crlf" that inspects
what happens to be at the path in the index and decides that it
should not turn CRLF in the contents being added into LF, only
because the blob in the index has CRLF in it, is simply broken.  If
a project wants to make sure blobs in some paths are recorded with
CRLF (perhaps because they are test data to compare with and the
program is supposed to always produce CRLF data), they can and
should be use the gitattributes mechanism to mark those paths as
such.

And that is why I really didn't like the approach to pass extra
sha1's around, churning codepaths that are at quite a low level,
only to feed it to the "safer crlf" mechanism.  If removing "safer
crlf" is the right thing to do in the longer term (and I think it
is), we shouldn't be making a big interface changes that we'd need
to revert when it goes away.

-- >8 --
Subject: [PATCH] merge: avoid "safer crlf" during recording of merge results

When merge_recursive() decides what the correct blob object merge
result for a path should be, it uses update_file_flags() helper
function to write it out to a working tree file and then calls
add_cacheinfo().  The add_cacheinfo() function in turn calls
make_cache_entry() to create a new cache entry to replace the
higher-stage entries for the path that represents the conflict.

The make_cache_entry() function calls refresh_cache_entry() to fill
in the cached stat information.  To mark a cache entry as
up-to-date, the data is re-read from the file in the working tree,
and goes through convert_to_git() conversion to be compared with the
blob object name the new cache entry records.

It is important to note that this happens while the higher-stage
entries, which are going to be replaced with the new entry, are
still in the index.  Unfortunately, the convert_to_git() conversion
has a misguided "safer crlf" mechanism baked in, and looks at the
existing cache entry for the path to decide how to convert the
contents in the working tree file.  If our side (i.e. stage#2)
records a text blob with CRLF in it, even when the system is
configured to record LF in blobs and convert them to CRLF upon
checkout (and back to LF upon checkin), the "safer crlf" mechanism
stops us doing so.

This especially poses a problem during a renormalizing merge, where
the merge result for the path is computed by first "normalizing" the
blobs involved in the merge by using convert_to_working_tree()
followed by convert_to_git() with "safer crlf" disabled.  The merge
result that is computed correctly and fed to add_cacheinfo() via
update_file_flags() does _not_ match what refresh_cache_entry() sees
by converting the working tree file via convert_to_git().

We can work this around by not refreshing the new cache entry in
make_cache_entry() called by add_cacheinfo().  After add_cacheinfo()
adds the new entry, we can call refresh_cache_entry() on that,
knowing that addition of this new cache entry would have removed the
stale cache entries that had CRLF in stage #2 that were carried over
before the renormalizing merge started and will not interfere with
the correct recording of the result.

The test update was taken from a series by Torsten Bögershausen
that attempted to fix this with a different approach (which was a
lot more intrusive).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h                    |  1 +
 merge-recursive.c          | 17 ++++++++++++----
 read-cache.c               |  5 +----
 t/t6038-merge-text-auto.sh | 51 +++++++++++++++++++++++++---------------------
 4 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/cache.h b/cache.h
index b829410..b33cb54 100644
--- a/cache.h
+++ b/cache.h
@@ -632,6 +632,7 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 #define REFRESH_IGNORE_SUBMODULES	0x0010	/* ignore submodules */
 #define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs update" */
 extern int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
+extern struct cache_entry *refresh_cache_entry(struct cache_entry *, unsigned int);
 
 extern void update_index_if_able(struct index_state *, struct lock_file *);
 
diff --git a/merge-recursive.c b/merge-recursive.c
index b880ae5..de37e51 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -202,12 +202,21 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 		const char *path, int stage, int refresh, int options)
 {
 	struct cache_entry *ce;
-	ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path, stage,
-			      (refresh ? (CE_MATCH_REFRESH |
-					  CE_MATCH_IGNORE_MISSING) : 0 ));
+	int ret;
+
+	ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path, stage, 0);
 	if (!ce)
 		return error(_("addinfo_cache failed for path '%s'"), path);
-	return add_cache_entry(ce, options);
+
+	ret = add_cache_entry(ce, options);
+	if (refresh) {
+		struct cache_entry *nce;
+
+		nce = refresh_cache_entry(ce, CE_MATCH_REFRESH | CE_MATCH_IGNORE_MISSING);
+		if (nce != ce)
+			ret = add_cache_entry(nce, options);
+	}
+	return ret;
 }
 
 static void init_tree_desc_from_tree(struct tree_desc *desc, struct tree *tree)
diff --git a/read-cache.c b/read-cache.c
index d9fb78b..6af409a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -19,9 +19,6 @@
 #include "split-index.h"
 #include "utf8.h"
 
-static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
-					       unsigned int options);
-
 /* Mask for the name length in ce_flags in the on-disk index */
 
 #define CE_NAMEMASK  (0x0fff)
@@ -1254,7 +1251,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	return has_errors;
 }
 
-static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
+struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 					       unsigned int options)
 {
 	return refresh_cache_ent(&the_index, ce, options, NULL, NULL);
diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index 33b77ee..5e8d5fa 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -91,16 +91,13 @@ test_expect_success 'Merge after setting text=auto' '
 	compare_files expected file
 '
 
-test_expect_success 'Merge addition of text=auto' '
+test_expect_success 'Merge addition of text=auto eol=LF' '
+	git config core.eol lf &&
 	cat <<-\EOF >expected &&
 	first line
 	same line
 	EOF
 
-	if test_have_prereq NATIVE_CRLF; then
-		append_cr <expected >expected.temp &&
-		mv expected.temp expected
-	fi &&
 	git config merge.renormalize true &&
 	git rm -fr . &&
 	rm -f .gitattributes &&
@@ -109,17 +106,31 @@ test_expect_success 'Merge addition of text=auto' '
 	compare_files  expected file
 '
 
+test_expect_success 'Merge addition of text=auto eol=CRLF' '
+	git config core.eol crlf &&
+	cat <<-\EOF >expected &&
+	first line
+	same line
+	EOF
+
+	append_cr <expected >expected.temp &&
+	mv expected.temp expected &&
+	git config merge.renormalize true &&
+	git rm -fr . &&
+	rm -f .gitattributes &&
+	git reset --hard b &&
+	echo >&2 "After git reset --hard b" &&
+	git ls-files -s --eol >&2 &&
+	git merge a &&
+	compare_files  expected file
+'
+
 test_expect_success 'Detect CRLF/LF conflict after setting text=auto' '
+	git config core.eol native &&
 	echo "<<<<<<<" >expected &&
-	if test_have_prereq NATIVE_CRLF; then
-		echo first line | append_cr >>expected &&
-		echo same line | append_cr >>expected &&
-		echo ======= | append_cr >>expected
-	else
-		echo first line >>expected &&
-		echo same line >>expected &&
-		echo ======= >>expected
-	fi &&
+	echo first line >>expected &&
+	echo same line >>expected &&
+	echo ======= >>expected &&
 	echo first line | append_cr >>expected &&
 	echo same line | append_cr >>expected &&
 	echo ">>>>>>>" >>expected &&
@@ -135,15 +146,9 @@ test_expect_success 'Detect LF/CRLF conflict from addition of text=auto' '
 	echo "<<<<<<<" >expected &&
 	echo first line | append_cr >>expected &&
 	echo same line | append_cr >>expected &&
-	if test_have_prereq NATIVE_CRLF; then
-		echo ======= | append_cr >>expected &&
-		echo first line | append_cr >>expected &&
-		echo same line | append_cr >>expected
-	else
-		echo ======= >>expected &&
-		echo first line >>expected &&
-		echo same line >>expected
-	fi &&
+	echo ======= >>expected &&
+	echo first line >>expected &&
+	echo same line >>expected &&
 	echo ">>>>>>>" >>expected &&
 	git config merge.renormalize false &&
 	rm -f .gitattributes &&
-- 
2.9.0-512-gbea6568

