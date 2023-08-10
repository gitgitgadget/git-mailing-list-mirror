Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6CAC0015E
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 00:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjHJAny (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 20:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHJAnx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 20:43:53 -0400
Received: from lxh-heta-043.node.capitar.com (lxh-heta-043.node.capitar.com [159.69.137.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580B21729
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 17:43:53 -0700 (PDT)
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id D4DD133B09
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 02:39:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id 80876339F8
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 02:39:59 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7wPz7XXXnto4 for <git@vger.kernel.org>;
        Thu, 10 Aug 2023 02:39:59 +0200 (CEST)
Received: from neptune.setarnet.aw (unknown [186.189.151.69])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id 85A813356F
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 02:39:58 +0200 (CEST)
From:   Wesley Schwengle <wesleys@opperschaap.net>
To:     git@vger.kernel.org
Subject: [PATCH] Fix bug when more than one readline instance is used
Date:   Wed,  9 Aug 2023 20:39:33 -0400
Message-ID: <20230810003939.1420306-1-wesleys@opperschaap.net>
X-Mailer: git-send-email 2.42.0.rc0.26.ga73c38ecaa
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=GP927dFK c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=Hb/lXKkKiutk7skFILyYNg==:17
        a=UttIx32zK-AA:10 a=N3miCFJ7AAAA:8 a=QbfZmLMmmaWp1gP5LqAA:9
        a=V5H4rQgsk92nlYCD-KPC:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following error was emitted if one issued the command

    git send-email --compose 0001-my.patch

Can't locate object method "IN" via package "FakeTerm" at
/home/wesleys/libexec/git-core/git-send-email line 997.

After added a warn in the relevant function that created the term it was
obvious what happened:

Only one Term::ReadLine::Gnu instance is allowed. at
/home/wesleys/libexec/git-core/git-send-email line 981.

When you supply no --to send-email asks you to whom you want to send the
email to. This starts a term, the first Term::ReadLine::Gnu instance.
The second time it wants to ask the user 'Send this email?
([y]es|[n]o|[e]dit|[q]uit|[a]ll):' and this causes FakeTerm to be
loaded, but it doesn't have IN/OUT methods and thus fails.

The fix is to make $term global. If git chooses to drop perl 5.8 support
and allows Perl 5.10, we could also use the state feature. Which would
solve the problem without making $term global.

More or less the same logic happens in git-svn.perl so I fixed it there
as well.

Signed-off-by: Wesley Schwengle <wesleys@opperschaap.net>
---
 git-send-email.perl | 4 +++-
 git-svn.perl        | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index affbb88509..7fdcf9084a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -971,8 +971,10 @@ sub get_patch_subject {
 	do_edit(@files);
 }
=20
+my $term;
 sub term {
-	my $term =3D eval {
+	return $term if $term;
+	$term =3D eval {
 		require Term::ReadLine;
 		$ENV{"GIT_SEND_EMAIL_NOTTY"}
 			? Term::ReadLine->new('git-send-email', \*STDIN, \*STDOUT)
diff --git a/git-svn.perl b/git-svn.perl
index be987e316f..2813551e06 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -306,10 +306,12 @@ sub readline {
 	my $self =3D shift;
 	die "Cannot use readline on FakeTerm: $$self";
 }
+
 package main;
=20
 my $term;
 sub term_init {
+	return $term if $term;
 	$term =3D eval {
 		require Term::ReadLine;
 		$ENV{"GIT_SVN_NOTTY"}
--=20
2.42.0.rc0.26.ga73c38ecaa

