From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [RFC] ident: support per-path configs by matching the path against
 a pattern
Date: Fri, 10 Jul 2015 09:36:38 +0000
Message-ID: <0000014e7752e758-a0bf7acb-2d0f-4492-8004-8eeeb9b2f042-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 10 11:52:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDUyg-00073M-LS
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 11:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbbGJJwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 05:52:15 -0400
Received: from a6-245.smtp-out.eu-west-1.amazonses.com ([54.240.6.245]:54062
	"EHLO a6-245.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752771AbbGJJwN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jul 2015 05:52:13 -0400
X-Greylist: delayed 932 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jul 2015 05:52:13 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1436520998;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=9rndsYDk5zuaEbWpHkCYK9QFbB1XJUP14hj0Ib6d85Y=;
	b=dBMT5OdATpUIJ0vmj97RXAq5YKjRYbmZCpogvMykAgLUWwZgmTt3lFhCXcvcyuz1
	PnYzATh5GdFIg2eSZmwRMHctNDV2VRMibI+U9ehsBg19KnzMd8i0I7j9GgVS0r/DL/Q
	XIUEEA3N5g0xxFd65GTQewkNUhHmSHpcNOxswP9U=
X-SES-Outgoing: 2015.07.10-54.240.6.245
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273811>

Support per-path identities by configuring Git like

    $ git config user.<pattern>.email <email address>

e.g.

    $ git config user.github.email sschuberth+github@gmail.com

In this example, the middle "github" pattern is searched for
case-insensitively in the absolute path name to the current git work tree.
If there is a match the configured email address is used instead of what
otherwise would be the default email address.

Note that repository-local identities still take precedence over global /
system ones even if the pattern configured in the global / system identity
matches the path to the local work tree.

This change avoids the need to use external tools like [1].

TODO: Once the community agrees that this is a feature worth having, add
tests and adjust the docs.

[1] https://github.com/prydonius/karn

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 ident.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/ident.c b/ident.c
index 5ff1aad..2429ed8 100644
--- a/ident.c
+++ b/ident.c
@@ -390,7 +390,21 @@ int author_ident_sufficiently_given(void)
 
 int git_ident_config(const char *var, const char *value, void *data)
 {
-	if (!strcmp(var, "user.name")) {
+	/* the caller has already checked that var starts with "user." */
+
+	const char *first_period = strchr(var, '.');
+	const char *last_period = strrchr(var, '.');
+
+	if (first_period < last_period) {
+		++first_period;
+		char *pattern = xstrndup(first_period, last_period - first_period);
+		const char *match = strcasestr(get_git_work_tree(), pattern);
+		free(pattern);
+		if (!match)
+			return 0;
+	}
+
+	if (ends_with(var, ".name")) {
 		if (!value)
 			return config_error_nonbool(var);
 		strbuf_reset(&git_default_name);
@@ -400,7 +414,7 @@ int git_ident_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
-	if (!strcmp(var, "user.email")) {
+	if (ends_with(var, ".email")) {
 		if (!value)
 			return config_error_nonbool(var);
 		strbuf_reset(&git_default_email);

---
https://github.com/git/git/pull/161
