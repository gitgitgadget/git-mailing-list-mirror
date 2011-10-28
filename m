From: mhagger@alum.mit.edu
Subject: [PATCH 27/28] read_packed_refs(): keep track of the directory being worked in
Date: Fri, 28 Oct 2011 14:28:40 +0200
Message-ID: <1319804921-17545-28-git-send-email-mhagger@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 14:31:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJlar-0004j8-Do
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 14:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932712Ab1J1MbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 08:31:25 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:55839 "EHLO
	homer.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932685Ab1J1MbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 08:31:25 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJlRw-0007Ud-Uy; Fri, 28 Oct 2011 14:22:16 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184390>

From: Michael Haggerty <mhagger@alum.mit.edu>

Packed references are stored in $GIT_DIR/packed-refs sorted, so
adjacent ones are pretty likely to be in the same directory.  So while
reading them, keep track of the last directory used, and reuse it if
possible to avoid searching the reference namespace from the root each
time.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 6a7f9c3..6a19d19 100644
--- a/refs.c
+++ b/refs.c
@@ -831,6 +831,7 @@ static const char *parse_ref_line(char *line, unsigned char *sha1)
 static void read_packed_refs(FILE *f, struct ref_entry *direntry)
 {
 	struct ref_entry *last = NULL;
+	struct ref_entry *current_direntry = NULL;
 	char refline[PATH_MAX];
 	int flag = REF_ISPACKED;
 
@@ -850,8 +851,21 @@ static void read_packed_refs(FILE *f, struct ref_entry *direntry)
 
 		refname = parse_ref_line(refline, sha1);
 		if (refname) {
+			if (current_direntry) {
+				char *slash = strrchr(refname, '/');
+				if (!slash
+				    || strncmp(current_direntry->name, refname,
+					       slash - refname + 1)
+				    || current_direntry->name[slash - refname + 1] != '\0')
+					/* The new refname does not go in current_direntry */
+					current_direntry = NULL;
+			}
+			if (!current_direntry)
+				current_direntry = find_containing_direntry(
+						direntry, refname, 1);
+
 			last = create_ref_entry(refname, sha1, flag);
-			add_ref(direntry, last);
+			add_entry(current_direntry, last);
 			continue;
 		}
 		if (last &&
-- 
1.7.7
