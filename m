From: Jeff King <peff@peff.net>
Subject: Re: Fwd: git status options feature suggestion
Date: Sun, 12 Oct 2008 04:26:08 -0400
Message-ID: <20081012082607.GA17852@sigill.intra.peff.net>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com> <20081009061136.GA24288@coredump.intra.peff.net> <81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com> <81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com> <alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de> <48EE1F58.2060707@drmicha.warpmail.net> <20081012044900.GA27845@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Oct 12 10:29:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KowKN-0007CM-Ha
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 10:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbYJLI0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 04:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbYJLI0U
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 04:26:20 -0400
Received: from peff.net ([208.65.91.99]:1269 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335AbYJLI0T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 04:26:19 -0400
Received: (qmail 13394 invoked by uid 111); 12 Oct 2008 08:26:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 12 Oct 2008 04:26:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Oct 2008 04:26:08 -0400
Content-Disposition: inline
In-Reply-To: <20081012044900.GA27845@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98007>

On Sun, Oct 12, 2008 at 12:49:00AM -0400, Jeff King wrote:

> A week or two ago I came across yet another git-status annoyance: it
> needs write access to the repository to run (I was helping somebody with
> a task on a shared box, and I wanted to run status in their repository
> using my account).
> 
> I considered submitting a patch to fix this, but I think it is really
> more fundamental. I use status to get an overview of what's going on in
> a repo, but it is intimately related to a potential commit.

BTW, in case anybody is interested, here is the patch. Like I said, I
think we are better off with an alternative to "status", but maybe this
is useful to somebody anyway.

---
diff --git a/builtin-commit.c b/builtin-commit.c
index b01ad9f..8951364 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -217,7 +217,8 @@ static void create_base_index(void)
 		exit(128); /* We've already reported the error, finish dying */
 }
 
-static char *prepare_index(int argc, const char **argv, const char *prefix)
+static char *prepare_index(int argc, const char **argv, const char *prefix,
+		int status_only)
 {
 	int fd;
 	struct string_list partial;
@@ -270,7 +271,13 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 	 * We still need to refresh the index here.
 	 */
 	if (!pathspec || !*pathspec) {
-		fd = hold_locked_index(&index_lock, 1);
+		fd = hold_locked_index(&index_lock, 0);
+		if (fd < 0) {
+			if (!status_only)
+				die("unable to lock index: %s",
+						strerror(errno));
+			return get_index_file();
+		}
 		refresh_cache(REFRESH_QUIET);
 		if (write_cache(fd, active_cache, active_nr) ||
 		    commit_locked_index(&index_lock))
@@ -869,7 +876,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	argc = parse_and_validate_options(argc, argv, builtin_status_usage, prefix);
 
-	index_file = prepare_index(argc, argv, prefix);
+	index_file = prepare_index(argc, argv, prefix, 1);
 
 	commitable = run_status(stdout, index_file, prefix, 0);
 
@@ -953,7 +960,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	argc = parse_and_validate_options(argc, argv, builtin_commit_usage, prefix);
 
-	index_file = prepare_index(argc, argv, prefix);
+	index_file = prepare_index(argc, argv, prefix, 0);
 
 	/* Set up everything for writing the commit object.  This includes
 	   running hooks, writing the trees, and interacting with the user.  */
