From: Jeff King <peff@peff.net>
Subject: Re: feature request - have git honor nested .gitconfig files
Date: Fri, 22 Mar 2013 14:33:06 -0400
Message-ID: <20130322183306.GA32448@sigill.intra.peff.net>
References: <CAM2RUGOOWnxRd2=04-NmKTC+tvnCD=ebgmmiexHas5bwyYrm4w@mail.gmail.com>
 <20130322182211.GD12223@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Josh Sharpe <josh.m.sharpe@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 19:33:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ6md-0003Qp-0g
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 19:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422876Ab3CVSdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 14:33:15 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35979 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422817Ab3CVSdP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 14:33:15 -0400
Received: (qmail 3934 invoked by uid 107); 22 Mar 2013 18:34:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Mar 2013 14:34:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Mar 2013 14:33:06 -0400
Content-Disposition: inline
In-Reply-To: <20130322182211.GD12223@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218834>

On Fri, Mar 22, 2013 at 11:22:11AM -0700, Jonathan Nieder wrote:

>  * Maintaining configuration per repository to record a rather simple
>    is more complicated than ideal.  It would be easier to understand
>    the configuration if ~/.gitconfig could spell out the rule
>    explicitly:
> 
> 	[include]
> 		path = cond(starts_with($GIT_DIR, ~/dev/),
> 			    ~/.config/git/dev-config,
> 			    ~/.config/git/nondev-config)
> 
>    This means supporting an extension language in the config file.
>    It sounds hard to do right, especially considering use cases like
>    "User runs into trouble, asks a privileged sysadmin to try running
>    a command in her untrusted repository", but it is worth thinking
>    about how to do.

I'd rather not invent a new language. It will either not be featureful
enough, or will end up bloated. Or both. How about something like:

  [include]
       exec = "
         case \"$GIT_DIR\" in)
           */dev/*) cat ~/.config/git/dev-config ;;
                 *) cat ~/.config/git/nondev-config ;;
          esac
       "

It involves a shell invocation, but it's not like we parse config in a
tight loop. Bonus points if git provides the name of the current config
file, so exec can use relative paths like:

  cat "$(dirname $GIT_CONFIG_FILE)"/dev-config

>  * The "Includes" facility is annoyingly close to being helpful.
>    An include.path setting from ~/.gitconfig cannot refer to $GIT_DIR
>    by name.

Yeah, we do not allow variable expansion at all beyond the usual path
mechanisms. I think if you had $GIT_DIR, though, it would end up
annoying.  You do not want one file in ~/.config/git per $GIT_DIR, so
you would need some way of munging $GIT_DIR into your naming scheme.

-Peff
