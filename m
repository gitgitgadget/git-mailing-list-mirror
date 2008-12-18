From: Jeff King <peff@peff.net>
Subject: Re: Suggestion: better error reporting when setting HEAD
Date: Thu, 18 Dec 2008 03:25:51 -0500
Message-ID: <20081218082551.GA29356@coredump.intra.peff.net>
References: <20081218055825.GQ6708@isafjordur.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	sam.vilain@catalyst.net.nz
To: Francois Marier <francois@debian.org>
X-From: git-owner@vger.kernel.org Thu Dec 18 09:27:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDEDw-00085I-5t
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 09:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbYLRIZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 03:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbYLRIZz
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 03:25:55 -0500
Received: from peff.net ([208.65.91.99]:2686 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470AbYLRIZy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 03:25:54 -0500
Received: (qmail 32711 invoked by uid 111); 18 Dec 2008 08:25:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Dec 2008 03:25:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Dec 2008 03:25:51 -0500
Content-Disposition: inline
In-Reply-To: <20081218055825.GQ6708@isafjordur.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103445>

[Junio cc'd, as I think he may have comments on the patch at the end]

On Thu, Dec 18, 2008 at 06:58:25PM +1300, Francois Marier wrote:

> If you take any valid git repo and then do the following:
> 
>   git symbolic-ref HEAD master
>   (instead of "git symbolic-ref HEAD refs/heads/master")
> 
> then other git commands (e.g. "git log") will return this error message:
> 
>   fatal: Not a git repository

I've done this exact same thing, and it is very annoying.

> I'd like to suggest two "usability" improvements:
> 
> 1- changing the error message to explain why the directory is no longer
>    considered a git repo. Maybe something along the lines of:
> 
>      fatal: Invalid reference in .git/HEAD

This can be done, but is more complex than you might hope; the test for
"is this is a git directory" may get run multiple times while trying to
find out if we are in a repo. So giving a reason why we aren't in a git
repo is going to end up something like:

  I tried X, but its HEAD ref had cruft in it;
  then I tried Y, but it had no HEAD file;
  then I gave up

Obviously with a working tree, the first directory with the '.git' repo
is a likely candidate for being the right thing, but with an error. But
if you are looking for a bare repository, then it could be any parent
directory. Maybe it is worth just spewing "there is a HEAD file here,
but it doesn't look right" when it fails to validate. It would give a
false positive if you had a file named HEAD (and you weren't actually in
a git repo), but that is unlikely to happen. And if you get multiple
ones, so be it.

> 2- To prevent this error from happening in the first place, git-symbolic-ref
>    could refuse to change HEAD to a non-existent ref.

Actually, we sometimes need to point to non-existent refs; these are
"branches yet to be born". The reason that the new HEAD doesn't validate
is that it is supposed to start with "refs/".

We could fix it like this:

diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
index bfc78bb..08fa3ce 100644
--- a/builtin-symbolic-ref.c
+++ b/builtin-symbolic-ref.c
@@ -44,6 +44,8 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 		check_symref(argv[0], quiet);
 		break;
 	case 2:
+		if (prefixcmp(argv[1], "refs/"))
+			die("Refusing to point %s outside of refs/", argv[0]);
 		create_symref(argv[0], argv[1], msg);
 		break;
 	default:

which tries to match the behavior used by validate_headref, but there
are a few open questions:

 - Should it require this of _all_ symbolic refs, or just HEAD?

 - Should there be a "-f" force option?

 - Should it be moved to the create_symref library function. It gets
   called in several places, and I didn't audit all of them.

 - I looked at trying to share validate_headref's logic (so they don't
   get out of sync), but really the only thing that applies is the
   "refs" check. The rest is about checking parts of the symref that are
   outside of the actual content.

 - This doesn't allow a sha1 for detached HEAD. However, that currently
   doesn't work _anyway_, as it creates a HEAD with "ref: $SHA1", which
   is totally bogus.

-Peff
