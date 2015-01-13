From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] builtin/apply.c: use xstrdup_or_null instead of
 null_strdup
Date: Mon, 12 Jan 2015 20:58:15 -0500
Message-ID: <20150113015815.GB18986@peff.net>
References: <20150113015427.GA5497@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lukas Fleischer <git@cryptocrack.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 02:58:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAqkP-0005Ae-6O
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 02:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbbAMB6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 20:58:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:33597 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752346AbbAMB6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 20:58:16 -0500
Received: (qmail 19191 invoked by uid 102); 13 Jan 2015 01:58:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jan 2015 19:58:16 -0600
Received: (qmail 22688 invoked by uid 107); 13 Jan 2015 01:58:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jan 2015 20:58:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jan 2015 20:58:15 -0500
Content-Disposition: inline
In-Reply-To: <20150113015427.GA5497@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262317>

This file had its own identical helper that predates
xstrdup_or_null. Let's use the global one to avoid
repetition.

Signed-off-by: Jeff King <peff@peff.net>
---
You'll note that every one of these could just be a ?:-conditional
(there are no function calls).

 builtin/apply.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 0aad912..dfd7a34 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -657,11 +657,6 @@ static size_t diff_timestamp_len(const char *line, size_t len)
 	return line + len - end;
 }
 
-static char *null_strdup(const char *s)
-{
-	return s ? xstrdup(s) : NULL;
-}
-
 static char *find_name_common(const char *line, const char *def,
 			      int p_value, const char *end, int terminate)
 {
@@ -684,10 +679,10 @@ static char *find_name_common(const char *line, const char *def,
 			start = line;
 	}
 	if (!start)
-		return squash_slash(null_strdup(def));
+		return squash_slash(xstrdup_or_null(def));
 	len = line - start;
 	if (!len)
-		return squash_slash(null_strdup(def));
+		return squash_slash(xstrdup_or_null(def));
 
 	/*
 	 * Generally we prefer the shorter name, especially
@@ -909,7 +904,7 @@ static void parse_traditional_patch(const char *first, const char *second, struc
 			patch->old_name = name;
 		} else {
 			patch->old_name = name;
-			patch->new_name = null_strdup(name);
+			patch->new_name = xstrdup_or_null(name);
 		}
 	}
 	if (!name)
@@ -998,7 +993,7 @@ static int gitdiff_delete(const char *line, struct patch *patch)
 {
 	patch->is_delete = 1;
 	free(patch->old_name);
-	patch->old_name = null_strdup(patch->def_name);
+	patch->old_name = xstrdup_or_null(patch->def_name);
 	return gitdiff_oldmode(line, patch);
 }
 
@@ -1006,7 +1001,7 @@ static int gitdiff_newfile(const char *line, struct patch *patch)
 {
 	patch->is_new = 1;
 	free(patch->new_name);
-	patch->new_name = null_strdup(patch->def_name);
+	patch->new_name = xstrdup_or_null(patch->def_name);
 	return gitdiff_newmode(line, patch);
 }
 
-- 
2.2.1.425.g441bb3c
