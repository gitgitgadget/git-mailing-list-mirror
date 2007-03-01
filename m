From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/2] pathattr: read from git_config().
Date: Thu, 01 Mar 2007 01:26:32 -0800
Message-ID: <7vbqjdwbzr.fsf@assigned-by-dhcp.cox.net>
References: <7vodndxwia.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 10:26:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMhYk-0000Sh-ES
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 10:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933213AbXCAJ0e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 04:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933214AbXCAJ0e
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 04:26:34 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:35752 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933213AbXCAJ0d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 04:26:33 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070301092633.QVHA2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 1 Mar 2007 04:26:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VMSY1W00M1kojtg0000000; Thu, 01 Mar 2007 04:26:33 -0500
In-Reply-To: <7vodndxwia.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 28 Feb 2007 23:18:05 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41063>

Now we read the path traits from the usual configuration
mechanism.  No per-directory .gitattributes yet, though.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * [3/2] (this one) and [4/2] are the follow-up to the pathattr
   series.

 pathattr.c |   63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 62 insertions(+), 1 deletions(-)

diff --git a/pathattr.c b/pathattr.c
index c84be39..2532c9a 100644
--- a/pathattr.c
+++ b/pathattr.c
@@ -85,6 +85,67 @@ static void add_match(struct pathattr_stack *s, struct pathattr *a, const char *
 	m->attr = a;
 }
 
+static convi_fn conv_i_trait(const char *value)
+{
+	if (!strcmp(value, "crlf"))
+		return convi_crlf;
+	return NULL;
+}
+
+static convo_fn conv_o_trait(const char *value)
+{
+	if (!strcmp(value, "crlf"))
+		return convo_crlf;
+	return NULL;
+}
+
+static pretty_fn pretty_trait(const char *value)
+{
+	if (!strcmp(value, "display"))
+		return show_display;
+	return NULL;
+}
+
+static int attr_config(const char *var, const char *value)
+{
+	struct pathattr *a;
+	static const char pa[] = "pathattr.";
+	const char *trait;
+	char group[256];
+	int group_len;
+
+	if (prefixcmp(var, pa))
+		return 0; /* we are not interested in other configs */
+	trait = strrchr(var, '.');
+	if (!trait)
+		return 0; /* huh? */
+	group_len = trait - var - (sizeof(pa) - 1);
+	if (group_len <= 0)
+		return 0; /* huh? */
+	trait++;
+	if (sizeof(group) < group_len)
+		die("'%.*s' is too long as a group name", group_len,
+		    var + sizeof(pa) - 1);
+	memcpy(group, var + sizeof(pa) - 1, group_len);
+	group[group_len] = 0;
+	a = locate(stk, group);
+
+	if (!strcmp(trait, "path"))
+		add_match(stk, a, value);
+	else if (!strcmp(trait, "conv_i"))
+		a->conv_i = conv_i_trait(value);
+	else if (!strcmp(trait, "conv_o"))
+		a->conv_i = conv_o_trait(value);
+	else if (!strcmp(trait, "pretty"))
+		a->pretty = pretty_trait(value);
+	/*
+	 * Do not barf if the configuration has unknown trait.
+	 * the user might be bisecting git and trying an older
+	 * version on the latest repository.
+	 */
+	return 0;
+}
+
 static void init_stack(void)
 {
 	struct pathattr *a;
@@ -105,7 +166,7 @@ static void init_stack(void)
 	add_match(stk, a, "*.jpg");
 	add_match(stk, a, "*.gif");
 
-	/* NEEDSWORK: read from config */
+	git_config(attr_config);
 }
 
 static void pop_stack(void)
-- 
1.5.0.2.809.g0f936
