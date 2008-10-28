From: Jeff King <peff@peff.net>
Subject: Re: error pushing stash ?
Date: Tue, 28 Oct 2008 17:17:55 -0400
Message-ID: <20081028211755.GA8074@sigill.intra.peff.net>
References: <20081007003435.GZ5774@eratosthenes.cryptobackpack.org> <20081007004051.GA18889@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Bryson <david@statichacks.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 28 22:19:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kuvy4-0007OA-7p
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 22:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbYJ1VR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 17:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107AbYJ1VR7
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 17:17:59 -0400
Received: from peff.net ([208.65.91.99]:1905 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752188AbYJ1VR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 17:17:59 -0400
Received: (qmail 23729 invoked by uid 111); 28 Oct 2008 21:17:58 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 28 Oct 2008 17:17:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Oct 2008 17:17:55 -0400
Content-Disposition: inline
In-Reply-To: <20081007004051.GA18889@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99324>

On Mon, Oct 06, 2008 at 05:40:51PM -0700, Shawn O. Pearce wrote:

> >  ! [remote rejected] refs/stash -> refs/stash (funny refname)
> > error: failed to push some refs to '/users/dbryson/backup/janus.git/'
> 
> refs/stash is a funny refname because it contains only 1 '/'.
> Normally a valid ref has at least 2 '/', e.g. refs/heads/8654 or
> refs/tags/v1.0.

Since no version of receive-pack accepts these "funny refs", perhaps we
should mirror the check when considering the list of refs to send. IOW,
don't even make them eligible for matching or mirroring. Patch is below.

> Naming the stash refs/stash was perhaps funny in the first place
> since it cannot be moved about on the transport protocol, but then
> again the bulk of the stash data is actually in the reflog for the
> stash (and not the stash ref itself) so there is basically no point
> in pushing or fetching a stash directly.

I agree there is not much point in pushing it, since the useful bit is
in the reflog. So perhaps a "funny" refname is a good place to put it,
since it easily tells us that it is not a useful thing to push.

---
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index bbf6e0a..298bd71 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -140,7 +140,13 @@ static struct ref *remote_refs, **remote_tail;
 static int one_local_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct ref *ref;
-	int len = strlen(refname) + 1;
+	int len;
+
+	/* we already know it starts with refs/ to get here */
+	if (check_ref_format(refname + 5))
+		return 0;
+
+	len = strlen(refname) + 1;
 	ref = xcalloc(1, sizeof(*ref) + len);
 	hashcpy(ref->new_sha1, sha1);
 	memcpy(ref->name, refname, len);
