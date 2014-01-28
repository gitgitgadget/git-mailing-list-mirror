From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] expand_user_path: do not look at NULL path
Date: Mon, 27 Jan 2014 20:36:12 -0500
Message-ID: <20140128013612.GA29548@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 28 02:36:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7xb9-0005dh-Av
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 02:36:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbaA1BgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 20:36:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:40033 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751425AbaA1BgO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 20:36:14 -0500
Received: (qmail 32671 invoked by uid 102); 28 Jan 2014 01:36:14 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 27 Jan 2014 19:36:14 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jan 2014 20:36:12 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241176>

We explicitly check for and handle the case that the
incoming "path" variable is NULL, but before doing so we
call strchrnul on it, leading to a potential segfault.

We can fix this simply by moving the strchrnul call down; as
a bonus, we can tighten the scope on the associated
variable.

Signed-off-by: Jeff King <peff@peff.net>
---
Most of the callers already check for NULL, so the only way to trigger
this is via an empty "include.path". That is addressed separately in the
next patch, so technically this is not needed if we apply that one. But
in that case, the "path == NULL" check here is useless, so I think this
makes things safer overall.

 path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path.c b/path.c
index 24594c4..f9c5062 100644
--- a/path.c
+++ b/path.c
@@ -265,12 +265,12 @@ static struct passwd *getpw_str(const char *username, size_t len)
 char *expand_user_path(const char *path)
 {
 	struct strbuf user_path = STRBUF_INIT;
-	const char *first_slash = strchrnul(path, '/');
 	const char *to_copy = path;
 
 	if (path == NULL)
 		goto return_null;
 	if (path[0] == '~') {
+		const char *first_slash = strchrnul(path, '/');
 		const char *username = path + 1;
 		size_t username_len = first_slash - username;
 		if (username_len == 0) {
-- 
1.8.5.2.500.g8060133
