From: Jeff King <peff@peff.net>
Subject: [PATCH] config: reject bogus section names for --rename-section
Date: Wed, 25 Apr 2012 21:47:14 -0400
Message-ID: <20120426014714.GC8590@sigill.intra.peff.net>
References: <9E01F5E2-FB51-418D-B50C-EB6DC63A4F84@justatheory.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "David E. Wheeler" <david@justatheory.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 03:47:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNDnn-00068K-O9
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 03:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077Ab2DZBrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 21:47:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44906
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008Ab2DZBrS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 21:47:18 -0400
Received: (qmail 8549 invoked by uid 107); 26 Apr 2012 01:47:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Apr 2012 21:47:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Apr 2012 21:47:14 -0400
Content-Disposition: inline
In-Reply-To: <9E01F5E2-FB51-418D-B50C-EB6DC63A4F84@justatheory.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196348>

You can feed junk to "git config --rename-section", which
will result in a config file that git will not even parse
(so you cannot fix it with git-config). We already have
syntactic sanity checks when setting a variable; let's do
the same for section names.

Signed-off-by: Jeff King <peff@peff.net>
---
On Mon, Apr 23, 2012 at 07:57:19PM -0700, David E. Wheeler wrote:

> I was fooling around and realized that I could assign an empty string
> as the name of a config section, like so:
> 
>     $ git config --rename-section my ''
> 
> This leaves the config file looking like this:
> 
>     []
>         foo = goodbye
> 
> Which does not appear to be valid:
> 
>     $ git config --get '.foo'          
>     fatal: bad config file line 13 in .git/config
> 
> So maybe git-config should disallow setting a section to an empty string?

Yes, we should definitely be more careful.

 config.c               |   24 +++++++++++++++++++++++-
 t/t1300-repo-config.sh |    8 ++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 68d3294..9ef947e 100644
--- a/config.c
+++ b/config.c
@@ -1552,20 +1552,42 @@ static int section_name_match (const char *buf, const char *name)
 	return 0;
 }
 
+static int section_name_is_ok(const char *name)
+{
+	/* Empty section names are bogus. */
+	if (!*name)
+		return 0;
+
+	/*
+	 * Before a dot, we must be alphanumeric or dash. After the first dot,
+	 * anything goes, so we can stop checking.
+	 */
+	for (; *name && *name != '.'; name++)
+		if (*name != '-' && !isalnum(*name))
+			return 0;
+	return 1;
+}
+
 /* if new_name == NULL, the section is removed instead */
 int git_config_rename_section_in_file(const char *config_filename,
 				      const char *old_name, const char *new_name)
 {
 	int ret = 0, remove = 0;
 	char *filename_buf = NULL;
-	struct lock_file *lock = xcalloc(sizeof(struct lock_file), 1);
+	struct lock_file *lock;
 	int out_fd;
 	char buf[1024];
 	FILE *config_file;
 
+	if (new_name && !section_name_is_ok(new_name)) {
+		ret = error("invalid section name: %s", new_name);
+		goto out;
+	}
+
 	if (!config_filename)
 		config_filename = filename_buf = git_pathdup("config");
 
+	lock = xcalloc(sizeof(struct lock_file), 1);
 	out_fd = hold_lock_file_for_update(lock, config_filename, 0);
 	if (out_fd < 0) {
 		ret = error("could not lock config file %s", config_filename);
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 36e227b..a477453 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -550,6 +550,14 @@ EOF
 
 test_expect_success "rename succeeded" "test_cmp expect .git/config"
 
+test_expect_success 'renaming empty section name is rejected' '
+	test_must_fail git config --rename-section branch.zwei ""
+'
+
+test_expect_success 'renaming to bogus section is rejected' '
+	test_must_fail git config --rename-section branch.zwei "bogus name"
+'
+
 cat >> .git/config << EOF
   [branch "zwei"] a = 1 [branch "vier"]
 EOF
-- 
1.7.9.6.11.gd9951
