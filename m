From: Frank Terbeck <ft@bewatermyfriend.org>
Subject: [PATCH v2 2/4] Add format.coverauto boolean
Date: Mon,  4 May 2009 11:59:00 +0200
Message-ID: <1241431142-8444-3-git-send-email-ft@bewatermyfriend.org>
References: <7v8wlxx18c.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Frank Terbeck <ft@bewatermyfriend.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 11:59:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0uxd-0007gz-TH
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 11:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbZEDJ7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 05:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754051AbZEDJ7h
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 05:59:37 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:55046 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbZEDJ7b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 05:59:31 -0400
Received: from [212.117.84.176] (helo=fsst.voodoo.lan)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1M0uxK-0003XU-UP; Mon, 04 May 2009 11:59:27 +0200
Received: from hawk by fsst.voodoo.lan with local (Exim 4.69)
	(envelope-from <ft@bewatermyfriend.org>)
	id 1M0uwy-0002Cp-4L; Mon, 04 May 2009 11:59:04 +0200
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
In-Reply-To: <7v8wlxx18c.fsf@gitster.siamese.dyndns.org>
X-Df-Sender: 430444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118222>

If set to true, format-patch behaves like it had been started
using the --cover-letter option.

An exception is if it is called using the --stdout option,
which disables format.coverauto, because users of --stdout
(like git-rebase.sh) usually are not interested in
cover letters at all.

If you do want it anyway, you can use:
  % git format-patch --stdout --cover-letter

Signed-off-by: Frank Terbeck <ft@bewatermyfriend.org>
---
 builtin-log.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 157c8cf..52c0d47 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -483,6 +483,10 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
 		return 0;
 	}
+	if (!strcmp(var, "format.coverauto")) {
+		cover_letter = git_config_bool(var, value);;
+		return 0;
+	}
 	if (!strcmp(var, "format.coverletter")) {
 		cover_letter_len = git_config_int(var, value);
 		return 0;
@@ -789,9 +793,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	 * possibly a valid SHA1.
 	 */
 	for (i = 1, j = 1; i < argc; i++) {
-		if (!strcmp(argv[i], "--stdout"))
+		if (!strcmp(argv[i], "--stdout")) {
 			use_stdout = 1;
-		else if (!strcmp(argv[i], "-n") ||
+			cover_letter = 0;
+		} else if (!strcmp(argv[i], "-n") ||
 				!strcmp(argv[i], "--numbered"))
 			numbered = 1;
 		else if (!strcmp(argv[i], "-N") ||
-- 
1.6.2.2.446.gfbdc0
