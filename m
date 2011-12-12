From: mhagger@alum.mit.edu
Subject: [PATCH v2 50/51] read_packed_refs(): keep track of the directory being worked in
Date: Mon, 12 Dec 2011 06:38:57 +0100
Message-ID: <1323668338-1764-51-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:41:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZydY-0000k3-61
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113Ab1LLFlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:41:11 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:35046 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab1LLFlH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:41:07 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8b3015577;
	Mon, 12 Dec 2011 06:40:58 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186864>

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
index 312ca3b..92523fd 100644
--- a/refs.c
+++ b/refs.c
@@ -780,6 +780,7 @@ static const char *parse_ref_line(char *line, unsigned char *sha1)
 static void read_packed_refs(FILE *f, struct ref_entry *direntry)
 {
 	struct ref_entry *last = NULL;
+	struct ref_entry *current_direntry = NULL;
 	char refline[PATH_MAX];
 	int flag = REF_ISPACKED;
 
@@ -799,8 +800,21 @@ static void read_packed_refs(FILE *f, struct ref_entry *direntry)
 
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
 			last = create_ref_entry(refname, sha1, flag, 1);
-			add_ref(direntry, last);
+			add_entry(current_direntry, last);
 			continue;
 		}
 		if (last &&
-- 
1.7.8
