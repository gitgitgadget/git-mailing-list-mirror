Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026B7EEB570
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345265AbjIHXbC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345272AbjIHXa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:30:58 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077A22105
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:30:38 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:34378)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdJ-007Qvl-UW; Fri, 08 Sep 2023 17:11:25 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdI-009u13-Te; Fri, 08 Sep 2023 17:11:25 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:18 -0500
Message-Id: <20230908231049.2035003-1-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekdI-009u13-Te;;;mid=<20230908231049.2035003-1-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/3QLOVx/ujlrJXiqC6Y+iBSe6gzFXACJU=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 01/32] doc hash-file-transition: A map file for mapping between sha1 and sha256
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The v3 pack index file as documented has a lot of complexity making it
difficult to implement correctly.  I worked with bryan's preliminary
implementation and it took several passes to get the bugs out.

The complexity also requires multiple table look-ups to find all of
the information that is needed to translate from one kind of oid to
another.  Which can't be good for cache locality.

Even worse coming up with a new index file version requires making
changes that have the potentialy to break anything that uses the index
of a pack file.

Instead of continuing to deal with the chance of braking things
besides the oid mapping functionality, the additional complexity in
the file format, and worry if the performance would be reasonable I
stripped down the problem to it's fundamental complexity and came up
with a file format that is exactly about mapping one kind of oid to
another, and only supports two kinds of oids.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 .../technical/hash-function-transition.txt    | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index ed574810891c..4b937480848a 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -209,6 +209,46 @@ format described in linkgit:gitformat-pack[5], just like
 today. The content that is compressed and stored uses SHA-256 content
 instead of SHA-1 content.
 
+Per Pack Mapping Table
+~~~~~~~~~~~~~~~~~~~~~~
+A pack compat map file (.compat) files have the following format:
+
+HEADER:
+	4-byte signature:
+	    The signature is: {'C', 'M', 'A', 'P'}
+	1-byte version number:
+	    Git only writes or recognizes version 1.
+	1-byte First Object Id Version
+	    We infer the length of object IDs (OIDs) from this value:
+		1 => SHA-1
+		2 => SHA-256
+	1-byte Second Object Id Version
+	    We infer the length of object IDs (OIDs) from this value:
+		1 => SHA-1
+		2 => SHA-256
+	1-byte reserved (must be zero)
+	4-byte number of objects names contained in this mapping
+	1-byte length in bytes of shorted object names for the first object id.
+	       This is the shortest possible length needed to make the
+	       first object names unambigious.
+	1-byte reserved (must be zero)
+	1-byte length in bytes of shorted object names for the second object id.
+	       This is the shortest possible length needed to make the
+	       second object names unambigious.
+	1-byte reserved (must be zero)
+
+OBJECT NAME TABLES:
+	[Object name raw length + 4]*Number of object names
+	   This table is sorted by object name
+	   Each entry in the table is formated as:
+		[20 or 32 byte] Object name
+		4-byte index into the other object name table
+
+TRAILER:
+	checksum of the corresponding packfile, and
+
+	checksum of all of the above.
+
 Pack index
 ~~~~~~~~~~
 Pack index (.idx) files use a new v3 format that supports multiple
-- 
2.41.0

