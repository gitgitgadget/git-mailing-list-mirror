From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Show dissimilarity index for D and N case.
Date: Mon, 30 May 2005 16:40:16 -0700
Message-ID: <7v1x7oz3j3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 01:38:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DctpW-0003yv-2f
	for gcvg-git@gmane.org; Tue, 31 May 2005 01:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVE3Xkc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 19:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVE3Xkc
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 19:40:32 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:34768 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261821AbVE3XkS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 19:40:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050530234016.FYTG550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 30 May 2005 19:40:16 -0400
To: torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The way broken deletes and creates are shown in the -p
(diff-patch) output format has become consistent with how
rename/copy edits are shown.  They will show "dissimilarity
index" value, immediately following the "deleted file mode" and
"new file mode" lines.

The git-apply is taught to grok such an extended header.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 apply.c |    6 ++++++
 diff.c  |   20 ++++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -336,6 +336,11 @@ static int gitdiff_similarity(const char
 	return 0;
 }
 
+static int gitdiff_dissimilarity(const char *line, struct patch *patch)
+{
+	return 0;
+}
+
 /*
  * This is normal for a diff that doesn't change anything: we'll fall through
  * into the next diff. Tell the parser to break out.
@@ -437,6 +442,7 @@ static int parse_git_header(char *line, 
 			{ "rename from ", gitdiff_renamesrc },
 			{ "rename to ", gitdiff_renamedst },
 			{ "similarity index ", gitdiff_similarity },
+			{ "dissimilarity index ", gitdiff_dissimilarity },
 			{ "", gitdiff_unrecognized },
 		};
 		int i;
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -132,10 +132,16 @@ static void builtin_diff(const char *nam
 			    diff_arg, input_name_sq[0], input_name_sq[1]);
 
 	printf("diff --git a/%s b/%s\n", name_a, name_b);
-	if (!path1[0][0])
+	if (!path1[0][0]) {
 		printf("new file mode %s\n", temp[1].mode);
-	else if (!path1[1][0])
+		if (xfrm_msg && xfrm_msg[0])
+			puts(xfrm_msg);
+	}
+	else if (!path1[1][0]) {
 		printf("deleted file mode %s\n", temp[0].mode);
+		if (xfrm_msg && xfrm_msg[0])
+			puts(xfrm_msg);
+	}
 	else {
 		if (strcmp(temp[0].mode, temp[1].mode)) {
 			printf("old mode %s\n", temp[0].mode);
@@ -733,6 +739,16 @@ static void diff_flush_patch(struct diff
 			p->one->path, p->two->path);
 		msg = msg_;
 		break;
+	case 'D': case 'N':
+		if (DIFF_PAIR_BROKEN(p)) {
+			sprintf(msg_,
+				"dissimilarity index %d%%",
+				(int)(0.5 + p->score * 100.0/MAX_SCORE));
+			msg = msg_;
+		}
+		else
+			msg = NULL;
+		break;
 	default:
 		msg = NULL;
 	}
------------

