From: mhagger@alum.mit.edu
Subject: [PATCH v2 06/12] do_for_each_ref(): correctly terminate while processesing extra_refs
Date: Fri, 28 Oct 2011 13:27:58 +0200
Message-ID: <1319801284-15625-7-git-send-email-mhagger@alum.mit.edu>
References: <1319801284-15625-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 13:28:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJkc5-0002WA-Cm
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 13:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755462Ab1J1L2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 07:28:15 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:54962 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297Ab1J1L2N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 07:28:13 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJkVI-0007Cx-Jh; Fri, 28 Oct 2011 13:21:40 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319801284-15625-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184366>

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
index c76d8b5..8043436 100644
--- a/refs.c
+++ b/refs.c
@@ -710,8 +710,11 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 
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
