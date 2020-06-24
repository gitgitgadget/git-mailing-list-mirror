Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35565C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 19:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09E3D2080C
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 19:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmYa9++D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406273AbgFXTzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:55:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55455 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2406135AbgFXTzd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 15:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593028532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5Yq1Rn0B7eQRXre8ngBh9BoQL3NG2ewiNI++UR2imkw=;
        b=DmYa9++DnEeJG0Rn2kx5v0HgcqchKnGduYe1DqbH8AGOsi5QehfhY3IkKnpvBqpSzO6n1Q
        EeCIXkoPsDb9HVtYP4/wscl7/CjspiaRCwTbqFgD3nGIoUsPuqCxg82gbfMPExjX355CQh
        xrm6whxDfarC5HGy6SZiPLL695/UCG8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-FbX089cnO7ipb6wzH9hNzA-1; Wed, 24 Jun 2020 15:55:30 -0400
X-MC-Unique: FbX089cnO7ipb6wzH9hNzA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C93E9805EE4
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 19:55:29 +0000 (UTC)
Received: from optiplex-lnx.redhat.com (unknown [10.3.128.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C93D1008034
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 19:55:29 +0000 (UTC)
From:   Rafael Aquini <aquini@redhat.com>
To:     git@vger.kernel.org
Subject: [PATCH] send-email: restore --in-reply-to superseding behavior
Date:   Wed, 24 Jun 2020 15:55:20 -0400
Message-Id: <20200624195520.2062298-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git send-email --in-reply-to= fails to override the email headers,
if they're present in the output of format-patch, which breakes the
contract of the command line switch. This can cause an email thread to
break, if subsequent replies to a given message need to be sent after
amending fixes to a commit and re-running git format-patch to get the
incremental patch-fix posted.

Fixes: 256be1d3f0 (send-email: avoid duplicate In-Reply-To/References, 2018-04-17)
Signed-off-by: Rafael Aquini <aquini@redhat.com>
---
 git-send-email.perl | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index dc95656f75..342e00b1f3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1699,10 +1699,14 @@ sub process_file {
 				$xfer_encoding = $1 if not defined $xfer_encoding;
 			}
 			elsif (/^In-Reply-To: (.*)/i) {
-				$in_reply_to = $1;
+				if (!$initial_in_reply_to) {
+					$in_reply_to = $1;
+				}
 			}
 			elsif (/^References: (.*)/i) {
-				$references = $1;
+				if (!$initial_in_reply_to) {
+					$references = $1;
+				}
 			}
 			elsif (!/^Date:\s/i && /^[-A-Za-z]+:\s+\S/) {
 				push @xh, $_;
-- 
2.23.0

