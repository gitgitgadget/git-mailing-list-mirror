From: mhagger@alum.mit.edu
Subject: [PATCH 02/15] refs: manage current_ref within do_one_ref()
Date: Tue, 10 Apr 2012 07:30:14 +0200
Message-ID: <1334035827-20331-3-git-send-email-mhagger@alum.mit.edu>
References: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 07:31:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHTfb-0002Gn-Jx
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 07:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972Ab2DJFav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 01:30:51 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59191 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351Ab2DJFat (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 01:30:49 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0B8CA.dip.t-dialin.net [79.192.184.202])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3A5UXdt000870;
	Tue, 10 Apr 2012 07:30:39 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195058>

From: Michael Haggerty <mhagger@alum.mit.edu>

Set and clear current_ref within do_one_ref() instead of setting it
here and leaving it to somebody else to clear it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 0c9ca4c..20d5300 100644
--- a/refs.c
+++ b/refs.c
@@ -250,6 +250,7 @@ static struct ref_entry *current_ref;
 static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 		      int flags, void *cb_data, struct ref_entry *entry)
 {
+	int retval;
 	if (prefixcmp(entry->name, base))
 		return 0;
 
@@ -262,7 +263,9 @@ static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 		}
 	}
 	current_ref = entry;
-	return fn(entry->name + trim, entry->sha1, entry->flag, cb_data);
+	retval = fn(entry->name + trim, entry->sha1, entry->flag, cb_data);
+	current_ref = NULL;
+	return retval;
 }
 
 /*
@@ -872,7 +875,7 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 		}
 		retval = do_one_ref(base, fn, trim, flags, cb_data, entry);
 		if (retval)
-			goto end_each;
+			return retval;
 	}
 
 	if (l < loose->nr) {
@@ -883,12 +886,10 @@ static int do_for_each_ref(const char *submodule, const char *base, each_ref_fn
 	for (; p < packed->nr; p++) {
 		retval = do_one_ref(base, fn, trim, flags, cb_data, packed->refs[p]);
 		if (retval)
-			goto end_each;
+			return retval;
 	}
 
-end_each:
-	current_ref = NULL;
-	return retval;
+	return 0;
 }
 
 static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
-- 
1.7.10
