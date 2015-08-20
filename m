From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] format_config: simplify buffer handling
Date: Thu, 20 Aug 2015 10:47:34 -0400
Message-ID: <20150820144733.GB11913@sigill.intra.peff.net>
References: <20150820144504.GA22935@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Aug 20 16:47:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSR8G-0000i8-5M
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 16:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846AbbHTOrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 10:47:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:47565 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753837AbbHTOrg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 10:47:36 -0400
Received: (qmail 3410 invoked by uid 102); 20 Aug 2015 14:47:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Aug 2015 09:47:36 -0500
Received: (qmail 23749 invoked by uid 107); 20 Aug 2015 14:47:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Aug 2015 10:47:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Aug 2015 10:47:34 -0400
Content-Disposition: inline
In-Reply-To: <20150820144504.GA22935@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276244>

When formatting a config value into a strbuf, we may end
up stringifying it into a fixed-size buffer using sprintf,
and then copying that buffer into the strbuf. We can
eliminate the middle-man (and drop some calls to sprintf!)
by writing directly to the strbuf.

The reason it was written this way in the first place is
that we need to know before writing the value whether to
insert a delimiter. Instead of delaying the write of the
value, we speculatively write the delimiter, and roll it
back in the single case that cares.

Signed-off-by: Jeff King <peff@peff.net>
---
I admit the rollback is a little gross. The other option would be adding
the delimiter in each of the conditional branches, which is also kind of
nasty. Or we could leave the buffer-write as-is, and replace the
sprintfs with snprintfs (this is actually something I was doing in
another branch, which is why I took particular notice; your patch
conflicts with my to-be-submitted branch :) ).

 builtin/config.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 91aa56f..04befce 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -111,41 +111,35 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 	if (show_keys)
 		strbuf_addstr(buf, key_);
 	if (!omit_values) {
-		int must_free_vptr = 0;
-		int must_add_delim = show_keys;
-		char value[256];
-		const char *vptr = value;
+		if (show_keys)
+			strbuf_addch(buf, key_delim);
 
 		if (types == TYPE_INT)
-			sprintf(value, "%"PRId64,
-				git_config_int64(key_, value_ ? value_ : ""));
+			strbuf_addf(buf, "%"PRId64,
+				    git_config_int64(key_, value_ ? value_ : ""));
 		else if (types == TYPE_BOOL)
-			vptr = git_config_bool(key_, value_) ? "true" : "false";
+			strbuf_addstr(buf, git_config_bool(key_, value_) ?
+				      "true" : "false");
 		else if (types == TYPE_BOOL_OR_INT) {
 			int is_bool, v;
 			v = git_config_bool_or_int(key_, value_, &is_bool);
 			if (is_bool)
-				vptr = v ? "true" : "false";
+				strbuf_addstr(buf, v ? "true" : "false");
 			else
-				sprintf(value, "%d", v);
+				strbuf_addf(buf, "%d", v);
 		} else if (types == TYPE_PATH) {
-			if (git_config_pathname(&vptr, key_, value_) < 0)
+			const char *v;
+			if (git_config_pathname(&v, key_, value_) < 0)
 				return -1;
-			must_free_vptr = 1;
+			strbuf_addstr(buf, v);
+			free((char *)v);
 		} else if (value_) {
-			vptr = value_;
+			strbuf_addstr(buf, value_);
 		} else {
-			/* Just show the key name */
-			vptr = "";
-			must_add_delim = 0;
+			/* Just show the key name; back out delimiter */
+			if (show_keys)
+				strbuf_setlen(buf, buf->len - 1);
 		}
-
-		if (must_add_delim)
-			strbuf_addch(buf, key_delim);
-		strbuf_addstr(buf, vptr);
-
-		if (must_free_vptr)
-			free((char *)vptr);
 	}
 	strbuf_addch(buf, term);
 	return 0;
-- 
2.5.0.680.g69e7703
