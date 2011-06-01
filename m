From: Jamey Sharp <jamey@minilop.net>
Subject: [PATCHv4 1/4] Refactor for_each_ref variants to use for_each_ref_in and avoid magic numbers
Date: Tue, 31 May 2011 17:24:27 -0700
Message-ID: <1306887870-3875-1-git-send-email-jamey@minilop.net>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Josh Triplett <josh@joshtriplett.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 02:25:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRZF5-000390-3e
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 02:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932973Ab1FAAYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 20:24:51 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60235 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932647Ab1FAAYu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 20:24:50 -0400
Received: by pzk9 with SMTP id 9so2264034pzk.19
        for <git@vger.kernel.org>; Tue, 31 May 2011 17:24:49 -0700 (PDT)
Received: by 10.68.48.164 with SMTP id m4mr2600565pbn.356.1306887889456;
        Tue, 31 May 2011 17:24:49 -0700 (PDT)
Received: from oh.minilop.net (host-249-168.pubnet.pdx.edu [131.252.249.168])
        by mx.google.com with ESMTPS id c3sm489257pbk.45.2011.05.31.17.24.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 May 2011 17:24:48 -0700 (PDT)
Received: from jamey by oh.minilop.net with local (Exim 4.76)
	(envelope-from <jamey@oh.minilop.net>)
	id 1QRZEt-00011b-0X; Tue, 31 May 2011 17:24:47 -0700
X-Mailer: git-send-email 1.7.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174841>

From: Josh Triplett <josh@joshtriplett.org>

Several variants of the for_each_ref functions call do_for_each_ref with
both a fixed string prefix and the hardcoded length of that prefix.
Furthermore, for_each_ref and for_each_ref_submodule passed "refs/" but
a length of 0, which caused do_for_each_ref to ignore the "refs/".

Change do_for_each_ref to use prefixcmp instead, and change the
for_each_ref variants to call for_each_ref_in with the prefix they
actually want.

Leave the separate "trim" parameter for callers that want to require a
prefix but not strip off that prefix.

Commit by Josh Triplett and Jamey Sharp.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Jamey Sharp <jamey@minilop.net>
---
With this change the "trim" parameter always equals strlen(base), but we
use trim=0 again in a later patch in this series.

 refs.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index e3c0511..60cebe6 100644
--- a/refs.c
+++ b/refs.c
@@ -584,7 +584,7 @@ int read_ref(const char *ref, unsigned char *sha1)
 static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 		      int flags, void *cb_data, struct ref_list *entry)
 {
-	if (strncmp(base, entry->name, trim))
+	if (prefixcmp(entry->name, base))
 		return 0;
 
 	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN)) {
@@ -728,12 +728,12 @@ int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(NULL, "refs/", fn, 0, 0, cb_data);
+	return for_each_ref_in("", fn, cb_data);
 }
 
 int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(submodule, "refs/", fn, 0, 0, cb_data);
+	return for_each_ref_in_submodule(submodule, "", fn, cb_data);
 }
 
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
@@ -779,7 +779,7 @@ int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *c
 
 int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(NULL, "refs/replace/", fn, 13, 0, cb_data);
+	return for_each_ref_in("refs/replace/", fn, cb_data);
 }
 
 int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
@@ -819,7 +819,7 @@ int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
 
 int for_each_rawref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(NULL, "refs/", fn, 0,
+	return do_for_each_ref(NULL, "", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
-- 
1.7.5.3
