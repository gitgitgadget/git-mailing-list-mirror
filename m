From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 4/3] create_symref: drop support for writing symbolic
 links
Date: Wed, 30 Dec 2015 01:53:44 -0500
Message-ID: <20151230065343.GA26964@sigill.intra.peff.net>
References: <20151229055558.GA12848@sigill.intra.peff.net>
 <20151229060055.GA17047@sigill.intra.peff.net>
 <xmqqbn99hzrv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 07:54:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEAdz-0008AR-46
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 07:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbbL3Gxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 01:53:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:47025 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751017AbbL3Gxq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 01:53:46 -0500
Received: (qmail 16609 invoked by uid 102); 30 Dec 2015 06:53:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Dec 2015 00:53:46 -0600
Received: (qmail 28375 invoked by uid 107); 30 Dec 2015 06:53:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Dec 2015 01:53:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Dec 2015 01:53:44 -0500
Content-Disposition: inline
In-Reply-To: <xmqqbn99hzrv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283163>

On Tue, Dec 29, 2015 at 10:32:04AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > A conservative choice would probably be to issue a deprecation warning
> > when we see it defined, wait a few versions, and then apply the patch
> > below.
> 
> I agree with the analysis below.  And I agree that in the ideal
> world, it would have been better not to add "prefer symlink refs"
> configuration in the first place.  But we do not live in the ideal
> world, and we already have it, so deprecation would need the usual
> multi-step process.

Here's the first step of that multi-step process. The commit message
will look familiar, as the rationale for deprecating is the same as for
dropping.

This is on top of what I posted earlier (it obviously could be
independent, but I assume we're planning to merge the other bits, and I
don't mind holding this topic hostage for a little while to save some
annoying merging).

-- >8 --
Subject: [PATCH] create_symref: deprecate support for writing symbolic links

Long ago, in 2fabd21 (Disable USE_SYMLINK_HEAD by default,
2005-11-15), we switched git's default behavior to writing
text symrefs instead of symbolic links. Any scripts
accustomed to looking directly at .git/HEAD were updated to
use `rev-parse` instead. The Linux kernel's setlocalversion
script was one, and it was fixed in 117a93d (kbuild: Use git
in scripts/setlocalversion, 2006-01-04).

However, the problem still happened when bisecting the
kernel; pre-117a93d would not build properly with a newer
git, because they wanted to look directly at HEAD. To solve
this, we added 9f0bb90 (core.prefersymlinkrefs: use symlinks
for .git/HEAD, 2006-05-02), which lets the user turn on the
old behavior, theoretically letting you bisect older kernel
history.

But there are a few complications with this solution:

  - packed-refs means you are limited in what you can do
    with .git/HEAD. If it is a symlink, you may `readlink`
    it to see where it points, but you cannot necessarily
    `cat .git/HEAD` to get the sha1, as the pointed-to ref
    may be packed.

    In particular, this means that the pre-117a93d kbuild
    script would sometimes work and sometimes not.

  - These days, we bisect on a detached HEAD. So during
    bisection, .git/HEAD _is_ a regular file with the
    sha1, and it works to `cat` it, whether or not you set
    core.preferSymlinkRefs.

Such scripts will all be broken again if we move to
alternate ref backends. They should have learned to use
`rev-parse` long ago, and it is only bisecting ancient
history that is a problem.

Now that almost ten years have passed, it seems less likely
that developers will bisect so far back in history. And
moreover, this is but one of many possible problems
developers run into when trying to build versions. The
standard solution is to apply a "fixup" patch or other
workaround while test-building the project, and that would
work here, too.

This patch therefore deprecates core.preferSymlinkRefs
completely. There are a few reasons to want to do so:

  1. It drops some code that is probably exercised very
     rarely.

  2. The symlink code is not up to the same standards as the
     rest of the ref code. In particular, it is racy with
     respect to simultaneous readers and writers.

  3. If we want to eventually drop the symlink-reading code,
     this is a good first step to deprecating it.

We print a deprecation warning anytime a symlink is created
using this code. That prevents us from spamming the user
with multiple warnings from read-only operations, but
catches major operations like init, clone, and checkout.

Signed-off-by: Jeff King <peff@peff.net>
---
There's no advice.* safety valve here. The solution is "fix your
script", and the last-ditch effort is "come to the mailing list and tell
us why it would be a bad thing to remove the feature".

 refs/files-backend.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 180c837..22b7c11 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2860,12 +2860,27 @@ static int create_symref_locked(struct ref_lock *lock, const char *refname,
 	return 0;
 }
 
+static const char symlink_deprecation_warning[] =
+"The core.preferSymlinkRefs configuration option has been\n"
+"deprecated and will be removed in a future version of Git. If your\n"
+"workflow or script depends on '.git/HEAD' being a symbolic link,\n"
+"it should be adjusted to use:\n"
+"\n"
+"        git rev-parse HEAD\n"
+"\n"
+"        git rev-parse --symbolic-full-name HEAD\n"
+"\n"
+"to get the sha1 or branch name, respectively.";
+
 int create_symref(const char *refname, const char *target, const char *logmsg)
 {
 	struct strbuf err = STRBUF_INIT;
 	struct ref_lock *lock;
 	int ret;
 
+	if (prefer_symlink_refs)
+		warning("%s", symlink_deprecation_warning);
+
 	lock = lock_ref_sha1_basic(refname, NULL, NULL, NULL, REF_NODEREF, NULL,
 				   &err);
 	if (!lock) {
-- 
2.7.0.rc3.367.g09631da
