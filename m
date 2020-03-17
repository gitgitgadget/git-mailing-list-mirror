Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD39C10F29
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 13:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51236205ED
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 13:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgCQN35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:29:57 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:35069 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgCQN35 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 09:29:57 -0400
Received: from localhost.localdomain (unknown [103.227.96.249])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 9CC33240011;
        Tue, 17 Mar 2020 13:29:43 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Jonathan Gilbert <JonathanG@iQmetrix.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH v2 2/2] git-gui: create a new namespace for chord script evaluation
Date:   Tue, 17 Mar 2020 18:59:21 +0530
Message-Id: <20200317132921.7222-3-me@yadavpratyush.com>
X-Mailer: git-send-email 2.26.0.rc1.11.g30e9940356
In-Reply-To: <20200317132921.7222-1-me@yadavpratyush.com>
References: <20200314224159.14174-1-me@yadavpratyush.com>
 <20200317132921.7222-1-me@yadavpratyush.com>
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

