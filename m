From: Jeff King <peff@peff.net>
Subject: Re: [PATCH, v4] git-tag: introduce --cleanup option
Date: Mon, 5 Dec 2011 17:27:24 -0500
Message-ID: <20111205222724.GA7603@sigill.intra.peff.net>
References: <1322972426-7591-1-git-send-email-kirill@shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
X-From: git-owner@vger.kernel.org Mon Dec 05 23:29:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXh2K-0000fd-5K
	for gcvg-git-2@lo.gmane.org; Mon, 05 Dec 2011 23:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559Ab1LEW11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 17:27:27 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39925
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932486Ab1LEW10 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 17:27:26 -0500
Received: (qmail 30212 invoked by uid 107); 5 Dec 2011 22:34:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 05 Dec 2011 17:34:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Dec 2011 17:27:24 -0500
Content-Disposition: inline
In-Reply-To: <1322972426-7591-1-git-send-email-kirill@shutemov.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186293>

On Sun, Dec 04, 2011 at 06:20:26AM +0200, Kirill A. Shutemov wrote:

> @@ -367,14 +390,15 @@ static void create_tag(const unsigned char *object, const char *tag,
> [...]
> -	if (!message && !buf->len)
> +	if (opt->message && !buf->len)
>  		die(_("no tag message?"));

Ah, this is the hunk that causes t6300 to fail. You accidentally removed
the negation when converting the "message" flag over.

This was much easier to find by splitting the refactoring (where the bug
is) away from the new feature (which is where I assumed the bug was).
Here's the first half of the "split". You can rebase your original patch
on top to get the second half.

I also looked at factoring out the "which cleanup mode to select" logic
from builtin/commit.c, but it turned out to just make things harder to
follow.

-- >8 --
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: [PATCH] tag: refactor passing tag creation options

Rather than continually adding parameters to the create_tag
function, we can put all of the flags in a struct.

Signed-off-by: Jeff King <peff@peff.net>
---
Actually, I'm not sure this really buys us much as a refactoring. It
saves a parameter in the function, but it's not like we end up passing
all those parameters to sub-functions, where something like this would
increase readability. I'm fine with this, but I'd also be fine with just
dropping this half and passing the cleanup_mode parameter directly.

 builtin/tag.c |   32 ++++++++++++++++++++------------
 1 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 9b6fd95..e5bd708 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -319,8 +319,13 @@ static int build_tag_object(struct strbuf *buf, int sign, unsigned char *result)
 	return 0;
 }
 
+struct create_tag_options {
+	unsigned int message;
+	unsigned int sign;
+};
+
 static void create_tag(const unsigned char *object, const char *tag,
-		       struct strbuf *buf, int message, int sign,
+		       struct strbuf *buf, struct create_tag_options *opt,
 		       unsigned char *prev, unsigned char *result)
 {
 	enum object_type type;
@@ -345,7 +350,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 	if (header_len > sizeof(header_buf) - 1)
 		die(_("tag header too big."));
 
-	if (!message) {
+	if (!opt->message) {
 		int fd;
 
 		/* write the template message before editing: */
@@ -369,12 +374,12 @@ static void create_tag(const unsigned char *object, const char *tag,
 
 	stripspace(buf, 1);
 
-	if (!message && !buf->len)
+	if (!opt->message && !buf->len)
 		die(_("no tag message?"));
 
 	strbuf_insert(buf, 0, header_buf, header_len);
 
-	if (build_tag_object(buf, sign, result) < 0) {
+	if (build_tag_object(buf, opt->sign, result) < 0) {
 		if (path)
 			fprintf(stderr, _("The tag message has been left in %s\n"),
 				path);
@@ -422,9 +427,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	unsigned char object[20], prev[20];
 	const char *object_ref, *tag;
 	struct ref_lock *lock;
-
-	int annotate = 0, sign = 0, force = 0, lines = -1,
-		list = 0, delete = 0, verify = 0;
+	struct create_tag_options opt;
+	int annotate = 0, force = 0, lines = -1, list = 0,
+	    delete = 0, verify = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
@@ -442,7 +447,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK('m', "message", &msg, "message",
 			     "tag message", parse_msg_arg),
 		OPT_FILENAME('F', "file", &msgfile, "read message from file"),
-		OPT_BOOLEAN('s', "sign", &sign, "annotated and GPG-signed tag"),
+		OPT_BOOLEAN('s', "sign", &opt.sign, "annotated and GPG-signed tag"),
 		OPT_STRING('u', "local-user", &keyid, "key-id",
 					"use another key to sign the tag"),
 		OPT__FORCE(&force, "replace the tag if exists"),
@@ -459,13 +464,15 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	git_config(git_tag_config, NULL);
 
+	opt.sign = 0;
+
 	argc = parse_options(argc, argv, prefix, options, git_tag_usage, 0);
 
 	if (keyid) {
-		sign = 1;
+		opt.sign = 1;
 		set_signingkey(keyid);
 	}
-	if (sign)
+	if (opt.sign)
 		annotate = 1;
 	if (argc == 0 && !(delete || verify))
 		list = 1;
@@ -523,9 +530,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	else if (!force)
 		die(_("tag '%s' already exists"), tag);
 
+	opt.message = msg.given || msgfile;
+
 	if (annotate)
-		create_tag(object, tag, &buf, msg.given || msgfile,
-			   sign, prev, object);
+		create_tag(object, tag, &buf, &opt, prev, object);
 
 	lock = lock_any_ref_for_update(ref.buf, prev, 0);
 	if (!lock)
-- 
1.7.8.rc4.4.g884ec
