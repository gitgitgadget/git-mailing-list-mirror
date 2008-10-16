From: Jeff King <peff@peff.net>
Subject: Re: Detached checkout will clobber branch head when using symlink
	HEAD
Date: Thu, 16 Oct 2008 15:17:51 -0400
Message-ID: <20081016191751.GB14707@coredump.intra.peff.net>
References: <1224095087.5366.19.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matt Draisey <matt@draisey.ca>
X-From: git-owner@vger.kernel.org Thu Oct 16 21:19:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqYNO-0007M5-BK
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 21:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490AbYJPTRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 15:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756271AbYJPTRz
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 15:17:55 -0400
Received: from peff.net ([208.65.91.99]:4476 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755419AbYJPTRy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 15:17:54 -0400
Received: (qmail 9195 invoked by uid 111); 16 Oct 2008 19:17:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 16 Oct 2008 15:17:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Oct 2008 15:17:51 -0400
Content-Disposition: inline
In-Reply-To: <1224095087.5366.19.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98404>

On Wed, Oct 15, 2008 at 02:24:47PM -0400, Matt Draisey wrote:

> If HEAD is a symlink rather than a "ref:" style link this is really
> bad.

Hmm. I don't think we have shipped with a symlink HEAD for quite a long
time. Using one obviously doesn't work with detached HEAD, but also
would fail with packed refs. I don't know if we ever deprecated it.

Still, this is a pretty nasty effect, in that it kills whatever was in
the existing ref. There is a fix below which refuses to lock any ref if
it is a symlink and we have requested not to dereference (actually, it
is overly cautious -- the symlink flag is triggered when we see a
symlink anywhere in the chain, though we need only prevent the situation
when the _first_ symref is a symlink. I don't know if it is worth
differentiating, since they are both "should never happen anymore"
situations, I think).

---
diff --git a/refs.c b/refs.c
index b680750..43568e7 100644
--- a/refs.c
+++ b/refs.c
@@ -447,7 +447,7 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 				strcpy(ref_buffer, buffer);
 				ref = ref_buffer;
 				if (flag)
-					*flag |= REF_ISSYMREF;
+					*flag |= REF_ISSYMREF | REF_ISSYMLINK;
 				continue;
 			}
 		}
@@ -817,6 +817,10 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 		}
 		ref = resolve_ref(orig_ref, lock->old_sha1, mustexist, &type);
 	}
+	if (type & REF_ISSYMLINK && flags & REF_NODEREF) {
+		error("unable to directly lock symbolic link '%s'", orig_ref);
+		goto error_return;
+	}
 	if (type_p)
 	    *type_p = type;
 	if (!ref) {
diff --git a/refs.h b/refs.h
index 06ad260..6356a6a 100644
--- a/refs.h
+++ b/refs.h
@@ -12,6 +12,7 @@ struct ref_lock {
 
 #define REF_ISSYMREF 01
 #define REF_ISPACKED 02
+#define REF_ISSYMLINK 04
 
 /*
  * Calls the specified function for each ref file until it returns nonzero,
