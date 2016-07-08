Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33F352070F
	for <e@80x24.org>; Fri,  8 Jul 2016 19:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbcGHTBx (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 15:01:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63170 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755400AbcGHTBw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2016 15:01:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0094E2B52F;
	Fri,  8 Jul 2016 15:01:51 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=If/0iGDUbDpT
	DBUTEDY4054DIT4=; b=XuB0DjNP41O+dgEPJwGl4yNq5uWPZvwoBy/31ezjwUpA
	Tn2jf6sfvz4sEnFERYpf79yHILGNWp0FMtJ/4nuyL7MQjTiqEN2ZSX573kc8vs0e
	ZeF9T0kYkmwZ+RAuCMH4PaeNx6g7TTz/fdnKh1kOSYOo62Ywrws7IlZRyTMK+oE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VzJ86p
	G5OLxoZKDSE4jIRiz/2HEpbOKwjOyJ1HdWmnr51pjO5R54Rfj4MNGXrT6hCcWvCy
	0aDUhH/tUEKXUydMKo5sc7CA0qgsP+HkFFV2vmtRobGZnNBXSg3w1Lj+LGq3wkOE
	eTAeaJLfmDduhcqM98vr2ZUIfB+qaBttBpH9Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EBBBA2B52E;
	Fri,  8 Jul 2016 15:01:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5F4462B52D;
	Fri,  8 Jul 2016 15:01:50 -0400 (EDT)
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
Date:	Fri, 08 Jul 2016 12:01:48 -0700
In-Reply-To: <f78fa94d-abd2-05a2-c411-15e2ffdb7dae@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Fri, 8 Jul 2016 19:13:40
 +0200")
Message-ID: <xmqqoa68kl7n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6D37A70C-453E-11E6-BBE2-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> Did that experiment made it to a branch somewhere ?

I've tentatively queued the following (it's the same as "Here is
another approach." I sent earlier, but with a real log message) on
'pu'.

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

We can work this around by not refreshing the individual cache
entries in make_cache_entry() called by add_cacheinfo().  After we
are finished mergeing, we call refresh_cache() to take care of the
refreshing of the stat information.  By the time this refreshing
happens, the stale cache entries that had CRLF in stage #2 that were
carried over before the renormalizing merge started will all be gone
and will not interfere with the correct recording of the result.

The test update was taken from a series by Torsten Bögershausen
that attempted to fix this with a different approach (which was a
lot more intrusive).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c            |  3 ++-
 merge-recursive.c          | 20 +++++++++---------
 t/t6038-merge-text-auto.sh | 51 +++++++++++++++++++++++++---------------------
 3 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 101ffef..d5bf68d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -678,7 +678,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 
 		hold_locked_index(&lock, 1);
 		clean = merge_recursive(&o, head,
-				remoteheads->item, reversed, &result);
+					remoteheads->item, reversed, &result);
+		refresh_cache(CE_MATCH_REFRESH | CE_MATCH_IGNORE_MISSING);
 		if (active_cache_changed &&
 		    write_locked_index(&the_index, &lock, COMMIT_LOCK))
 			die (_("unable to write %s"), get_index_file());
diff --git a/merge-recursive.c b/merge-recursive.c
index b880ae5..8aaf1b5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -199,14 +199,14 @@ static void output_commit_title(struct merge_options *o, struct commit *commit)
 }
 
 static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
-		const char *path, int stage, int refresh, int options)
+			 const char *path, int stage, int options)
 {
 	struct cache_entry *ce;
-	ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path, stage,
-			      (refresh ? (CE_MATCH_REFRESH |
-					  CE_MATCH_IGNORE_MISSING) : 0 ));
+
+	ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path, stage, 0);
 	if (!ce)
 		return error(_("addinfo_cache failed for path '%s'"), path);
+
 	return add_cache_entry(ce, options);
 }
 
@@ -552,13 +552,13 @@ static int update_stages(const char *path, const struct diff_filespec *o,
 		if (remove_file_from_cache(path))
 			return -1;
 	if (o)
-		if (add_cacheinfo(o->mode, o->sha1, path, 1, 0, options))
+		if (add_cacheinfo(o->mode, o->sha1, path, 1, options))
 			return -1;
 	if (a)
-		if (add_cacheinfo(a->mode, a->sha1, path, 2, 0, options))
+		if (add_cacheinfo(a->mode, a->sha1, path, 2, options))
 			return -1;
 	if (b)
-		if (add_cacheinfo(b->mode, b->sha1, path, 3, 0, options))
+		if (add_cacheinfo(b->mode, b->sha1, path, 3, options))
 			return -1;
 	return 0;
 }
@@ -804,7 +804,7 @@ static void update_file_flags(struct merge_options *o,
 	}
  update_index:
 	if (update_cache)
-		add_cacheinfo(mode, sha, path, 0, update_wd, ADD_CACHE_OK_TO_ADD);
+		add_cacheinfo(mode, sha, path, 0, ADD_CACHE_OK_TO_ADD);
 }
 
 static void update_file(struct merge_options *o,
@@ -1638,8 +1638,7 @@ static int merge_content(struct merge_options *o,
 		 */
 		path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
 		if (!path_renamed_outside_HEAD) {
-			add_cacheinfo(mfi.mode, mfi.sha, path,
-				      0, (!o->call_depth), 0);
+			add_cacheinfo(mfi.mode, mfi.sha, path, 0, 0);
 			return mfi.clean;
 		}
 	} else
@@ -2019,6 +2018,7 @@ int merge_recursive_generic(struct merge_options *o,
 	hold_locked_index(lock, 1);
 	clean = merge_recursive(o, head_commit, next_commit, ca,
 			result);
+	refresh_cache(CE_MATCH_REFRESH | CE_MATCH_IGNORE_MISSING);
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, lock, COMMIT_LOCK))
 		return error(_("Unable to write index."));
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

