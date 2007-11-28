From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH/RFC] "color.diff = true" is not "always" anymore.
Date: Tue, 27 Nov 2007 23:26:56 -0800
Message-ID: <7vd4tuakzj.fsf_-_@gitster.siamese.dyndns.org>
References: <474B42EC.1000408@wanadoo.fr>
	<7vr6icej23.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 14:15:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKvP-0004Ff-8j
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:17:51 +0100
Received: from mail-mx6.uio.no ([129.240.10.47])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxHPB-0003Zn-VA
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 08:32:21 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx6.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxHP3-0007eP-1z
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 08:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbXK1H1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 02:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbXK1H1B
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 02:27:01 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:33397 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbXK1H1A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 02:27:00 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A60902F0;
	Wed, 28 Nov 2007 02:27:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0830898BFF;
	Wed, 28 Nov 2007 02:27:19 -0500 (EST)
In-Reply-To: <7vr6icej23.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 26 Nov 2007 14:30:28 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.6, required=5.0, autolearn=disabled, AWL=1.368,RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: B45304A85B0953D054064AC68F53D609CFB21289
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -55 maxlevel 200 minaction 2 bait 0 mail/h: 52 total 724040 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66316>

Too many people got burned by setting color.diff and color.status to
true when they really should have set it to "auto".

This makes only "always" to do the unconditional colorization, and
change the meaning of "true" to the same as "auto": colorize only when
we are talking to a terminal.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is definitely a backward incompatible change, but I think it is
   only in a good way.  Are there people who have "color.* = true" and
   do mean it?  If we do this, they need to change their configuration
   and use "always", but I suspect there is no sane workflow that wants
   the color escape code in files (e.g. "git log >file") or pipes
   (e.g. "git diff | grep foo") by default, in which case this won't
   hurt anybody and would help countless normal people who were bitten
   by the mistaken meaning originally chosen for "true".

 color.c |   32 +++++++++++++++++++-------------
 1 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/color.c b/color.c
index 124ba33..97cfbda 100644
--- a/color.c
+++ b/color.c
@@ -118,21 +118,27 @@ bad:
 
 int git_config_colorbool(const char *var, const char *value)
 {
-	if (!value)
-		return 1;
-	if (!strcasecmp(value, "auto")) {
-		if (isatty(1) || (pager_in_use && pager_use_color)) {
-			char *term = getenv("TERM");
-			if (term && strcmp(term, "dumb"))
-				return 1;
-		}
-		return 0;
+	if (value) {
+		if (!strcasecmp(value, "never"))
+			return 0;
+		if (!strcasecmp(value, "always"))
+			return 1;
+		if (!strcasecmp(value, "auto"))
+			goto auto_color;
 	}
-	if (!strcasecmp(value, "never"))
+
+	/* Missing or explicit false to turn off colorization */
+	if (!git_config_bool(var, value))
 		return 0;
-	if (!strcasecmp(value, "always"))
-		return 1;
-	return git_config_bool(var, value);
+
+	/* any normal truth value defaults to 'auto' */
+ auto_color:
+	if (isatty(1) || (pager_in_use && pager_use_color)) {
+		char *term = getenv("TERM");
+		if (term && strcmp(term, "dumb"))
+			return 1;
+	}
+	return 0;
 }
 
 static int color_vfprintf(FILE *fp, const char *color, const char *fmt,
-- 
1.5.3.6.2039.g0495
