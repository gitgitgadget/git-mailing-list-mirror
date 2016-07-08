Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABB8D2070D
	for <e@80x24.org>; Fri,  8 Jul 2016 17:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755520AbcGHR7U (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 13:59:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755400AbcGHR7T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 13:59:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 91CFC283D8;
	Fri,  8 Jul 2016 13:59:17 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lBD5il3Hd/iwQ7kqMbeK1mcx2nY=; b=eO7k8x
	J4eyvC2dhLrPbJRdr2J5dme+eDTqCoqI2XVgLQw7NtItHmPUG/3qvWOTsxnxkWBz
	YqbyqF14EoZC3efO2zYc1+nfULQLcHZ7qr+1mcN7tfy5MoobjOAkEB0G0o3NUvj5
	nozy2vtkREA2x4l8m+aTQbmHnuCpRyeAa/X94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U//s94FWJ9+vdPaFypmI/+nDAwnL1Tpk
	XMw2ZZRHvg2dIN2x3SRN2Lj52jhyFhQiuVX+z/WjIMagKFq9sq8ERJiAxRrKQzi2
	6mDNl8K/TxAU3ujOhIyYlpNGn9icj9ii9tjQZG09nCvQmt3a62PcLZjhX/qH1XNu
	g1lCewi10eM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B0F0283D7;
	Fri,  8 Jul 2016 13:59:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 01B24283D6;
	Fri,  8 Jul 2016 13:59:16 -0400 (EDT)
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
	<xmqq1t34m47z.fsf@gitster.mtv.corp.google.com>
Date:	Fri, 08 Jul 2016 10:59:15 -0700
In-Reply-To: <xmqq1t34m47z.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 08 Jul 2016 10:25:52 -0700")
Message-ID: <xmqqwpkwko3w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0063BB0-4535-11E6-8AC2-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Not yet.  As I called it "experiment", it was merely to demonstrate
> that there are less intrusive ways to kill the "safer crlf" we may
> want to consider first before passing an extra blob object name
> around.

Here is another approach, that probably is less intrusive.  It
contains the test updates from your 3/3, and you can apply it
directly on top of 65237284 (convert: unify the "auto" handling of
CRLF, 2016-06-28), which is the result of applying your 1/3 on top
of v2.9.0-rc0~11^2 (convert.c: ident + core.autocrlf didn't work,
2016-04-25).

Instead of letting add_cacheinfo() to refresh individual cache
entries as they are added, we just leave them as they are, which
would bypass the make_cache_entry() -> refresh_cache_entry() ->
... -> ce_compare_data() -> "safer crlf" callchain.  After we are
done all (in builtin/merge.c that directly calls merge_recursive(),
and also merge_recursive_generic()), we let refresh_cache() to take
care of the refreshing of the stat information--by the time this
happens, the stale cache entries that had CRLF in stage #2 that were
carried over before the renormalizing merge started will all be gone
and will not interfere.


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



