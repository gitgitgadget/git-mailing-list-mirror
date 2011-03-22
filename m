From: Jeff King <peff@peff.net>
Subject: Re: Weird behavior of shell variables in git aliases
Date: Tue, 22 Mar 2011 09:43:58 -0400
Message-ID: <20110322134358.GA19064@sigill.intra.peff.net>
References: <d9c38309-c433-476c-bba3-f2c5b7e94a89@k15g2000prk.googlegroups.com>
 <20110321215310.GA2122@sigill.intra.peff.net>
 <7v8vw8nmh2.fsf@alter.siamese.dyndns.org>
 <7v4o6wnlxm.fsf@alter.siamese.dyndns.org>
 <20110322111844.GA32446@sigill.intra.peff.net>
 <20110322132820.GA14559@sigill.intra.peff.net>
 <AANLkTin3fXkGaC5cTVny5adU=FusQV0WAcPHLUEeEzLi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, git@vger.kernel.org
To: Lasse Makholm <lasse.makholm@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 14:44:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q21sZ-0004NG-4W
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 14:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094Ab1CVNoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 09:44:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59019
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932081Ab1CVNoE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 09:44:04 -0400
Received: (qmail 24744 invoked by uid 107); 22 Mar 2011 13:44:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 Mar 2011 09:44:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Mar 2011 09:43:58 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTin3fXkGaC5cTVny5adU=FusQV0WAcPHLUEeEzLi@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169737>

On Tue, Mar 22, 2011 at 02:35:10PM +0100, Lasse Makholm wrote:

> On 22 March 2011 14:28, Jeff King <peff@peff.net> wrote:
> > But I think that is a little too magic for my taste. Although the false
> > positives ("!echo 'literal $#'") and false negatives (you want "!foo" to
> > _ignore_ its parameters) are pretty obscure, I would prefer to keep
> > things simple.
> 
> Then how about simply:
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 6468a68..8097480 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -586,9 +586,16 @@ If the alias expansion is prefixed with an
> exclamation point,
>  it will be treated as a shell command.  For example, defining
>  "alias.new = !gitk --all --not ORIG_HEAD", the invocation
>  "git new" is equivalent to running the shell command
> -"gitk --all --not ORIG_HEAD".  Note that shell commands will be
> -executed from the top-level directory of a repository, which may
> -not necessarily be the current directory.
> +"gitk --all --not ORIG_HEAD". Note that any arguments you pass
> +when running aliases are simply appended to the shell command.
> +This means that "alias.foo = !echo $# args: $1, $2 and $3" will
> +not do what you expect. To use alias arguments as positional
> +parameters, wrap your command in a shell function:
> +"alias.foo = !foo () { echo $# args: $1, $2 and $3; }; foo"
> ++
> +Shell commands will be executed from the top-level directory
> +of a repository, which may not necessarily be the current
> +directory.

Yeah, that certainly improves the situation.

A small formatting nit: Those long commands with punctuation get hard to
read in the middle of a paragraph. Maybe something like this on top:

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3916665..d2b7515 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -582,10 +582,18 @@ it will be treated as a shell command.  For example, defining
 "git new" is equivalent to running the shell command
 "gitk --all --not ORIG_HEAD". Note that any arguments you pass
 when running aliases are simply appended to the shell command.
-This means that "alias.foo = !echo $# args: $1, $2 and $3" will
-not do what you expect. To use alias arguments as positional
+This means that
++
+----------------------
+alias.foo = !echo $# args: $1, $2 and $3
+----------------------
++
+will not do what you expect. To use alias arguments as positional
 parameters, wrap your command in a shell function:
-"alias.foo = !foo () { echo $# args: $1, $2 and $3; }; foo"
++
+----------------------
+alias.foo = !foo () { echo $# args: $1, $2 and $3; }; foo
+----------------------
 +
 Shell commands will be executed from the top-level directory
 of a repository, which may not necessarily be the current

-Peff

PS Your patch was wrapped on the @@ line. You might want to check your
   mailer settings.
