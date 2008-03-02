From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Clean up find_unique_abbrev() callers
Date: Sat, 01 Mar 2008 23:49:10 -0800
Message-ID: <7vy791sgzt.fsf_-_@gitster.siamese.dyndns.org>
References: <7vpruf9q5a.fsf@gitster.siamese.dyndns.org>
 <20080301050641.GB8969@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 08:50:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVixM-0003pi-K7
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 08:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbYCBHtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 02:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbYCBHtY
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 02:49:24 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64303 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbYCBHtY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 02:49:24 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9904F19E7;
	Sun,  2 Mar 2008 02:49:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C61F119E4; Sun,  2 Mar 2008 02:49:18 -0500 (EST)
In-Reply-To: <20080301050641.GB8969@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 1 Mar 2008 00:06:41 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75744>

Now find_unique_abbrev() never returns NULL, there is no need for callers
to prepare for seeing NULL and fall back to giving the full 40 hexdigits.

While we are at it, drop "..." in the "git reset" output that reports the
location of the new HEAD, between the abbreviated commit object name and
the one line commit summary.  Because we are always showing the HEAD
(which cannot be missing!), we never had a case where we show the full 40
hexdigits that is not followed by three dots, and these three dots were
stealing 3 columns from the precious horizontal screen real estate out of
80 that can better be used for the one line commit summary.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin-reset.c     |    8 ++------
 builtin-send-pack.c |    4 +---
 diff.c              |    2 --
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index af0037e..bb3e192 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -63,14 +63,10 @@ static int reset_index_file(const unsigned char *sha1, int is_hard_reset)
 
 static void print_new_head_line(struct commit *commit)
 {
-	const char *hex, *dots = "...", *body;
+	const char *hex, *body;
 
 	hex = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
-	if (!hex) {
-		hex = sha1_to_hex(commit->object.sha1);
-		dots = "";
-	}
-	printf("HEAD is now at %s%s", hex, dots);
+	printf("HEAD is now at %s", hex);
 	body = strstr(commit->buffer, "\n\n");
 	if (body) {
 		const char *eol;
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
