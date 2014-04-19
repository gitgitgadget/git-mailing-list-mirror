From: Jeff King <peff@peff.net>
Subject: [PATCH 6/6] run_external_diff: refactor cmdline setup logic
Date: Sat, 19 Apr 2014 15:22:25 -0400
Message-ID: <20140419192225.GB9189@sigill.intra.peff.net>
References: <20140419191128.GA9266@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 21:22:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbaqO-0005oP-Vg
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 21:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644AbaDSTW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 15:22:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:34503 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751476AbaDSTW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 15:22:27 -0400
Received: (qmail 26856 invoked by uid 102); 19 Apr 2014 19:22:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 19 Apr 2014 14:22:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Apr 2014 15:22:25 -0400
Content-Disposition: inline
In-Reply-To: <20140419191128.GA9266@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246536>

The current logic makes it hard to see what gets put onto
the command line in which cases. Pulling out a helper
function lets us see that we have two sets of file data, and
the second set either uses the original name, or the "other"
renamed/copy name.

Signed-off-by: Jeff King <peff@peff.net>
---
The last patch and this one are getting a little bit into code churn,
perhaps. I think the prior one is hands-down more readable. This one, I
am on the fence on whether it is a true improvement or simply "this is
how _I_ would have written it". I won't be offended if we drop it.

 diff.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index 173b657..4b8bfc6 100644
--- a/diff.c
+++ b/diff.c
@@ -2888,6 +2888,16 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 	return temp;
 }
 
+static void add_external_diff_name(struct argv_array *argv,
+				   const char *name,
+				   struct diff_filespec *df)
+{
+	struct diff_tempfile *temp = prepare_temp_file(name, df);
+	argv_array_push(argv, temp->name);
+	argv_array_push(argv, temp->hex);
+	argv_array_push(argv, temp->mode);
+}
+
 /* An external diff command takes:
  *
  * diff-cmd name infile1 infile1-sha1 infile1-mode \
@@ -2911,17 +2921,11 @@ static void run_external_diff(const char *pgm,
 	argv_array_push(&argv, name);
 
 	if (one && two) {
-		struct diff_tempfile *temp_one, *temp_two;
-		const char *othername = (other ? other : name);
-		temp_one = prepare_temp_file(name, one);
-		temp_two = prepare_temp_file(othername, two);
-		argv_array_push(&argv, temp_one->name);
-		argv_array_push(&argv, temp_one->hex);
-		argv_array_push(&argv, temp_one->mode);
-		argv_array_push(&argv, temp_two->name);
-		argv_array_push(&argv, temp_two->hex);
-		argv_array_push(&argv, temp_two->mode);
-		if (other) {
+		add_external_diff_name(&argv, name, one);
+		if (!other)
+			add_external_diff_name(&argv, name, two);
+		else {
+			add_external_diff_name(&argv, other, two);
 			argv_array_push(&argv, other);
 			argv_array_push(&argv, xfrm_msg);
 		}
-- 
1.9.1.656.ge8a0637
