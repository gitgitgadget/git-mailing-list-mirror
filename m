From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFH/PATCH] prefix_path(): disallow absolute paths
Date: Mon, 28 Jan 2008 12:33:48 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801281210440.23907@racer.site>
References: <47975FE6.4050709@viscovery.net> <1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com> <alpine.LSU.1.00.0801272043040.23907@racer.site> <7v3asiyk2i.fsf@gitster.siamese.dyndns.org> <20080128003404.GA18276@lintop> <7vodb6wtix.fsf@gitster.siamese.dyndns.org>
 <479D805E.3000209@viscovery.net> <7vprvmuykw.fsf@gitster.siamese.dyndns.org> <479D9ADE.6010003@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jan 28 13:34:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJTCE-0004eu-1h
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 13:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755288AbYA1MeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 07:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbYA1MeK
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 07:34:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:56137 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755288AbYA1MeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 07:34:09 -0500
Received: (qmail invoked by alias); 28 Jan 2008 12:34:07 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp013) with SMTP; 28 Jan 2008 13:34:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX194D+Rv6nl4J94stECxyazW5+sLb0o70Q+dzbsVZY
	fbgev3+Smerx8/
X-X-Sender: gene099@racer.site
In-Reply-To: <479D9ADE.6010003@viscovery.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71883>


Without this fix, "git ls-files --others /" would list _all_ files,
except for those tracked in the current repository.  Worse, "git clean /"
would start removing them.

Noticed by Johannes Sixt.

Incidentally, it fixes some strange code in builtin-mv.c by yours truly,
where a slash was added to "dst" but then ignored, and instead taken from
the source path.  This triggered the new check for absolute paths.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
	On Mon, 28 Jan 2008, Johannes Sixt wrote:

	> Junio C Hamano schrieb:
	> > Johannes Sixt <j.sixt@viscovery.net> writes:
	> > 
	> >> The "problem" is not only with git-clean, but also in others, 
	> >> like git-ls-files. Try this in you favorite repository:
	> >>
	> >>    $ git ls-files -o /*bin
	> >>
	> >> The output does not make a lot of sense. (Here it lists the 
	> >> contents of /bin and /sbin.) Not that it hurts with ls-files, 
	> >> but
	> >>
	> >>    $ git clean -f /
	> >>
	> >> is basically a synonym for
	> >>
	> >>    $ rm -rf /
	> > 
	> > Yeah, /*bin is not inside the repository so it should not even 
	> > be reported as "others".  Shouldn't the commands detect this 
	> > and reject feeding such paths outside the work tree to the 
	> > core, which always expect you to talk about paths inside?
	> 
	> That's what I had expected. But look:
	> 
	>    $ git ls-files -o /
	>    [... tons of file names ...]
	> 
	>    $ git ls-files -o ..
	>    fatal: '..' is outside repository
	> 
	>    $ git clean -n /    # with Shawn's patch
	>    Would remove /bin/
	>    [... etc ...]
	> 
	>    $ git clean -n ..
	>    fatal: '..' is outside repository
	> 
	> Some mechanism for this is already there; it's just not complete 
	> enough.

	This patch cannot be applied as-is: t3101 is failing (t7001 is 
	fixed by the builtin-mv.c part).

	The failure of t3101 has something to do with ls-tree filtering 
	out invalid paths; I maintain that this behaviour is wrong to 
	begin with.

	So the help I am requesting is this: so late in the game for 1.5.4 
	I would hate to introduce a change in prefix_path(), because it 
	affects apparently too much.  However, the "git clean /" bug is a 
	real one, and should at least be prevented.  What to do?

 builtin-mv.c |    4 ++--
 setup.c      |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index 990e213..94f6dd2 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -164,7 +164,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				}
 
 				dst = add_slash(dst);
-				dst_len = strlen(dst) - 1;
+				dst_len = strlen(dst);
 
 				for (j = 0; j < last - first; j++) {
 					const char *path =
@@ -172,7 +172,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 					source[argc + j] = path;
 					destination[argc + j] =
 						prefix_path(dst, dst_len,
-							path + length);
+							path + length + 1);
 					modes[argc + j] = INDEX;
 				}
 				argc += last - first;
diff --git a/setup.c b/setup.c
index 2174e78..5a4aadc 100644
--- a/setup.c
+++ b/setup.c
@@ -13,6 +13,8 @@ const char *get_current_prefix()
 const char *prefix_path(const char *prefix, int len, const char *path)
 {
 	const char *orig = path;
+	if (is_absolute_path(path))
+		die("no absolute paths allowed: '%s'", path);
 	for (;;) {
 		char c;
 		if (*path != '.')
-- 
1.5.4.rc5.15.g8231f
