Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD26C04E69
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 01:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjHJBSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 21:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHJBSo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 21:18:44 -0400
Received: from lxh-heta-043.node.capitar.com (lxh-heta-043.node.capitar.com [159.69.137.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7261610E6
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 18:18:41 -0700 (PDT)
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id ED1F734D5F
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 03:18:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id 9EA3234B16
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 03:18:39 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nwJhOnrwdqyp for <git@vger.kernel.org>;
        Thu, 10 Aug 2023 03:18:39 +0200 (CEST)
Received: from neptune.setarnet.aw (unknown [186.189.151.69])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id 9597634EEC
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 03:18:38 +0200 (CEST)
From:   Wesley Schwengle <wesleys@opperschaap.net>
To:     git@vger.kernel.org
Subject: [[PATCH v2]] Fix bug when more than one readline instance is used
Date:   Wed,  9 Aug 2023 21:18:31 -0400
Message-ID: <20230810011831.1423208-1-wesleys@opperschaap.net>
X-Mailer: git-send-email 2.42.0.rc0.26.ga73c38ecaa
In-Reply-To: <20230810004956.GA816605@coredump.intra.peff.net>
References: <20230810004956.GA816605@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=GP927dFK c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=Hb/lXKkKiutk7skFILyYNg==:17
        a=UttIx32zK-AA:10 a=VwQbUJbxAAAA:8 a=PKzvZo6CAAAA:8 a=N3miCFJ7AAAA:8
        a=TlRkSbGG0TTuMDPgWEEA:9 a=bNQ1wH-LY4IA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=q92HNjYiIAC_jH7JDaYf:22 a=V5H4rQgsk92nlYCD-KPC:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A followup[^1] for git-svn.perl on d42e4ca9f8 where this bug was solved
for git-send-email.perl

[^1]: https://lore.kernel.org/git/20230810004956.GA816605@coredump.intra.=
peff.net/T/#t

Signed-off-by: Wesley Schwengle <wesleys@opperschaap.net>
---
 git-svn.perl | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index be987e316f..93f6538d61 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -297,27 +297,18 @@ sub _req_svn {
 		{} ],
 );
=20
-package FakeTerm;
-sub new {
-	my ($class, $reason) =3D @_;
-	return bless \$reason, shift;
-}
-sub readline {
-	my $self =3D shift;
-	die "Cannot use readline on FakeTerm: $$self";
-}
 package main;
=20
-my $term;
-sub term_init {
-	$term =3D eval {
+{
+	my $term;
+	sub term_init {
+		return $term if $term;
 		require Term::ReadLine;
-		$ENV{"GIT_SVN_NOTTY"}
-			? new Term::ReadLine 'git-svn', \*STDIN, \*STDOUT
-			: new Term::ReadLine 'git-svn';
-	};
-	if ($@) {
-		$term =3D new FakeTerm "$@: going non-interactive";
+		$term =3D $ENV{"GIT_SVN_NOTTY"}
+				? new Term::ReadLine 'git-svn', \*STDIN, \*STDOUT
+				: new Term::ReadLine 'git-svn';
+		};
+		return $term;
 	}
 }
=20
--=20
2.42.0.rc0.26.ga73c38ecaa

