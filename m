From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v8 3/4] tag: update parsing to be more precise regarding errors
Date: Tue, 15 Jul 2014 14:29:13 -0700
Message-ID: <1405459754-4220-4-git-send-email-jacob.e.keller@intel.com>
References: <1405459754-4220-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 15 23:29:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7AI3-0001kn-DH
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 23:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbaGOV3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 17:29:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:55382 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752398AbaGOV3V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 17:29:21 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 15 Jul 2014 14:29:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,668,1400050800"; 
   d="scan'208";a="573664236"
Received: from jekeller-desk1.jf.intel.com (HELO jekeller-desk1.amr.corp.intel.com) ([134.134.173.156])
  by orsmga002.jf.intel.com with ESMTP; 15 Jul 2014 14:29:20 -0700
X-Mailer: git-send-email 2.0.1.475.g9b8d714
In-Reply-To: <1405459754-4220-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253606>

Update the parsing of sort string specifications so that it is able to
properly detect errors in the function type and allowed atoms.

Cc: Jeff King <peff@peff.net>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
This function should replace the one I think is already on one of the branches.
This version fully updates the parse_sort_opt to be like what will be the
parse_sort_string function. I have ensured that the next patch is purely a move
of this function, and does not contain modifications to make this easier to
review. Instead of using skip_prefix, I use strchr and check for the separator.

 builtin/tag.c | 55 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index ef765563388c..7d82526e76be 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -522,24 +522,51 @@ static int parse_opt_points_at(const struct option *opt __attribute__((unused)),
 static int parse_opt_sort(const struct option *opt, const char *arg, int unset)
 {
 	int *sort = opt->value;
-	int flags = 0;
+	char *value, *separator, *type, *atom;
+	int flags = 0, function = 0, err = 0;
 
-	if (*arg == '-') {
+	/* skip the '-' prefix for reverse sort order first */
+	if (skip_prefix(arg, "-", &arg))
 		flags |= REVERSE_SORT;
-		arg++;
+
+	/* duplicate string so we can modify it in place */
+	value = xstrdup(arg);
+
+	/* determine the sort function and the sorting atom */
+	separator = strchr(value, ':');
+	if (separator) {
+		/* split the string at the separator with a NULL byte */
+		*separator = '\0';
+		type = value;
+		atom = separator + 1;
+	} else {
+		/* we have no separator, so assume the whole string is the * atom */
+		type = NULL;
+		atom = value;
 	}
-	if (starts_with(arg, "version:")) {
-		*sort = VERCMP_SORT;
-		arg += 8;
-	} else if (starts_with(arg, "v:")) {
-		*sort = VERCMP_SORT;
-		arg += 2;
+
+	if (type) {
+		if (!strcmp(type, "version") || !strcmp(type, "v"))
+			function = VERCMP_SORT;
+		else {
+			err = error(_("unsupported sort function '%s'"), type);
+			goto abort;
+		}
+
 	} else
-		*sort = STRCMP_SORT;
-	if (strcmp(arg, "refname"))
-		die(_("unsupported sort specification %s"), arg);
-	*sort |= flags;
-	return 0;
+		function = STRCMP_SORT;
+
+	/* for now, only the refname is a valid atom */
+	if (atom && strcmp(atom, "refname")) {
+		err = error(_("unsupported sort specification '%s'"), atom);
+		goto abort;
+	}
+
+	*sort = (flags | function);
+
+abort:
+	free(value);
+	return err;
 }
 
 int cmd_tag(int argc, const char **argv, const char *prefix)
-- 
2.0.1.475.g9b8d714
