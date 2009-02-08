From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Sun, 8 Feb 2009 06:00:42 -0500
Message-ID: <20090208110042.GA14359@coredump.intra.peff.net>
References: <20090205204436.GA6072@diku.dk> <20090206191511.GD19494@coredump.intra.peff.net> <2c6b72b30902061410l64c98c33g19b97f656d347c83@mail.gmail.com> <20090207071056.GB14856@coredump.intra.peff.net> <2c6b72b30902080231i3f550322s106e1be2e5a4ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sun Feb 08 12:02:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW7QR-0007HP-3w
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 12:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264AbZBHLAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 06:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753240AbZBHLAp
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 06:00:45 -0500
Received: from peff.net ([208.65.91.99]:33363 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753239AbZBHLAo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 06:00:44 -0500
Received: (qmail 26842 invoked by uid 107); 8 Feb 2009 11:00:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 08 Feb 2009 06:00:59 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Feb 2009 06:00:42 -0500
Content-Disposition: inline
In-Reply-To: <2c6b72b30902080231i3f550322s106e1be2e5a4ed@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108957>

On Sun, Feb 08, 2009 at 11:31:43AM +0100, Jonas Fonseca wrote:

> On Sat, Feb 7, 2009 at 08:10, Jeff King <peff@peff.net> wrote:
> > It would require a "reload and jump to this arbitrary line" function,
> > which I remember being problematic when I did my original patch a long
> > time ago.  But I haven't looked at the new code to see if it is easier
> > now (it looks like you have been doing quite a bit of refactoring in
> > that area lately).
> 
> Yes, support for restoring/jumping to an arbitrary line is possible by
> setting the view lineno and then call open_view with the OPEN_REFRESH
> flag.

I just tried out the version you pushed today (which has both the
cleaner version of my patch and the guesstimation patch). It behaves
exactly as I would expect. Thanks so much for looking into this.

I do have one more complaint, though. :)

If you parent-blame far enough, you will reach a point before the file
existed at all, in which case blame_read_file will die() with an error.
It would be nice to print an error and stay on the same screen. Below is
a patch which implements (I think) reasonably elegant solution.

-- >8 --
handle blaming beyond the creation of file more gracefully

Currently when you ask to re-blame from the parent of a
commit that created the file, blame_read_file will complain
that it cannot get the file contents ("No blame exist").

At the time we try to read the file, it is too late to abort
the operation, as we have already changed to the new blame
view. However, we can detect this situation early by
limiting the selection of the parent revision to the
particular path of interest: if it returns a parent even
with path-limiting, then we know the path exists; if not,
then we know it doesn't.

Signed-off-by: Jeff King <peff@peff.net>
---
 tig.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tig.c b/tig.c
index 04a44db..28fae2c 100644
--- a/tig.c
+++ b/tig.c
@@ -3384,11 +3384,11 @@ select_commit_parent_handler(void *data, char *buf, int c)
 }
 
 static bool
-select_commit_parent(const char *id, char rev[SIZEOF_REV])
+select_commit_parent(const char *id, char rev[SIZEOF_REV], const char *path)
 {
 	char buf[SIZEOF_STR * 4];
 	const char *revlist_argv[] = {
-		"git", "rev-list", "-1", "--parents", id, NULL
+		"git", "rev-list", "-1", "--parents", id, "--", path, NULL
 	};
 	int parents;
 
@@ -3399,7 +3399,10 @@ select_commit_parent(const char *id, char rev[SIZEOF_REV])
 		return FALSE;
 
 	} else if (parents == 0) {
-		report("The selected commit has no parents");
+		if (path)
+			report("path '%s' does not exist in the parent", path);
+		else
+			report("The selected commit has no parents");
 		return FALSE;
 	}
 
@@ -4468,7 +4471,8 @@ blame_request(struct view *view, enum request request, struct line *line)
 
 	case REQ_PARENT:
 		if (check_blame_commit(blame) &&
-		    select_commit_parent(blame->commit->id, opt_ref)) {
+		    select_commit_parent(blame->commit->id, opt_ref,
+					 blame->commit->filename)) {
 			string_copy(opt_file, blame->commit->filename);
 			setup_blame_parent_line(view, blame);
 			open_view(view, REQ_VIEW_BLAME, OPEN_REFRESH);
-- 
1.6.1.2.553.gdd056.dirty
