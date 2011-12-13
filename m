From: mhagger@alum.mit.edu
Subject: [PATCH 3/6] Extract a function do_for_each_extra_ref()
Date: Tue, 13 Dec 2011 21:06:48 +0100
Message-ID: <1323806811-5798-4-git-send-email-mhagger@alum.mit.edu>
References: <1323806811-5798-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 21:07:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaYdE-0001PP-KJ
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 21:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755713Ab1LMUHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 15:07:06 -0500
Received: from mail.berlin.jpk.com ([212.222.128.130]:37195 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755685Ab1LMUHA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 15:07:00 -0500
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RaYUR-0006aj-Lz; Tue, 13 Dec 2011 20:58:15 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323806811-5798-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187057>

From: Michael Haggerty <mhagger@alum.mit.edu>

We want to hold the extra refs at arms length.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 6115487..268bda9 100644
--- a/refs.c
+++ b/refs.c
@@ -693,17 +693,28 @@ fallback:
 	return -1;
 }
 
+static int do_for_each_extra_ref(const char *base, each_ref_fn fn,
+				 int trim, int flags, void *cb_data)
+{
+	int i;
+	for (i = 0; i < extra_refs.nr; i++) {
+		int retval = do_one_ref(base, fn, trim, flags, cb_data, extra_refs.refs[i]);
+		if (retval)
+			return retval;
+	}
+	return 0;
+}
+
 static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn fn,
 			   int trim, int flags, void *cb_data)
 {
-	int retval = 0, i, p = 0, l = 0;
+	int retval = 0, p = 0, l = 0;
 	struct ref_array *packed = get_packed_refs(submodule);
 	struct ref_array *loose = get_loose_refs(submodule);
 
-	struct ref_array *extra = &extra_refs;
-
-	for (i = 0; i < extra->nr; i++)
-		retval = do_one_ref(base, fn, trim, flags, cb_data, extra->refs[i]);
+	retval = do_for_each_extra_ref(base, fn, trim, flags, cb_data);
+	if (retval)
+		goto end_each;
 
 	while (p < packed->nr && l < loose->nr) {
 		struct ref_entry *entry;
-- 
1.7.8
