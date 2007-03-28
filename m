From: Jeff King <peff@peff.net>
Subject: [PATCH] commit: fix pretty-printing of messages with "\nencoding "
Date: Wed, 28 Mar 2007 17:52:09 -0400
Message-ID: <20070328215209.GA13672@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 23:52:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWg43-0000Nw-5u
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 23:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933297AbXC1VwN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 17:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933305AbXC1VwN
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 17:52:13 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2588 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933297AbXC1VwM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 17:52:12 -0400
Received: (qmail 14444 invoked from network); 28 Mar 2007 21:52:42 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 28 Mar 2007 21:52:42 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2007 17:52:09 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43391>

The function replace_encoding_header is given the whole
commit buffer, including the commit message. When looking
for the encoding header, if none was found in the header, it
would locate any line in the commit message matching
"\nencoding " and remove it.

Instead, we now make sure to search only to the end of the
header.

Signed-off-by: Jeff King <peff@peff.net>
---
You can see the bug by doing this:
  git-commit -m 'encoding foo'
  git-show
and getting a blank log message (unless, of course, you're using a
non-utf8 commit encoding, in which case you will actually have an
encoding header).

I wonder, though, if this function before or after is actually correct;
if there is no encoding header, we exit the function immediately. But if
we are changing the encoding from utf8 to a non-utf8 value, we
presumably should continue and actually insert the new encoding header.

The searching could potentially be refactored to share code with
get_header; however, either the interface gets a little hairy, or you
have to repeat a few strlen()s, and I seem to recall a recent effort to
reduce such calls in critical paths (which I think this probably is).
The implementation here isn't ugly, anyway.

 commit.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index a4f2e74..754d1b8 100644
--- a/commit.c
+++ b/commit.c
@@ -654,6 +654,7 @@ static char *get_header(const struct commit *commit, const char *key)
 static char *replace_encoding_header(char *buf, const char *encoding)
 {
 	char *encoding_header = strstr(buf, "\nencoding ");
+	char *header_end = strstr(buf, "\n\n");
 	char *end_of_encoding_header;
 	int encoding_header_pos;
 	int encoding_header_len;
@@ -661,8 +662,10 @@ static char *replace_encoding_header(char *buf, const char *encoding)
 	int need_len;
 	int buflen = strlen(buf) + 1;
 
-	if (!encoding_header)
-		return buf; /* should not happen but be defensive */
+	if (!header_end)
+		header_end = buf + buflen;
+	if (!encoding_header || encoding_header >= header_end)
+		return buf;
 	encoding_header++;
 	end_of_encoding_header = strchr(encoding_header, '\n');
 	if (!end_of_encoding_header)
-- 
1.5.1.rc2.636.g7ca6fa-dirty
