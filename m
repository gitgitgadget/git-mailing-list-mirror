From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 2/4] replace: use OPT_CMDMODE to handle modes
Date: Thu, 6 Mar 2014 12:49:22 -0500
Message-ID: <20140306174921.GB30691@sigill.intra.peff.net>
References: <20140306174803.GA30486@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 06 18:49:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLcQD-00013O-RT
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 18:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbaCFRtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 12:49:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:34186 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751645AbaCFRtY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 12:49:24 -0500
Received: (qmail 20822 invoked by uid 102); 6 Mar 2014 17:49:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Mar 2014 11:49:23 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Mar 2014 12:49:22 -0500
Content-Disposition: inline
In-Reply-To: <20140306174803.GA30486@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243526>

By using OPT_CMDMODE, the mutual exclusion between modes is
taken care of for us. It also makes it easy for us to
maintain a single variable with the mode, which makes its
intent more clear. We can use a single switch() to make sure
we have covered all of the modes.

This ends up breaking even in code size, but the win will be
much bigger when we start adding more modes.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/replace.c | 49 +++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 6a0e8bd..0b5cb17 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -168,11 +168,17 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 
 int cmd_replace(int argc, const char **argv, const char *prefix)
 {
-	int list = 0, delete = 0, force = 0;
+	int force = 0;
 	const char *format = NULL;
+	enum {
+		MODE_UNSPECIFIED = 0,
+		MODE_LIST,
+		MODE_DELETE,
+		MODE_REPLACE
+	} cmdmode = MODE_UNSPECIFIED;
 	struct option options[] = {
-		OPT_BOOL('l', "list", &list, N_("list replace refs")),
-		OPT_BOOL('d', "delete", &delete, N_("delete replace refs")),
+		OPT_CMDMODE('l', "list", &cmdmode, N_("list replace refs"), MODE_LIST),
+		OPT_CMDMODE('d', "delete", &cmdmode, N_("delete replace refs"), MODE_DELETE),
 		OPT_BOOL('f', "force", &force, N_("replace the ref if it exists")),
 		OPT_STRING(0, "format", &format, N_("format"), N_("use this format")),
 		OPT_END()
@@ -182,42 +188,37 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, git_replace_usage, 0);
 
-	if (!list && !delete)
-		if (!argc)
-			list = 1;
+	if (!cmdmode)
+		cmdmode = argc ? MODE_REPLACE : MODE_DELETE;
 
-	if (list && delete)
-		usage_msg_opt("-l and -d cannot be used together",
-			      git_replace_usage, options);
-
-	if (format && !list)
+	if (format && cmdmode != MODE_LIST)
 		usage_msg_opt("--format cannot be used when not listing",
 			      git_replace_usage, options);
 
-	if (force && (list || delete))
-		usage_msg_opt("-f cannot be used with -d or -l",
+	if (force && cmdmode != MODE_REPLACE)
+		usage_msg_opt("-f only makes sense when writing a replacement",
 			      git_replace_usage, options);
 
-	/* Delete refs */
-	if (delete) {
+	switch (cmdmode) {
+	case MODE_DELETE:
 		if (argc < 1)
 			usage_msg_opt("-d needs at least one argument",
 				      git_replace_usage, options);
 		return for_each_replace_name(argv, delete_replace_ref);
-	}
 
-	/* Replace object */
-	if (!list && argc) {
+	case MODE_REPLACE:
 		if (argc != 2)
 			usage_msg_opt("bad number of arguments",
 				      git_replace_usage, options);
 		return replace_object(argv[0], argv[1], force);
-	}
 
-	/* List refs, even if "list" is not set */
-	if (argc > 1)
-		usage_msg_opt("only one pattern can be given with -l",
-			      git_replace_usage, options);
+	case MODE_LIST:
+		if (argc > 1)
+			usage_msg_opt("only one pattern can be given with -l",
+				      git_replace_usage, options);
+		return list_replace_refs(argv[0], format);
 
-	return list_replace_refs(argv[0], format);
+	default:
+		die("BUG: invalid cmdmode %d", (int)cmdmode);
+	}
 }
-- 
1.8.5.2.500.g8060133
