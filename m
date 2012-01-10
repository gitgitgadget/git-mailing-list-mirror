From: Jeff King <peff@peff.net>
Subject: Re: [BUG] gitattribute macro expansion oddity
Date: Tue, 10 Jan 2012 12:11:00 -0500
Message-ID: <20120110171100.GA18962@sigill.intra.peff.net>
References: <20120110070300.GA17086@sigill.intra.peff.net>
 <4F0BFE6E.6080904@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Henrik =?utf-8?Q?Grubbstr=C3=B6m?= <grubba@grubba.org>,
	git-dev@github.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 10 18:11:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkfEJ-0006yO-Rj
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 18:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499Ab2AJRLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 12:11:07 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33710
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932508Ab2AJRLG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 12:11:06 -0500
Received: (qmail 11457 invoked by uid 107); 10 Jan 2012 17:17:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jan 2012 12:17:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jan 2012 12:11:00 -0500
Content-Disposition: inline
In-Reply-To: <4F0BFE6E.6080904@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188267>

On Tue, Jan 10, 2012 at 10:01:34AM +0100, Michael Haggerty wrote:

> On 01/10/2012 08:03 AM, Jeff King wrote:
> > I'm seeing some very odd behavior with git's attribute expansion for
> > diffs. You can see it with this repository:
> > 
> >   git clone git://github.com/libgit2/libgit2sharp.git
> > 
> > Try a diff of a non-binary file: [...]
> 
> The problem has nothing with diffing; simply interrogating the attribute
> values gives different results depending on the order of the files:
> 
> $ git check-attr --all Lib/NativeBinaries/x86/git2.dll
> LibGit2Sharp/Configuration.cs
> Lib/NativeBinaries/x86/git2.dll: binary: set
> Lib/NativeBinaries/x86/git2.dll: diff: unset
> Lib/NativeBinaries/x86/git2.dll: text: unset
> LibGit2Sharp/Configuration.cs: binary: set
> LibGit2Sharp/Configuration.cs: diff: unset
> LibGit2Sharp/Configuration.cs: text: unset
> LibGit2Sharp/Configuration.cs: crlf: set
> $ git check-attr --all LibGit2Sharp/Configuration.cs
> Lib/NativeBinaries/x86/git2.dll
> LibGit2Sharp/Configuration.cs: diff: csharp
> LibGit2Sharp/Configuration.cs: crlf: set
> Lib/NativeBinaries/x86/git2.dll: binary: set
> Lib/NativeBinaries/x86/git2.dll: diff: unset
> Lib/NativeBinaries/x86/git2.dll: text: unset

Thanks. I tried to test it with check-attr but for some reason wasn't
able to provoke the bug (I think I probably just screwed up the
invocation).

> It also doesn't depend on the fact that Lib/.gitattributes uses CRLF as
> its EOL, nor does it depend on the use of the "binary" macro.  However,
> it does depend on the fact that the directory name "Lib" matches the
> first part of the directory name "LibGit2Sharp".  Here is a simplified
> demonstration of the problem:

Ah, very helpful. That allowed me to find the problem very quickly by
grepping for "strncmp". :)

The patch below seem to fix it for me. I'll do a bit more testing before
posting it for real, though.

-Peff

diff --git a/attr.c b/attr.c
index 7467baf..f4beb62 100644
--- a/attr.c
+++ b/attr.c
@@ -528,7 +528,8 @@ static void prepare_attr_stack(const char *path, int dirlen)
 
 		elem = attr_stack;
 		if (namelen <= dirlen &&
-		    !strncmp(elem->origin, path, namelen))
+		    !strncmp(elem->origin, path, namelen) &&
+		    (!namelen || path[namelen] == '/' || path[namelen] == '\0'))
 			break;
 
 		debug_pop(elem);
