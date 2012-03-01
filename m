From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCH 5/5] t7004 (tag): modernize style
Date: Wed, 29 Feb 2012 17:45:21 -0800
Message-ID: <1330566326-26075-6-git-send-email-tmgrennan@gmail.com>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Amos Waterland <apw@rossby.metr.ou.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 02:46:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2v6P-0004Mc-FZ
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 02:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030586Ab2CABqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 20:46:32 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:64394 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757899Ab2CABp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 20:45:59 -0500
Received: by vcqp1 with SMTP id p1so74233vcq.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 17:45:58 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.52.68.139 as permitted sender) client-ip=10.52.68.139;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.52.68.139 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.52.68.139])
        by 10.52.68.139 with SMTP id w11mr4088907vdt.110.1330566358769 (num_hops = 1);
        Wed, 29 Feb 2012 17:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=CGIsSH8JOEkgcfDnJT0vDiOPrKWcnvSLpYIfBmepY88=;
        b=cSIdsxsKMe7bnco0uCyUewzltA7UGfQqB4zx0BYmaWUg2CUIkZvaPae2MzBY8h/MQr
         oS+cccLCs346w/u4W7WxJ+6/dukpkv/h7qs/eUXzQex26AzorgKu9pJJ/qdbe9th59D7
         RyAeQ/rSC3f0WizWvrnFuT9zNTtAQaPmT67WU=
Received: by 10.52.68.139 with SMTP id w11mr3505131vdt.110.1330566358700;
        Wed, 29 Feb 2012 17:45:58 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id n14sm502335vdj.22.2012.02.29.17.45.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Feb 2012 17:45:57 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <20120223002215.GE2410@tgrennan-laptop>
References: <20120223002215.GE2410@tgrennan-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191883>

- Guard setup with test_expect_success
- Single-quoted, tab prefaced test blocks of < 80 cols
- Redirect unwanted output
- Use a "here" filter for expect generation

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 t/t7004-tag.sh | 1680 ++++++++++++++++++++++++++------------------------------
 1 files changed, 783 insertions(+), 897 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index f8c247a..6704046 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -7,15 +7,37 @@ test_description='git tag
 
 Tests for operations with tags.'
 
+if ! test -r test-lib.sh ; then
+	(cd ${0%/*} && ./${0##*/} $@)
+	exit $?
+fi
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
-# creating and listing lightweight tags:
+quiet () { "$@" >/dev/null; }
+silent () { "$@" >/dev/null 2>&1; }
+here () { sed 's/\\s/ /g; s/\\t/\t/g; s/\\n/\n/g' $@; }
 
 tag_exists () {
 	git show-ref --quiet --verify refs/tags/"$1"
 }
 
+gen_header () { # name, object, type, time
+	cat <<-EOF &&
+		object $2
+		type $3
+		tag $1
+		tagger C O Mitter <committer@example.com> $4 -0700
+
+	EOF
+	here
+}
+
+get_header () {
+	git cat-file tag "$1" | sed -e "/BEGIN PGP/q"
+}
+
 # todo: git tag -l now returns always zero, when fixed, change this test
 test_expect_success 'listing all tags in an empty tree should succeed' '
 	git tag -l &&
@@ -27,36 +49,38 @@ test_expect_success 'listing all tags in an empty tree should output nothing' '
 	test `git tag | wc -l` -eq 0
 '
 
-test_expect_success 'looking for a tag in an empty tree should fail' \
-	'! (tag_exists mytag)'
+test_expect_success 'looking for a tag in an empty tree should fail' '
+	! tag_exists mytag
+'
 
 test_expect_success 'creating a tag in an empty tree should fail' '
-	test_must_fail git tag mynotag &&
+	silent test_must_fail git tag mynotag &&
 	! tag_exists mynotag
 '
 
 test_expect_success 'creating a tag for HEAD in an empty tree should fail' '
-	test_must_fail git tag mytaghead HEAD &&
+	silent test_must_fail git tag mytaghead HEAD &&
 	! tag_exists mytaghead
 '
 
 test_expect_success 'creating a tag for an unknown revision should fail' '
-	test_must_fail git tag mytagnorev aaaaaaaaaaa &&
+	silent test_must_fail git tag mytagnorev aaaaaaaaaaa &&
 	! tag_exists mytagnorev
 '
 
-# commit used in the tests, test_tick is also called here to freeze the date:
 test_expect_success 'creating a tag using default HEAD should succeed' '
+	# commit used in the tests
+	# test_tick is also called here to freeze the date:
 	test_tick &&
-	echo foo >foo &&
+	echo >foo foo &&
 	git add foo &&
-	git commit -m Foo &&
+	git commit -q -m Foo &&
 	git tag mytag
 '
 
 test_expect_success 'listing all tags if one exists should succeed' '
-	git tag -l &&
-	git tag
+	quiet git tag -l &&
+	quiet git tag
 '
 
 test_expect_success 'listing all tags if one exists should output that tag' '
@@ -66,36 +90,36 @@ test_expect_success 'listing all tags if one exists should output that tag' '
 
 # pattern matching:
 
-test_expect_success 'listing a tag using a matching pattern should succeed' \
-	'git tag -l mytag'
+test_expect_success 'listing a tag using a matching pattern should succeed' '
+	quiet git tag -l mytag
+'
 
-test_expect_success \
-	'listing a tag using a matching pattern should output that tag' \
-	'test `git tag -l mytag` = mytag'
+test_expect_success 'listing a tag using a matching pattern should output that tag' '
+	test `git tag -l mytag` = mytag
+'
 
 # todo: git tag -l now returns always zero, when fixed, change this test
-test_expect_success \
-	'listing tags using a non-matching pattern should suceed' \
-	'git tag -l xxx'
+test_expect_success 'listing tags using a non-matching pattern should suceed' '
+	git tag -l xxx
+'
 
-test_expect_success \
-	'listing tags using a non-matching pattern should output nothing' \
-	'test `git tag -l xxx | wc -l` -eq 0'
+test_expect_success 'listing tags using a non-matching pattern should output nothing' '
+	test `git tag -l xxx | wc -l` -eq 0
+'
 
 # special cases for creating tags:
 
-test_expect_success \
-	'trying to create a tag with the name of one existing should fail' \
-	'test_must_fail git tag mytag'
+test_expect_success 'trying to create a tag with the name of one existing should fail' '
+	silent test_must_fail git tag mytag
+'
 
-test_expect_success \
-	'trying to create a tag with a non-valid name should fail' '
+test_expect_success 'trying to create a tag with a non-valid name should fail' '
 	test `git tag -l | wc -l` -eq 1 &&
-	test_must_fail git tag "" &&
-	test_must_fail git tag .othertag &&
-	test_must_fail git tag "other tag" &&
-	test_must_fail git tag "othertag^" &&
-	test_must_fail git tag "other~tag" &&
+	silent test_must_fail git tag "" &&
+	silent test_must_fail git tag .othertag &&
+	silent test_must_fail git tag "other tag" &&
+	silent test_must_fail git tag "othertag^" &&
+	silent test_must_fail git tag "other~tag" &&
 	test `git tag -l | wc -l` -eq 1
 '
 
@@ -108,62 +132,59 @@ test_expect_success 'creating a tag using HEAD directly should succeed' '
 
 test_expect_success 'trying to delete an unknown tag should fail' '
 	! tag_exists unknown-tag &&
-	test_must_fail git tag -d unknown-tag
+	silent test_must_fail git tag -d unknown-tag
 '
 
-cat >expect <<EOF
-myhead
-mytag
-EOF
-test_expect_success \
-	'trying to delete tags without params should succeed and do nothing' '
-	git tag -l > actual && test_cmp expect actual &&
+test_expect_success 'trying to delete tags without params should succeed and do nothing' '
+	cat >expect <<-EOF &&
+		myhead
+		mytag
+	EOF
+	git tag -l | test_cmp expect - &&
 	git tag -d &&
-	git tag -l > actual && test_cmp expect actual
+	git tag -l | test_cmp expect -
 '
 
-test_expect_success \
-	'deleting two existing tags in one command should succeed' '
+test_expect_success 'deleting two existing tags in one command should succeed' '
 	tag_exists mytag &&
 	tag_exists myhead &&
-	git tag -d mytag myhead &&
+	quiet git tag -d mytag myhead &&
 	! tag_exists mytag &&
 	! tag_exists myhead
 '
 
-test_expect_success \
-	'creating a tag with the name of another deleted one should succeed' '
+test_expect_success 'creating a tag with the name of another deleted one should succeed' '
 	! tag_exists mytag &&
 	git tag mytag &&
 	tag_exists mytag
 '
 
-test_expect_success \
-	'trying to delete two tags, existing and not, should fail in the 2nd' '
+test_expect_success 'trying to delete two tags, existing and not, should fail in the 2nd' '
 	tag_exists mytag &&
 	! tag_exists myhead &&
-	test_must_fail git tag -d mytag anothertag &&
+	silent test_must_fail git tag -d mytag anothertag &&
 	! tag_exists mytag &&
 	! tag_exists myhead
 '
 
-test_expect_success 'trying to delete an already deleted tag should fail' \
-	'test_must_fail git tag -d mytag'
+test_expect_success 'trying to delete an already deleted tag should fail' '
+	silent test_must_fail git tag -d mytag
+'
 
 # listing various tags with pattern matching:
 
-cat >expect <<EOF
-a1
-aa1
-cba
-t210
-t211
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-EOF
 test_expect_success 'listing all tags should print them ordered' '
+	cat >expect <<-EOF &&
+		a1
+		aa1
+		cba
+		t210
+		t211
+		v0.2.1
+		v1.0
+		v1.0.1
+		v1.1.3
+	EOF
 	git tag v1.0.1 &&
 	git tag t211 &&
 	git tag aa1 &&
@@ -173,561 +194,486 @@ test_expect_success 'listing all tags should print them ordered' '
 	git tag a1 &&
 	git tag v1.0 &&
 	git tag t210 &&
-	git tag -l > actual &&
-	test_cmp expect actual &&
-	git tag > actual &&
-	test_cmp expect actual
+	git tag -l | test_cmp expect - &&
+	git tag | test_cmp expect -
 '
 
-cat >expect <<EOF
-a1
-aa1
-cba
-EOF
-test_expect_success \
-	'listing tags with substring as pattern must print those matching' '
-	rm *a* &&
-	git tag -l "*a*" > current &&
-	test_cmp expect current
-'
-
-cat >expect <<EOF
-v0.2.1
-v1.0.1
-EOF
-test_expect_success \
-	'listing tags with a suffix as pattern must print those matching' '
-	git tag -l "*.1" > actual &&
-	test_cmp expect actual
+test_expect_success 'listing tags with substring as pattern must print those matching' '
+	cat >expect <<-EOF &&
+		a1
+		aa1
+		cba
+	EOF
+	git tag -l "*a*" | test_cmp expect -
 '
 
-cat >expect <<EOF
-t210
-t211
-EOF
-test_expect_success \
-	'listing tags with a prefix as pattern must print those matching' '
-	git tag -l "t21*" > actual &&
-	test_cmp expect actual
+test_expect_success 'listing tags with a suffix as pattern must print those matching' '
+	cat >expect <<-EOF &&
+		v0.2.1
+		v1.0.1
+	EOF
+	git tag -l "*.1" | test_cmp expect -
 '
 
-cat >expect <<EOF
-a1
-EOF
-test_expect_success \
-	'listing tags using a name as pattern must print that one matching' '
-	git tag -l a1 > actual &&
-	test_cmp expect actual
+test_expect_success 'listing tags with a prefix as pattern must print those matching' '
+	cat >expect <<-EOF &&
+		t210
+		t211
+	EOF
+	git tag -l "t21*" | test_cmp expect -
 '
 
-cat >expect <<EOF
-v1.0
-EOF
-test_expect_success \
-	'listing tags using a name as pattern must print that one matching' '
-	git tag -l v1.0 > actual &&
-	test_cmp expect actual
+test_expect_success 'listing tags using a name as pattern must print that one matching' '
+	cat >expect <<-EOF &&
+		a1
+	EOF
+	git tag -l a1 | test_cmp expect -
 '
 
-cat >expect <<EOF
-v1.0.1
-v1.1.3
-EOF
-test_expect_success \
-	'listing tags with ? in the pattern should print those matching' '
-	git tag -l "v1.?.?" > actual &&
-	test_cmp expect actual
+test_expect_success 'listing tags using a name as pattern must print that one matching' '
+	cat >expect <<-EOF &&
+		v1.0
+	EOF
+	git tag -l v1.0 | test_cmp expect -
 '
 
->expect
-test_expect_success \
-	'listing tags using v.* should print nothing because none have v.' '
-	git tag -l "v.*" > actual &&
-	test_cmp expect actual
+test_expect_success 'listing tags with ? in the pattern should print those matching' '
+	cat >expect <<-EOF &&
+		v1.0.1
+		v1.1.3
+	EOF
+	git tag -l "v1.?.?" | test_cmp expect -
 '
 
-cat >expect <<EOF
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-EOF
-test_expect_success \
-	'listing tags using v* should print only those having v' '
-	git tag -l "v*" > actual &&
-	test_cmp expect actual
+test_expect_success 'listing tags using v.* should print nothing because none have v.' '
+	>expect &&
+	git tag -l "v.*" | test_cmp expect -
+'
+
+test_expect_success 'listing tags using v* should print only those having v' '
+	cat >expect <<-EOF &&
+		v0.2.1
+		v1.0
+		v1.0.1
+		v1.1.3
+	EOF
+	git tag -l "v*" | test_cmp expect -
 '
 
 test_expect_success 'tag -l can accept multiple patterns' '
-	git tag -l "v1*" "v0*" >actual &&
-	test_cmp expect actual
+	git tag -l "v1*" "v0*" | test_cmp expect -
 '
 
 # creating and verifying lightweight tags:
 
-test_expect_success \
-	'a non-annotated tag created without parameters should point to HEAD' '
+test_expect_success 'a non-annotated tag created without parameters should point to HEAD' '
 	git tag non-annotated-tag &&
 	test $(git cat-file -t non-annotated-tag) = commit &&
 	test $(git rev-parse non-annotated-tag) = $(git rev-parse HEAD)
 '
 
-test_expect_success 'trying to verify an unknown tag should fail' \
-	'test_must_fail git tag -v unknown-tag'
+test_expect_success 'trying to verify an unknown tag should fail' '
+	silent test_must_fail git tag -v unknown-tag
+'
 
-test_expect_success \
-	'trying to verify a non-annotated and non-signed tag should fail' \
-	'test_must_fail git tag -v non-annotated-tag'
+test_expect_success 'trying to verify a non-annotated and non-signed tag should fail' '
+	silent test_must_fail git tag -v non-annotated-tag
+'
 
-test_expect_success \
-	'trying to verify many non-annotated or unknown tags, should fail' \
-	'test_must_fail git tag -v unknown-tag1 non-annotated-tag unknown-tag2'
+test_expect_success 'trying to verify many non-annotated or unknown tags, should fail' '
+	silent test_must_fail git tag -v unknown-tag1 non-annotated-tag unknown-tag2
+'
 
 # creating annotated tags:
 
-get_tag_msg () {
-	git cat-file tag "$1" | sed -e "/BEGIN PGP/q"
-}
-
-# run test_tick before committing always gives the time in that timezone
-get_tag_header () {
-cat <<EOF
-object $2
-type $3
-tag $1
-tagger C O Mitter <committer@example.com> $4 -0700
-
-EOF
-}
-
-commit=$(git rev-parse HEAD)
-time=$test_tick
-
-get_tag_header annotated-tag $commit commit $time >expect
-echo "A message" >>expect
-test_expect_success \
-	'creating an annotated tag with -m message should succeed' '
-	git tag -m "A message" annotated-tag &&
-	get_tag_msg annotated-tag >actual &&
-	test_cmp expect actual
+test_expect_success 'creating an annotated tag with -m message should succeed' '
+	commit=$(git rev-parse HEAD) &&
+	time=$test_tick &&
+	name="annotated-tag" &&
+	msg="A message" &&
+	gen_header >expect $name $commit commit $time <<-EOF &&
+		$msg
+	EOF
+	git tag -m "$msg" $name &&
+	get_header $name | test_cmp expect -
 '
 
-cat >msgfile <<EOF
-Another message
-in a file.
-EOF
-get_tag_header file-annotated-tag $commit commit $time >expect
-cat msgfile >>expect
-test_expect_success \
-	'creating an annotated tag with -F messagefile should succeed' '
-	git tag -F msgfile file-annotated-tag &&
-	get_tag_msg file-annotated-tag >actual &&
-	test_cmp expect actual
+test_expect_success 'creating an annotated tag with -F messagefile should succeed' '
+	name="file-annotated-tag" &&
+	gen_header >expect $name $commit commit $time <<-EOF &&
+		Another message
+		in a file.
+	EOF
+	tail -n 2 expect >msgfile &&
+	git tag -F msgfile $name &&
+	get_header $name | test_cmp expect -
 '
 
-cat >inputmsg <<EOF
-A message from the
-standard input
-EOF
-get_tag_header stdin-annotated-tag $commit commit $time >expect
-cat inputmsg >>expect
 test_expect_success 'creating an annotated tag with -F - should succeed' '
-	git tag -F - stdin-annotated-tag <inputmsg &&
-	get_tag_msg stdin-annotated-tag >actual &&
-	test_cmp expect actual
+	name="stdin-annotated-tag" &&
+	gen_header >expect $name $commit commit $time <<-EOF &&
+		A message from the
+		standard input
+	EOF
+	tail -n 2 expect | git tag -F - $name &&
+	get_header $name | test_cmp expect -
 '
 
-test_expect_success \
-	'trying to create a tag with a non-existing -F file should fail' '
+test_expect_success 'trying to create a tag with a non-existing -F file should fail' '
 	! test -f nonexistingfile &&
 	! tag_exists notag &&
-	test_must_fail git tag -F nonexistingfile notag &&
+	silent test_must_fail git tag -F nonexistingfile notag &&
 	! tag_exists notag
 '
 
-test_expect_success \
-	'trying to create tags giving both -m or -F options should fail' '
-	echo "message file 1" >msgfile1 &&
-	echo "message file 2" >msgfile2 &&
+test_expect_success 'trying to create tags giving both -m or -F options should fail' '
+	echo >msgfile1 "message file 1" &&
+	echo >msgfile2 "message file 2" &&
 	! tag_exists msgtag &&
-	test_must_fail git tag -m "message 1" -F msgfile1 msgtag &&
+	silent test_must_fail git tag -m "message 1" -F msgfile1 msgtag &&
 	! tag_exists msgtag &&
-	test_must_fail git tag -F msgfile1 -m "message 1" msgtag &&
+	silent test_must_fail git tag -F msgfile1 -m "message 1" msgtag &&
 	! tag_exists msgtag &&
-	test_must_fail git tag -m "message 1" -F msgfile1 \
+	silent test_must_fail git tag -m "message 1" -F msgfile1 \
 		-m "message 2" msgtag &&
 	! tag_exists msgtag
 '
 
 # blank and empty messages:
 
-get_tag_header empty-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with an empty -m message should succeed' '
-	git tag -m "" empty-annotated-tag &&
-	get_tag_msg empty-annotated-tag >actual &&
-	test_cmp expect actual
+test_expect_success 'creating a tag with an empty -m message should succeed' '
+	name="empty-annotated-tag" &&
+	gen_header >expect $name $commit commit $time </dev/null &&
+	git tag -m "" $name &&
+	get_header $name | test_cmp expect -
 '
 
->emptyfile
-get_tag_header emptyfile-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with an empty -F messagefile should succeed' '
-	git tag -F emptyfile emptyfile-annotated-tag &&
-	get_tag_msg emptyfile-annotated-tag >actual &&
-	test_cmp expect actual
+test_expect_success 'creating a tag with an empty -F messagefile should succeed' '
+	>emptyfile &&
+	name="emptyfile-annotated-tag" &&
+	gen_header >expect $name $commit commit $time </dev/null &&
+	git tag -F emptyfile $name &&
+	get_header $name | test_cmp expect -
 '
 
-printf '\n\n  \n\t\nLeading blank lines\n' >blanksfile
-printf '\n\t \t  \nRepeated blank lines\n' >>blanksfile
-printf '\n\n\nTrailing spaces      \t  \n' >>blanksfile
-printf '\nTrailing blank lines\n\n\t \n\n' >>blanksfile
-get_tag_header blanks-annotated-tag $commit commit $time >expect
-cat >>expect <<EOF
-Leading blank lines
+test_expect_success 'extra blanks in the message for an annotated tag should be removed' '
+	here >blanksfile <<-\EOF &&
 
-Repeated blank lines
+		\s\s
+		\t
+		Leading blank lines
 
-Trailing spaces
+		\t\s\t\s\s
+		Repeated blank lines
 
-Trailing blank lines
-EOF
-test_expect_success \
-	'extra blanks in the message for an annotated tag should be removed' '
-	git tag -F blanksfile blanks-annotated-tag &&
-	get_tag_msg blanks-annotated-tag >actual &&
-	test_cmp expect actual
+
+
+		Trailing spaces\s\s\s\s\s\s\t\s\s
+
+		Trailing blank lines
+
+		\t\s
+
+	EOF
+	name="blanks-annotated-tag" &&
+	gen_header $name $commit commit $time >expect <<-EOF &&
+		Leading blank lines
+
+		Repeated blank lines
+
+		Trailing spaces
+
+		Trailing blank lines
+	EOF
+	git tag -F blanksfile $name &&
+	get_header $name | test_cmp expect -
 '
 
-get_tag_header blank-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with blank -m message with spaces should succeed' '
-	git tag -m "     " blank-annotated-tag &&
-	get_tag_msg blank-annotated-tag >actual &&
-	test_cmp expect actual
+test_expect_success 'creating a tag with blank -m message with spaces should succeed' '
+	name="blank-annotated-tag" &&
+	gen_header $name $commit commit $time </dev/null >expect &&
+	git tag -m "     " $name &&
+	get_header $name | test_cmp expect -
 '
 
-echo '     ' >blankfile
-echo ''      >>blankfile
-echo '  '    >>blankfile
-get_tag_header blankfile-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with blank -F messagefile with spaces should succeed' '
-	git tag -F blankfile blankfile-annotated-tag &&
-	get_tag_msg blankfile-annotated-tag >actual &&
-	test_cmp expect actual
+test_expect_success 'creating a tag with blank -F messagefile with spaces should succeed' '
+	here >blankfile <<-\EOF &&
+		\s\s\s\s\s
+
+		\s\s
+	EOF
+	name="blankfile-annotated-tag" &&
+	gen_header >expect $name $commit commit $time </dev/null &&
+	git tag -F blankfile $name &&
+	get_header $name | test_cmp expect -
 '
 
-printf '      ' >blanknonlfile
-get_tag_header blanknonlfile-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with -F file of spaces and no newline should succeed' '
-	git tag -F blanknonlfile blanknonlfile-annotated-tag &&
-	get_tag_msg blanknonlfile-annotated-tag >actual &&
-	test_cmp expect actual
+test_expect_success 'creating a tag with -F file of spaces and no newline should succeed' '
+	printf >blanknonlfile "      " &&
+	name="blanknonlfile-annotated-tag" &&
+	gen_header >expect $name $commit commit $time </dev/null &&
+	git tag -F blanknonlfile $name &&
+	get_header $name | test_cmp expect -
 '
 
 # messages with commented lines:
 
-cat >commentsfile <<EOF
-# A comment
+test_expect_success 'creating a tag using a -F messagefile with #comments should succeed' '
+	cat >commentsfile <<-EOF &&
+		# A comment
 
-############
-The message.
-############
-One line.
+		############
+		The message.
+		############
+		One line.
 
 
-# commented lines
-# commented lines
+		# commented lines
+		# commented lines
 
-Another line.
-# comments
+		Another line.
+		# comments
 
-Last line.
-EOF
-get_tag_header comments-annotated-tag $commit commit $time >expect
-cat >>expect <<EOF
-The message.
-One line.
+		Last line.
+	EOF
+	name="comments-annotated-tag" &&
+	gen_header $name $commit commit $time >expect <<-EOF &&
+		The message.
+		One line.
 
-Another line.
+		Another line.
 
-Last line.
-EOF
-test_expect_success \
-	'creating a tag using a -F messagefile with #comments should succeed' '
-	git tag -F commentsfile comments-annotated-tag &&
-	get_tag_msg comments-annotated-tag >actual &&
-	test_cmp expect actual
+		Last line.
+	EOF
+	git tag -F commentsfile $name &&
+	get_header $name | test_cmp expect -
 '
 
-get_tag_header comment-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with a #comment in the -m message should succeed' '
-	git tag -m "#comment" comment-annotated-tag &&
-	get_tag_msg comment-annotated-tag >actual &&
-	test_cmp expect actual
+test_expect_success 'creating a tag with a #comment in the -m message should succeed' '
+	name="comment-annotated-tag" &&
+	gen_header $name $commit commit $time >expect </dev/null &&
+	git tag -m "#comment" $name &&
+	get_header $name | test_cmp expect -
 '
 
-echo '#comment' >commentfile
-echo ''         >>commentfile
-echo '####'     >>commentfile
-get_tag_header commentfile-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with #comments in the -F messagefile should succeed' '
-	git tag -F commentfile commentfile-annotated-tag &&
-	get_tag_msg commentfile-annotated-tag >actual &&
-	test_cmp expect actual
+test_expect_success 'creating a tag with #comments in the -F messagefile should succeed' '
+	cat >commentfile <<-EOF &&
+		#comment
+
+		####
+	EOF
+	name="commentfile-annotated-tag" &&
+	gen_header $name $commit commit $time >expect </dev/null &&
+	git tag -F commentfile $name &&
+	get_header $name | test_cmp expect -
 '
 
-printf '#comment' >commentnonlfile
-get_tag_header commentnonlfile-annotated-tag $commit commit $time >expect
-test_expect_success \
-	'creating a tag with a file of #comment and no newline should succeed' '
-	git tag -F commentnonlfile commentnonlfile-annotated-tag &&
-	get_tag_msg commentnonlfile-annotated-tag >actual &&
-	test_cmp expect actual
+test_expect_success 'creating a tag with a file of #comment and no newline should succeed' '
+	printf >commentnonlfile "#comment" &&
+	name="commentnonlfile-annotated-tag" &&
+	gen_header >expect $name $commit commit $time </dev/null &&
+	git tag -F commentnonlfile $name &&
+	get_header $name | test_cmp expect -
 '
 
 # listing messages for annotated non-signed tags:
 
-test_expect_success \
-	'listing the one-line message of a non-signed tag should succeed' '
+test_expect_success 'listing the one-line message of a non-signed tag should succeed' '
 	git tag -m "A msg" tag-one-line &&
 
-	echo "tag-one-line" >expect &&
-	git tag -l | grep "^tag-one-line" >actual &&
-	test_cmp expect actual &&
-	git tag -n0 -l | grep "^tag-one-line" >actual &&
-	test_cmp expect actual &&
-	git tag -n0 -l tag-one-line >actual &&
-	test_cmp expect actual &&
-
-	echo "tag-one-line    A msg" >expect &&
-	git tag -n1 -l | grep "^tag-one-line" >actual &&
-	test_cmp expect actual &&
-	git tag -n -l | grep "^tag-one-line" >actual &&
-	test_cmp expect actual &&
-	git tag -n1 -l tag-one-line >actual &&
-	test_cmp expect actual &&
-	git tag -n2 -l tag-one-line >actual &&
-	test_cmp expect actual &&
-	git tag -n999 -l tag-one-line >actual &&
-	test_cmp expect actual
+	echo >expect "tag-one-line" &&
+	git tag -l | grep "^tag-one-line" | test_cmp expect - &&
+	git tag -n0 -l | grep "^tag-one-line" | test_cmp expect - &&
+	git tag -n0 -l tag-one-line | test_cmp expect - &&
+
+	echo >expect "tag-one-line    A msg" &&
+	git tag -n1 -l | grep "^tag-one-line" | test_cmp expect - &&
+	git tag -n -l | grep "^tag-one-line" | test_cmp expect - &&
+	git tag -n1 -l tag-one-line | test_cmp expect - &&
+	git tag -n2 -l tag-one-line | test_cmp expect - &&
+	git tag -n999 -l tag-one-line | test_cmp expect -
 '
 
-test_expect_success \
-	'listing the zero-lines message of a non-signed tag should succeed' '
+test_expect_success 'listing the zero-lines message of a non-signed tag should succeed' '
 	git tag -m "" tag-zero-lines &&
 
-	echo "tag-zero-lines" >expect &&
-	git tag -l | grep "^tag-zero-lines" >actual &&
-	test_cmp expect actual &&
-	git tag -n0 -l | grep "^tag-zero-lines" >actual &&
-	test_cmp expect actual &&
-	git tag -n0 -l tag-zero-lines >actual &&
-	test_cmp expect actual &&
-
-	echo "tag-zero-lines  " >expect &&
-	git tag -n1 -l | grep "^tag-zero-lines" >actual &&
-	test_cmp expect actual &&
-	git tag -n -l | grep "^tag-zero-lines" >actual &&
-	test_cmp expect actual &&
-	git tag -n1 -l tag-zero-lines >actual &&
-	test_cmp expect actual &&
-	git tag -n2 -l tag-zero-lines >actual &&
-	test_cmp expect actual &&
-	git tag -n999 -l tag-zero-lines >actual &&
-	test_cmp expect actual
+	echo >expect "tag-zero-lines" &&
+	git tag -l | grep "^tag-zero-lines" | test_cmp expect - &&
+	git tag -n0 -l | grep "^tag-zero-lines" | test_cmp expect - &&
+	git tag -n0 -l tag-zero-lines | test_cmp expect - &&
+
+	echo >expect "tag-zero-lines  " &&
+	git tag -n1 -l | grep "^tag-zero-lines" | test_cmp expect - &&
+	git tag -n -l | grep "^tag-zero-lines" | test_cmp expect - &&
+	git tag -n1 -l tag-zero-lines | test_cmp expect - &&
+	git tag -n2 -l tag-zero-lines | test_cmp expect - &&
+	git tag -n999 -l tag-zero-lines | test_cmp expect -
 '
 
-echo 'tag line one' >annotagmsg
-echo 'tag line two' >>annotagmsg
-echo 'tag line three' >>annotagmsg
-test_expect_success \
-	'listing many message lines of a non-signed tag should succeed' '
+test_expect_success 'listing many message lines of a non-signed tag should succeed' '
+	cat >annotagmsg <<-EOF &&
+		tag line one
+		tag line two
+		tag line three
+	EOF
 	git tag -F annotagmsg tag-lines &&
-
 	echo "tag-lines" >expect &&
-	git tag -l | grep "^tag-lines" >actual &&
-	test_cmp expect actual &&
-	git tag -n0 -l | grep "^tag-lines" >actual &&
-	test_cmp expect actual &&
-	git tag -n0 -l tag-lines >actual &&
-	test_cmp expect actual &&
+	git tag -l | grep "^tag-lines" | test_cmp expect - &&
+	git tag -n0 -l | grep "^tag-lines" | test_cmp expect - &&
+	git tag -n0 -l tag-lines | test_cmp expect - &&
 
 	echo "tag-lines       tag line one" >expect &&
-	git tag -n1 -l | grep "^tag-lines" >actual &&
-	test_cmp expect actual &&
-	git tag -n -l | grep "^tag-lines" >actual &&
-	test_cmp expect actual &&
-	git tag -n1 -l tag-lines >actual &&
-	test_cmp expect actual &&
+	git tag -n1 -l | grep "^tag-lines" | test_cmp expect - &&
+	git tag -n -l | grep "^tag-lines" | test_cmp expect - &&
+	git tag -n1 -l tag-lines | test_cmp expect - &&
 
 	echo "    tag line two" >>expect &&
-	git tag -n2 -l | grep "^ *tag.line" >actual &&
-	test_cmp expect actual &&
-	git tag -n2 -l tag-lines >actual &&
-	test_cmp expect actual &&
+	git tag -n2 -l | grep "^.*tag.line" | test_cmp expect - &&
+	git tag -n2 -l tag-lines | test_cmp expect - &&
 
 	echo "    tag line three" >>expect &&
-	git tag -n3 -l | grep "^ *tag.line" >actual &&
-	test_cmp expect actual &&
-	git tag -n3 -l tag-lines >actual &&
-	test_cmp expect actual &&
-	git tag -n4 -l | grep "^ *tag.line" >actual &&
-	test_cmp expect actual &&
-	git tag -n4 -l tag-lines >actual &&
-	test_cmp expect actual &&
-	git tag -n99 -l | grep "^ *tag.line" >actual &&
-	test_cmp expect actual &&
-	git tag -n99 -l tag-lines >actual &&
-	test_cmp expect actual
+	git tag -n3 -l | grep "^.*tag.line" | test_cmp expect - &&
+	git tag -n3 -l tag-lines | test_cmp expect - &&
+	git tag -n4 -l | grep "^.*tag.line" | test_cmp expect - &&
+	git tag -n4 -l tag-lines | test_cmp expect - &&
+	git tag -n99 -l | grep "^.*tag.line" | test_cmp expect - &&
+	git tag -n99 -l tag-lines | test_cmp expect -
 '
 
 test_expect_success 'annotations for blobs are empty' '
-	blob=$(git hash-object -w --stdin <<-\EOF
-	Blob paragraph 1.
+	blob=$(git hash-object -w --stdin <<-EOF
+		Blob paragraph 1.
 
-	Blob paragraph 2.
+		Blob paragraph 2.
 	EOF
 	) &&
 	git tag tag-blob $blob &&
-	echo "tag-blob        " >expect &&
-	git tag -n1 -l tag-blob >actual &&
-	test_cmp expect actual
+	echo >expect "tag-blob        " &&
+	git tag -n1 -l tag-blob | test_cmp expect -
 '
 
 # trying to verify annotated non-signed tags:
 
-test_expect_success GPG \
-	'trying to verify an annotated non-signed tag should fail' '
+test_expect_success GPG 'trying to verify an annotated non-signed tag should fail' '
 	tag_exists annotated-tag &&
-	test_must_fail git tag -v annotated-tag
+	silent test_must_fail git tag -v annotated-tag
 '
 
-test_expect_success GPG \
-	'trying to verify a file-annotated non-signed tag should fail' '
+test_expect_success GPG 'trying to verify a file-annotated non-signed tag should fail' '
 	tag_exists file-annotated-tag &&
-	test_must_fail git tag -v file-annotated-tag
+	silent test_must_fail git tag -v file-annotated-tag
 '
 
-test_expect_success GPG \
-	'trying to verify two annotated non-signed tags should fail' '
+test_expect_success GPG 'trying to verify two annotated non-signed tags should fail' '
 	tag_exists annotated-tag file-annotated-tag &&
-	test_must_fail git tag -v annotated-tag file-annotated-tag
+	silent test_must_fail git tag -v annotated-tag file-annotated-tag
 '
 
 # creating and verifying signed tags:
 
-get_tag_header signed-tag $commit commit $time >expect
-echo 'A signed tag message' >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG 'creating a signed tag with -m message should succeed' '
-	git tag -s -m "A signed tag message" signed-tag &&
-	get_tag_msg signed-tag >actual &&
-	test_cmp expect actual
+	name="signed-tag" &&
+	msg="A signed tag message" &&
+	gen_header >expect $name $commit commit $time <<-EOF &&
+		$msg
+		-----BEGIN PGP SIGNATURE-----
+	EOF
+	git tag -s -m "$msg" $name &&
+	get_header $name | test_cmp expect -
 '
 
-get_tag_header u-signed-tag $commit commit $time >expect
-echo 'Another message' >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG 'sign with a given key id' '
-
-	git tag -u committer@example.com -m "Another message" u-signed-tag &&
-	get_tag_msg u-signed-tag >actual &&
-	test_cmp expect actual
-
+	name="u-signed-tag" &&
+	msg="Another message" &&
+	gen_header >expect $name $commit commit $time <<-EOF &&
+		$msg
+		-----BEGIN PGP SIGNATURE-----
+	EOF
+	git tag -u committer@example.com -m "$msg" $name &&
+	get_header $name | test_cmp expect -
 '
 
 test_expect_success GPG 'sign with an unknown id (1)' '
-
-	test_must_fail git tag -u author@example.com \
+	silent test_must_fail git tag -u author@example.com \
 		-m "Another message" o-signed-tag
-
 '
 
 test_expect_success GPG 'sign with an unknown id (2)' '
-
-	test_must_fail git tag -u DEADBEEF -m "Another message" o-signed-tag
-
+	silent test_must_fail git tag -u DEADBEEF -m "Another message" o-signed-tag
 '
 
-cat >fakeeditor <<'EOF'
-#!/bin/sh
-test -n "$1" && exec >"$1"
-echo A signed tag message
-echo from a fake editor.
-EOF
-chmod +x fakeeditor
-
-get_tag_header implied-sign $commit commit $time >expect
-./fakeeditor >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG '-u implies signed tag' '
-	GIT_EDITOR=./fakeeditor git tag -u CDDE430D implied-sign &&
-	get_tag_msg implied-sign >actual &&
-	test_cmp expect actual
+	cat <<-\EOF | write_script fakeeditor &&
+		test -n "$1" && exec >"$1"
+		echo A signed tag message
+		echo from a fake editor.
+	EOF
+	name="implied-signed" &&
+	gen_header >expect $name $commit commit $time <<-EOF &&
+		A signed tag message
+		from a fake editor.
+		-----BEGIN PGP SIGNATURE-----
+	EOF
+	GIT_EDITOR=./fakeeditor git tag -u CDDE430D $name &&
+	get_header $name | test_cmp expect -
 '
 
-cat >sigmsgfile <<EOF
-Another signed tag
-message in a file.
-EOF
-get_tag_header file-signed-tag $commit commit $time >expect
-cat sigmsgfile >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with -F messagefile should succeed' '
-	git tag -s -F sigmsgfile file-signed-tag &&
-	get_tag_msg file-signed-tag >actual &&
-	test_cmp expect actual
+test_expect_success GPG 'creating a signed tag with -F messagefile should succeed' '
+	name="file-signed-tag" &&
+	gen_header >expect $name $commit commit $time <<-EOF &&
+		Another signed tag
+		message in a file.
+		-----BEGIN PGP SIGNATURE-----
+	EOF
+	tail -n 3 expect | head -n 2 >sigmsgfile
+	git tag -s -F sigmsgfile $name &&
+	get_header $name | test_cmp expect -
 '
 
-cat >siginputmsg <<EOF
-A signed tag message from
-the standard input
-EOF
-get_tag_header stdin-signed-tag $commit commit $time >expect
-cat siginputmsg >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG 'creating a signed tag with -F - should succeed' '
-	git tag -s -F - stdin-signed-tag <siginputmsg &&
-	get_tag_msg stdin-signed-tag >actual &&
-	test_cmp expect actual
+	name="stdin-signed-tag" &&
+	gen_header >expect $name $commit commit $time <<-EOF &&
+		A signed tag message from
+		the standard input
+		-----BEGIN PGP SIGNATURE-----
+	EOF
+	tail -n 3 expect | head -n 2 | git tag -s -F - $name &&
+	get_header $name | test_cmp expect -
 '
 
-get_tag_header implied-annotate $commit commit $time >expect
-./fakeeditor >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG '-s implies annotated tag' '
-	GIT_EDITOR=./fakeeditor git tag -s implied-annotate &&
-	get_tag_msg implied-annotate >actual &&
-	test_cmp expect actual
+	name="implied-signed-tag" &&
+	gen_header >expect $name $commit commit $time <<-EOF &&
+		A signed tag message
+		from a fake editor.
+		-----BEGIN PGP SIGNATURE-----
+	EOF
+	GIT_EDITOR=./fakeeditor git tag -s $name &&
+	get_header $name | test_cmp expect -
 '
 
-test_expect_success GPG \
-	'trying to create a signed tag with non-existing -F file should fail' '
+test_expect_success GPG 'trying to create a signed tag with non-existing -F file should fail' '
 	! test -f nonexistingfile &&
 	! tag_exists nosigtag &&
-	test_must_fail git tag -s -F nonexistingfile nosigtag &&
+	silent test_must_fail git tag -s -F nonexistingfile nosigtag &&
 	! tag_exists nosigtag
 '
 
-test_expect_success GPG 'verifying a signed tag should succeed' \
-	'git tag -v signed-tag'
+test_expect_success GPG 'verifying a signed tag should succeed' '
+	silent git tag -v signed-tag
+'
 
-test_expect_success GPG 'verifying two signed tags in one command should succeed' \
-	'git tag -v signed-tag file-signed-tag'
+test_expect_success GPG 'verifying two signed tags in one command should succeed' '
+	silent git tag -v signed-tag file-signed-tag
+'
 
-test_expect_success GPG \
-	'verifying many signed and non-signed tags should fail' '
-	test_must_fail git tag -v signed-tag annotated-tag &&
-	test_must_fail git tag -v file-annotated-tag file-signed-tag &&
-	test_must_fail git tag -v annotated-tag \
+test_expect_success GPG 'verifying many signed and non-signed tags should fail' '
+	silent test_must_fail git tag -v signed-tag annotated-tag &&
+	silent test_must_fail git tag -v file-annotated-tag file-signed-tag &&
+	silent test_must_fail git tag -v annotated-tag \
 		file-signed-tag file-annotated-tag &&
-	test_must_fail git tag -v signed-tag annotated-tag file-signed-tag
+	silent test_must_fail git tag -v signed-tag \
+		annotated-tag file-signed-tag
 '
 
 test_expect_success GPG 'verifying a forged tag should fail' '
@@ -735,405 +681,374 @@ test_expect_success GPG 'verifying a forged tag should fail' '
 		sed -e "s/signed-tag/forged-tag/" |
 		git mktag) &&
 	git tag forged-tag $forged &&
-	test_must_fail git tag -v forged-tag
+	silent test_must_fail git tag -v forged-tag
 '
 
 # blank and empty messages for signed tags:
 
-get_tag_header empty-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with an empty -m message should succeed' '
-	git tag -s -m "" empty-signed-tag &&
-	get_tag_msg empty-signed-tag >actual &&
-	test_cmp expect actual &&
-	git tag -v empty-signed-tag
-'
-
->sigemptyfile
-get_tag_header emptyfile-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with an empty -F messagefile should succeed' '
-	git tag -s -F sigemptyfile emptyfile-signed-tag &&
-	get_tag_msg emptyfile-signed-tag >actual &&
-	test_cmp expect actual &&
-	git tag -v emptyfile-signed-tag
-'
-
-printf '\n\n  \n\t\nLeading blank lines\n' > sigblanksfile
-printf '\n\t \t  \nRepeated blank lines\n' >>sigblanksfile
-printf '\n\n\nTrailing spaces      \t  \n' >>sigblanksfile
-printf '\nTrailing blank lines\n\n\t \n\n' >>sigblanksfile
-get_tag_header blanks-signed-tag $commit commit $time >expect
-cat >>expect <<EOF
-Leading blank lines
-
-Repeated blank lines
-
-Trailing spaces
-
-Trailing blank lines
-EOF
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'extra blanks in the message for a signed tag should be removed' '
-	git tag -s -F sigblanksfile blanks-signed-tag &&
-	get_tag_msg blanks-signed-tag >actual &&
-	test_cmp expect actual &&
-	git tag -v blanks-signed-tag
-'
-
-get_tag_header blank-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with a blank -m message should succeed' '
-	git tag -s -m "     " blank-signed-tag &&
-	get_tag_msg blank-signed-tag >actual &&
-	test_cmp expect actual &&
-	git tag -v blank-signed-tag
-'
-
-echo '     ' >sigblankfile
-echo ''      >>sigblankfile
-echo '  '    >>sigblankfile
-get_tag_header blankfile-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with blank -F file with spaces should succeed' '
-	git tag -s -F sigblankfile blankfile-signed-tag &&
-	get_tag_msg blankfile-signed-tag >actual &&
-	test_cmp expect actual &&
-	git tag -v blankfile-signed-tag
-'
-
-printf '      ' >sigblanknonlfile
-get_tag_header blanknonlfile-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with spaces and no newline should succeed' '
-	git tag -s -F sigblanknonlfile blanknonlfile-signed-tag &&
-	get_tag_msg blanknonlfile-signed-tag >actual &&
-	test_cmp expect actual &&
-	git tag -v signed-tag
+test_expect_success GPG 'creating a signed tag with an empty -m message should succeed' '
+	name="empty-signed-tag" &&
+	gen_header $name $commit commit $time >expect <<-EOF &&
+		-----BEGIN PGP SIGNATURE-----
+	EOF
+	git tag -s -m "" $name &&
+	get_header $name | test_cmp expect - &&
+	silent git tag -v $name
+'
+
+test_expect_success GPG 'creating a signed tag with an empty -F messagefile should succeed' '
+	>sigemptyfile &&
+	name="emptyfile-signed-tag" &&
+	gen_header $name $commit commit $time >expect <<-EOF &&
+		-----BEGIN PGP SIGNATURE-----
+	EOF
+	git tag -s -F sigemptyfile $name &&
+	get_header $name | test_cmp expect - &&
+	silent git tag -v $name
+'
+
+test_expect_success GPG 'extra blanks in the message for a signed tag should be removed' '
+	here >sigblanksfile <<-\EOF &&
+
+		\s\s
+		\t
+		Leading blank lines
+
+		\t\s\t\s\s
+		Repeated blank lines
+
+
+
+		Trailing spaces\s\s\s\s\s\s\t\s\s
+
+		Trailing blank lines
+
+		\t\s
+
+	EOF
+	name="blanks-signed-tag" &&
+	gen_header $name $commit commit $time >expect <<-EOF &&
+		Leading blank lines
+
+		Repeated blank lines
+
+		Trailing spaces
+
+		Trailing blank lines
+		-----BEGIN PGP SIGNATURE-----
+	EOF
+	git tag -s -F sigblanksfile $name &&
+	get_header $name | test_cmp expect - &&
+	silent git tag -v $name
+'
+
+test_expect_success GPG 'creating a signed tag with a blank -m message should succeed' '
+	name="blank-signed-tag" &&
+	gen_header >expect $name $commit commit $time <<-EOF &&
+		-----BEGIN PGP SIGNATURE-----
+	EOF
+	git tag -s -m "     " $name &&
+	get_header $name | test_cmp expect - &&
+	silent git tag -v $name
+'
+
+test_expect_success GPG 'creating a signed tag with blank -F file with spaces should succeed' '
+	here >sigblankfile <<-\EOF &&
+		\s\s\s\s\s
+
+		\s\s
+	EOF
+	name="blankfile-signed-tag" &&
+	gen_header >expect $name $commit commit $time <<-EOF &&
+		-----BEGIN PGP SIGNATURE-----
+	EOF
+	git tag -s -F sigblankfile $name &&
+	get_header $name | test_cmp expect - &&
+	silent git tag -v $name
+'
+
+test_expect_success GPG 'creating a signed tag with spaces and no newline should succeed' '
+	printf >sigblanknonlfile "      " &&
+	name="blanknonlfile-signed-tag" &&
+	gen_header $name $commit commit $time >expect <<-EOF &&
+		-----BEGIN PGP SIGNATURE-----
+	EOF
+	git tag -s -F sigblanknonlfile $name &&
+	get_header $name | test_cmp expect - &&
+	silent git tag -v $name
 '
 
 # messages with commented lines for signed tags:
 
-cat >sigcommentsfile <<EOF
-# A comment
-
-############
-The message.
-############
-One line.
-
-
-# commented lines
-# commented lines
-
-Another line.
-# comments
-
-Last line.
-EOF
-get_tag_header comments-signed-tag $commit commit $time >expect
-cat >>expect <<EOF
-The message.
-One line.
-
-Another line.
-
-Last line.
-EOF
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with a -F file with #comments should succeed' '
-	git tag -s -F sigcommentsfile comments-signed-tag &&
-	get_tag_msg comments-signed-tag >actual &&
-	test_cmp expect actual &&
-	git tag -v comments-signed-tag
-'
-
-get_tag_header comment-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with #commented -m message should succeed' '
-	git tag -s -m "#comment" comment-signed-tag &&
-	get_tag_msg comment-signed-tag >actual &&
-	test_cmp expect actual &&
-	git tag -v comment-signed-tag
-'
-
-echo '#comment' >sigcommentfile
-echo ''         >>sigcommentfile
-echo '####'     >>sigcommentfile
-get_tag_header commentfile-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with #commented -F messagefile should succeed' '
-	git tag -s -F sigcommentfile commentfile-signed-tag &&
-	get_tag_msg commentfile-signed-tag >actual &&
-	test_cmp expect actual &&
-	git tag -v commentfile-signed-tag
-'
-
-printf '#comment' >sigcommentnonlfile
-get_tag_header commentnonlfile-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with a #comment and no newline should succeed' '
-	git tag -s -F sigcommentnonlfile commentnonlfile-signed-tag &&
-	get_tag_msg commentnonlfile-signed-tag >actual &&
-	test_cmp expect actual &&
-	git tag -v commentnonlfile-signed-tag
+test_expect_success GPG 'creating a signed tag with a -F file with #comments should succeed' '
+	cat >sigcommentsfile <<-EOF &&
+		# A comment
+
+		############
+		The message.
+		############
+		One line.
+
+
+		# commented lines
+		# commented lines
+
+		Another line.
+		# comments
+
+		Last line.
+	EOF
+	name="comments-signed-tag" &&
+	gen_header >expect $name $commit commit $time <<-EOF &&
+		The message.
+		One line.
+
+		Another line.
+
+		Last line.
+		-----BEGIN PGP SIGNATURE-----
+	EOF
+	git tag -s -F sigcommentsfile $name &&
+	get_header $name | test_cmp expect - &&
+	silent git tag -v $name
+'
+
+test_expect_success GPG 'creating a signed tag with #commented -m message should succeed' '
+	name="comment-signed-tag" &&
+	gen_header $name $commit commit $time >expect <<-EOF &&
+		-----BEGIN PGP SIGNATURE-----
+	EOF
+	git tag -s -m "#comment" $name &&
+	get_header $name | test_cmp expect - &&
+	silent git tag -v $name
+'
+
+test_expect_success GPG 'creating a signed tag with #commented -F messagefile should succeed' '
+	cat >sigcommentfile <<-EOF &&
+		#comment
+
+		####
+	EOF
+	name="commentfile-signed-tag" &&
+	gen_header $name $commit commit $time >expect <<-EOF &&
+		-----BEGIN PGP SIGNATURE-----
+	EOF
+	git tag -s -F sigcommentfile $name &&
+	get_header $name | test_cmp expect - &&
+	silent git tag -v $name
+'
+
+test_expect_success GPG 'creating a signed tag with a #comment and no newline should succeed' '
+	printf "#comment" >sigcommentnonlfile &&
+	name="commentnonlfile-signed-tag" &&
+	gen_header $name $commit commit $time >expect <<-EOF &&
+		-----BEGIN PGP SIGNATURE-----
+	EOF
+	git tag -s -F sigcommentnonlfile $name &&
+	get_header $name | test_cmp expect - &&
+	silent git tag -v $name
 '
 
 # listing messages for signed tags:
 
-test_expect_success GPG \
-	'listing the one-line message of a signed tag should succeed' '
+test_expect_success GPG 'listing the one-line message of a signed tag should succeed' '
 	git tag -s -m "A message line signed" stag-one-line &&
 
 	echo "stag-one-line" >expect &&
-	git tag -l | grep "^stag-one-line" >actual &&
-	test_cmp expect actual &&
-	git tag -n0 -l | grep "^stag-one-line" >actual &&
-	test_cmp expect actual &&
-	git tag -n0 -l stag-one-line >actual &&
-	test_cmp expect actual &&
+	git tag -l | grep "^stag-one-line" | test_cmp expect - &&
+	git tag -n0 -l | grep "^stag-one-line" | test_cmp expect - &&
+	git tag -n0 -l stag-one-line | test_cmp expect - &&
 
 	echo "stag-one-line   A message line signed" >expect &&
-	git tag -n1 -l | grep "^stag-one-line" >actual &&
-	test_cmp expect actual &&
-	git tag -n -l | grep "^stag-one-line" >actual &&
-	test_cmp expect actual &&
-	git tag -n1 -l stag-one-line >actual &&
-	test_cmp expect actual &&
-	git tag -n2 -l stag-one-line >actual &&
-	test_cmp expect actual &&
-	git tag -n999 -l stag-one-line >actual &&
-	test_cmp expect actual
+	git tag -n1 -l | grep "^stag-one-line" | test_cmp expect - &&
+	git tag -n -l | grep "^stag-one-line" | test_cmp expect - &&
+	git tag -n1 -l stag-one-line | test_cmp expect - &&
+	git tag -n2 -l stag-one-line | test_cmp expect - &&
+	git tag -n999 -l stag-one-line | test_cmp expect -
 '
 
-test_expect_success GPG \
-	'listing the zero-lines message of a signed tag should succeed' '
+test_expect_success GPG 'listing the zero-lines message of a signed tag should succeed' '
 	git tag -s -m "" stag-zero-lines &&
 
 	echo "stag-zero-lines" >expect &&
-	git tag -l | grep "^stag-zero-lines" >actual &&
-	test_cmp expect actual &&
-	git tag -n0 -l | grep "^stag-zero-lines" >actual &&
-	test_cmp expect actual &&
-	git tag -n0 -l stag-zero-lines >actual &&
-	test_cmp expect actual &&
+	git tag -l | grep "^stag-zero-lines" | test_cmp expect - &&
+	git tag -n0 -l | grep "^stag-zero-lines" | test_cmp expect - &&
+	git tag -n0 -l stag-zero-lines | test_cmp expect - &&
 
 	echo "stag-zero-lines " >expect &&
-	git tag -n1 -l | grep "^stag-zero-lines" >actual &&
-	test_cmp expect actual &&
-	git tag -n -l | grep "^stag-zero-lines" >actual &&
-	test_cmp expect actual &&
-	git tag -n1 -l stag-zero-lines >actual &&
-	test_cmp expect actual &&
-	git tag -n2 -l stag-zero-lines >actual &&
-	test_cmp expect actual &&
-	git tag -n999 -l stag-zero-lines >actual &&
-	test_cmp expect actual
-'
-
-echo 'stag line one' >sigtagmsg
-echo 'stag line two' >>sigtagmsg
-echo 'stag line three' >>sigtagmsg
-test_expect_success GPG \
-	'listing many message lines of a signed tag should succeed' '
+	git tag -n1 -l | grep "^stag-zero-lines" | test_cmp expect - &&
+	git tag -n -l  | grep "^stag-zero-lines" | test_cmp expect - &&
+	git tag -n1 -l stag-zero-lines | test_cmp expect - &&
+	git tag -n2 -l stag-zero-lines | test_cmp expect - &&
+	git tag -n999 -l stag-zero-lines | test_cmp expect -
+'
+
+test_expect_success GPG 'listing many message lines of a signed tag should succeed' '
+	cat >sigtagmsg <<-EOF &&
+		stag line one
+		stag line two
+		stag line three
+	EOF
 	git tag -s -F sigtagmsg stag-lines &&
 
 	echo "stag-lines" >expect &&
-	git tag -l | grep "^stag-lines" >actual &&
-	test_cmp expect actual &&
-	git tag -n0 -l | grep "^stag-lines" >actual &&
-	test_cmp expect actual &&
-	git tag -n0 -l stag-lines >actual &&
-	test_cmp expect actual &&
+	git tag -l | grep "^stag-lines" | test_cmp expect - &&
+	git tag -n0 -l | grep "^stag-lines" | test_cmp expect - &&
+	git tag -n0 -l stag-lines | test_cmp expect - &&
 
 	echo "stag-lines      stag line one" >expect &&
-	git tag -n1 -l | grep "^stag-lines" >actual &&
-	test_cmp expect actual &&
-	git tag -n -l | grep "^stag-lines" >actual &&
-	test_cmp expect actual &&
-	git tag -n1 -l stag-lines >actual &&
-	test_cmp expect actual &&
+	git tag -n1 -l | grep "^stag-lines" | test_cmp expect - &&
+	git tag -n -l | grep "^stag-lines" | test_cmp expect - &&
+	git tag -n1 -l stag-lines | test_cmp expect - &&
 
 	echo "    stag line two" >>expect &&
-	git tag -n2 -l | grep "^ *stag.line" >actual &&
-	test_cmp expect actual &&
-	git tag -n2 -l stag-lines >actual &&
-	test_cmp expect actual &&
+	git tag -n2 -l | grep "^.*stag.line" | test_cmp expect - &&
+	git tag -n2 -l stag-lines | test_cmp expect - &&
 
 	echo "    stag line three" >>expect &&
-	git tag -n3 -l | grep "^ *stag.line" >actual &&
-	test_cmp expect actual &&
-	git tag -n3 -l stag-lines >actual &&
-	test_cmp expect actual &&
-	git tag -n4 -l | grep "^ *stag.line" >actual &&
-	test_cmp expect actual &&
-	git tag -n4 -l stag-lines >actual &&
-	test_cmp expect actual &&
-	git tag -n99 -l | grep "^ *stag.line" >actual &&
-	test_cmp expect actual &&
-	git tag -n99 -l stag-lines >actual &&
-	test_cmp expect actual
-'
-
-# tags pointing to objects different from commits:
-
-tree=$(git rev-parse HEAD^{tree})
-blob=$(git rev-parse HEAD:foo)
-tag=$(git rev-parse signed-tag 2>/dev/null)
-
-get_tag_header tree-signed-tag $tree tree $time >expect
-echo "A message for a tree" >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag pointing to a tree should succeed' '
-	git tag -s -m "A message for a tree" tree-signed-tag HEAD^{tree} &&
-	get_tag_msg tree-signed-tag >actual &&
-	test_cmp expect actual
+	git tag -n3 -l | grep "^.*stag.line" | test_cmp expect - &&
+	git tag -n3 -l stag-lines | test_cmp expect - &&
+	git tag -n4 -l | grep "^.*stag.line" | test_cmp expect - &&
+	git tag -n4 -l stag-lines | test_cmp expect - &&
+	git tag -n99 -l | grep "^.*stag.line" | test_cmp expect - &&
+	git tag -n99 -l stag-lines | test_cmp expect -
+'
+
+
+test_expect_success GPG 'creating a signed tag pointing to a tree should succeed' '
+	# tags pointing to objects different from commits:
+	tree=$(git rev-parse HEAD^{tree}) &&
+	blob=$(git rev-parse HEAD:foo) &&
+	tag=$(git rev-parse signed-tag) &&
+	name="tree-signed-tag" &&
+	msg="A message for a tree" &&
+	gen_header $name $tree tree $time >expect <<-EOF &&
+		$msg
+		-----BEGIN PGP SIGNATURE-----
+	EOF
+	git tag -s -m "$msg" $name HEAD^{tree} &&
+	get_header $name | test_cmp expect -
 '
 
-get_tag_header blob-signed-tag $blob blob $time >expect
-echo "A message for a blob" >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag pointing to a blob should succeed' '
-	git tag -s -m "A message for a blob" blob-signed-tag HEAD:foo &&
-	get_tag_msg blob-signed-tag >actual &&
-	test_cmp expect actual
+test_expect_success GPG 'creating a signed tag pointing to a blob should succeed' '
+	msg="A message for a blob" &&
+	name="blob-signed-tag" &&
+	gen_header $name $blob blob $time >expect <<-EOF &&
+		$msg
+		-----BEGIN PGP SIGNATURE-----
+	EOF
+	git tag -s -m "$msg" $name HEAD:foo &&
+	get_header $name | test_cmp expect -
 '
 
-get_tag_header tag-signed-tag $tag tag $time >expect
-echo "A message for another tag" >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag pointing to another tag should succeed' '
-	git tag -s -m "A message for another tag" tag-signed-tag signed-tag &&
-	get_tag_msg tag-signed-tag >actual &&
-	test_cmp expect actual
+test_expect_success GPG 'creating a signed tag pointing to another tag should succeed' '
+	msg="A message for another tag" &&
+	name="tag-signed-tag" &&
+	gen_header $name $tag tag $time >expect <<-EOF &&
+		$msg
+		-----BEGIN PGP SIGNATURE-----
+	EOF
+	git tag -s -m "$msg" $name signed-tag &&
+	get_header $name | test_cmp expect -
 '
 
 # usage with rfc1991 signatures
-echo "rfc1991" > gpghome/gpg.conf
-get_tag_header rfc1991-signed-tag $commit commit $time >expect
-echo "RFC1991 signed tag" >>expect
-echo '-----BEGIN PGP MESSAGE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with rfc1991' '
-	git tag -s -m "RFC1991 signed tag" rfc1991-signed-tag $commit &&
-	get_tag_msg rfc1991-signed-tag >actual &&
-	test_cmp expect actual
+test_expect_success GPG 'creating a signed tag with rfc1991' '
+	echo "rfc1991" >gpghome/gpg.conf &&
+	msg="RFC1991 signed tag" &&
+	name="rfc1991-signed-tag"
+	gen_header $name $commit commit $time >expect <<-EOF &&
+		$msg
+		-----BEGIN PGP MESSAGE-----
+	EOF
+	git tag -s -m "$msg" $name $commit &&
+	get_header $name | test_cmp expect -
 '
 
-cat >fakeeditor <<'EOF'
-#!/bin/sh
-cp "$1" actual
-EOF
-chmod +x fakeeditor
-
-test_expect_success GPG \
-	'reediting a signed tag body omits signature' '
+test_expect_success GPG 'reediting a signed tag body omits signature' '
+	cat <<-\EOF | write_script fakeeditor &&
+		cp "$1" actual
+	EOF
 	echo "RFC1991 signed tag" >expect &&
-	GIT_EDITOR=./fakeeditor git tag -f -s rfc1991-signed-tag $commit &&
+	GIT_EDITOR=./fakeeditor \
+		quiet git tag -f -s rfc1991-signed-tag $commit &&
 	test_cmp expect actual
 '
 
-test_expect_success GPG \
-	'verifying rfc1991 signature' '
-	git tag -v rfc1991-signed-tag
+test_expect_success GPG 'verifying rfc1991 signature' '
+	silent git tag -v rfc1991-signed-tag
 '
 
-test_expect_success GPG \
-	'list tag with rfc1991 signature' '
+test_expect_success GPG 'list tag with rfc1991 signature' '
 	echo "rfc1991-signed-tag RFC1991 signed tag" >expect &&
-	git tag -l -n1 rfc1991-signed-tag >actual &&
-	test_cmp expect actual &&
-	git tag -l -n2 rfc1991-signed-tag >actual &&
-	test_cmp expect actual &&
-	git tag -l -n999 rfc1991-signed-tag >actual &&
-	test_cmp expect actual
+	git tag -l -n1 rfc1991-signed-tag | test_cmp expect - &&
+	git tag -l -n2 rfc1991-signed-tag | test_cmp expect - &&
+	git tag -l -n999 rfc1991-signed-tag | test_cmp expect -
 '
 
-rm -f gpghome/gpg.conf
-
-test_expect_success GPG \
-	'verifying rfc1991 signature without --rfc1991' '
-	git tag -v rfc1991-signed-tag
+test_expect_success GPG 'verifying rfc1991 signature without --rfc1991' '
+	rm -f gpghome/gpg.conf &&
+	silent git tag -v rfc1991-signed-tag
 '
 
-test_expect_success GPG \
-	'list tag with rfc1991 signature without --rfc1991' '
-	echo "rfc1991-signed-tag RFC1991 signed tag" >expect &&
-	git tag -l -n1 rfc1991-signed-tag >actual &&
-	test_cmp expect actual &&
-	git tag -l -n2 rfc1991-signed-tag >actual &&
-	test_cmp expect actual &&
-	git tag -l -n999 rfc1991-signed-tag >actual &&
-	test_cmp expect actual
+test_expect_success GPG 'list tag with rfc1991 signature without --rfc1991' '
+	echo >expect "rfc1991-signed-tag RFC1991 signed tag" &&
+	git tag -l -n1 rfc1991-signed-tag | test_cmp expect - &&
+	git tag -l -n2 rfc1991-signed-tag | test_cmp expect - &&
+	git tag -l -n999 rfc1991-signed-tag | test_cmp expect -
 '
 
-test_expect_success GPG \
-	'reediting a signed tag body omits signature' '
+test_expect_success GPG 'reediting a signed tag body omits signature' '
 	echo "RFC1991 signed tag" >expect &&
-	GIT_EDITOR=./fakeeditor git tag -f -s rfc1991-signed-tag $commit &&
+	GIT_EDITOR=./fakeeditor \
+		quiet git tag -f -s rfc1991-signed-tag $commit &&
 	test_cmp expect actual
 '
 
-# try to sign with bad user.signingkey
-git config user.signingkey BobTheMouse
-test_expect_success GPG \
-	'git tag -s fails if gpg is misconfigured' \
-	'test_must_fail git tag -s -m tail tag-gpg-failure'
-git config --unset user.signingkey
-
-# try to verify without gpg:
+test_expect_success GPG 'git tag -s fails if gpg is misconfigured' '
+	# try to sign with bad user.signingkey
+	git config user.signingkey BobTheMouse &&
+	silent test_must_fail git tag -s -m tail tag-gpg-failure &&
+	git config --unset user.signingkey
+'
 
-rm -rf gpghome
-test_expect_success GPG \
-	'verify signed tag fails when public key is not present' \
-	'test_must_fail git tag -v signed-tag'
+test_expect_success GPG 'verify signed tag fails when public key is not present' '
+	# try to verify without gpg:
+	rm -rf gpghome &&
+	silent test_must_fail git tag -v signed-tag
+'
 
-test_expect_success \
-	'git tag -a fails if tag annotation is empty' '
-	! (GIT_EDITOR=cat git tag -a initial-comment)
+test_expect_success 'git tag -a fails if tag annotation is empty' '
+	! (GIT_EDITOR=cat silent git tag -a initial-comment)
 '
 
-test_expect_success \
-	'message in editor has initial comment' '
-	! (GIT_EDITOR=cat git tag -a initial-comment > actual)
+test_expect_success 'message in editor has initial comment' '
+	! (GIT_EDITOR=cat git tag -a initial-comment >actual 2>/dev/null)
 '
 
 test_expect_success 'message in editor has initial comment: first line' '
 	# check the first line --- should be empty
 	echo >first.expect &&
-	sed -e 1q <actual >first.actual &&
+	sed -e 1q actual >first.actual &&
 	test_i18ncmp first.expect first.actual
 '
 
-test_expect_success \
-	'message in editor has initial comment: remainder' '
+test_expect_success 'message in editor has initial comment: remainder' '
 	# remove commented lines from the remainder -- should be empty
 	>rest.expect
 	sed -e 1d -e '/^#/d' <actual >rest.actual &&
 	test_cmp rest.expect rest.actual
 '
 
-get_tag_header reuse $commit commit $time >expect
-echo "An annotation to be reused" >> expect
-test_expect_success \
-	'overwriting an annoted tag should use its previous body' '
-	git tag -a -m "An annotation to be reused" reuse &&
-	GIT_EDITOR=true git tag -f -a reuse &&
-	get_tag_msg reuse >actual &&
-	test_cmp expect actual
+test_expect_success 'overwriting an annoted tag should use its previous body' '
+	name="reuse" &&
+	msg="An annotation to be reused" &&
+	gen_header $name $commit commit $time >expect <<-EOF &&
+		reuse
+	EOF
+	git tag -a -m "$msg" $name &&
+	GIT_EDITOR=true git tag -f -a -m "reuse" $name &&
+	get_header $name | test_cmp expect -
 '
 
 test_expect_success 'filename for the message is relative to cwd' '
@@ -1144,7 +1059,7 @@ test_expect_success 'filename for the message is relative to cwd' '
 		cd subdir &&
 		git tag -a -F msgfile-5 tag-from-subdir
 	) &&
-	git cat-file tag tag-from-subdir | grep "in sub directory"
+	git cat-file tag tag-from-subdir | grep -q "in sub directory"
 '
 
 test_expect_success 'filename for the message is relative to cwd' '
@@ -1153,172 +1068,143 @@ test_expect_success 'filename for the message is relative to cwd' '
 		cd subdir &&
 		git tag -a -F msgfile-6 tag-from-subdir-2
 	) &&
-	git cat-file tag tag-from-subdir-2 | grep "in sub directory"
+	git cat-file tag tag-from-subdir-2 | grep -q "in sub directory"
 '
 
-# create a few more commits to test --contains
-
-hash1=$(git rev-parse HEAD)
-
 test_expect_success 'creating second commit and tag' '
+	# create a few more commits to test --contains
+	hash1=$(git rev-parse HEAD) &&
 	echo foo-2.0 >foo &&
 	git add foo &&
-	git commit -m second &&
+	git commit -q -m second &&
+	hash2=$(git rev-parse HEAD) &&
 	git tag v2.0
 '
 
-hash2=$(git rev-parse HEAD)
-
 test_expect_success 'creating third commit without tag' '
 	echo foo-dev >foo &&
 	git add foo &&
-	git commit -m third
+	git commit -q -m third &&
+	hash3=$(git rev-parse HEAD)
+'
+
+test_expect_success 'checking that first commit is in all tags (hash)' '
+	# simple linear checks of --contains
+	cat >expect <<-EOF &&
+		v0.2.1
+		v1.0
+		v1.0.1
+		v1.1.3
+		v2.0
+	EOF
+	git tag -l --contains $hash1 v* | test_cmp expect -
 '
 
-hash3=$(git rev-parse HEAD)
-
-# simple linear checks of --continue
-
-cat > expected <<EOF
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-v2.0
-EOF
-
-test_expect_success 'checking that first commit is in all tags (hash)' "
-	git tag -l --contains $hash1 v* >actual &&
-	test_cmp expected actual
-"
-
-# other ways of specifying the commit
-test_expect_success 'checking that first commit is in all tags (tag)' "
-	git tag -l --contains v1.0 v* >actual &&
-	test_cmp expected actual
-"
-
-test_expect_success 'checking that first commit is in all tags (relative)' "
-	git tag -l --contains HEAD~2 v* >actual &&
-	test_cmp expected actual
-"
-
-cat > expected <<EOF
-v2.0
-EOF
-
-test_expect_success 'checking that second commit only has one tag' "
-	git tag -l --contains $hash2 v* >actual &&
-	test_cmp expected actual
-"
+test_expect_success 'checking that first commit is in all tags (tag)' '
+	# other ways of specifying the commit
+	git tag -l --contains v1.0 v* | test_cmp expect -
+'
 
+test_expect_success 'checking that first commit is in all tags (relative)' '
+	git tag -l --contains HEAD~2 v* | test_cmp expect -
+'
 
-cat > expected <<EOF
-EOF
+test_expect_success 'checking that second commit only has one tag' '
+	cat >expect <<-EOF &&
+		v2.0
+	EOF
+	git tag -l --contains $hash2 v* | test_cmp expect -
+'
 
-test_expect_success 'checking that third commit has no tags' "
-	git tag -l --contains $hash3 v* >actual &&
-	test_cmp expected actual
-"
+test_expect_success 'checking that third commit has no tags' '
+	>expect
+	git tag -l --contains $hash3 v* | test_cmp expect -
+'
 
 # how about a simple merge?
 
 test_expect_success 'creating simple branch' '
 	git branch stable v2.0 &&
-        git checkout stable &&
-	echo foo-3.0 > foo &&
-	git commit foo -m fourth &&
+	git checkout -q stable &&
+	echo foo-3.0 >foo &&
+	git commit -q foo -m fourth &&
+	hash4=$(git rev-parse HEAD) &&
 	git tag v3.0
 '
 
-hash4=$(git rev-parse HEAD)
-
-cat > expected <<EOF
-v3.0
-EOF
-
-test_expect_success 'checking that branch head only has one tag' "
-	git tag -l --contains $hash4 v* >actual &&
-	test_cmp expected actual
-"
+test_expect_success 'checking that branch head only has one tag' '
+	cat >expect <<-EOF &&
+		v3.0
+	EOF
+	git tag -l --contains $hash4 v* | test_cmp expect -
+'
 
 test_expect_success 'merging original branch into this branch' '
-	git merge --strategy=ours master &&
+	git merge -q --strategy=ours master &&
         git tag v4.0
 '
 
-cat > expected <<EOF
-v4.0
-EOF
-
-test_expect_success 'checking that original branch head has one tag now' "
-	git tag -l --contains $hash3 v* >actual &&
-	test_cmp expected actual
-"
-
-cat > expected <<EOF
-v0.2.1
-v1.0
-v1.0.1
-v1.1.3
-v2.0
-v3.0
-v4.0
-EOF
-
-test_expect_success 'checking that initial commit is in all tags' "
-	git tag -l --contains $hash1 v* >actual &&
-	test_cmp expected actual
-"
+test_expect_success 'checking that original branch head has one tag now' '
+	cat >expect <<-EOF &&
+		v4.0
+	EOF
+	git tag -l --contains $hash3 v* | test_cmp expect -
+'
+
+test_expect_success 'checking that initial commit is in all tags' '
+	cat >expect <<-EOF &&
+		v0.2.1
+		v1.0
+		v1.0.1
+		v1.1.3
+		v2.0
+		v3.0
+		v4.0
+	EOF
+	git tag -l --contains $hash1 v* | test_cmp expect -
+'
 
-# mixing modes and options:
 
 test_expect_success 'mixing incompatibles modes and options is forbidden' '
-	test_must_fail git tag -a &&
-	test_must_fail git tag -l -v &&
-	test_must_fail git tag -n 100 &&
-	test_must_fail git tag -l -m msg &&
-	test_must_fail git tag -l -F some file &&
-	test_must_fail git tag -v -s
+	# mixing modes and options:
+	silent test_must_fail git tag -a &&
+	silent test_must_fail git tag -l -v &&
+	silent test_must_fail git tag -n 100 &&
+	silent test_must_fail git tag -l -m msg &&
+	silent test_must_fail git tag -l -F some file &&
+	silent test_must_fail git tag -v -s &&
+	silent test_must_fail git tag --points-at=v4.0 foo
 '
 
 # check points-at
 
-test_expect_success '--points-at cannot be used in non-list mode' '
-	test_must_fail git tag --points-at=v4.0 foo
-'
-
 test_expect_success '--points-at finds lightweight tags' '
 	echo v4.0 >expect &&
-	git tag --points-at v4.0 >actual &&
-	test_cmp expect actual
+	git tag --points-at v4.0 | test_cmp expect -
 '
 
 test_expect_success '--points-at finds annotated tags of commits' '
 	git tag -m "v4.0, annotated" annotated-v4.0 v4.0 &&
 	echo annotated-v4.0 >expect &&
-	git tag -l --points-at v4.0 "annotated*" >actual &&
-	test_cmp expect actual
+	git tag -l --points-at v4.0 "annotated*" | test_cmp expect -
 '
 
 test_expect_success '--points-at finds annotated tags of tags' '
 	git tag -m "describing the v4.0 tag object" \
 		annotated-again-v4.0 annotated-v4.0 &&
-	cat >expect <<-\EOF &&
-	annotated-again-v4.0
-	annotated-v4.0
+	cat >expect <<-EOF &&
+		annotated-again-v4.0
+		annotated-v4.0
 	EOF
-	git tag --points-at=annotated-v4.0 >actual &&
-	test_cmp expect actual
+	git tag --points-at=annotated-v4.0 | test_cmp expect -
 '
 
 test_expect_success 'multiple --points-at are OR-ed together' '
-	cat >expect <<-\EOF &&
-	v2.0
-	v3.0
+	cat >expect <<-EOF &&
+		v2.0
+		v3.0
 	EOF
-	git tag --points-at=v2.0 --points-at=v3.0 >actual &&
-	test_cmp expect actual
+	git tag --points-at=v2.0 --points-at=v3.0 | test_cmp expect -
 '
 
 test_done
-- 
1.7.8
