From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/2] Re: [PATCH] config: warn on inaccessible files
Date: Sun, 14 Oct 2012 02:16:22 -0400
Message-ID: <20121014061622.GA13477@sigill.intra.peff.net>
References: <20121014000210.GA19094@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 08:16:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNHVH-0006Sq-N9
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 08:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349Ab2JNGQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 02:16:30 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51958 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752252Ab2JNGQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 02:16:29 -0400
Received: (qmail 18436 invoked by uid 107); 14 Oct 2012 06:17:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 14 Oct 2012 02:17:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Oct 2012 02:16:22 -0400
Content-Disposition: inline
In-Reply-To: <20121014000210.GA19094@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207639>

On Sat, Oct 13, 2012 at 05:02:10PM -0700, Jonathan Nieder wrote:

> > Before reading a config file, we check "!access(path, R_OK)"
> > to make sure that the file exists and is readable. If it's
> > not, then we silently ignore it.
> 
> git became noisy:
> 
>  $ git fetch --all
>  warning: unable to access '/home/jrn/.config/git/config': Not a directory
> [...]

I somehow thought that we had dealt with this ENOTDIR already, but I see
that 8e950da only dealt with .gitattributes, which may look for
arbitrary path names that are not reflected in the current working tree.

We didn't ignore ENOTDIR for config files at the same time, because it
is not obvious that such a bogus config path is not something the user
would want to know about.

> On this machine, ~/.config/git has been a regular file for a while,
> with ~/.gitconfig a symlink to it.  Probably ENOTDIR should be ignored
> just like ENOENT is.  Except for the noise, the behavior is fine, but
> something still feels wrong.

Hmm. Your use of ~/.config/git is interesting. Recent versions of git
will look in ~/.config (or $XDG_CONFIG_HOME), but they want to find
"git/config" there, and your single file is in conflict with that. So
this has nothing to do with ~/.gitconfig, or the fact that it is
symlinked. This is the XDG lookup code kicking in, because you happened
to put your file in the same place, and then afterwards git learned to
look there (albeit with a slightly different format).

So on the one hand, this ENOTDIR is uninteresting, because it is not
really about an error with the file we are trying to open at all, but
simply another way of saying "the file does not exist". And therefore it
should be ignored.

On the other hand, it is actually alerting you to an unusual situation
that you might want to fix (you are putting stuff in the XDG config
directory, but it is not in the format git wants).

I don't have a strong preference about what should happen, but I would
lean towards your first patch. ENOTDIR really is just another way of
saying ENOENT (it just gives more information about the leading paths).
It did find a configuration oddity you might want to fix, but that
oddity was not actually hurting anything.

> When ~/.gitconfig is unreadable (EPERM), the messages are a symptom of
> an older issue: the config file is being ignored.  Shouldn't git error
> out instead so the permissions can be fixed?  E.g., if the sysadmin
> has set "[branch] autoSetupRebase" to true in /etc/gitconfig and I
> have set it to false in my own ~/.gitconfig, I'd rather see git error
> out because ~/.gitconfig has become unreadable in a chmod gone wrong
> than have a branch set up with the wrong settings and have to learn to
> fix it up myself.

This is a separate issue from above. I tend to agree that dying would be
better in most cases, because an operation may not do what you want if
opening the config fails (for an even worse example, considering
something like receive-pack trying to figure out if receive.denyDeletes
is set).

I considered doing this when I wrote the original patch, but was mainly
worried about regressions in weird situations. The two I can think of
are:

  1. You are inspecting somebody else's repo, but you do not have access
     to their .git/config file. But then, I think that is probably a
     sane time to die anyway, since we cannot read core.repositoryFormatVersion.

  2. You have used sudo or some other tool to switch uid, but your
     environment still points git at your original user's global config,
     which may not be readable.

Those are unusual situations, though. It probably makes more sense for
us to be conservative in the common case and die. Case 1 is pretty
insane and should probably involve dying anyway. Case 2 people may be
inconvenienced (they would rather see the harmless warning and continue
the operation), but they can work around it by setting up their
environment properly after switching uids.

> In other words, how about something like this?
> 
> Jonathan Nieder (2):
>   config, gitignore: failure to access with ENOTDIR is ok
>   config: treat user and xdg config permission problems as errors

Yeah, those look sane, modulo a question about the second one (I'll
reply directly).

-Peff
