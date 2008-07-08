From: Jeff King <peff@peff.net>
Subject: Re: error: unlink(.git/refs/remotes/origin/testbranch) failed: was
	remote does not support deleting refs
Date: Tue, 8 Jul 2008 00:08:02 -0400
Message-ID: <20080708040801.GA7186@sigill.intra.peff.net>
References: <486FE602.3060301@gmx.de> <48700FC2.8080307@gmx.de> <37fcd2780807061134l341ac676ueb674a976ce15e6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Martin <html-kurs@gmx.de>,
	git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 06:09:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG4Vr-0004ci-IZ
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 06:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbYGHEIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 00:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbYGHEIN
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 00:08:13 -0400
Received: from peff.net ([208.65.91.99]:3877 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823AbYGHEIN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 00:08:13 -0400
Received: (qmail 27916 invoked by uid 111); 8 Jul 2008 04:08:12 -0000
Received: from c-75-75-1-159.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (75.75.1.159)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 08 Jul 2008 00:08:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Jul 2008 00:08:02 -0400
Content-Disposition: inline
In-Reply-To: <37fcd2780807061134l341ac676ueb674a976ce15e6f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87699>

On Sun, Jul 06, 2008 at 10:34:31PM +0400, Dmitry Potapov wrote:

> On Sun, Jul 06, 2008 at 02:20:18AM +0200, Martin wrote:
> > But I get another error:
> > $ git push origin :testbranch
> > To ssh://myserver.com/my/path/to/repository
> >  - [deleted]         testbranch
> > error: unlink(.git/refs/remotes/origin/testbranch) failed: No such file_
> > or directory
> > error: Failed to delete
> >_
> > Any idea?
> 
> It is harmless. It is just that "git push origin :refs/heads/testbranch"
> cannot remove your local reference to that branch because you already have
> removed it by running "git branch -d -r origin/testbranch"

It is harmless, but it still feels a little wrong to scare the user with
that message, especially since "Failed to delete" is ambiguous; it looks
like the main operation, deleting the remote ref, failed. But it didn't;
the operation that failed was something not even explicitly asked for.

How about this cleanup:

-- >8 --
make deleting a missing ref more quiet

If git attempts to delete a ref, but the unlink of the ref
file fails, we print a message to stderr. This is usually a
good thing, but if the error is ENOENT, then it indicates
that the ref has _already_ been deleted. And since that's
our goal, it doesn't make sense to complain to the user.

This harmonizes the error reporting behavior for the
unpacked and packed cases; the packed case already printed
nothing on ENOENT, but the unpacked printed unconditionally.

Additionally, send-pack would, when deleting the tracking
ref corresponding to a remote delete, print "Failed to
delete" on any failure. This can be a misleading
message, since we actually _did_ delete at the remote side,
but we failed to delete locally. Rather than make the
message more precise, let's just eliminate it entirely; the
delete_ref routine already takes care of printing out a much
more specific message about what went wrong.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-send-pack.c          |    3 +--
 refs.c                       |    2 +-
 t/t5404-tracking-branches.sh |    7 +++++++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index d76260c..a708d0a 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -226,8 +226,7 @@ static void update_tracking_ref(struct remote *remote, struct ref *ref)
 		if (args.verbose)
 			fprintf(stderr, "updating local tracking ref '%s'\n", rs.dst);
 		if (ref->deletion) {
-			if (delete_ref(rs.dst, NULL))
-				error("Failed to delete");
+			delete_ref(rs.dst, NULL);
 		} else
 			update_ref("update by push", rs.dst,
 					ref->new_sha1, NULL, 0, 0);
diff --git a/refs.c b/refs.c
index 6c6e9e5..39a3b23 100644
--- a/refs.c
+++ b/refs.c
@@ -925,7 +925,7 @@ int delete_ref(const char *refname, const unsigned char *sha1)
 		i = strlen(lock->lk->filename) - 5; /* .lock */
 		lock->lk->filename[i] = 0;
 		err = unlink(lock->lk->filename);
-		if (err) {
+		if (err && errno != ENOENT) {
 			ret = 1;
 			error("unlink(%s) failed: %s",
 			      lock->lk->filename, strerror(errno));
diff --git a/t/t5404-tracking-branches.sh b/t/t5404-tracking-branches.sh
index 1493a92..64fe261 100755
--- a/t/t5404-tracking-branches.sh
+++ b/t/t5404-tracking-branches.sh
@@ -10,6 +10,7 @@ test_expect_success 'setup' '
 	git commit -m 1 &&
 	git branch b1 &&
 	git branch b2 &&
+	git branch b3 &&
 	git clone . aa &&
 	git checkout b1 &&
 	echo b1 >>file &&
@@ -50,4 +51,10 @@ test_expect_success 'deleted branches have their tracking branches removed' '
 	test "$(git rev-parse origin/b1)" = "origin/b1"
 '
 
+test_expect_success 'already deleted tracking branches ignored' '
+	git branch -d -r origin/b3 &&
+	git push origin :b3 >output 2>&1 &&
+	! grep error output
+'
+
 test_done
-- 
1.5.6.2.381.ga86b
