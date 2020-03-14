Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D5FC0044D
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 01:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5222071B
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 01:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgCOBsk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:48:40 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:35946 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgCOBsk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Mar 2020 21:48:40 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 0EDFD3A5EFD
        for <git@vger.kernel.org>; Sat, 14 Mar 2020 22:42:06 +0000 (UTC)
X-Originating-IP: 103.227.98.14
Received: from localhost.localdomain (unknown [103.227.98.14])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id A1950C0005;
        Sat, 14 Mar 2020 22:42:05 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Jonathan Gilbert <JonathanG@iQmetrix.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH v1 2/2] git-gui: create a new namespace for chord script evaluation
Date:   Sun, 15 Mar 2020 04:11:59 +0530
Message-Id: <20200314224159.14174-3-me@yadavpratyush.com>
X-Mailer: git-send-email 2.26.0.rc1.11.g30e9940356
In-Reply-To: <20200314224159.14174-1-me@yadavpratyush.com>
References: <20200314224159.14174-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Evaluating the script in the same namespace as the chord itself creates
potential for variable name collision. And in that case the script would
unknowingly use the chord's variables.

For example, say the script has a variable called 'is_completed', which
also exists in the chord's namespace. The script then calls 'eval' and
sets 'is_completed' to 1 thinking it is setting its own variable,
completely unaware of how the chord works behind the scenes. This leads
to the chord never actually executing because it sees 'is_completed' as
true and thinks it has already completed.

Avoid the potential collision by creating a separate namespace for the
script that is a child of the chord's namespace.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
 lib/chord.tcl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/chord.tcl b/lib/chord.tcl
index 7de7cba..e21e7d3 100644
--- a/lib/chord.tcl
+++ b/lib/chord.tcl
@@ -64,6 +64,7 @@ class SimpleChord {
 	field notes
 	field body
 	field is_completed
+	field eval_ns
 
 	# Constructor:
 	#   set chord [SimpleChord::new {body}]
@@ -74,6 +75,7 @@ class SimpleChord {
 		set notes [list]
 		set body $i_body
 		set is_completed 0
+		set eval_ns "[namespace qualifiers $this]::eval"
 		return $this
 	}
 
@@ -83,7 +85,7 @@ class SimpleChord {
 	#     the chord body will be evaluated. This can be used to set variable
 	#     values for the chord body to use.
 	method eval {script} {
-		namespace eval [namespace qualifiers $this] $script
+		namespace eval $eval_ns $script
 	}
 
 	# Method:
@@ -111,7 +113,7 @@ class SimpleChord {
 
 			set is_completed 1
 
-			namespace eval [namespace qualifiers $this] $body
+			namespace eval $eval_ns $body
 			delete_this
 		}
 	}
-- 
2.26.0.rc1.11.g30e9940356

