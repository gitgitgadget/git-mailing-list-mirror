Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EF4C433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 19:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726D5207BC
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 19:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YkGGyySu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgHZTrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 15:47:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63177 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgHZTrC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 15:47:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 067307EC4D;
        Wed, 26 Aug 2020 15:46:56 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=zzMDb/9sIVy7yhrr/9OAREjr0
        z8=; b=YkGGyySuxUB8CihMBzZh/0Ka5EHmnCAELkhaOrMu6pEhkM8i65HssG5xV
        gMap60xD6EYrC+Fv0tZT8tUL8hYSUNkyheuHqKDqYRnq2YcaUc426zsVaj4Um2G1
        oRysNOEs6uDcW8wNEmODdn6/btjy1TJaFnJ0XJidCHPgYJNI6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=DYjSGTZJE9a06A3u7ke
        PdYRZ413idjlDD9tlCemOe6g1gBX4J0B5tpqgJl+Esg2mN+SECeXVG3awO8dEIz4
        WnHbzyNL6NWDKXWxacQQkfmv4SAHf+Jyw/yacQvt0Rts/lp0rN3YLpwcL5lMAaco
        zh3l+lCdg+K6zi+2TVlZqdqQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2E3B7EC4C;
        Wed, 26 Aug 2020 15:46:55 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B2EC7EC49;
        Wed, 26 Aug 2020 15:46:55 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 2/2] cvsexportcommit: do not run git programs in dashed form
Date:   Wed, 26 Aug 2020 12:46:50 -0700
Message-Id: <20200826194650.4031087-3-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-454-g5f859b1948
In-Reply-To: <20200826194650.4031087-1-gitster@pobox.com>
References: <xmqqd03dwe2x.fsf@gitster.c.googlers.com>
 <20200826194650.4031087-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: E559F770-E7D4-11EA-B893-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This ancient script runs "git-foo" all over the place, which is
OK for a scripted Porcelain in the Git suite, but asking "git" to
dispatch to subcommands is the usual way these days.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-cvsexportcommit.perl | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index 0ae8bce3fb..289d4bc684 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -30,7 +30,7 @@
 	# Remember where GIT_DIR is before changing to CVS checkout
 	unless ($ENV{GIT_DIR}) {
 		# No GIT_DIR set. Figure it out for ourselves
-		my $gd =3D`git-rev-parse --git-dir`;
+		my $gd =3D`git rev-parse --git-dir`;
 		chomp($gd);
 		$ENV{GIT_DIR} =3D $gd;
 	}
@@ -66,7 +66,7 @@
 # resolve target commit
 my $commit;
 $commit =3D pop @ARGV;
-$commit =3D safe_pipe_capture('git-rev-parse', '--verify', "$commit^0");
+$commit =3D safe_pipe_capture('git', 'rev-parse', '--verify', "$commit^0=
");
 chomp $commit;
 if ($?) {
     die "The commit reference $commit did not resolve!";
@@ -76,7 +76,7 @@
 my $parent;
 if (@ARGV) {
     $parent =3D pop @ARGV;
-    $parent =3D  safe_pipe_capture('git-rev-parse', '--verify', "$parent=
^0");
+    $parent =3D  safe_pipe_capture('git', 'rev-parse', '--verify', "$par=
ent^0");
     chomp $parent;
     if ($?) {
 	die "The parent reference did not resolve!";
@@ -84,7 +84,7 @@
 }
=20
 # find parents from the commit itself
-my @commit  =3D safe_pipe_capture('git-cat-file', 'commit', $commit);
+my @commit  =3D safe_pipe_capture('git', 'cat-file', 'commit', $commit);
 my @parents;
 my $committer;
 my $author;
@@ -162,9 +162,9 @@
 close MSG;
=20
 if ($parent eq $noparent) {
-    `git-diff-tree --binary -p --root $commit >.cvsexportcommit.diff`;# =
|| die "Cannot diff";
+    `git diff-tree --binary -p --root $commit >.cvsexportcommit.diff`;# =
|| die "Cannot diff";
 } else {
-    `git-diff-tree --binary -p $parent $commit >.cvsexportcommit.diff`;#=
 || die "Cannot diff";
+    `git diff-tree --binary -p $parent $commit >.cvsexportcommit.diff`;#=
 || die "Cannot diff";
 }
=20
 ## apply non-binary changes
@@ -178,7 +178,7 @@
 print "Checking if patch will apply\n";
=20
 my @stat;
-open APPLY, "GIT_INDEX_FILE=3D$tmpdir/index git-apply $context --summary=
 --numstat<.cvsexportcommit.diff|" || die "cannot patch";
+open APPLY, "GIT_INDEX_FILE=3D$tmpdir/index git apply $context --summary=
 --numstat<.cvsexportcommit.diff|" || die "cannot patch";
 @stat=3D<APPLY>;
 close APPLY || die "Cannot patch";
 my (@bfiles,@files,@afiles,@dfiles);
@@ -333,7 +333,7 @@
 if ($opt_W) {
     system("git checkout -q $commit^0") && die "cannot patch";
 } else {
-    `GIT_INDEX_FILE=3D$tmpdir/index git-apply $context --summary --numst=
at --apply <.cvsexportcommit.diff` || die "cannot patch";
+    `GIT_INDEX_FILE=3D$tmpdir/index git apply $context --summary --numst=
at --apply <.cvsexportcommit.diff` || die "cannot patch";
 }
=20
 print "Patch applied successfully. Adding new files and directories to C=
VS\n";
--=20
2.28.0-454-g5f859b1948

