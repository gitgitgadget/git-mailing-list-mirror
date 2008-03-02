From: Jeff King <peff@peff.net>
Subject: bug in git-revert
Date: Sun, 2 Mar 2008 01:44:49 -0500
Message-ID: <20080302064449.GA6334@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 02 07:46:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVhxP-0002kH-Tb
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 07:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbYCBGox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 01:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbYCBGox
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 01:44:53 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1696 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbYCBGox (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 01:44:53 -0500
Received: (qmail 1385 invoked by uid 111); 2 Mar 2008 06:44:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Mar 2008 01:44:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Mar 2008 01:44:49 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75731>

In 9509af6 (Make git-revert & git-cherry-pick a builtin), you introduced
the following code:

   252          } else {
   253                  struct wt_status s;
   254
   255                  if (get_sha1("HEAD", head))
   256                          die ("You do not have a valid HEAD");
   257                  wt_status_prepare(&s);
   258                  if (s.commitable || s.workdir_dirty)
   259                          die ("Dirty index: cannot %s", me);
   260                  discard_cache();
   261          }

(where the die condition was later changed to allow a dirty workdir). Am
I crazy, or is it impossible to trigger either of those conditions?
wt_status_prepare is about setting up the object to do the actual diff.
At that point it hasn't actually looked at the index or file contents,
and so commitable is _always_ 0. And if it did do the right thing, it
would have spewed a bunch of stuff to stdout.

I think it should be fixable by something like the patch below, but it
feels a little hack-ish. Should there perhaps be an equivalent to
"wt_status_print_updated" that just finds the commitable flag?

diff --git a/builtin-revert.c b/builtin-revert.c
index b6dee6a..64f381c 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -279,6 +279,8 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		if (get_sha1("HEAD", head))
 			die ("You do not have a valid HEAD");
 		wt_status_prepare(&s);
+		s.fp = NULL;
+		wt_status_print_updated(&s);
 		if (s.commitable)
 			die ("Dirty index: cannot %s", me);
 		discard_cache();
diff --git a/color.c b/color.c
index 12a6453..6dba762 100644
--- a/color.c
+++ b/color.c
@@ -160,6 +160,8 @@ static int color_vfprintf(FILE *fp, const char *color, const char *fmt,
 {
 	int r = 0;
 
+	if (!fp)
+		return 0;
 	if (*color)
 		r += fprintf(fp, "%s", color);
 	r += vfprintf(fp, fmt, args);
diff --git a/wt-status.c b/wt-status.c
index 32d780a..bf0934a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -169,7 +169,8 @@ static void wt_status_print_filepair(struct wt_status *s,
 	default:
 		die("bug: unhandled diff status %c", p->status);
 	}
-	fprintf(s->fp, "\n");
+	if (s->fp)
+		fprintf(s->fp, "\n");
 	strbuf_release(&onebuf);
 	strbuf_release(&twobuf);
 }
@@ -238,7 +239,7 @@ static void wt_status_print_initial(struct wt_status *s)
 	strbuf_release(&buf);
 }
 
-static void wt_status_print_updated(struct wt_status *s)
+void wt_status_print_updated(struct wt_status *s)
 {
 	struct rev_info rev;
 	init_revisions(&rev, NULL);
@@ -369,8 +370,10 @@ void wt_status_print(struct wt_status *s)
 	if (s->verbose && !s->is_initial)
 		wt_status_print_verbose(s);
 	if (!s->commitable) {
-		if (s->amend)
-			fprintf(s->fp, "# No changes\n");
+		if (s->amend) {
+			if (s->fp)
+				fprintf(s->fp, "# No changes\n");
+		}
 		else if (s->nowarn)
 			; /* nothing */
 		else if (s->workdir_dirty)
diff --git a/wt-status.h b/wt-status.h
index 02afaa6..7d40a57 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -32,5 +32,6 @@ int wt_status_use_color;
 int wt_status_relative_paths;
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
+void wt_status_print_updated(struct wt_status *s);
 
 #endif /* STATUS_H */
