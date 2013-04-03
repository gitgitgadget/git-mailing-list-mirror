From: Jeff King <peff@peff.net>
Subject: Re: Behavior of git rm
Date: Wed, 3 Apr 2013 11:58:41 -0400
Message-ID: <20130403155841.GA16885@sigill.intra.peff.net>
References: <1365000624535-7581485.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: jpinheiro <7jpinheiro@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 03 17:59:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNQ5l-0001EY-De
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 17:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762037Ab3DCP6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 11:58:47 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53553 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761748Ab3DCP6q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 11:58:46 -0400
Received: (qmail 25232 invoked by uid 107); 3 Apr 2013 16:00:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Apr 2013 12:00:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Apr 2013 11:58:41 -0400
Content-Disposition: inline
In-Reply-To: <1365000624535-7581485.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219951>

On Wed, Apr 03, 2013 at 07:50:24AM -0700, jpinheiro wrote:

> While experimenting with git we found an unexpected behavior with git rm.
> Here is a trace of the unexpected behavior:
> 
> $ git init
> $ mkdir D
> $ echo "Hi" > D/F
> $ git add D/F
> $ rm -r D
> $ echo "Hey" > D
> $ git rm D/F
> warning: 'D/F': Not a directory
> rm 'D/F'
> fatal: git rm: 'D/F': Not a directory

We drop the D/F entry from the index, but then fail to actually remove
it from the filesystem, because it has already been replaced. It is
impossible to tell from this toy example what the true intent was, but
in such a situation, there is a reasonable chance that the user should
have invoked "rm --cached" in the first place.

That being said, we do try to handle files which have already gone
missing; when unlink() fails, we do not consider it an error if we got
ENOENT. We could perhaps add ENOTDIR to that list, as it also indicates
that the file is gone (it just happens that one of its prefix
directories was replaced with something else).

The opposite case is also interesting:

  $ git init
  $ echo 1 >D
  $ git add D
  $ rm D
  $ mkdir D
  $ echo 2 >D/F
  $ git rm D
  rm 'D'
  fatal: git rm: 'D': Is a directory

We expect to see 'D' as a file, but it is now a directory. We _could_
recursively remove the directory, but that has the potential to delete
files that the user does not expect.

So in both cases, "git rm" could certainly detect the situation and
proceed with the destructive operation. But when there is such a
conflict between what's in the working tree and what's in the index, I
think we may be better off erring on the conservative side and bailing,
and letting the user reconcile the differences themselves (using either
"git add" or "git rm --cached" to update the index, or deciding how to
handle the working tree contents themselves with regular "rm").

Of the two situations, I think the first one is less likely to be
destructive (noticing that a file is already gone via ENOTDIR), as we
are only proceeding with the index deletion, and we end up not touching
the filesystem at all. That patch would look something like:

diff --git a/builtin/rm.c b/builtin/rm.c
index dabfcf6..7b91d52 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -110,7 +110,7 @@ static int check_local_mod(unsigned char *head, int index_only)
 		ce = active_cache[pos];
 
 		if (lstat(ce->name, &st) < 0) {
-			if (errno != ENOENT)
+			if (errno != ENOENT && errno != ENOTDIR)
 				warning("'%s': %s", ce->name, strerror(errno));
 			/* It already vanished from the working tree */
 			continue;
diff --git a/dir.c b/dir.c
index 57394e4..f9e7355 100644
--- a/dir.c
+++ b/dir.c
@@ -1603,7 +1603,7 @@ int remove_path(const char *name)
 {
 	char *slash;
 
-	if (unlink(name) && errno != ENOENT)
+	if (unlink(name) && errno != ENOENT && errno != ENOTDIR)
 		return -1;
 
 	slash = strrchr(name, '/');
