Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C55EB64DA
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 21:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjGHVfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jul 2023 17:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGHVfl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2023 17:35:41 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04543E46
        for <git@vger.kernel.org>; Sat,  8 Jul 2023 14:35:39 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CDF242E858;
        Sat,  8 Jul 2023 17:35:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=TT339pRUhYE7g5tUYcgmMhlhX
        +n993D3f8n+AnE0tBg=; b=LJIOzm0/pYUIUqgnfhyUrPHVtLzBLNd0uTIasN5ig
        R8vxDohk4MxnkGqXIuKxbANKq1VoEjX/+UJvvo4Zf9JiewKjLOfYA7tNSYtSOJoM
        7hmWAaQcZS23ZmykbFKTWtyR27TlmiN8TdCDmoS3pt9+jClOxaXTgwH5vVp9z2B6
        DM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C7B4A2E857;
        Sat,  8 Jul 2023 17:35:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5EC472E856;
        Sat,  8 Jul 2023 17:35:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: [PATCH 2alt/2] dir: match "attr" pathspec magic with correct paths
References: <20230707220457.3655121-1-gitster@pobox.com>
        <20230707220457.3655121-3-gitster@pobox.com>
        <xmqqttuf70bn.fsf_-_@gitster.g>
        <26f81ed0-8d1f-e0be-9696-25ce3938ae09@web.de>
Date:   Sat, 08 Jul 2023 14:35:33 -0700
Message-ID: <xmqqh6qe5boa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5EFF6E76-1DD7-11EE-A5DA-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>>  	if (item->attr_match_nr &&
>> -	    !match_pathspec_attrs(istate, name, namelen, item))
>> +	    !match_pathspec_attrs(istate, name - prefix, namelen + prefix, i=
tem))
>
> match_pathspec_item() has only one caller, and it did the opposite, so
> this is safe.  And a minimal fix like that is less likely to have side
> effects.  Removing the trick will surely improve the code, though.  If
> match_pathspec_item() needs the full name then we should pass it on,
> and if the "prefix" offset needs to be added then it can happen right
> there in that function.

Yup.  I am inclined to take this version and then update the
proposed log message to put less blame on the "common prefix"
optimization in general.

Thanks.

Just for completeness, this is with an updated log message.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
The match_pathspec_item() function takes "prefix" value, allowing a
caller to chop off the common leading prefix of pathspec pattern
strings from the path and only use the remainder of the path to
match the pathspec patterns (after chopping the same leading prefix
of them, of course).

This "common leading prefix" optimization has two main features:

 * discard the entries in the in-core index that are outside of the
   common leading prefix; if you are doing "ls-files one/a one/b",
   we know all matches must be from "one/", so first the code
   discards all entries outside the "one/" directory from the
   in-core index.  This allows us to work on a smaller dataset.

 * allow skipping the comparison of the leading bytes when matching
   pathspec with path.  When "ls-files" finds the path "one/a/1" in
   the in-core index given "one/a" and "one/b" as the pathspec,
   knowing that common leading prefix "one/" was found lets the
   pathspec matchinery not to bother comparing "one/" part, and
   allows it to feed "a/1" down, as long as the pathspec element
   "one/a" gets corresponding adjustment to "a".

When the "attr" pathspec magic is in effect, however, the current
code breaks down.

The attributes, other than the ones that are built-in and the ones
that come from the $GIT_DIR/info/attributes file and the top-level
.gitattributes file, are lazily read from the filesystem on-demand,
as we encounter each path and ask if it matches the pathspec.  For
example, if you say "git ls-files "(attr:label)sub/" in a repository
with a file "sub/file" that is given the 'label' attribute in
"sub/.gitattributes":

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

The last one is what breaks the match in the current code, as the
pathspec subsystem ends up asking the attribute subsystem to find
the attribute attached to the path "file".  We need to ask about the
attributes on "sub/file" when calling match_pathspec_attrs(); this
can be done by looking at "prefix" bytes before the beginning of
"name", which is the same trick already used by another piece of the
code in the same match_pathspec_item() function.

Unfortunately this was not discovered so far because the code works
with slightly different arguments, e.g.

 $ git ls-files "(attr:label)sub"
 $ git ls-files "(attr:label)sub/" "no/such/dir/"

would have reported "sub/file" as a path with the 'label' attribute
just fine, because neither would trigger the common prefix
optimization.

Reported-by: Matthew Hughes <mhughes@uw.co.uk>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c                          |  2 +-
 t/t6135-pathspec-with-attrs.sh | 24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index a7469df3ac..635d1b058c 100644
--- a/dir.c
+++ b/dir.c
@@ -374,7 +374,7 @@ static int match_pathspec_item(struct index_state *is=
tate,
 		return 0;
=20
 	if (item->attr_match_nr &&
-	    !match_pathspec_attrs(istate, name, namelen, item))
+	    !match_pathspec_attrs(istate, name - prefix, namelen + prefix, item=
))
 		return 0;
=20
 	/* If the match was just the prefix, we matched */
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
2.41.0-327-gaa9166bcc0


