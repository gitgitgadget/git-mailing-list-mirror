From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] report which $PATH entry had trouble running execvp(3)
Date: Wed, 20 Apr 2011 01:51:11 -0400
Message-ID: <20110420055111.GB28597@sigill.intra.peff.net>
References: <7v8vv78eld.fsf@alter.siamese.dyndns.org>
 <7vipub6r3s.fsf@alter.siamese.dyndns.org>
 <7vaafl371q.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 07:51:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCQJs-00037S-V2
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 07:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058Ab1DTFvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 01:51:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43529
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707Ab1DTFvP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 01:51:15 -0400
Received: (qmail 16266 invoked by uid 107); 20 Apr 2011 05:52:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Apr 2011 01:52:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Apr 2011 01:51:11 -0400
Content-Disposition: inline
In-Reply-To: <7vaafl371q.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171840>

On Tue, Apr 19, 2011 at 09:01:21PM -0700, Junio C Hamano wrote:

> You can add your own custom subcommand 'frotz' to the system by adding
> 'git-frotz' in a directory somewhere in your $PATH environment variable.
> When you ask "git frotz" from the command line, "git-frotz" is run via
> execvp(3).
> [...]
> we do not report 'git-frotz' in which directory we had trouble with.
> We could do better if we implemented the command search behaviour of
> execvp(3) ourselves.

I like the idea of giving the user more information about which
git-frotz was the problem. Usually there is just one, and pointing them
to it saves them time.

But what about the case of

  mkdir one two
  touch one/frotz two/frotz
  PATH=one:two:$PATH

We would report two/frotz, but might it be even better to say "we found
2 frotzes, but neither of them were executable"?

I don't know if it is worth the effort for such a weird corner case.

> Three plausible scenarios that the execvp(3) would fail for us are:
> 
>  * The first 'git-frotz' found in a directory on $PATH was not a proper
>    executable binary, and we got "Exec format error" (ENOEXEC);

What about the magic "unknown things get executed as shell scripts"
behavior that is implemented by libc's execvp? Your patch has a
regression for:

  echo "git log --with-some-options" >local/bin/git-frotz
  chmod +x local/bin/git-frotz
  git frotz

I have always found that behavior slightly insane, but it is
well-established, and your sane_execvp breaks anybody who is depending
on it.

> @@ -278,7 +324,7 @@ fail_pipe:
>  		} else if (cmd->use_shell) {
>  			execv_shell_cmd(cmd->argv);
>  		} else {
> -			execvp(cmd->argv[0], (char *const*) cmd->argv);
> +			cmd->argv[0] = sane_execvp(cmd->argv[0], cmd->argv);
>  		}
>  		/*
>  		 * Do not check for cmd->silent_exec_failure; the parent

This is inside "#ifndef WIN32". Presumably people on Windows want it,
too.  In fact, they already have their own execvp in compat/mingw.c. It
might make sense to bring the implementations together. Or perhaps not.
Theirs is quite different; it does a search of PATH itself, looking for
executables (and magically appending ".exe"), and then exec's the
result. On the other hand, doing that PATH lookup, deciding you have
something, and _then_ exec'ing can be convenient. IIRC, there are a few
warts in the git wrapper that could be improved by doing that, but I
don't recall the specifics anymore (maybe something like handling the
pager between the momemnt when we decide a command exists and when we
exec?).

-Peff
