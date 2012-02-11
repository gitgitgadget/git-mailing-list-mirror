From: mhagger@alum.mit.edu
Subject: [PATCH 6/7] clone: do not add alternate references to extra_refs
Date: Sat, 11 Feb 2012 07:21:00 +0100
Message-ID: <1328941261-29746-7-git-send-email-mhagger@alum.mit.edu>
References: <1328941261-29746-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 07:21:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw6L8-0001rt-DO
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 07:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753696Ab2BKGVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 01:21:33 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50491 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253Ab2BKGV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 01:21:29 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BED675.dip.t-dialin.net [84.190.214.117])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q1B6L6CG019131;
	Sat, 11 Feb 2012 07:21:22 +0100
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1328941261-29746-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190489>

From: Michael Haggerty <mhagger@alum.mit.edu>

Alternate references are directly (and now, correctly) handled by
fetch-pack, so there is no need to inform fetch-pack about them via
the extra_refs back channel.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/clone.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 279fdf0..b15fccb 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -232,9 +232,6 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 {
 	char *ref_git;
 	struct strbuf alternate = STRBUF_INIT;
-	struct remote *remote;
-	struct transport *transport;
-	const struct ref *extra;
 
 	/* Beware: real_path() and mkpath() return static buffer */
 	ref_git = xstrdup(real_path(item->string));
@@ -249,14 +246,6 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 	strbuf_addf(&alternate, "%s/objects", ref_git);
 	add_to_alternates_file(alternate.buf);
 	strbuf_release(&alternate);
-
-	remote = remote_get(ref_git);
-	transport = transport_get(remote, ref_git);
-	for (extra = transport_get_remote_refs(transport); extra;
-	     extra = extra->next)
-		add_extra_ref(extra->name, extra->old_sha1, 0);
-
-	transport_disconnect(transport);
 	free(ref_git);
 	return 0;
 }
@@ -500,7 +489,6 @@ static void update_remote_refs(const struct ref *refs,
 			       const char *msg)
 {
 	if (refs) {
-		clear_extra_refs();
 		write_remote_refs(mapped_refs);
 		if (option_single_branch)
 			write_followtags(refs, msg);
-- 
1.7.9
