From: Jeff King <peff@peff.net>
Subject: [PATCH 13/16] fast-import: refactor parsing of spaces
Date: Wed, 18 Jun 2014 15:51:57 -0400
Message-ID: <20140618195157.GM22622@sigill.intra.peff.net>
References: <20140618194117.GA22269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 21:52:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxLts-0007ef-UR
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940AbaFRTv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 15:51:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:46963 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754900AbaFRTv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:51:59 -0400
Received: (qmail 30546 invoked by uid 102); 18 Jun 2014 19:51:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 14:51:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 15:51:57 -0400
Content-Disposition: inline
In-Reply-To: <20140618194117.GA22269@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252045>

When we see a file change in a commit, we expect one of:

  1. A mark.

  2. An "inline" keyword.

  3. An object sha1.

The handling of spaces is inconsistent between the three
options. Option 1 calls a sub-function which checks for the
space, but doesn't parse past it. Option 2 parses the space,
then deliberately avoids moving the pointer past it. Option
3 detects the space locally but doesn't move past it.

This is confusing, because it looks like option 1 forgets to
check for the space (it's just buried). And option 2 checks
for "inline ", but only moves strlen("inline") characters
forward, which looks like a bug but isn't.

We can make this more clear by just having each branch move
past the space as it is checked (and we can replace the
doubled use of "inline" with a call to skip_prefix).

Signed-off-by: Jeff King <peff@peff.net>
---
 fast-import.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 5f17adb..55ca7d8 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2269,7 +2269,7 @@ static uintmax_t parse_mark_ref_space(const char **p)
 	char *end;
 
 	mark = parse_mark_ref(*p, &end);
-	if (*end != ' ')
+	if (*end++ != ' ')
 		die("Missing space after mark: %s", command_buf.buf);
 	*p = end;
 	return mark;
@@ -2304,20 +2304,17 @@ static void file_change_m(const char *p, struct branch *b)
 	if (*p == ':') {
 		oe = find_mark(parse_mark_ref_space(&p));
 		hashcpy(sha1, oe->idx.sha1);
-	} else if (starts_with(p, "inline ")) {
+	} else if (skip_prefix(p, "inline ", &p)) {
 		inline_data = 1;
 		oe = NULL; /* not used with inline_data, but makes gcc happy */
-		p += strlen("inline");  /* advance to space */
 	} else {
 		if (get_sha1_hex(p, sha1))
 			die("Invalid dataref: %s", command_buf.buf);
 		oe = find_object(sha1);
 		p += 40;
-		if (*p != ' ')
+		if (*p++ != ' ')
 			die("Missing space after SHA1: %s", command_buf.buf);
 	}
-	assert(*p == ' ');
-	p++;  /* skip space */
 
 	strbuf_reset(&uq);
 	if (!unquote_c_style(&uq, p, &endp)) {
@@ -2474,20 +2471,17 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 	if (*p == ':') {
 		oe = find_mark(parse_mark_ref_space(&p));
 		hashcpy(sha1, oe->idx.sha1);
-	} else if (starts_with(p, "inline ")) {
+	} else if (skip_prefix(p, "inline ", &p)) {
 		inline_data = 1;
 		oe = NULL; /* not used with inline_data, but makes gcc happy */
-		p += strlen("inline");  /* advance to space */
 	} else {
 		if (get_sha1_hex(p, sha1))
 			die("Invalid dataref: %s", command_buf.buf);
 		oe = find_object(sha1);
 		p += 40;
-		if (*p != ' ')
+		if (*p++ != ' ')
 			die("Missing space after SHA1: %s", command_buf.buf);
 	}
-	assert(*p == ' ');
-	p++;  /* skip space */
 
 	/* <commit-ish> */
 	s = lookup_branch(p);
@@ -3005,6 +2999,8 @@ static struct object_entry *parse_treeish_dataref(const char **p)
 			die("Invalid dataref: %s", command_buf.buf);
 		e = find_object(sha1);
 		*p += 40;
+		if (*(*p)++ != ' ')
+			die("Missing space after tree-ish: %s", command_buf.buf);
 	}
 
 	while (!e || e->type != OBJ_TREE)
@@ -3056,8 +3052,6 @@ static void parse_ls(const char *p, struct branch *b)
 		if (!is_null_sha1(root->versions[1].sha1))
 			root->versions[1].mode = S_IFDIR;
 		load_tree(root);
-		if (*p++ != ' ')
-			die("Missing space after tree-ish: %s", command_buf.buf);
 	}
 	if (*p == '"') {
 		static struct strbuf uq = STRBUF_INIT;
-- 
2.0.0.566.gfe3e6b2
