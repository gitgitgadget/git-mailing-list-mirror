From: Kevin Ballard <kevin@sb.org>
Subject: [WIP/PATCH] merge-recursive: option to specify rename threshold
Date: Tue, 21 Sep 2010 23:03:39 -0700
Message-ID: <1285135419-7503-1-git-send-email-kevin@sb.org>
Cc: Kevin Ballard <kevin@sb.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 22 08:03:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyIQp-0007pW-Jl
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 08:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746Ab0IVGDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 02:03:46 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33332 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab0IVGDp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 02:03:45 -0400
Received: by pwi3 with SMTP id 3so67847pwi.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 23:03:45 -0700 (PDT)
Received: by 10.142.110.6 with SMTP id i6mr9601636wfc.276.1285135425039;
        Tue, 21 Sep 2010 23:03:45 -0700 (PDT)
Received: from localhost.localdomain ([69.170.160.74])
        by mx.google.com with ESMTPS id o9sm9472523wfd.16.2010.09.21.23.03.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Sep 2010 23:03:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.237.ge0a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156785>

The recursive merge strategy turns on rename detection but leaves the
rename score at the default. Add a strategy option to allow the user
to specify a rename score to use.
---
The only thing I'm concerned about in this patch is the duplicated
parse_num() function. I'm inclined to take that function in diff.c,
rename it to something like parse_rename_score(), and declare it
in diff.h.

 merge-recursive.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 merge-recursive.h |    1 +
 2 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index bf611ae..f8ff30e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -334,6 +334,7 @@ static struct string_list *get_renames(struct merge_options *o,
 	opts.rename_limit = o->merge_rename_limit >= 0 ? o->merge_rename_limit :
 			    o->diff_rename_limit >= 0 ? o->diff_rename_limit :
 			    500;
+	opts.rename_score = o->rename_score;
 	opts.warn_on_too_large_rename = 1;
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	if (diff_setup_done(&opts) < 0)
@@ -1552,6 +1553,43 @@ void init_merge_options(struct merge_options *o)
 	o->current_directory_set.strdup_strings = 1;
 }
 
+// XXX: copied from diff.c
+static int parse_num(const char **cp_p)
+{
+	unsigned long num, scale;
+	int ch, dot;
+	const char *cp = *cp_p;
+
+	num = 0;
+	scale = 1;
+	dot = 0;
+	for (;;) {
+		ch = *cp;
+		if ( !dot && ch == '.' ) {
+			scale = 1;
+			dot = 1;
+		} else if ( ch == '%' ) {
+			scale = dot ? scale*100 : 100;
+			cp++;	/* % is always at the end */
+			break;
+		} else if ( ch >= '0' && ch <= '9' ) {
+			if ( scale < 100000 ) {
+				scale *= 10;
+				num = (num*10) + (ch-'0');
+			}
+		} else {
+			break;
+		}
+		cp++;
+	}
+	*cp_p = cp;
+
+	/* user says num divided by scale and we say internally that
+	 * is MAX_SCORE * num / scale.
+	 */
+	return (int)((num >= scale) ? MAX_SCORE : (MAX_SCORE * num / scale));
+}
+
 int parse_merge_opt(struct merge_options *o, const char *s)
 {
 	if (!s || !*s)
@@ -1576,6 +1614,11 @@ int parse_merge_opt(struct merge_options *o, const char *s)
 		o->renormalize = 1;
 	else if (!strcmp(s, "no-renormalize"))
 		o->renormalize = 0;
+	else if (!prefixcmp(s, "rename-score=")) {
+		const char *score = s + strlen("rename-score=");
+		if ((o->rename_score = parse_num(&score)) == -1 || *score != 0)
+			return -1;
+	}
 	else
 		return -1;
 	return 0;
diff --git a/merge-recursive.h b/merge-recursive.h
index 2eb5d1a..c8135b0 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -19,6 +19,7 @@ struct merge_options {
 	int verbosity;
 	int diff_rename_limit;
 	int merge_rename_limit;
+	int rename_score;
 	int call_depth;
 	struct strbuf obuf;
 	struct string_list current_file_set;
-- 
1.7.3.237.ge0a7
