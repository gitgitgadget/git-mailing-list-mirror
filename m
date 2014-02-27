From: Jeff King <peff@peff.net>
Subject: [PATCH] shallow: use stat_validity to check for up-to-date file
Date: Thu, 27 Feb 2014 05:56:31 -0500
Message-ID: <20140227105630.GA29668@sigill.intra.peff.net>
References: <1393485183-20100-1-git-send-email-pclouds@gmail.com>
 <20140227090426.GA21892@sigill.intra.peff.net>
 <20140227091012.GB21892@sigill.intra.peff.net>
 <20140227092227.GA28551@sigill.intra.peff.net>
 <CACsJy8AHwyy0wwFD3fu+Aak+k=bFM1NAWzVSs1G4389UWqZptg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 11:56:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIyds-0006gu-9X
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 11:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbaB0K4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 05:56:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:57950 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751453AbaB0K4f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 05:56:35 -0500
Received: (qmail 16980 invoked by uid 102); 27 Feb 2014 10:56:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Feb 2014 04:56:35 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Feb 2014 05:56:31 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8AHwyy0wwFD3fu+Aak+k=bFM1NAWzVSs1G4389UWqZptg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242802>

On Thu, Feb 27, 2014 at 05:18:58PM +0700, Duy Nguyen wrote:

> On Thu, Feb 27, 2014 at 4:22 PM, Jeff King <peff@peff.net> wrote:
> > On Thu, Feb 27, 2014 at 04:10:12AM -0500, Jeff King wrote:
> >
> >> I also notice that check_shallow_file_for_update returns early if
> >> !is_shallow. Is that safe? Is it possible for another process to have
> >> made us shallow since the program began? In that case, we would have to
> >> stat() the file always, then complain if it exists and !is_shallow.
> 
> I think it's safer to do it your way.

Yeah, I played around a bit and found that using "git fetch --depth" in
a non-shallow repo could run into this case.

> >         if (stat(git_path("shallow"), &st))
> >                 die("shallow file was removed during fetch");
> > +       else if (!is_shallow)
> > +               die("shallow file appeared during fetch");

Note that this is wrong; when the file is missing (the first part of the
conditional), we need to check "is_shallow" before dying. Otherwise we
erroneously complain when creating the file for the first time.

As I was fixing it, though, I recalled that we had to write a similar
system for the packed-refs file. Fortunately, it was easy to reuse, and
I ended up with the patch below.

-- >8 --
Subject: shallow: use stat_validity to check for up-to-date file

When we are about to write the shallow file, we check that
it has not changed since we last read it. Instead of
hand-rolling this, we can use stat_validity. This is built
around the index stat-check, so it is more robust than just
checking the mtime, as we do now (it uses the same check as
we do for index files).

The new code also handles the case of a shallow file
appearing unexpectedly. With the current code, two
simultaneous processes making us shallow (e.g., two "git
fetch --depth=1" running at the same time in a non-shallow
repository) can race to overwrite each other.

As a bonus, we also remove a race in determining the stat
information of what we read (we stat and then open, leaving
a race window; instead we should open and then fstat the
descriptor).

Signed-off-by: Jeff King <peff@peff.net>
---
 shallow.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/shallow.c b/shallow.c
index 75da07a..9668b39 100644
--- a/shallow.c
+++ b/shallow.c
@@ -10,7 +10,7 @@
 #include "commit-slab.h"
 
 static int is_shallow = -1;
-static struct stat shallow_stat;
+static struct stat_validity shallow_stat;
 static char *alternate_shallow_file;
 
 void set_alternate_shallow_file(const char *path, int override)
@@ -52,12 +52,12 @@ int is_repository_shallow(void)
 	 * shallow file should be used. We could just open it and it
 	 * will likely fail. But let's do an explicit check instead.
 	 */
-	if (!*path ||
-	    stat(path, &shallow_stat) ||
-	    (fp = fopen(path, "r")) == NULL) {
+	if (!*path || (fp = fopen(path, "r")) == NULL) {
+		stat_validity_clear(&shallow_stat);
 		is_shallow = 0;
 		return is_shallow;
 	}
+	stat_validity_update(&shallow_stat, fileno(fp));
 	is_shallow = 1;
 
 	while (fgets(buf, sizeof(buf), fp)) {
@@ -137,21 +137,11 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 
 void check_shallow_file_for_update(void)
 {
-	struct stat st;
-
-	if (!is_shallow)
-		return;
-	else if (is_shallow == -1)
+	if (is_shallow == -1)
 		die("BUG: shallow must be initialized by now");
 
-	if (stat(git_path("shallow"), &st))
-		die("shallow file was removed during fetch");
-	else if (st.st_mtime != shallow_stat.st_mtime
-#ifdef USE_NSEC
-		 || ST_MTIME_NSEC(st) != ST_MTIME_NSEC(shallow_stat)
-#endif
-		   )
-		die("shallow file was changed during fetch");
+	if (!stat_validity_check(&shallow_stat, git_path("shallow")))
+		die("shallow file has changed since we read it");
 }
 
 #define SEEN_ONLY 1
-- 
1.8.5.2.500.g8060133
