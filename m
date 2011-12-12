From: mhagger@alum.mit.edu
Subject: [PATCH v2 17/51] do_for_each_ref(): correctly terminate while processesing extra_refs
Date: Mon, 12 Dec 2011 06:38:24 +0100
Message-ID: <1323668338-1764-18-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:40:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZycd-0000Sq-P1
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:40:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665Ab1LLFkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:40:09 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34680 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab1LLFkG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:06 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aU015577;
	Mon, 12 Dec 2011 06:39:50 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186837>

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
index 579e4c3..fb6fe84 100644
--- a/refs.c
+++ b/refs.c
@@ -711,8 +711,11 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 
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
1.7.8
