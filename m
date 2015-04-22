From: Jeff King <peff@peff.net>
Subject: [PATCH] stop putting argv[0] dirname at front of PATH
Date: Wed, 22 Apr 2015 14:14:02 -0400
Message-ID: <20150422181402.GB3535@peff.net>
References: <CAKuTQSGEmHHr-c+Tc2jM-JPkx6+_f3gp8Zjj8EuQy_e4=PvMzg@mail.gmail.com>
 <xmqqk2xe39zt.fsf@gitster.dls.corp.google.com>
 <CAKuTQSGapeUeZptdX1=Uv441Moo6X19RNR0oySU--F+Kj6Xz=w@mail.gmail.com>
 <20150416061732.GA5612@peff.net>
 <xmqq1tjcf432.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David =?utf-8?Q?Rodr=C3=ADguez?= <deivid.rodriguez@gmail.com>,
	Matthew Rothenberg <mroth@khanacademy.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 20:14:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkzA4-0003aD-6H
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 20:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbbDVSOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 14:14:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:48688 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752113AbbDVSOF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 14:14:05 -0400
Received: (qmail 4318 invoked by uid 102); 22 Apr 2015 18:14:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 13:14:05 -0500
Received: (qmail 12463 invoked by uid 107); 22 Apr 2015 18:14:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 14:14:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2015 14:14:02 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1tjcf432.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267606>

On Wed, Apr 22, 2015 at 10:46:57AM -0700, Junio C Hamano wrote:

> > If we can get away with just dropping this element from the PATH, I'd
> > much rather do that than try to implement a complicated path-precedence
> > scheme.
> 
> I am OK with dropping it at a major version boundary with
> deprecation notice in the release note.  Unlike older days, by now,
> Git has become so essential to users' everyday life, and there is
> not much reason for people to keep the installation of Git they
> built outside their $PATH, and "alias git=/opt/git/bin/git" has lost
> much of its value, I would think.

Actually, on looking further into it, I am not sure that the use-case
originally presented hasn't simply been broken since 2007. The patch
below is trivial, but I've tried to summarize the situation in the
commit message.

If we are really breaking workflows, I agree on the deprecation. But I
think we may not be, in which case it would be fine (IMHO) to skip the
deprecation notice.

-- >8 --
Subject: stop putting argv[0] dirname at front of PATH

When the "git" wrapper is invoked, we prepend the baked-in
exec-path to our PATH, so that any sub-processes we exec
will all find the git-foo commands that match the wrapper
version.

If you invoke git with an absolute path, like:

  /usr/bin/git foo

we also prepend "/usr/bin" to the PATH. This was added long
ago by by 231af83 (Teach the "git" command to handle some
commands internally, 2006-02-26), with the intent that
things would just work if you did something like:

  cd /opt
  tar xzf premade-git-package.tar.gz
  alias git=/opt/git/bin/git

as we would then find all of the related external commands
in /opt/git/bin. I.e., it made git runtime-relocatable,
since at the time of 231af83, we installed all of the git
commands into $(bindir). But these days, that is not enough.
Since f28ac70 (Move all dashed-form commands to libexecdir,
2007-11-28), we do not put commands into $(bindir), and you
actually need to convert "/usr/bin" into "/usr/libexec". And
not just for finding binaries; we want to find $(sharedir),
etc, the same way.  The RUNTIME_PREFIX build knob does this
the right way, by assuming a sane hierarchy rooted at
"$prefix" when we run "$prefix/bin/git", and inferring
"$prefix/libexec/git-core", etc.

So this feature (prepending the argv[0] dirname to the PATH)
is broken for providing a runtime prefix, and has been for
many years. Does it do anything for other cases?

For the "git" wrapper itself, as well as any commands
shipped by "git", the answer is no. Those are already in
git's exec-path, which is consulted first. For third-party
commands which you've dropped into the same directory, it
does include them. So if you do

  cd /opt
  tar xzf git-built-specifically-for-opt-git.tar.gz
  cp third-party/git-foo /opt/git/bin/git-foo
  alias git=/opt/git/bin/git

it does mean that we will find the third-party "git-foo",
even if you do not put /opt/git/bin into your $PATH. But
the flipside of this is that we will bump the precedence of
_other_ third-party tools that happen to be in the same
directory as git. For example, consider this setup:

  1. Git is installed by the system in /usr/bin. There are
     other system utilities in /usr/bin. E.g., a system
     "vi".

  2. The user installs tools they prefer in /usr/local/bin.
     E.g., vim with a "vi" symlink. They set their PATH to
     /usr/local/bin:/usr/bin to prefer their custom tools.

  3. Running /usr/bin/git puts "/usr/bin" at the front of
     their PATH. When git invokes the editor on behalf of
     the user, they get the system vi, not their normal vim.

There are other variants of this, including overriding
system ruby and python (which is quite common using tools
like "rvm" and "virtualenv", which use relocatable
hierarchies and $PATH settings to get a consistent
environment).

Given that the main motivation for git pulling the argv[0]
dirname into the PATH has been broken for years, that the
remaining cases are obscure and unlikely (and easily fixed
by the user just setting up their $PATH sanely), and that
the behavior is hurting real, reasonably common use cases,
it's not worth continuing to do so.

Signed-off-by: Jeff King <peff@peff.net>
---
If people _are_ interested in relocatable binary packages, I think
RUNTIME_PREFIX is the right way forward. But note that you can't just
flip on RUNTIME_PREFIX on non-Windows systems, as some invocations will
get the full path to the executable, and others see just "git". You'd
need to convert that into an absolute path (either by searching the
$PATH, or doing something system-specific like looking in /proc/$$/exe).

 exec_cmd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 8ab37b5..e85f0fd 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -96,7 +96,6 @@ void setup_path(void)
 	struct strbuf new_path = STRBUF_INIT;
 
 	add_path(&new_path, git_exec_path());
-	add_path(&new_path, argv0_path);
 
 	if (old_path)
 		strbuf_addstr(&new_path, old_path);
-- 
2.4.0.rc2.498.g02440db
