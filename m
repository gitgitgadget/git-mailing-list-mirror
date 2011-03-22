From: Jeff King <peff@peff.net>
Subject: Re: Weird behavior of shell variables in git aliases
Date: Tue, 22 Mar 2011 09:28:20 -0400
Message-ID: <20110322132820.GA14559@sigill.intra.peff.net>
References: <d9c38309-c433-476c-bba3-f2c5b7e94a89@k15g2000prk.googlegroups.com>
 <20110321215310.GA2122@sigill.intra.peff.net>
 <7v8vw8nmh2.fsf@alter.siamese.dyndns.org>
 <7v4o6wnlxm.fsf@alter.siamese.dyndns.org>
 <20110322111844.GA32446@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 14:28:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q21dO-00045a-V2
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 14:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756064Ab1CVN20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 09:28:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54488
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754189Ab1CVN2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 09:28:24 -0400
Received: (qmail 24503 invoked by uid 107); 22 Mar 2011 13:29:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 Mar 2011 09:29:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Mar 2011 09:28:20 -0400
Content-Disposition: inline
In-Reply-To: <20110322111844.GA32446@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169733>

On Tue, Mar 22, 2011 at 07:18:44AM -0400, Jeff King wrote:

> Doesn't it also break a lot of other more garden-variety aliases that
> rely on the automagic "$@", like:
> 
>   $ git config alias.log-nopager
>   !git --no-pager log
> [...]
>   $ GIT_TRACE=1 git.master log-nopager --oneline
>   trace: exec: 'git-log-nopager' '--oneline'
>   trace: run_command: 'git-log-nopager' '--oneline'
>   trace: run_command: 'git --no-pager log' '--oneline'
>   trace: exec: 'sh' '-c' 'git --no-pager log "$@"' 'git --no-pager log' '--oneline'
>   trace: built-in: git 'log' '--oneline'
>   93c7d44 foo
> 
>   $ GIT_TRACE=1 git.jch.shell-alias log-nopager --oneline
>   trace: exec: 'git-log-nopager' '--oneline'
>   trace: run_command: 'git-log-nopager' '--oneline'
>   trace: run_command: 'sh' '-c' 'git --no-pager log' '-' '--oneline'
>   trace: exec: 'sh' '-c' 'git --no-pager log' '-' '--oneline'
>   trace: built-in: git 'log'
>   commit 93c7d44635e8bb56a4fd864d024ce75a2ad4ffcf
>   Author: Jeff King <peff@peff.net>
>   Date:   Tue Mar 22 06:57:02 2011 -0400
> 
>       foo

One other solution would be to make the "$@" more magic by detecting
when the alias uses positional parameters and omitting it in that
case.  Something like (on top of your patch):

diff --git a/git.c b/git.c
index 8d54466..1daf89c 100644
--- a/git.c
+++ b/git.c
@@ -161,6 +161,27 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 	return handled;
 }
 
+static int alias_uses_positional_parameters(const char *s)
+{
+	while ((s = strchr(s, '$')))
+		if (s[1] == '@' || s[1] == '#' ||
+		   (s[1] >= '1' && s[1] <= '9'))
+			return 1;
+	return 0;
+}
+
+static char *alias_to_shell(const char *in)
+{
+	struct strbuf out = STRBUF_INIT;
+
+	if (alias_uses_positional_parameters(in))
+		return xstrdup(in);
+
+	strbuf_addstr(&out, in);
+	strbuf_addstr(&out, " \"$@\"");
+	return strbuf_detach(&out, NULL);
+}
+
 static int handle_alias(int *argcp, const char ***argv)
 {
 	int envchanged = 0, ret = 0, saved_errno = errno;
@@ -186,7 +207,7 @@ static int handle_alias(int *argcp, const char ***argv)
 			alias_argv = xmalloc(sizeof(*alias_argv) * (argc + 4));
 			alias_argv[0] = "sh";
 			alias_argv[1] = "-c";
-			alias_argv[2] = alias_string + 1;
+			alias_argv[2] = alias_to_shell(alias_string + 1);
 			alias_argv[3] = "-";
 			for (i = 1; i < argc; ++i)
 				alias_argv[i + 3] = (*argv)[i];


But I think that is a little too magic for my taste. Although the false
positives ("!echo 'literal $#'") and false negatives (you want "!foo" to
_ignore_ its parameters) are pretty obscure, I would prefer to keep
things simple.

-Peff
