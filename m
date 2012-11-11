From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2012, #02; Fri, 9)
Date: Sun, 11 Nov 2012 10:48:46 -0500
Message-ID: <20121111154846.GA13188@sigill.intra.peff.net>
References: <20121109192336.GA9401@sigill.intra.peff.net>
 <87a9uq5tql.fsf@Niukka.kon.iki.fi>
 <20121110155209.75EFC2E8B68@grass.foxharp.boston.ma.us>
 <871ug15k5c.fsf@Niukka.kon.iki.fi>
 <20121110220811.DC6A42E8B68@grass.foxharp.boston.ma.us>
 <87wqxs4o6f.fsf@Niukka.kon.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Fox <pgf@foxharp.boston.ma.us>, git@vger.kernel.org
To: Kalle Olavi Niemitalo <kon@iki.fi>
X-From: git-owner@vger.kernel.org Sun Nov 11 16:49:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXZmR-00015h-Ss
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 16:49:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323Ab2KKPst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 10:48:49 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43887 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753066Ab2KKPst (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 10:48:49 -0500
Received: (qmail 32755 invoked by uid 107); 11 Nov 2012 15:49:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 11 Nov 2012 10:49:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2012 10:48:46 -0500
Content-Disposition: inline
In-Reply-To: <87wqxs4o6f.fsf@Niukka.kon.iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209394>

On Sun, Nov 11, 2012 at 09:02:48AM +0200, Kalle Olavi Niemitalo wrote:

> If git did the same thing as cvs here, i.e. ignore the signals in
> the parent process only and check the exit status of the editor,
> I think that would be OK.

Silly me. When I thought through the impact of Paul's patch, I knew that
we would notice signal death of the editor. But I totally forgot to
consider that the blocked signal is inherited by the child process. I
think we just need to move the signal() call to after we've forked. Like
this (on top of Paul's patch):

diff --git a/editor.c b/editor.c
index 3ca361b..0ed23ce 100644
--- a/editor.c
+++ b/editor.c
@@ -38,11 +38,20 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 
 	if (strcmp(editor, ":")) {
 		const char *args[] = { editor, path, NULL };
+		struct child_process p;
 		int ret;
 
+		memset(&p, 0, sizeof(p));
+		p.argv = args;
+		p.env = env;
+		p.use_shell = 1;
+		if (start_command(&p) < 0)
+			return error("unable to start editor '%s'", editor);
+
 		sigchain_push(SIGINT, SIG_IGN);
-		ret = run_command_v_opt_cd_env(args, RUN_USING_SHELL, NULL, env);
+		ret = finish_command(&p);
 		sigchain_pop(SIGINT);
+
 		if (ret)
 			return error("There was a problem with the editor '%s'.",
 					editor);

Note that this will give you a slightly verbose message from git.
Potentially we could notice editor death due to SIGINT and suppress the
message, under the assumption that the user hit ^C and does not need to
be told.

-Peff
