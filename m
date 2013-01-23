From: Jeff King <peff@peff.net>
Subject: [PATCHv2 8/8] reflog: use parse_config_key in config callback
Date: Wed, 23 Jan 2013 01:27:37 -0500
Message-ID: <20130123062737.GH5036@sigill.intra.peff.net>
References: <20130123062132.GA2038@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 07:28:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxtoX-0000TI-I9
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 07:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144Ab3AWG1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 01:27:41 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44633 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885Ab3AWG1k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 01:27:40 -0500
Received: (qmail 1383 invoked by uid 107); 23 Jan 2013 06:29:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Jan 2013 01:29:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Jan 2013 01:27:37 -0500
Content-Disposition: inline
In-Reply-To: <20130123062132.GA2038@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214289>

This doesn't save any lines, but does keep us from doing
error-prone pointer arithmetic with constants.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/reflog.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index b3c9e27..1fedf66 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -510,26 +510,27 @@ static int reflog_expire_config(const char *var, const char *value, void *cb)
 
 static int reflog_expire_config(const char *var, const char *value, void *cb)
 {
-	const char *lastdot = strrchr(var, '.');
+	const char *pattern, *key;
+	int pattern_len;
 	unsigned long expire;
 	int slot;
 	struct reflog_expire_cfg *ent;
 
-	if (!lastdot || prefixcmp(var, "gc."))
+	if (parse_config_key(var, "gc", &pattern, &pattern_len, &key) < 0)
 		return git_default_config(var, value, cb);
 
-	if (!strcmp(lastdot, ".reflogexpire")) {
+	if (!strcmp(key, "reflogexpire")) {
 		slot = EXPIRE_TOTAL;
 		if (parse_expire_cfg_value(var, value, &expire))
 			return -1;
-	} else if (!strcmp(lastdot, ".reflogexpireunreachable")) {
+	} else if (!strcmp(key, "reflogexpireunreachable")) {
 		slot = EXPIRE_UNREACH;
 		if (parse_expire_cfg_value(var, value, &expire))
 			return -1;
 	} else
 		return git_default_config(var, value, cb);
 
-	if (lastdot == var + 2) {
+	if (!pattern) {
 		switch (slot) {
 		case EXPIRE_TOTAL:
 			default_reflog_expire = expire;
@@ -541,7 +542,7 @@ static int reflog_expire_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	ent = find_cfg_ent(var + 3, lastdot - (var+3));
+	ent = find_cfg_ent(pattern, pattern_len);
 	if (!ent)
 		return -1;
 	switch (slot) {
-- 
1.8.0.2.15.g815dc66
