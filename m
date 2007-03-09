From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-bundle: only die if pack would be empty, warn if ref is
 skipped
Date: Fri, 9 Mar 2007 17:30:15 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703091726530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0703090348300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45F0D1B3.9020204@gmail.com> <7vejny7umx.fsf@assigned-by-dhcp.cox.net>
 <45F17EF0.5060008@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 17:30:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPhz7-0004rV-5N
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 17:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767363AbXCIQaU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 11:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767367AbXCIQaT
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 11:30:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:48281 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1767363AbXCIQaR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 11:30:17 -0500
Received: (qmail invoked by alias); 09 Mar 2007 16:30:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 09 Mar 2007 17:30:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18J1qVior0JJojd/Ss4l5cDtyGGIdQXKgHdFQzvlr
	pWZTfMZJ6yocxP
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45F17EF0.5060008@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41802>


A use case for git-bundle expected to be quite common is this:

	$ git bundle create daily.bundle --since=10.days.ago --all

The expected outcome is _not_ to error out if only a couple of the
refs were not changed during the last 10 days.

This patch complains loudly about refs which are skipped due to the
pack not containing the corresponding objects, but dies only if
no objects would be in the pack _at all_.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	On Fri, 9 Mar 2007, Mark Levedahl wrote:

	> Junio C Hamano wrote:
	> > If I were doing a nightly script, I would probably be doing
	> > something like this:
	> > 
	> > 	#!/bin/sh
	> > 	yesterday=$(git bundle list-heads yesterday.bdl | sed -e 's/ .*//')
	> > 	git bundle create today.bdl --all --not $yesterday
	> > 	# mail it out
	>
	> Thinking about this further, the above has a problem (or should, 
	> but see below). [...]

	I see another problem, too: if at least one ref was not updated 
	since yesterday, "create" would fail with the latest patches.

	This fixes it.

	BTW I had a little laugh when seeing what git-describe made of my 
	current version :-)

 builtin-bundle.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 55f6d0a..7868080 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -263,7 +263,7 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	int bundle_fd = -1;
 	const char **argv_boundary = xmalloc((argc + 4) * sizeof(const char *));
 	const char **argv_pack = xmalloc(5 * sizeof(const char *));
-	int pid, in, out, i, status;
+	int pid, in, out, i, status, ref_count = 0;
 	char buffer[1024];
 	struct rev_info revs;
 
@@ -328,15 +328,20 @@ static int create_bundle(struct bundle_header *header, const char *path,
 		 * other limiting options could have prevented all the tips
 		 * from getting output.
 		 */
-		if (!(e->item->flags & SHOWN))
-			die("ref '%s' is excluded by the rev-list options",
+		if (!(e->item->flags & SHOWN)) {
+			warn("ref '%s' is excluded by the rev-list options",
 				e->name);
+			continue;
+		}
+		ref_count++;
 		write_or_die(bundle_fd, sha1_to_hex(e->item->sha1), 40);
 		write_or_die(bundle_fd, " ", 1);
 		write_or_die(bundle_fd, ref, strlen(ref));
 		write_or_die(bundle_fd, "\n", 1);
 		free(ref);
 	}
+	if (!ref_count)
+		die ("Refusing to create empty bundle.");
 
 	/* end header */
 	write_or_die(bundle_fd, "\n", 1);
-- 
1.5.0.3.2621.gaaaa-dirty
