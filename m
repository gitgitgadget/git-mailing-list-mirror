Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8824C433E0
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 20:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86BD0206F1
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 20:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qe3qUuCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389849AbgF2UzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:55:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27060 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730739AbgF2TNN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 29 Jun 2020 15:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593457991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CCxrpthey0iRHkzq3LdIBKWlZv9mqi/OUHYkFIqCGrE=;
        b=Qe3qUuCeZoV4PyW5DIO1a4q3xqWc3mqTTzLz6GFpwZmI6B1twCNrK3NYtgCOm8V5b9ZoKH
        jXx7mnGHHS1RZpyJNinfcAxr0knNIcna495j/pFPhttGj/OIsvvCQTm9T2RKrmP5VNF+fF
        Pi//3t6rXLEMKZgwZoHs26lMtwxn3OI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-6AHnuX9GPHCIvlQAFg9ncA-1; Mon, 29 Jun 2020 10:11:17 -0400
X-MC-Unique: 6AHnuX9GPHCIvlQAFg9ncA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F7F9107ACF2;
        Mon, 29 Jun 2020 14:11:16 +0000 (UTC)
Received: from optiplex-lnx.redhat.com (unknown [10.3.128.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A2DB1002397;
        Mon, 29 Jun 2020 14:11:15 +0000 (UTC)
From:   Rafael Aquini <aquini@redhat.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, carenas@gmail.com
Subject: [PATCH v2] send-email: restore --in-reply-to superseding behavior
Date:   Mon, 29 Jun 2020 10:11:04 -0400
Message-Id: <20200629141104.2522011-1-aquini@redhat.com>
In-Reply-To: <xmqqo8p85eud.fsf@gitster.c.googlers.com>
References: <xmqqo8p85eud.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git send-email --in-reply-to= fails to override In-Reply-To email headers,
if they're present in the output of format-patch, even when explicitly
told to do so by the option --no-thread, which breaks the contract of the
command line switch option, per its man page.

"
   --in-reply-to=<identifier>
       Make the first mail (or all the mails with --no-thread) appear as
       a reply to the given Message-Id, which avoids breaking threads to
       provide a new patch series.
"

This patch fixes the aformentioned issue, by bringing --in-reply-to's old
overriding behavior back.

Fixes: 256be1d3f0 (send-email: avoid duplicate In-Reply-To/References, 2018-04-17)
Signed-off-by: Rafael Aquini <aquini@redhat.com>
---
v2 changelog:
* conform to the command manual page, when send-email threading is requested

 git-send-email.perl | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index dc95656f75..36c47bae1d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1699,10 +1699,14 @@ sub process_file {
 				$xfer_encoding = $1 if not defined $xfer_encoding;
 			}
 			elsif (/^In-Reply-To: (.*)/i) {
-				$in_reply_to = $1;
+				if (!$initial_in_reply_to || $thread) {
+					$in_reply_to = $1;
+				}
 			}
 			elsif (/^References: (.*)/i) {
-				$references = $1;
+				if (!$initial_in_reply_to || $thread) {
+					$references = $1;
+				}
 			}
 			elsif (!/^Date:\s/i && /^[-A-Za-z]+:\s+\S/) {
 				push @xh, $_;
-- 
2.23.0

