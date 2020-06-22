Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DF5C433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF5CC2076A
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="DbQCzyyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbgFVSEd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:04:33 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39994 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730275AbgFVSEa (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Jun 2020 14:04:30 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2929460A64;
        Mon, 22 Jun 2020 18:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592849069;
        bh=rGGLBfcx22IVYnzje3das6IhdM10H333AO2lxvPa2RQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=DbQCzyyXJoGEd0hEtBncPdI0pVm5puc1lIaNf7ZisO/QzTdqkVGCquVPAyTNZ1nIO
         QBb/yBwL44u9AU3oFosFraR5wpU00hGlSLuX2kDPB1jCZeNZOwsg+9R52jzKRh0RNx
         9n2qHSwHVIFCQwDuwnvgRv548tGt+Ojqqansc7GWeWNh854Be/ceY6RHS5+eSH/kNn
         X3hRsMOUE/bNeoxuaE32GhyU/5liV4/8pt5OtGeoEx0dOemtX3vARFCME92VyVKkDI
         yJC3SCBroUWRpYs+PURFzEZrzUY9x1Tu0FsodGY7NlxbgABcETewlGL1EM524eKFfr
         VLX2ZH7/obgkrz5L6L5TuwZA6UzWw8OzV7VDE11FsyLHW5rRGiq5cDVQS1QRA8mXBV
         6Ui8YEUhg++blV12eVIQLUP03AW4ob5dVYLyhVYjSXp8x3T68RF7w/8E9wawKouVKU
         tU5v6QD7ZRuNcUXlRn5lUSz1Ahb2qO/NgX5be5lbOaWWuNh1DeW
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>, Eric Wong <e@80x24.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/14] perl: make Git::IndexInfo work with SHA-256
Date:   Mon, 22 Jun 2020 18:04:13 +0000
Message-Id: <20200622180418.2418483-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200622180418.2418483-1-sandals@crustytoothpaste.net>
References: <20200619223947.947067-1-sandals@crustytoothpaste.net>
 <20200622180418.2418483-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of the Git modules, git-svn excepted, don't know anything about the
hash algorithm and mostly work.  However, when we're printing an
all-zero object ID in Git::IndexInfo, we need to know the hash length.

Since we don't want to change the API to have that information passed
in, let's query the config to find the hash algorithm and compute the
right value.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 perl/Git/IndexInfo.pm | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/perl/Git/IndexInfo.pm b/perl/Git/IndexInfo.pm
index a43108c985..2a7b4908f3 100644
--- a/perl/Git/IndexInfo.pm
+++ b/perl/Git/IndexInfo.pm
@@ -5,13 +5,15 @@ package Git::IndexInfo;
 
 sub new {
 	my ($class) = @_;
+	my $hash_algo = Git::config('extensions.objectformat') || 'sha1';
 	my ($gui, $ctx) = command_input_pipe(qw/update-index -z --index-info/);
-	bless { gui => $gui, ctx => $ctx, nr => 0}, $class;
+	bless { gui => $gui, ctx => $ctx, nr => 0, hash_algo => $hash_algo}, $class;
 }
 
 sub remove {
 	my ($self, $path) = @_;
-	if (print { $self->{gui} } '0 ', 0 x 40, "\t", $path, "\0") {
+	my $length = $self->{hash_algo} eq 'sha256' ? 64 : 40;
+	if (print { $self->{gui} } '0 ', 0 x $length, "\t", $path, "\0") {
 		return ++$self->{nr};
 	}
 	undef;
