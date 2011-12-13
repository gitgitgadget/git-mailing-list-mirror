From: mhagger@alum.mit.edu
Subject: [PATCH 5/6] Omit extra_refs except when iterating using for_each_ref()
Date: Tue, 13 Dec 2011 21:06:50 +0100
Message-ID: <1323806811-5798-6-git-send-email-mhagger@alum.mit.edu>
References: <1323806811-5798-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 21:07:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaYdF-0001PP-6U
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 21:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755693Ab1LMUHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 15:07:08 -0500
Received: from mail.berlin.jpk.com ([212.222.128.130]:37211 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755615Ab1LMUHF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 15:07:05 -0500
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RaYUW-0006aj-Ic; Tue, 13 Dec 2011 20:58:20 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323806811-5798-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187056>

From: Michael Haggerty <mhagger@alum.mit.edu>

According to Junio, the only reference iteration function that needs
to include the extra refs is for_each_ref().  So call
do_for_each_extra_ref() directly from there instead of from
do_for_each_ref().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 843c530..f52d8b5 100644
--- a/refs.c
+++ b/refs.c
@@ -730,10 +730,6 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 	struct ref_array *packed = get_packed_refs(submodule);
 	struct ref_array *loose = get_loose_refs(submodule);
 
-	retval = do_for_each_extra_ref(base, fn, trim, cb_data);
-	if (retval)
-		goto end_each;
-
 	while (p < packed->nr && l < loose->nr) {
 		struct ref_entry *entry;
 		int cmp = strcmp(packed->refs[p]->name, loose->refs[l]->name);
@@ -798,6 +794,9 @@ int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
+	int retval = do_for_each_extra_ref("", fn, 0, cb_data);
+	if (retval)
+		return retval;
 	return do_for_each_ref(NULL, "", fn, 0, 0, cb_data);
 }
 
-- 
1.7.8
