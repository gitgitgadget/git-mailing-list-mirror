From: Jeff King <peff@peff.net>
Subject: [PATCH 54/68] drop strcpy in favor of raw sha1_to_hex
Date: Thu, 24 Sep 2015 17:08:05 -0400
Message-ID: <20150924210805.GY30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:09:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDlN-00032s-0b
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391AbbIXVII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:08:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:36021 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754373AbbIXVIH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:08:07 -0400
Received: (qmail 12122 invoked by uid 102); 24 Sep 2015 21:08:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:08:07 -0500
Received: (qmail 29478 invoked by uid 107); 24 Sep 2015 21:08:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:08:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:08:05 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278616>

In some cases where we strcpy() the result of sha1_to_hex(),
there's no need; the result goes directly into a printf
statement, and we can simply pass the return value from
sha1_to_hex() directly.

When this code was originally written, sha1_to_hex used a
single buffer, and it was not safe to use it twice within a
single expression. That changed as of dcb3450 (sha1_to_hex()
usage cleanup, 2006-05-03), but this code ewas never
updated.

History-dug-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 http-push.c | 6 ++----
 walker.c    | 5 ++---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/http-push.c b/http-push.c
index 43a9036..48f39b7 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1856,7 +1856,6 @@ int main(int argc, char **argv)
 
 	new_refs = 0;
 	for (ref = remote_refs; ref; ref = ref->next) {
-		char old_hex[60], *new_hex;
 		struct argv_array commit_argv = ARGV_ARRAY_INIT;
 
 		if (!ref->peer_ref)
@@ -1911,13 +1910,12 @@ int main(int argc, char **argv)
 		}
 		hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
 		new_refs++;
-		strcpy(old_hex, sha1_to_hex(ref->old_sha1));
-		new_hex = sha1_to_hex(ref->new_sha1);
 
 		fprintf(stderr, "updating '%s'", ref->name);
 		if (strcmp(ref->name, ref->peer_ref->name))
 			fprintf(stderr, " using '%s'", ref->peer_ref->name);
-		fprintf(stderr, "\n  from %s\n  to   %s\n", old_hex, new_hex);
+		fprintf(stderr, "\n  from %s\n  to   %s\n",
+			sha1_to_hex(ref->old_sha1), sha1_to_hex(ref->new_sha1));
 		if (dry_run) {
 			if (helper_status)
 				printf("ok %s\n", ref->name);
diff --git a/walker.c b/walker.c
index 44a936c..cdeb63f 100644
--- a/walker.c
+++ b/walker.c
@@ -17,10 +17,9 @@ void walker_say(struct walker *walker, const char *fmt, const char *hex)
 
 static void report_missing(const struct object *obj)
 {
-	char missing_hex[41];
-	strcpy(missing_hex, sha1_to_hex(obj->sha1));
 	fprintf(stderr, "Cannot obtain needed %s %s\n",
-		obj->type ? typename(obj->type): "object", missing_hex);
+		obj->type ? typename(obj->type): "object",
+		sha1_to_hex(obj->sha1));
 	if (!is_null_sha1(current_commit_sha1))
 		fprintf(stderr, "while processing commit %s.\n",
 			sha1_to_hex(current_commit_sha1));
-- 
2.6.0.rc3.454.g204ad51
