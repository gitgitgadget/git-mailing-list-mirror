From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] show git tag output in pager
Date: Fri, 7 Oct 2011 10:44:38 -0400
Message-ID: <20111007144438.GA30318@sigill.intra.peff.net>
References: <20110927134235.GA27478@zelva.suse.cz>
 <vpqehz2cbk4.fsf@bauges.imag.fr>
 <20110929093749.GB27152@zelva.suse.cz>
 <20110930104241.GB24507@sigill.intra.peff.net>
 <vpqwrcmw7ve.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michal Vyskocil <mvyskocil@suse.cz>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Oct 07 16:44:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCBfM-0005bd-69
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 16:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965483Ab1JGOon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 10:44:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54916
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965454Ab1JGOom (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 10:44:42 -0400
Received: (qmail 22013 invoked by uid 107); 7 Oct 2011 14:44:42 -0000
Received: from 208.177.47.101.ptr.us.xo.net (HELO sigill.intra.peff.net) (208.177.47.101)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 07 Oct 2011 10:44:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Oct 2011 10:44:38 -0400
Content-Disposition: inline
In-Reply-To: <vpqwrcmw7ve.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183077>

On Mon, Oct 03, 2011 at 02:57:09PM +0200, Matthieu Moy wrote:

> I like the try_subcommand_pager idea. Ideally, there would also be a
> nice mechanism to set defaults for subcommands, so that "git tag
> <whatever>" does the right thing without configuration.

That's easy enough. Something like the patch below?

Still thoroughly untested, but it looks Obviously Correct to me. :)

---
 builtin.h     |    1 +
 builtin/tag.c |    1 +
 git.c         |   13 +++++++++++++
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/builtin.h b/builtin.h
index 0e9da90..b2badf8 100644
--- a/builtin.h
+++ b/builtin.h
@@ -35,6 +35,7 @@ int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
 void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c);
 
 extern int check_pager_config(const char *cmd);
+extern void try_subcommand_pager(const char *subcommand, int fallback);
 
 extern int textconv_object(const char *path, unsigned mode, const unsigned char *sha1, char **buf, unsigned long *buf_size);
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 9d89616..c77adc4 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -152,6 +152,7 @@ static int list_tags(const char **patterns, int lines,
 	filter.lines = lines;
 	filter.with_commit = with_commit;
 
+	try_subcommand_pager("tag.list", 1);
 	for_each_tag_ref(show_reference, (void *) &filter);
 
 	return 0;
diff --git a/git.c b/git.c
index 8e34903..11ee1a8 100644
--- a/git.c
+++ b/git.c
@@ -64,6 +64,19 @@ static void commit_pager_choice(void) {
 	}
 }
 
+void try_subcommand_pager(const char *subcommand, int fallback)
+{
+	/* it's too late to turn off a running pager */
+	if (pager_in_use())
+		return;
+
+	if (use_pager == -1)
+		use_pager = check_pager_config(subcommand);
+	if (use_pager == -1)
+		use_pager = fallback;
+	commit_pager_choice();
+}
+
 static int handle_options(const char ***argv, int *argc, int *envchanged)
 {
 	const char **orig_argv = *argv;
-- 
1.7.7.rc2.7.gdfc92
