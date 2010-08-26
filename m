From: alex@chmrr.net
Subject: [PATCH] config: Print the delimeter of intuited --bool values under --get-regexp
Date: Thu, 26 Aug 2010 16:49:35 -0400
Message-ID: <1282855775-22582-1-git-send-email-alex@chmrr.net>
References: <1282844716-30591-1-git-send-email-alex@chmrr.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 26 22:54:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OojT5-0001LW-I3
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 22:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313Ab0HZUyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 16:54:35 -0400
Received: from chmrr.net ([209.67.253.66]:48482 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168Ab0HZUye (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 16:54:34 -0400
Received: from 75-147-59-54-newengland.hfc.comcastbusiness.net ([75.147.59.54] helo=localhost.localdomain)
	by utwig.chmrr.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.71)
	(envelope-from <alex@chmrr.net>)
	id 1OojSw-0004Ot-5j
	for git@vger.kernel.org; Thu, 26 Aug 2010 16:54:33 -0400
X-Mailer: git-send-email 1.7.2.2.458.g8d9c8
In-Reply-To: <1282844716-30591-1-git-send-email-alex@chmrr.net>
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Exim-Version: 4.71 (build at 26-Feb-2010 17:03:13)
X-Date: 2010-08-26 16:54:33
X-Connected-IP: 75.147.59.54:38561
X-Message-Linecount: 72
X-Body-Linecount: 63
X-Message-Size: 2007
X-Body-Size: 1599
X-Received-Count: 1
X-Recipient-Count: 1
X-Local-Recipient-Count: 1
X-Local-Recipient-Defer-Count: 0
X-Local-Recipient-Fail-Count: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154561>

From: Alex Vandiver <alex@chmrr.net>

Keys with no explicit value set may still have values that need to be
printed, if used in conjunction with --bool, for example.  Defer
printing the key-value delimeter until we know what value, if any, we
intend to output.

Signed-off-by: Alex Vandiver <alex@chmrr.net>
---

I found a couple tuits under the couch; perhaps something like the
following would be correct.

 builtin/config.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index ca4a0db..98fd1ba 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -108,12 +108,9 @@ static int show_config(const char *key_, const char *value_, void *cb)
 	    (do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, 0)))
 		return 0;
 
-	if (show_keys) {
-		if (value_)
-			printf("%s%c", key_, key_delim);
-		else
-			printf("%s", key_);
-	}
+	if (show_keys)
+		printf("%s", key_);
+
 	if (seen && !do_all)
 		dup_error = 1;
 	if (types == TYPE_INT)
@@ -132,14 +129,21 @@ static int show_config(const char *key_, const char *value_, void *cb)
 		must_free_vptr = 1;
 	}
 	else
-		vptr = value_?value_:"";
+		vptr = value_;
+
+	if (show_keys && vptr)
+		printf("%c", key_delim);
+
 	seen++;
 	if (dup_error) {
 		error("More than one value for the key %s: %s",
 				key_, vptr);
 	}
-	else
+	else if (vptr)
 		printf("%s%c", vptr, term);
+	else
+		printf("%c", term);
+
 	if (must_free_vptr)
 		/* If vptr must be freed, it's a pointer to a
 		 * dynamically allocated buffer, it's safe to cast to
-- 
1.7.2.2.458.g8d9c8
