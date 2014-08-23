From: Jeff King <peff@peff.net>
Subject: [PATCH 4/5] fast-import: fix buffer overflow in dump_tags
Date: Sat, 23 Aug 2014 01:32:37 -0400
Message-ID: <20140823053237.GD18075@peff.net>
References: <20140823052334.GA17813@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 07:32:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XL3wR-0001kV-9I
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 07:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbaHWFcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2014 01:32:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:57250 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751976AbaHWFcj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2014 01:32:39 -0400
Received: (qmail 13844 invoked by uid 102); 23 Aug 2014 05:32:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 23 Aug 2014 00:32:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Aug 2014 01:32:37 -0400
Content-Disposition: inline
In-Reply-To: <20140823052334.GA17813@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255732>

When creating a new annotated tag, we sprintf the refname
into a static-sized buffer. If we have an absurdly long
tagname, like:

  git init repo &&
  cd repo &&
  git commit --allow-empty -m foo &&
  git tag -m message mytag &&
  git fast-export mytag |
  perl -lpe '/^tag/ and s/mytag/"a" x 8192/e' |
  git fast-import <input

we'll overflow the buffer. We can fix it by using a strbuf.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm not sure how easily exploitable this is. The buffer is on the stack,
and we definitely demolish the return address. But we never actually
return from the function, since lock_ref_sha1 will fail in such a case
and die (it cannot succeed because the name is longer than PATH_MAX,
which we check when concatenating it with $GIT_DIR).

Still, there is no limit to the size of buffer you can feed it, so it's
entirely possible you can overwrite something else and cause some
mischief. So I wouldn't call it trivially exploitable, but I would not
bet my servers that it is not (and of course it is easy to trigger if
you can convince somebody to run fast-import a stream, so any remote
helpers produce a potentially vulnerable situation).

 fast-import.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index f25a4ae..a1479e9 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1734,14 +1734,16 @@ static void dump_tags(void)
 	static const char *msg = "fast-import";
 	struct tag *t;
 	struct ref_lock *lock;
-	char ref_name[PATH_MAX];
+	struct strbuf ref_name = STRBUF_INIT;
 
 	for (t = first_tag; t; t = t->next_tag) {
-		sprintf(ref_name, "tags/%s", t->name);
-		lock = lock_ref_sha1(ref_name, NULL);
+		strbuf_reset(&ref_name);
+		strbuf_addf(&ref_name, "tags/%s", t->name);
+		lock = lock_ref_sha1(ref_name.buf, NULL);
 		if (!lock || write_ref_sha1(lock, t->sha1, msg) < 0)
-			failure |= error("Unable to update %s", ref_name);
+			failure |= error("Unable to update %s", ref_name.buf);
 	}
+	strbuf_release(&ref_name);
 }
 
 static void dump_marks_helper(FILE *f,
-- 
2.1.0.346.ga0367b9
