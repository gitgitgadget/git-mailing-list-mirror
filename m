Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CACEEB570
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 23:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245331AbjIHXLg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242771AbjIHXLd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 19:11:33 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138DE133
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 16:11:29 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:39270)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdM-006MmZ-1J; Fri, 08 Sep 2023 17:11:28 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54328 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qekdL-009u13-0g; Fri, 08 Sep 2023 17:11:27 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  8 Sep 2023 18:10:19 -0500
Message-Id: <20230908231049.2035003-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1qekdL-009u13-0g;;;mid=<20230908231049.2035003-2-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+LTVjOby0KHTZEKTR3lI9ZSCXb/K5ndBg=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 02/32] doc hash-function-transition: Replace compatObjectFormat with compatMap
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ir makes a lot of sense for the hash algorithm that determines how all
of the objects in the repostiory be an extension so that versions of
git that don't know about it won't even try.

For implementing the compatiblity maps that really is not the case.
An version of git that does not recognizes the won't care and continue
to use the repository as is.  The mapping functionality simply won't be
present.

Similarly if all of the objects are not mapped this could cause
some practical difficulties but it will not cause anything to perform
the wrong actions to the repository.  Some commands just won't work.
In the worst case all that needs to happen is for the compatibilty
maps to be rebuilt.

So let's use an option that forces unnecessary breakage of existing
tools.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 .../technical/hash-function-transition.txt       | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index 4b937480848a..10572c5794f9 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -148,14 +148,14 @@ Detailed Design
 Repository format extension
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 A SHA-256 repository uses repository format version `1` (see
-Documentation/technical/repository-version.txt) with extensions
-`objectFormat` and `compatObjectFormat`:
+Documentation/technical/repository-version.txt) with the extension
+`objectFormat`, and an optional core.compatMap configuration.
 
 	[core]
 		repositoryFormatVersion = 1
+		compatMap = on
 	[extensions]
 		objectFormat = sha256
-		compatObjectFormat = sha1
 
 The combination of setting `core.repositoryFormatVersion=1` and
 populating `extensions.*` ensures that all versions of Git later than
@@ -682,7 +682,7 @@ Some initial steps can be implemented independently of one another:
 - adding support for the PSRC field and safer object pruning
 
 The first user-visible change is the introduction of the objectFormat
-extension (without compatObjectFormat). This requires:
+extension. This requires:
 
 - teaching fsck about this mode of operation
 - using the hash function API (vtable) when computing object names
@@ -690,7 +690,7 @@ extension (without compatObjectFormat). This requires:
 - rejecting attempts to fetch from or push to an incompatible
   repository
 
-Next comes introduction of compatObjectFormat:
+Next comes introduction of compatMap:
 
 - implementing the loose-object-idx
 - translating object names between object formats
@@ -724,9 +724,9 @@ Over time projects would encourage their users to adopt the "early
 transition" and then "late transition" modes to take advantage of the
 new, more futureproof SHA-256 object names.
 
-When objectFormat and compatObjectFormat are both set, commands
-generating signatures would generate both SHA-1 and SHA-256 signatures
-by default to support both new and old users.
+When objectFormat and compatMap are both set, commands generating
+signatures would generate both SHA-1 and SHA-256 signatures by default
+to support both new and old users.
 
 In projects using SHA-256 heavily, users could be encouraged to adopt
 the "post-transition" mode to avoid accidentally making implicit use
-- 
2.41.0

