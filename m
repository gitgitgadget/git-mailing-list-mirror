From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH] bisect--helper: convert a function in shell to C
Date: Mon, 21 Mar 2016 19:00:56 +0000
Message-ID: <010201539a8d2b8a-9f168d7a-d4c6-4c23-a61f-1ef6ee22f774-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 01:09:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai9tT-00052N-DW
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 01:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbcCVAJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 20:09:50 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:39789
	"EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750934AbcCVAJt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2016 20:09:49 -0400
X-Greylist: delayed 4525 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Mar 2016 20:09:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1458586856;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=x8wOcwldBQm3pOD8YQWmpaW1KPhnZiLdJ0P3nP5ftlU=;
	b=eJfKJe8O4SlKUOM3Cw+DgNW/K1vjhV4F51ZlTNsZ1b8b3XksDzIOmp7WungeKxZh
	+2ZRGRzmPMM2AnyW/gsI6zB9KUa0JvDikz0qPVIe5UodpCfbtrwxCOhu86ChpkoSv0f
	kR0qS6RDZtEXBJb307bZr0q5yINhjDWyUMWPd9cY=
X-SES-Outgoing: 2016.03.22-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289476>

Convert the code literally without changing its design even though it
seems that its obscure as to the use of comparing revision to different bisect
arguments which seems like a problem in shell because of the way
function arguments are handled.

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 3324229..61abe68 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -2,12 +2,35 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "bisect.h"
+#include "refs.h"
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
 	NULL
 };
 
+static int check_term_format(const char *term, const char *revision, int flag) {
+	if (check_refname_format(term, flag))
+		die("'%s' is not a valid term", term);
+
+	if (!strcmp(term, "help") || !strcmp(term, "start") ||
+		!strcmp(term, "skip") || !strcmp(term, "next") ||
+		!strcmp(term, "reset") || !strcmp(term, "visualize") ||
+		!strcmp(term, "replay") || !strcmp(term, "log") ||
+		!strcmp(term, "run"))
+		die("can't use the builtin command '%s' as a term", term);
+
+	if (!strcmp(term, "bad") || !strcmp(term, "new"))
+		if(strcmp(revision, "bad"))
+			die("can't change the meaning of term '%s'", term);
+
+	if (!strcmp(term, "good") || !strcmp(term, "old"))
+		if (strcmp(revision, "good"))
+			die("can't change the meaning of term '%s'", term);
+
+	return 1;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	int next_all = 0;

--
https://github.com/git/git/pull/216
