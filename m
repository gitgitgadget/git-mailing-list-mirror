From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] log --pretty: do not accept bogus "--prettyshort"
Date: Sun, 25 May 2008 20:19:30 -0700
Message-ID: <7vy75xeoql.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon May 26 05:20:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0TGE-0004pj-IC
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 05:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbYEZDTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 23:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752173AbYEZDTj
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 23:19:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbYEZDTi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 23:19:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4FAA45F2C;
	Sun, 25 May 2008 23:19:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 842BE5F2B; Sun, 25 May 2008 23:19:34 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 92115DD2-2AD2-11DD-8293-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82894>

... nor bogus "format.pretty = '=short'".  Both are syntax errors.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This lazy parsing was introduced by 6cdfd17 (commit: allow --pretty=
   args to be abbreviated, 2006-05-14), more than a year ago...

 pretty.c   |    2 --
 revision.c |    7 ++++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/pretty.c b/pretty.c
index 6872932..8eb39e9 100644
--- a/pretty.c
+++ b/pretty.c
@@ -28,8 +28,6 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 		rev->commit_format = CMIT_FMT_DEFAULT;
 		return;
 	}
-	if (*arg == '=')
-		arg++;
 	if (!prefixcmp(arg, "format:") || !prefixcmp(arg, "tformat:")) {
 		const char *cp = strchr(arg, ':') + 1;
 		free(user_format);
diff --git a/revision.c b/revision.c
index ac057e1..fc66755 100644
--- a/revision.c
+++ b/revision.c
@@ -1197,11 +1197,16 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->verbose_header = 1;
 				continue;
 			}
-			if (!prefixcmp(arg, "--pretty")) {
+			if (!strcmp(arg, "--pretty")) {
 				revs->verbose_header = 1;
 				get_commit_format(arg+8, revs);
 				continue;
 			}
+			if (!prefixcmp(arg, "--pretty=")) {
+				revs->verbose_header = 1;
+				get_commit_format(arg+9, revs);
+				continue;
+			}
 			if (!strcmp(arg, "--graph")) {
 				revs->topo_order = 1;
 				revs->rewrite_parents = 1;
-- 
1.5.5.1.467.g9bd81
