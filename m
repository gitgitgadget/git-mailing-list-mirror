From: Jeff King <peff@peff.net>
Subject: Re: error: Unable to append to
	.git/logs/refs/remotes/origin/master: Permission denied
Date: Wed, 29 Apr 2009 00:07:20 -0400
Message-ID: <20090429040719.GA14912@coredump.intra.peff.net>
References: <20090428073138.GA9094@elte.hu> <20090429032943.GB8826@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Apr 29 06:07:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz151-0002Gr-It
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 06:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbZD2EHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 00:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbZD2EHX
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 00:07:23 -0400
Received: from peff.net ([208.65.91.99]:60404 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696AbZD2EHW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 00:07:22 -0400
Received: (qmail 2575 invoked by uid 107); 29 Apr 2009 04:07:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 29 Apr 2009 00:07:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Apr 2009 00:07:20 -0400
Content-Disposition: inline
In-Reply-To: <20090429032943.GB8826@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117844>

On Tue, Apr 28, 2009 at 11:29:43PM -0400, Jeff King wrote:

> Note the repeated use of "hopefully". :) Maybe the earlier message is
> too hidden to rely on. We might be able to get by with checking "errno"
> for ENOTDIR after trying to lock the ref and using a different message,
> but I don't know how portable that will be.

Hmm, that actually doesn't work. errno is properly EACCESS in your
example, but the D/F problem doesn't actually set errno, since it is git
itself, and not a failed syscall, that determines that "foo/bar" is not
available because "foo" exists (and git must do it, because "foo" may be
a packed ref).

So I think we would need to simulate the errno setting, like the patch
below. That should generate the hint only when it would actually be
useful.

---
diff --git a/builtin-fetch.c b/builtin-fetch.c
index 0bb290b..ad00bd2 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -181,9 +181,9 @@ static int s_update_ref(const char *action,
 	lock = lock_any_ref_for_update(ref->name,
 				       check_old ? ref->old_sha1 : NULL, 0);
 	if (!lock)
-		return 2;
+		return errno == ENOTDIR ? 2 : 1;
 	if (write_ref_sha1(lock, ref->new_sha1, msg) < 0)
-		return 2;
+		return errno == ENOTDIR ? 2 : 1;
 	return 0;
 }
 
diff --git a/refs.c b/refs.c
index e65a3b4..79795d0 100644
--- a/refs.c
+++ b/refs.c
@@ -893,8 +893,10 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-            !is_refname_available(ref, NULL, get_packed_refs(), 0))
+            !is_refname_available(ref, NULL, get_packed_refs(), 0)) {
+		last_errno = ENOTDIR;
 		goto error_return;
+	}
 
 	lock->lk = xcalloc(1, sizeof(struct lock_file));
 
