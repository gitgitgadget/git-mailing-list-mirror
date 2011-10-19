From: mhagger@alum.mit.edu
Subject: [PATCH 06/12] do_for_each_ref(): correctly terminate while processesing extra_refs
Date: Wed, 19 Oct 2011 23:44:46 +0200
Message-ID: <1319060692-27216-7-git-send-email-mhagger@alum.mit.edu>
References: <1319060692-27216-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 23:45:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdxF-0000Hm-Jj
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 23:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682Ab1JSVpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 17:45:18 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:33136 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754579Ab1JSVpN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 17:45:13 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RGdqr-0004K1-Ir; Wed, 19 Oct 2011 23:39:05 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319060692-27216-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183976>

From: Michael Haggerty <mhagger@alum.mit.edu>

If the user-supplied function returns a nonzero value while processing
extra_refs, terminate without processing the rest of the list.

This probably has no practical importance, but makes the handling of
extra_refs a little bit more consistent with the handling of other
refs.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

 refs.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index ae90993..7aef76c 100644
--- a/refs.c
+++ b/refs.c
@@ -706,8 +706,11 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 
 	struct ref_array *extra = &extra_refs;
 
-	for (i = 0; i < extra->nr; i++)
+	for (i = 0; i < extra->nr; i++) {
 		retval = do_one_ref(base, fn, trim, flags, cb_data, extra->refs[i]);
+		if (retval)
+			goto end_each;
+	}
 
 	while (p < packed->nr && l < loose->nr) {
 		struct ref_entry *entry;
-- 
1.7.7
