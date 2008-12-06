From: Jeff King <peff@peff.net>
Subject: Re: git tag -s: TAG_EDITMSG should not be deleted upon failures
Date: Sat, 6 Dec 2008 14:40:34 -0500
Message-ID: <20081206194034.GA18418@coredump.intra.peff.net>
References: <4936AB74.3090901@jaeger.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Christian Jaeger <christian@jaeger.mine.nu>
X-From: git-owner@vger.kernel.org Sat Dec 06 20:42:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L932K-0001zW-2e
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 20:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbYLFTkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 14:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbYLFTkj
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 14:40:39 -0500
Received: from peff.net ([208.65.91.99]:4076 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752220AbYLFTki (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 14:40:38 -0500
Received: (qmail 6906 invoked by uid 111); 6 Dec 2008 19:40:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 06 Dec 2008 14:40:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Dec 2008 14:40:34 -0500
Content-Disposition: inline
In-Reply-To: <4936AB74.3090901@jaeger.mine.nu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102470>

tag: delete TAG_EDITMSG only on successful tag

The user may put some effort into writing an annotated tag
message. When the tagging process later fails (which can
happen fairly easily, since it may be dependent on gpg being
correctly configured and used), there is no record left on
disk of the tag message.

Instead, let's keep the TAG_EDITMSG file around until we are
sure the tag has been created successfully. If we die
because of an error, the user can recover their text from
that file. Leaving the file in place causes no conflicts;
it will be silently overwritten by the next annotated tag
creation.

This matches the behavior of COMMIT_EDITMSG, which stays
around in case of error.

Signed-off-by: Jeff King <peff@peff.net>
---
On Wed, Dec 03, 2008 at 04:53:24PM +0100, Christian Jaeger wrote:

> Before I've now set my default signing key id in my ~/.gitconfig, I've  
> run at least half a dozen times into the case where I'm running "git tag  
> -s $tagname", carefully preparing a tag message, saving the file &  
> exiting from the editor, only to be greeted with an error message that no 
> key could be found for my (deliberately host-specific) email address, and 
> my message gone. If it would keep the TAG_EDITMSG file (like git commit 
> seems to be doing with COMMIT_EDITMSG anyway), I could rescue the message 
> from there. I relentlessly assume that this small change would also make a 
> handful of other people happier.

I think that is sensible. Here is the patch.

There are two possible improvements I can think of:

  - we can be more friendly about helping the user recover. Right now,
    we don't tell them that their message was saved anywhere, and it
    will be silently overwritten if they try another tag. I'm not sure
    what would be the best way to go about that, though.

  - the "path" variable became a little less local. It might be worth
    giving it a better name ("editmsg_path" or similar), but keeping it
    made the diff a lot less noisy (and it's still local to a fairly
    simple function).

 builtin-tag.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index d339971..ea596d2 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -260,6 +260,7 @@ static void create_tag(const unsigned char *object, const char *tag,
 	enum object_type type;
 	char header_buf[1024];
 	int header_len;
+	char *path;
 
 	type = sha1_object_info(object, NULL);
 	if (type <= OBJ_NONE)
@@ -279,7 +280,6 @@ static void create_tag(const unsigned char *object, const char *tag,
 		die("tag header too big.");
 
 	if (!message) {
-		char *path;
 		int fd;
 
 		/* write the template message before editing: */
@@ -300,9 +300,6 @@ static void create_tag(const unsigned char *object, const char *tag,
 			"Please supply the message using either -m or -F option.\n");
 			exit(1);
 		}
-
-		unlink(path);
-		free(path);
 	}
 
 	stripspace(buf, 1);
@@ -316,6 +313,9 @@ static void create_tag(const unsigned char *object, const char *tag,
 		die("unable to sign the tag");
 	if (write_sha1_file(buf->buf, buf->len, tag_type, result) < 0)
 		die("unable to write tag file");
+
+	unlink(path);
+	free(path);
 }
 
 struct msg_arg {
-- 
1.6.1.rc1.335.gf97227.dirty
