Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D772EB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 22:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjGGWFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 18:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjGGWFK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 18:05:10 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9834BFF
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 15:05:08 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3E521992F5;
        Fri,  7 Jul 2023 18:05:07 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NXq21klm0oEN
        E4Qd67e8rsok0+PZYARrS9QAvITpNFs=; b=KABcxfm2imq3Tl8pAKnr0VbWO+H8
        NLKKZMNUTJqj3FFdXPpvFwEirjz2vHSueCoQXaKyaHqQjQggLmGwcUL2gaJVg1cW
        AOJ7SR4MHkguXOq6a5UmU+9H6fPgSugUtUGgjHmcNarAuyiElALRcQy8nMR9nYYh
        Y//5tu5nQGkZbBI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B51771992F1;
        Fri,  7 Jul 2023 18:05:07 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 01A211992EF;
        Fri,  7 Jul 2023 18:05:06 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Matthew Hughes <mhughes@uw.co.uk>
Subject: [PATCH 2/2] dir: do not feed path suffix to pathspec match
Date:   Fri,  7 Jul 2023 15:04:57 -0700
Message-ID: <20230707220457.3655121-3-gitster@pobox.com>
X-Mailer: git-send-email 2.41.0-318-g061c58647e
In-Reply-To: <20230707220457.3655121-1-gitster@pobox.com>
References: <20230707220457.3655121-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 5526522C-1D12-11EE-B67A-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

match_pathspec_item() takes "prefix" value, assuming that it is OK
for a caller to chop off the common leading prefix of pathspec
strings from the path and only allow the remainder of the path to
match the pathspec pattern (after chopping the same leading prefix
of it, of course).

The "common leading prefix" optimization has two main features:

 * discard the entries in the in-core index that are outside of the
   common leading prefix; if you are doing "ls-files one/a one/b",
   we know all matches must be from "one/", so first the code
   discards all entries outside the "one/" directory from the
   in-core index.  This allows us to work on a smaller dataset.

 * allow skipping the comparison of a few leading bytes when
   matching pathspec with path.  When "ls-files" finds the path
   "one/a/1" in the in-core index given "one/a" and "one/b" as the
   pathspec, knowing that common leading prefix "one/" was found
   lets the pathspec matchiner not to bother comparing "one/" part,
   and allows it to feed "a/1" down, as long as the pathspec element
   "one/a" gets corresponding adjustment to "a".

However, losing the full path in the repository too early in the
callchain (at dir.c:do_match_pathspec()) and feeding only the suffix
to the low level code (i.e. dir.c:match_pathspec_item()) loses a
crucial piece of infomation that is needed by the pathspec matching
code, when the attribute magic is involved.  The attributes, other
than the ones that are built-in and the ones that come from the
$GIT_DIR/info/attributes file and the top-level .gitattributes file,
are lazily read on-demand, as we encounter each path and ask if it
matches the pathspec.

For example, if you say "git ls-files "(attr:label)sub/" in a
repository with a file "sub/file" that is given the 'label'
attribute in sub/.gitattributes:

 * The common prefix optimization finds that "sub/" is the common
   prefix and prunes the in-core index so that it has only entries
   inside that directory.  This is desirable.

 * The code then walks the in-core index, finds "sub/file", and
   eventually asks do_match_pathspec() if it matches the given
   pathspec.

 * do_match_pathspec() calls match_pathspec_item() _after_ stripping
   the common prefix "sub/" from the path, giving it "file", plus
   the length of the common prefix (4-bytes), so that the pathspec
   element "(attr:label)sub/" can be treated as if it were "(attr:label)"=
.

The last one is what breaks the match, as the pathspec subsystem
ends up asking the attribute subsystem to find the attribute
attached to the path "file".

Unfortunately this was not discovered so far because the code works
well if we do not trigger the common prefix optimization, e.g.

	git ls-files "(attr:label)sub"
	git ls-files "(attr:label)sub/" "(attr:label)dir/"

would have reported "sub/file" as a path with the 'label' attribute
just fine.

Update do_match_pathspec() so that it does not strip the prefix from
the path, and always feeding the full pathname to match_pathspec_item().

Reported-by: Matthew Hughes <mhughes@uw.co.uk>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c                          | 31 ++++++++-----------------------
 t/t6135-pathspec-with-attrs.sh | 24 +++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/dir.c b/dir.c
index 3acac7beb1..6116022ae6 100644
--- a/dir.c
+++ b/dir.c
@@ -337,12 +337,11 @@ static int do_read_blob(const struct object_id *oid=
, struct oid_stat *oid_stat,
  * [2] Only if DO_MATCH_LEADING_PATHSPEC is passed; otherwise, not a mat=
ch.
  */
 static int match_pathspec_item(struct index_state *istate,
-			       const struct pathspec_item *item, int prefix,
+			       const struct pathspec_item *item,
 			       const char *name, int namelen, unsigned flags)
 {
-	/* name/namelen has prefix cut off by caller */
-	const char *match =3D item->match + prefix;
-	int matchlen =3D item->len - prefix;
+	const char *match =3D item->match;
+	int matchlen =3D item->len;
=20
 	/*
 	 * The normal call pattern is:
@@ -362,19 +361,9 @@ static int match_pathspec_item(struct index_state *i=
state,
 	 * other words, we do not trust the caller on comparing the
 	 * prefix part when :(icase) is involved. We do exact
 	 * comparison ourselves.
-	 *
-	 * Normally the caller (common_prefix_len() in fact) does
-	 * _exact_ matching on name[-prefix+1..-1] and we do not need
-	 * to check that part. Be defensive and check it anyway, in
-	 * case common_prefix_len is changed, or a new caller is
-	 * introduced that does not use common_prefix_len.
-	 *
-	 * If the penalty turns out too high when prefix is really
-	 * long, maybe change it to
-	 * strncmp(match, name, item->prefix - prefix)
 	 */
 	if (item->prefix && (item->magic & PATHSPEC_ICASE) &&
-	    strncmp(item->match, name - prefix, item->prefix))
+	    strncmp(item->match, name, item->prefix))
 		return 0;
=20
 	if (item->attr_match_nr &&
@@ -399,7 +388,7 @@ static int match_pathspec_item(struct index_state *is=
tate,
=20
 	if (item->nowildcard_len < item->len &&
 	    !git_fnmatch(item, match, name,
-			 item->nowildcard_len - prefix))
+			 item->nowildcard_len))
 		return MATCHED_FNMATCH;
=20
 	/* Perform checks to see if "name" is a leading string of the pathspec =
*/
@@ -414,8 +403,7 @@ static int match_pathspec_item(struct index_state *is=
tate,
=20
 		/* name doesn't match up to the first wild character */
 		if (item->nowildcard_len < item->len &&
-		    ps_strncmp(item, match, name,
-			       item->nowildcard_len - prefix))
+		    ps_strncmp(item, match, name, item->nowildcard_len))
 			return 0;
=20
 		/*
@@ -488,9 +476,6 @@ static int do_match_pathspec(struct index_state *ista=
te,
 			return 0;
 	}
=20
-	name +=3D prefix;
-	namelen -=3D prefix;
-
 	for (i =3D ps->nr - 1; i >=3D 0; i--) {
 		int how;
=20
@@ -506,8 +491,8 @@ static int do_match_pathspec(struct index_state *ista=
te,
 		 */
 		if (seen && ps->items[i].magic & PATHSPEC_EXCLUDE)
 			seen[i] =3D MATCHED_FNMATCH;
-		how =3D match_pathspec_item(istate, ps->items+i, prefix, name,
-					  namelen, flags);
+		how =3D match_pathspec_item(istate, ps->items+i,
+					  name, namelen, flags);
 		if (ps->recursive &&
 		    (ps->magic & PATHSPEC_MAXDEPTH) &&
 		    ps->max_depth !=3D -1 &&
diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs=
.sh
index f63774094f..f70c395e75 100755
--- a/t/t6135-pathspec-with-attrs.sh
+++ b/t/t6135-pathspec-with-attrs.sh
@@ -65,7 +65,8 @@ test_expect_success 'setup .gitattributes' '
 	fileValue label=3Dfoo
 	fileWrongLabel label=E2=98=BA
 	EOF
-	git add .gitattributes &&
+	echo fileSetLabel label1 >sub/.gitattributes &&
+	git add .gitattributes sub/.gitattributes &&
 	git commit -m "add attributes"
 '
=20
@@ -157,6 +158,7 @@ test_expect_success 'check unspecified attr' '
 	fileC
 	fileNoLabel
 	fileWrongLabel
+	sub/.gitattributes
 	sub/fileA
 	sub/fileAB
 	sub/fileAC
@@ -181,6 +183,7 @@ test_expect_success 'check unspecified attr (2)' '
 	HEAD:fileC
 	HEAD:fileNoLabel
 	HEAD:fileWrongLabel
+	HEAD:sub/.gitattributes
 	HEAD:sub/fileA
 	HEAD:sub/fileAB
 	HEAD:sub/fileAC
@@ -200,6 +203,7 @@ test_expect_success 'check multiple unspecified attr'=
 '
 	fileC
 	fileNoLabel
 	fileWrongLabel
+	sub/.gitattributes
 	sub/fileC
 	sub/fileNoLabel
 	sub/fileWrongLabel
@@ -273,4 +277,22 @@ test_expect_success 'backslash cannot be used as a v=
alue' '
 	test_i18ngrep "for value matching" actual
 '
=20
+test_expect_success 'reading from .gitattributes in a subdirectory (1)' =
'
+	git ls-files ":(attr:label1)" >actual &&
+	test_write_lines "sub/fileSetLabel" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'reading from .gitattributes in a subdirectory (2)' =
'
+	git ls-files ":(attr:label1)sub" >actual &&
+	test_write_lines "sub/fileSetLabel" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'reading from .gitattributes in a subdirectory (3)' =
'
+	git ls-files ":(attr:label1)sub/" >actual &&
+	test_write_lines "sub/fileSetLabel" >expect &&
+	test_cmp expect actual
+'
+
 test_done
--=20
2.41.0-318-g061c58647e

