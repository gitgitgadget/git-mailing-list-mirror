From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git branch -D: give a better error message when
 lockfile creation fails
Date: Sun, 27 Sep 2009 04:21:23 -0400
Message-ID: <20090927082123.GD15393@coredump.intra.peff.net>
References: <vpqy6o15v6m.fsf@bauges.imag.fr>
 <1254006909-1862-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu.Moy@grenoble-inp.fr, spearce@spearce.org,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Sep 27 10:24:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mrp3m-0006lt-7m
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 10:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbZI0IVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2009 04:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753443AbZI0IVY
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 04:21:24 -0400
Received: from peff.net ([208.65.91.99]:59628 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753439AbZI0IVW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2009 04:21:22 -0400
Received: (qmail 18820 invoked by uid 107); 27 Sep 2009 08:24:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 27 Sep 2009 04:24:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Sep 2009 04:21:23 -0400
Content-Disposition: inline
In-Reply-To: <1254006909-1862-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129199>

On Sun, Sep 27, 2009 at 01:15:09AM +0200, Miklos Vajna wrote:

> Changes since the previous one:
> 
> * unable_to_lock_index() renamed to unable_to_lock()
> * NORETURN is back for unable_to_lock_index_die()

Much better, but:

> +	if (noreturn)
> +		die(buf.buf);
> +	ret = error(buf.buf);

These need to be:

  die("%s", buf.buf);

as the resulting message (which contains the filename) may have '%' in
it.

> +NORETURN void unable_to_lock_index_die(const char *path, int err)
> +{
> +	unable_to_lock(path, err, 1);
> +	die("unable_to_lock() should have died already");
>  }

Maybe it is just me, but that extra die() that should never be reached
is terribly ugly. I would do it with two functions, one that dies and
one that doesn't, with a helper to format the message. IOW, this:

-- >8 --
From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git branch -D: give a better error message when lockfile creation fails

Previously the old error message just told the user that it was not
possible to delete the ref from the packed-refs file. Give instructions
on how to resolve the problem.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h    |    1 +
 lockfile.c |   26 ++++++++++++++++++++------
 refs.c     |    4 +++-
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 1a6412d..a5eeead 100644
--- a/cache.h
+++ b/cache.h
@@ -489,6 +489,7 @@ struct lock_file {
 };
 #define LOCK_DIE_ON_ERROR 1
 #define LOCK_NODEREF 2
+extern int unable_to_lock_error(const char *path, int err);
 extern NORETURN void unable_to_lock_index_die(const char *path, int err);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
diff --git a/lockfile.c b/lockfile.c
index eb931ed..6851fa5 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -155,18 +155,32 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	return lk->fd;
 }
 
-
-NORETURN void unable_to_lock_index_die(const char *path, int err)
+static char *unable_to_lock_message(const char *path, int err)
 {
+	struct strbuf buf = STRBUF_INIT;
+
 	if (err == EEXIST) {
-		die("Unable to create '%s.lock': %s.\n\n"
+		strbuf_addf(&buf, "Unable to create '%s.lock': %s.\n\n"
 		    "If no other git process is currently running, this probably means a\n"
 		    "git process crashed in this repository earlier. Make sure no other git\n"
 		    "process is running and remove the file manually to continue.",
 		    path, strerror(err));
-	} else {
-		die("Unable to create '%s.lock': %s", path, strerror(err));
-	}
+	} else
+		strbuf_addf(&buf, "Unable to create '%s.lock': %s", path, strerror(err));
+	return strbuf_detach(&buf, NULL);
+}
+
+int unable_to_lock_error(const char *path, int err)
+{
+	char *msg = unable_to_lock_message(path, err);
+	error("%s", msg);
+	free(msg);
+	return -1;
+}
+
+NORETURN void unable_to_lock_index_die(const char *path, int err)
+{
+	die("%s", unable_to_lock_message(path, err));
 }
 
 int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
diff --git a/refs.c b/refs.c
index 24865cf..808f56b 100644
--- a/refs.c
+++ b/refs.c
@@ -972,8 +972,10 @@ static int repack_without_ref(const char *refname)
 	if (!found)
 		return 0;
 	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
-	if (fd < 0)
+	if (fd < 0) {
+		unable_to_lock_error(git_path("packed-refs"), errno);
 		return error("cannot delete '%s' from packed refs", refname);
+	}
 
 	for (list = packed_ref_list; list; list = list->next) {
 		char line[PATH_MAX + 100];
-- 
1.6.5.rc2.197.g25cf3
