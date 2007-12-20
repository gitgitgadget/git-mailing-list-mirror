From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-commit: add --verbatim to allow unstripped commit
 messages
Date: Thu, 20 Dec 2007 13:40:13 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712201324270.21557@woody.linux-foundation.org>
References: <20071220211835.GA3052@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 22:41:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5T8Q-0005cJ-DX
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 22:40:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556AbXLTVkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 16:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754653AbXLTVkV
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 16:40:21 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43960 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753556AbXLTVkT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Dec 2007 16:40:19 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBKLeEm3020830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 20 Dec 2007 13:40:15 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBKLeDPf014081;
	Thu, 20 Dec 2007 13:40:13 -0800
In-Reply-To: <20071220211835.GA3052@steel.home>
X-Spam-Status: No, hits=-4.113 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_23,J_CHICKENPOX_43,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69018>



On Thu, 20 Dec 2007, Alex Riesen wrote:
> 
> I just happen to have a corporate template (for perforce messages, I
> reuse it my git mirror repo) which contains "#" and at least one time
> lost my bash comments in a commit.

I think that this is a real bug, but I don't think this is something that 
we should add a flag for.

Basically, I don't think we should really strip lines starting with '#' 
unless *we* added them. In particular, I don't think we should strip them 
at all unless we're running the editor.

So I think that instead of your thing, we should do somethign like the 
appended, which allows you to do things like

	git commit -m "# Message starting with a hash-mark"

which the current code makes impossible ("empty commit message").

That may be enough for your case, although it still does leave the "use 
editor on a template thing", so if that is your usage scenario, I guess we 
still do need a flag for it.

But even if we *do* add a flag (like "--verbatim") you should at the 
*least* also then remove the

	"# (Comment lines starting with '#' will not be included)\n"

printout! Which you didn't.

So I say NAK on this patch.

> It also implies --allow-empty.

I disagree with this one too.

We have had *way* too many problems with various tools generating bogus 
empty commits. I get them from stgit users (and I think this is a serious 
BUG in stgit, dammit!), but I have this memory of some other usage 
scenario that did it too. 

In other words, empty commits are almost always just bogus. And dammit, if 
they aren't bogus, you should *say* so. No "implied" permissions, please. 
If you really want your commits to be empty, what's the downside of just 
adding an explicit "--allow-empty"?

		Linus

---
 builtin-commit.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 0a91013..4685938 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -434,7 +434,7 @@ static int message_is_empty(struct strbuf *sb, int start)
 	/* See if the template is just a prefix of the message. */
 	strbuf_init(&tmpl, 0);
 	if (template_file && strbuf_read_file(&tmpl, template_file, 0) > 0) {
-		stripspace(&tmpl, 1);
+		stripspace(&tmpl, !no_edit);
 		if (start + tmpl.len <= sb->len &&
 		    memcmp(tmpl.buf, sb->buf + start, tmpl.len) == 0)
 			start += tmpl.len;
@@ -813,7 +813,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (p != NULL)
 		strbuf_setlen(&sb, p - sb.buf + 1);
 
-	stripspace(&sb, 1);
+	stripspace(&sb, !no_edit);
 	if (sb.len < header_len || message_is_empty(&sb, header_len)) {
 		rollback_index_files();
 		die("no commit message?  aborting commit.");
