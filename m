From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 2/2] git-rev-parse: use leaky().
Date: Tue, 24 Jun 2008 22:14:34 +0200
Message-ID: <1214338474-16822-3-git-send-email-madcoder@debian.org>
References: <1214338474-16822-1-git-send-email-madcoder@debian.org>
 <1214338474-16822-2-git-send-email-madcoder@debian.org>
Cc: gitster@pobox.com, Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 22:15:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBEvN-0001UV-Pc
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 22:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbYFXUOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 16:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753461AbYFXUOh
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 16:14:37 -0400
Received: from pan.madism.org ([88.191.52.104]:55489 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752385AbYFXUOh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 16:14:37 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 2C2BA374CD;
	Tue, 24 Jun 2008 22:14:36 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 5189C35771B; Tue, 24 Jun 2008 22:14:34 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.119.gbb8cf
In-Reply-To: <1214338474-16822-2-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86136>

Mark the mallocs that cmd_parseopt never frees as leaky so that nobody
loses time trying to fix them.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-rev-parse.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index a7860ed..02defbb 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -319,12 +319,12 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 		s = strchr(sb.buf, ' ');
 		if (!s || *sb.buf == ' ') {
 			o->type = OPTION_GROUP;
-			o->help = xstrdup(skipspaces(sb.buf));
+			o->help = leaky(xstrdup(skipspaces(sb.buf)));
 			continue;
 		}
 
 		o->type = OPTION_CALLBACK;
-		o->help = xstrdup(skipspaces(s));
+		o->help = leaky(xstrdup(skipspaces(s)));
 		o->value = &parsed;
 		o->flags = PARSE_OPT_NOARG;
 		o->callback = &parseopt_dump;
@@ -349,10 +349,10 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 		if (s - sb.buf == 1) /* short option only */
 			o->short_name = *sb.buf;
 		else if (sb.buf[1] != ',') /* long option only */
-			o->long_name = xmemdupz(sb.buf, s - sb.buf);
+			o->long_name = leaky(xmemdupz(sb.buf, s - sb.buf));
 		else {
 			o->short_name = *sb.buf;
-			o->long_name = xmemdupz(sb.buf + 2, s - sb.buf - 2);
+			o->long_name = leaky(xmemdupz(sb.buf + 2, s - sb.buf - 2));
 		}
 	}
 	strbuf_release(&sb);
-- 
1.5.6.120.g3adb8.dirty
