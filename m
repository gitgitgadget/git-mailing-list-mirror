Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29C311F437
	for <e@80x24.org>; Sat, 28 Jan 2017 20:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752074AbdA1UyF (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jan 2017 15:54:05 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:34957 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752073AbdA1UyE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2017 15:54:04 -0500
Received: from homiemail-a99.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 6836DD5948
        for <git@vger.kernel.org>; Sat, 28 Jan 2017 12:53:49 -0800 (PST)
Received: from homiemail-a99.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a99.g.dreamhost.com (Postfix) with ESMTP id 3AE72D3E06A
        for <git@vger.kernel.org>; Sat, 28 Jan 2017 12:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=from
        :date:subject:to:content-transfer-encoding:message-id:
        mime-version; s=mattmccutchen.net; bh=pgJ+v+cO1NU5hctDByJzhtGrZl
        I=; b=JzsREdL7YJ9m/jOpRdYZjByHeqKnhQlpeD+PinfKiNLd/tdH/3Bi6XvoXi
        fXMsZseErYv2prtDEIzkiV6Ym4Nncdy6r3g7y7tzUcAxN1f4gyDFiEaMqFebyMPg
        dEGdxa6UK82HuQeikwxhYytwwy5AqEnkxuPBJ0SDq/jUaTpiE=
Received: from main (c-50-177-20-184.hsd1.ma.comcast.net [50.177.20.184])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a99.g.dreamhost.com (Postfix) with ESMTPSA id DB199D3E067
        for <git@vger.kernel.org>; Sat, 28 Jan 2017 12:52:47 -0800 (PST)
From:   Matt McCutchen <matt@mattmccutchen.net>
Date:   Sat, 28 Jan 2017 15:25:48 -0500
Subject: [PATCH] t0001: don't let a default ACL interfere with the umask
 test
To:     git@vger.kernel.org
X-Mailer: Evolution 3.22.4 (3.22.4-2.fc25) 
Content-Transfer-Encoding: 7bit
Message-ID: <1485636766.2482.3.camel@mattmccutchen.net>
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "init creates a new deep directory (umask vs. shared)" test expects
the permissions of newly created files to be based on the umask, which
fails if a default ACL is inherited from the working tree for git.  So
attempt to remove a default ACL if there is one.  Same idea as
8ed0a740dd42bd0724aebed6e3b07c4ea2a2d5e8.  (I guess I'm the only one who
ever runs the test suite with a default ACL set.)

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---
 t/t0001-init.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index b8fc588..e424de5 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -258,6 +258,9 @@ test_expect_success POSIXPERM 'init creates a new deep directory (umask vs. shar
 	(
 		# Leading directories should honor umask while
 		# the repository itself should follow "shared"
+		mkdir newdir &&
+		# Remove a default ACL if possible.
+		(setfacl -k newdir 2>/dev/null || true) &&
 		umask 002 &&
 		git init --bare --shared=0660 newdir/a/b/c &&
 		test_path_is_dir newdir/a/b/c/refs &&
-- 
2.9.3


