From: mhagger@alum.mit.edu
Subject: [RFC 04/13] add_ref(): move the call of check_refname_format() to callers
Date: Wed, 19 Oct 2011 22:55:07 +0200
Message-ID: <1319057716-28094-5-git-send-email-mhagger@alum.mit.edu>
References: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 22:55:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdAo-0003UG-3z
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 22:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938Ab1JSUz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 16:55:29 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:60896 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab1JSUzY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 16:55:24 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RGd4e-000423-LF; Wed, 19 Oct 2011 22:49:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183952>

From: Michael Haggerty <mhagger@alum.mit.edu>

Do not call check_refname_format() in add_ref(); instead change its
callers to do the check.  (In fact, don't do any checking in
add_extra_ref(), because that function handles bizarre things like
"refs/tags/3.1.1.1^{}".)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

I'm still not clear on how extra_refs are used.  Are they generated
from local refs or are they generated from remote refs?  If the
latter, then it is probably irresponsible not to do *some* sanity
checking in add_extra_ref() to prevent any chance of refnames like
"../../../etc/passwd".

 refs.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 8299e51..a40dfa5 100644
--- a/refs.c
+++ b/refs.c
@@ -60,8 +60,6 @@ static void add_ref(const char *name, const unsigned char *sha1,
 	entry = xmalloc(sizeof(struct ref_entry) + len);
 	hashcpy(entry->sha1, sha1);
 	hashclr(entry->peeled);
-	if (check_refname_format(name, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT))
-		die("Reference has invalid format: '%s'", name);
 	memcpy(entry->name, name, len);
 	entry->flag = flag;
 	if (new_entry)
@@ -232,6 +230,8 @@ static void read_packed_refs(FILE *f, struct ref_array *array)
 
 		name = parse_ref_line(refline, sha1);
 		if (name) {
+			if (check_refname_format(name, REFNAME_FULL))
+				die("Reference has invalid format: '%s'", name);
 			add_ref(name, sha1, flag, array, &last);
 			continue;
 		}
@@ -336,6 +336,8 @@ static void get_ref_dir(const char *submodule, const char *base,
 					hashclr(sha1);
 					flag |= REF_BROKEN;
 				}
+			if (check_refname_format(ref, REFNAME_FULL))
+				die("Reference has invalid format: '%s'", ref);
 			add_ref(ref, sha1, flag, array, NULL);
 		}
 		free(ref);
-- 
1.7.7
