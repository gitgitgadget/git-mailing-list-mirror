From: Junio C Hamano <gitster@pobox.com>
Subject: Redefine semantics of find_unique_abbrev()
Date: Fri, 29 Feb 2008 17:41:53 -0800
Message-ID: <7vpruf9q5a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 02:42:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVGkY-0003Rl-Oj
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 02:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758906AbYCABmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 20:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755792AbYCABmS
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 20:42:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55318 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755307AbYCABmR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 20:42:17 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 717533DFE;
	Fri, 29 Feb 2008 20:42:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6B7663DFD; Fri, 29 Feb 2008 20:42:06 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75601>

The function returned NULL when no object that matches the name
was found, but that made the callers more complicated, as nobody
used that NULL return as an indication that no object with such
a name exists.  They (at least the careful ones) instead took
the full 40-hexdigit and used in such a case, and the careless
ones segfaulted.

With this "git rev-parse --short 5555555555555555555555555555555555555555"
would stop segfaulting.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-reset.c     |    4 ----
 builtin-send-pack.c |    4 +---
 diff.c              |    2 --
 sha1_name.c         |    8 +++-----
 4 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index af0037e..be58a8b 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -66,10 +66,6 @@ static void print_new_head_line(struct commit *commit)
 	const char *hex, *dots = "...", *body;
 
 	hex = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
-	if (!hex) {
-		hex = sha1_to_hex(commit->object.sha1);
-		dots = "";
-	}
 	printf("HEAD is now at %s%s", hex, dots);
 	body = strstr(commit->buffer, "\n\n");
 	if (body) {
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index b0cfae8..930e0fb 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -264,9 +264,7 @@ static void print_ref_status(char flag, const char *summary, struct ref *to, str
 
 static const char *status_abbrev(unsigned char sha1[20])
 {
-	const char *abbrev;
-	abbrev = find_unique_abbrev(sha1, DEFAULT_ABBREV);
-	return abbrev ? abbrev : sha1_to_hex(sha1);
+	return find_unique_abbrev(sha1, DEFAULT_ABBREV);
 }
 
 static void print_ok_ref_status(struct ref *ref)
diff --git a/diff.c b/diff.c
index ad16164..b80f656 100644
--- a/diff.c
+++ b/diff.c
@@ -2581,8 +2581,6 @@ const char *diff_unique_abbrev(const unsigned char *sha1, int len)
 		return sha1_to_hex(sha1);
 
 	abbrev = find_unique_abbrev(sha1, len);
-	if (!abbrev)
-		return sha1_to_hex(sha1);
 	abblen = strlen(abbrev);
 	if (abblen < 37) {
 		static char hex[41];
diff --git a/sha1_name.c b/sha1_name.c
index 9d088cc..05c2e7a 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -202,16 +202,14 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
 	while (len < 40) {
 		unsigned char sha1_ret[20];
 		status = get_short_sha1(hex, len, sha1_ret, 1);
-		if (!status ||
-		    (is_null && status != SHORT_NAME_AMBIGUOUS)) {
+		if ((!is_null && !status) ||
+		    (is_null && status == SHORT_NAME_NOT_FOUND)) {
 			hex[len] = 0;
 			return hex;
 		}
-		if (status != SHORT_NAME_AMBIGUOUS)
-			return NULL;
 		len++;
 	}
-	return NULL;
+	return hex;
 }
 
 static int ambiguous_path(const char *path, int len)
