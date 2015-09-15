From: Jeff King <peff@peff.net>
Subject: [PATCH 37/67] http-push: use strbuf instead of fwrite_buffer
Date: Tue, 15 Sep 2015 11:52:51 -0400
Message-ID: <20150915155250.GK29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:55:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbsZO-0001Eb-OF
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbbIOPyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:54:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:59381 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754311AbbIOPwx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:52:53 -0400
Received: (qmail 12845 invoked by uid 102); 15 Sep 2015 15:52:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:52:53 -0500
Received: (qmail 7450 invoked by uid 107); 15 Sep 2015 15:53:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:53:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:52:51 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277940>

The http-push code defines an fwrite_buffer function for use
as a curl callback; it just writes to a strbuf. There's no
reason we need to use it ourselves, as we know we have a
strbuf. This lets us format directly into it, rather than
dealing with an extra temporary buffer (which required
manual length computation).

While we're here, let's also remove the literal tabs from
the source in favor of "\t", which is more visually obvious.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-push.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/http-push.c b/http-push.c
index 37baff8..e501c28 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1459,8 +1459,6 @@ static void add_remote_info_ref(struct remote_ls_ctx *ls)
 {
 	struct strbuf *buf = (struct strbuf *)ls->userData;
 	struct object *o;
-	int len;
-	char *ref_info;
 	struct ref *ref;
 
 	ref = alloc_ref(ls->dentry_name);
@@ -1484,23 +1482,14 @@ static void add_remote_info_ref(struct remote_ls_ctx *ls)
 		return;
 	}
 
-	len = strlen(ls->dentry_name) + 42;
-	ref_info = xcalloc(len + 1, 1);
-	sprintf(ref_info, "%s	%s\n",
-		sha1_to_hex(ref->old_sha1), ls->dentry_name);
-	fwrite_buffer(ref_info, 1, len, buf);
-	free(ref_info);
+	strbuf_addf(buf, "%s\t%s\n",
+		    sha1_to_hex(ref->old_sha1), ls->dentry_name);
 
 	if (o->type == OBJ_TAG) {
 		o = deref_tag(o, ls->dentry_name, 0);
-		if (o) {
-			len = strlen(ls->dentry_name) + 45;
-			ref_info = xcalloc(len + 1, 1);
-			sprintf(ref_info, "%s	%s^{}\n",
-				sha1_to_hex(o->sha1), ls->dentry_name);
-			fwrite_buffer(ref_info, 1, len, buf);
-			free(ref_info);
-		}
+		if (o)
+			strbuf_addf(buf, "%s\t%s^{}\n",
+				    sha1_to_hex(o->sha1), ls->dentry_name);
 	}
 	free(ref);
 }
-- 
2.6.0.rc2.408.ga2926b9
