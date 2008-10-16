From: Jeff King <peff@peff.net>
Subject: Re: Detached checkout will clobber branch head when using symlink
	HEAD
Date: Thu, 16 Oct 2008 16:39:16 -0400
Message-ID: <20081016203916.GB9487@coredump.intra.peff.net>
References: <1224095087.5366.19.camel@localhost> <20081016191751.GB14707@coredump.intra.peff.net> <1224187863.2796.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matt Draisey <matt@draisey.ca>
X-From: git-owner@vger.kernel.org Thu Oct 16 22:40:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqZe3-00054y-Tf
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 22:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041AbYJPUjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 16:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754281AbYJPUjT
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 16:39:19 -0400
Received: from peff.net ([208.65.91.99]:1169 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259AbYJPUjT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 16:39:19 -0400
Received: (qmail 9872 invoked by uid 111); 16 Oct 2008 20:39:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 16 Oct 2008 16:39:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Oct 2008 16:39:16 -0400
Content-Disposition: inline
In-Reply-To: <1224187863.2796.15.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98422>

On Thu, Oct 16, 2008 at 04:11:03PM -0400, Matt Draisey wrote:

> I am using the following system defaults:
> 
> core.prefersymlinkrefs=true
> gc.packrefs=false
> 
> so almost all my git repositories are still using a symlink HEAD.
> I have some old scripts That I use occasionally and still depend on it.
> Using detached checkout is the only problem I've had.

In your position I would consider updating my scripts. But I guess you
could also try to work up a patch that makes detached HEAD work
(replacing the symlink with a file, then bringing back the symlink when
you're on a branch). In the meantime, here is a cleaned-up version of my
patch, with a proper commit message and a test.

-- >8 --
do not clobber symlinked ref with detached HEAD

The default configuration for git uses a symref for HEAD.
When we detach the HEAD, we can simply write the detached
commit sha1 into the HEAD file.

It is still possible to use symlinks for HEAD (either by
setting it up manually, or by using core.prefersymlinkrefs).
In that case, moving to a detached HEAD is impossible, since
we have nowhere to store the sha1.

However, the current code doesn't realize this and actually
writes into the HEAD file anyway, meaning that it overwrites
the value of the currently checked out branch.

Instead, let's detect in the locking mechanism that we have
a symlink but the caller requested that we lock the original
ref name instead of its linked destination. This has two
advantages:

  - we don't have to add an extra stat call, since we
    discover the symlink during normal ref resolution

  - any code to update a ref should lock it, meaning that we
    should catch any other similar instances

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c                      |    9 ++++++++-
 refs.h                      |    1 +
 t/t7202-checkout-symlink.sh |   19 +++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletions(-)
 create mode 100755 t/t7202-checkout-symlink.sh

diff --git a/refs.c b/refs.c
index b680750..b4b3865 100644
--- a/refs.c
+++ b/refs.c
@@ -446,8 +446,11 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 				buffer[len] = 0;
 				strcpy(ref_buffer, buffer);
 				ref = ref_buffer;
-				if (flag)
+				if (flag) {
+					if (!(*flag & REF_ISSYMREF))
+						*flag |= REF_OUTER_IS_SYMLINK;
 					*flag |= REF_ISSYMREF;
+				}
 				continue;
 			}
 		}
@@ -817,6 +820,10 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 		}
 		ref = resolve_ref(orig_ref, lock->old_sha1, mustexist, &type);
 	}
+	if (type & REF_OUTER_IS_SYMLINK && flags & REF_NODEREF) {
+		error("unable to directly lock symbolic link '%s'", orig_ref);
+		goto error_return;
+	}
 	if (type_p)
 	    *type_p = type;
 	if (!ref) {
diff --git a/refs.h b/refs.h
index 06ad260..9b0dcd9 100644
--- a/refs.h
+++ b/refs.h
@@ -12,6 +12,7 @@ struct ref_lock {
 
 #define REF_ISSYMREF 01
 #define REF_ISPACKED 02
+#define REF_OUTER_IS_SYMLINK 04
 
 /*
  * Calls the specified function for each ref file until it returns nonzero,
diff --git a/t/t7202-checkout-symlink.sh b/t/t7202-checkout-symlink.sh
new file mode 100755
index 0000000..cf09f5f
--- /dev/null
+++ b/t/t7202-checkout-symlink.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+test_description='checkout with symlinked HEAD'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo one > file && git add file && git commit -m one &&
+	echo two > file && git add file && git commit -m two &&
+	ln -sf refs/heads/master .git/HEAD
+'
+
+test_expect_success 'checkout detached HEAD does not clobber ref' '
+	test_must_fail git checkout HEAD^ &&
+	echo two >expect &&
+	git log -1 --pretty=tformat:%s >actual
+	test_cmp actual expect
+'
+
+test_done
-- 
1.6.0.2.711.gf1ba4.dirty
