Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41B6E202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 17:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbdGMRfn (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 13:35:43 -0400
Received: from siwi.pair.com ([209.68.5.199]:11085 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752614AbdGMRfl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 13:35:41 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 70DDC844E5;
        Thu, 13 Jul 2017 13:35:40 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C2C57844E3;
        Thu, 13 Jul 2017 13:35:39 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, ethomson@edwardthomson.com,
        jonathantanmy@google.com, jrnieder@gmail.com,
        jeffhost@microsoft.com
Subject: [PATCH v2 13/19] upload-pack: add filter-objects to protocol documentation
Date:   Thu, 13 Jul 2017 17:34:53 +0000
Message-Id: <20170713173459.3559-14-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170713173459.3559-1-git@jeffhostetler.com>
References: <20170713173459.3559-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/pack-protocol.txt         | 16 ++++++++++++++++
 Documentation/technical/protocol-capabilities.txt |  7 +++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index a349171..dce6e04 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -212,6 +212,7 @@ out of what the server said it could do with the first 'want' line.
   upload-request    =  want-list
 		       *shallow-line
 		       *1depth-request
+		       [filter-request]
 		       flush-pkt
 
   want-list         =  first-want
@@ -226,7 +227,13 @@ out of what the server said it could do with the first 'want' line.
   first-want        =  PKT-LINE("want" SP obj-id SP capability-list)
   additional-want   =  PKT-LINE("want" SP obj-id)
 
+  filter-request    =  PKT-LINE("filter-omit-all-blobs") /
+		       PKT-LINE("filter-omit-large-blobs" SP magnitude) /
+		       PKT-LINE("filter-use-sparse" SP obj-id)
+
   depth             =  1*DIGIT
+
+  magnitude         =  1*DIGIT [ "k" | "m" | "g" ]
 ----
 
 Clients MUST send all the obj-ids it wants from the reference
@@ -249,6 +256,15 @@ complete those commits. Commits whose parents are not received as a
 result are defined as shallow and marked as such in the server. This
 information is sent back to the client in the next step.
 
+The client can optionally request that pack-objects omit various
+objects from the packfile using one of several filtering techniques.
+These are intended for use with partial/narrow clone/fetch operations.
+"filter-omit-all-blobs" requests that all blobs be omitted from
+the packfile.  "filter-omit-large-blobs" requests that blobs larger
+than the requested size be omitted, unless they have a ".git*"
+special filename.  "filter-use-sparse" requests blob filtering based
+upon a sparse-checkout specification in the given blob id.
+
 Once all the 'want's and 'shallow's (and optional 'deepen') are
 transferred, clients MUST send a flush-pkt, to tell the server side
 that it is done sending the list.
diff --git a/Documentation/technical/protocol-capabilities.txt b/Documentation/technical/protocol-capabilities.txt
index 26dcc6f..7011eb3 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -309,3 +309,10 @@ to accept a signed push certificate, and asks the <nonce> to be
 included in the push certificate.  A send-pack client MUST NOT
 send a push-cert packet unless the receive-pack server advertises
 this capability.
+
+filter-objects
+--------------
+
+If the upload-pack server advertises the 'filter-objects' capability,
+fetch-pack may send "filter-*" commands to request a partial/narrow
+clone/fetch where the server omits various objects from the packfile.
-- 
2.9.3

