Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3D2C433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CFC120767
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="rWPa/Vwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgFVSEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:04:41 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40018 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730274AbgFVSEc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Jun 2020 14:04:32 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 69C5260A60;
        Mon, 22 Jun 2020 18:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592849071;
        bh=Vt+S52KAiVY6VU5azzrjvNMZS8DsI5yczr9HIcJcdYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=rWPa/Vwi8u04nCtqtjmLjWmznW216HoMQqFvz3bCwrin++zKa7OYohX3kj+bW9KLu
         DYtv0JhIu3dmk+OYEJa3JLO+5y72/d4TC23otfDJSErhpNXsFzfyqweCWMeFdsLFG7
         Bc3kdjeO8NuPCow8Ae+TtQsXtAe7GmuxQeenpnEQPMG7GrHqz3h4xL5PA0izYapQ0G
         9y5WFk/HapK8dKXm9WkpmLkdA7MqhSdODItFCceY++xk3OOQ5/n41/zzD0oWmVRXA9
         Q1gUJqPAj7wQTwRUhHRW0m1iJbOCbT10elEgSkvdqrtdzVEdW5vfCP4n8VwoFhGo3P
         1JEZHsDtAE6xjeSM2qpKQvASzjAjo5+yGG5t+tlxoM+A6g4ub72Bfybc/kas4Uu7BU
         56qIY+BQaRr9odX0tQsBCvRp+zSoF7jCjc5t3YRycltZ9cT7Gdxi0quzCNeOi3BEjM
         EPZDvNQP/YRzFZqpjSIv09UVYaRv1JgtwKG8MXXguCxUlPUuGTM
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>, Eric Wong <e@80x24.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/14] git-cvsimport: port to SHA-256
Date:   Mon, 22 Jun 2020 18:04:17 +0000
Message-Id: <20200622180418.2418483-14-sandals@crustytoothpaste.net>
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

Instead of calling the function is_sha1, call it is_oid and update it to
match either a SHA-1 or a SHA-256 hex object ID.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-cvsimport.perl | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 1057f389d3..7bf3c12d67 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -637,9 +637,9 @@ ()
 	return $pwd;
 }
 
-sub is_sha1 {
+sub is_oid {
 	my $s = shift;
-	return $s =~ /^[a-f0-9]{40}$/;
+	return $s =~ /^[a-f0-9]{40}(?:[a-f0-9]{24})?$/;
 }
 
 sub get_headref ($) {
@@ -810,7 +810,7 @@ ()
 	open(my $fh, '-|', qw(git write-tree))
 		or die "unable to open git write-tree: $!";
 	chomp(my $tree = <$fh>);
-	is_sha1($tree)
+	is_oid($tree)
 		or die "Cannot get tree id ($tree): $!";
 	close($fh)
 		or die "Error running git write-tree: $?\n";
@@ -896,7 +896,7 @@ sub commit {
 
 	print "Committed patch $patchset ($branch $commit_date)\n" if $opt_v;
 	chomp(my $cid = <$commit_read>);
-	is_sha1($cid) or die "Cannot get commit id ($cid): $!\n";
+	is_oid($cid) or die "Cannot get commit id ($cid): $!\n";
 	print "Commit ID $cid\n" if $opt_v;
 	close($commit_read);
 
