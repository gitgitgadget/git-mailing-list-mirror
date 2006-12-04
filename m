X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sam Vilain <sam@vilain.net>
Subject: [PATCH] merge-recursive: configurable 'merge' program
Date: Mon, 4 Dec 2006 22:36:18 +1100
Message-ID: <20061204235647.9BA8B139B0E@magnus.utsl.gen.nz>
NNTP-Posting-Date: Mon, 4 Dec 2006 23:57:02 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33265>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrNg6-0005Q6-Di for gcvg-git@gmane.org; Tue, 05 Dec
 2006 00:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937189AbWLDX4v (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 18:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937170AbWLDX4v
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 18:56:51 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:41884 "EHLO
 magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S937189AbWLDX4u (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 18:56:50 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 1003) id 9BA8B139B0E;
 Tue,  5 Dec 2006 12:56:47 +1300 (NZDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

For those who like to spawn interactive merge tools on a merge failure
or otherwise run some kind of script, allow a "merge.tool" repo-config
option that will take arguments as merge(1) does.
---
 merge-recursive.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

Here's the script I use:

#!/bin/sh

output=`mktemp -p . .merge_file_XXXXXX`
branch1="$7"
branch2="$9"
ancestor="$8"

cp $branch1 $output

if merge -L $2 -L $4 -L $6 $output $ancestor $branch2
then
    mv $output $branch1
    exit 0
else

    rm $output

    emacs --eval "(ediff-merge-files-with-ancestor \"${branch1}\" 
\"${branch2}\" \"${ancestor}\" nil \"${output}\")"

    if [ -s "$output" ]
    then
        mv $output $branch1
        exit 0
    else
        exit 1
    fi
fi

diff --git a/merge-recursive.c b/merge-recursive.c
index 5a70a5c..0e2da57 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -627,6 +627,8 @@ static char *git_unpack_file(const unsigned char *sha1, char *path)
 	return path;
 }
 
+static char* merge_tool = "merge";
+
 static struct merge_file_info merge_file(struct diff_filespec *o,
 		struct diff_filespec *a, struct diff_filespec *b,
 		const char *branch1, const char *branch2)
@@ -661,12 +663,14 @@ static struct merge_file_info merge_file(struct diff_filespec *o,
 			char src1[PATH_MAX];
 			char src2[PATH_MAX];
 			const char *argv[] = {
-				"merge", "-L", NULL, "-L", NULL, "-L", NULL,
+				NULL, "-L", NULL, "-L", NULL, "-L", NULL,
 				NULL, NULL, NULL,
 				NULL
 			};
 			char *la, *lb, *lo;
 
+			argv[0] = merge_tool;
+
 			git_unpack_file(o->sha1, orig);
 			git_unpack_file(a->sha1, src1);
 			git_unpack_file(b->sha1, src2);
@@ -1134,6 +1138,21 @@ static int process_entry(const char *path, struct stage_data *entry,
 	return clean_merge;
 }
 
+static int
+git_merge_config(const char *key, const char *val)
+{
+	char merge_key[] = "merge.";
+	if (strncmp( key, merge_key, sizeof merge_key - 1 ))
+		return 0;
+	key += sizeof merge_key - 1;
+
+	if (!strcmp( "tool", key )) {
+	    merge_tool = xstrdup(val);
+	}
+
+	return 0;
+}
+
 static int merge_trees(struct tree *head,
 		       struct tree *merge,
 		       struct tree *common,
@@ -1148,6 +1167,8 @@ static int merge_trees(struct tree *head,
 		return 1;
 	}
 
+	git_config( git_merge_config );
+
 	code = git_merge_trees(index_only, common, head, merge);
 
 	if (code != 0)
-- 
1.4.4.1.ge918e-dirty
