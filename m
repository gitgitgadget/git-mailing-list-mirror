From: Jeff King <peff@peff.net>
Subject: Re: [BUG] crash on make test
Date: Fri, 4 Dec 2009 05:35:57 -0500
Message-ID: <20091204103557.GC27495@coredump.intra.peff.net>
References: <D6F784B72498304C93A8A4691967698E8EE2C44FE1@REX2.intranet.epfl.ch>
 <D6F784B72498304C93A8A4691967698E8EE2C44FE2@REX2.intranet.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Marinescu Paul dan <pauldan.marinescu@epfl.ch>
X-From: git-owner@vger.kernel.org Fri Dec 04 11:36:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGVWA-0002ES-Ht
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 11:36:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524AbZLDKfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 05:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754237AbZLDKfx
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 05:35:53 -0500
Received: from peff.net ([208.65.91.99]:49074 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbZLDKfx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 05:35:53 -0500
Received: (qmail 18737 invoked by uid 107); 4 Dec 2009 10:40:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 04 Dec 2009 05:40:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Dec 2009 05:35:57 -0500
Content-Disposition: inline
In-Reply-To: <D6F784B72498304C93A8A4691967698E8EE2C44FE2@REX2.intranet.epfl.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134505>

On Thu, Dec 03, 2009 at 04:38:58PM +0100, Marinescu Paul dan wrote:

> I got a crash on git's make test with and a core file in ./t/trash
> directory.t4200-rerere/ The problem seems to be in garbage_collect
> (builtin-rerere.c) where readdir can be called with a null pointer

Hmm. The problematic code is pretty straightforward to see, but what I
don't understand is how you managed to trigger it. The code path to get
there makes sure that the rr-cache directory exists (because we check
whether rerere is enabled, which means either rr-cache exists, or
rerere.enabled is set, and in the latter case we mkdir the directory).

I can see how it might happen if rr-cache exists but isn't readable. I
can easily trigger a segfault with:

  mkdir .git/rr-cache
  sudo chown root .git/rr-cache
  sudo chmod 0700 .git/rr-cache
  git gc

and we should definitely fix that (patch below).

But how do you end up with this situation in the middle of the test
suite? And if it is not a permissions problem, but that the directory is
missing, that would indicate something randomly deleting files while
you're running the test.

I think we should apply the patch below to maint, as this is something
that can come up due to permissions problems. But I fear it won't
actually fix the test failure you are seeing; you will just see it die()
instead of segfaulting. However, the value of errno should give us a
clue about what is happening, so please try running the test again with
this patch.

-- >8 --
Subject: [PATCH] rerere: don't segfault on failure to open rr-cache

The rr-cache directory should always exist if we are doing
garbage collection (earlier code paths check this
explicitly), but we may not necessarily succeed in opening
it (for example, due to permissions problems). In that case,
we should print an error message rather than simply
segfaulting.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-rerere.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-rerere.c b/builtin-rerere.c
index 343d6cd..2be9ffb 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -48,6 +48,8 @@ static void garbage_collect(struct string_list *rr)
 
 	git_config(git_rerere_gc_config, NULL);
 	dir = opendir(git_path("rr-cache"));
+	if (!dir)
+		die_errno("unable to open rr-cache directory");
 	while ((e = readdir(dir))) {
 		if (is_dot_or_dotdot(e->d_name))
 			continue;
-- 
1.6.6.rc1.18.ga777f.dirty
