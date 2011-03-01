From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/RFC 1/2] grep: --full-tree
Date: Tue,  1 Mar 2011 10:53:29 +0100
Message-ID: <f179d6fa62001ada34a4236327eda985e09416b1.1298972832.git.git@drmicha.warpmail.net>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 10:57:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuMKN-0005AT-35
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 10:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756126Ab1CAJ46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 04:56:58 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59903 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754461Ab1CAJ45 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 04:56:57 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 454E620432;
	Tue,  1 Mar 2011 04:56:57 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 01 Mar 2011 04:56:57 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=sRxa1vkosATvXKrpvxJxSg2ntCU=; b=E1mYLjztnXCjvkg+yt3zQnZ2GYPJKY8XedwSIatJD5y+gXd4rnsz2ak08mzYoJLhzUAKeEwJNvu4AxXq7hlrh0BKwyHUEIjrcu2X8G1iGapXgOR9AQodVN4WI6RUxdc/J56eSXgE6PHwjyZEPchpKLX+nAxAwCI4FrK3Vvdyz7A=
X-Sasl-enc: SRNUSjA/crHe/0lFQAooRC5u0V85/KeimsImxSZ91IDS 1298973416
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BBC204039CF;
	Tue,  1 Mar 2011 04:56:56 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.257.gb09fa
In-Reply-To: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com>
In-Reply-To: <cover.1298972832.git.git@drmicha.warpmail.net>
References: <cover.1298972832.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168205>

From: Junio C Hamano <gitster@pobox.com>

While working inside a deep subdirectory, it sometimes is necessary to
find a string you see in a file you are working on from the files in the
entire project.  This is especially true when you are dipping your toe
into an unfamiliar project.

By default, "git grep" limits its search space to the current directory
and below (i.e. as if "-r ." is specified), and it is rather cumbersome to
repeat ../ as many times as necessary.  This new option tells "git grep"
not to limit the search space to the current directory.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/grep.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 5afee2f..d005528 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -728,6 +728,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 {
 	int hit = 0;
 	int cached = 0;
+	int full_tree = 0;
 	int seen_dashdash = 0;
 	int external_grep_allowed__ignored;
 	const char *show_in_pager = NULL, *default_pager = "dummy";
@@ -773,6 +774,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BIT('H', NULL, &opt.pathname, "show filenames", 1),
 		OPT_NEGBIT(0, "full-name", &opt.relative,
 			"show filenames relative to top directory", 1),
+		OPT_BIT(0, "full-tree", &full_tree,
+			"search from the top of the tree", 1),
 		OPT_BOOLEAN('l', "files-with-matches", &opt.name_only,
 			"show only filenames instead of matching lines"),
 		OPT_BOOLEAN(0, "name-only", &opt.name_only,
@@ -957,7 +960,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 
 	if (i < argc)
 		paths = get_pathspec(prefix, argv + i);
-	else if (prefix) {
+	else if (prefix && !full_tree) {
 		paths = xcalloc(2, sizeof(const char *));
 		paths[0] = prefix;
 		paths[1] = NULL;
-- 
1.7.4.1.257.gb09fa
