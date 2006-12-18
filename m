X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-fetch: Avoid reading packed refs over and over again
Date: Sun, 17 Dec 2006 17:54:58 -0800
Message-ID: <7vslfe3r4d.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0612172048331.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 01:55:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34716>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gw7ik-0004Zu-Rn for gcvg-git@gmane.org; Mon, 18 Dec
 2006 02:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751487AbWLRBzA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 20:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWLRBzA
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 20:55:00 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:38653 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751487AbWLRBzA (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006
 20:55:00 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061218015459.MXYW22053.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Sun, 17
 Dec 2006 20:54:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 01vB1W00E1kojtg0000000; Sun, 17 Dec 2006
 20:55:11 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	Since this option is purely for use in git-fetch, I did not even
> 	bother documenting it.

I think the name --filter-blah makes it unclear if it is a
filter that picks up items that match the criteria "blah" out of
its input, or if it filters out the ones that do not match the
criteria.

In either case, you are not filtering "invalid vs valid" but
"existing vs missing".

If you are making a git-fetch specific extension, it would make
sense to include what the upstream sed does as well.  That is,
the user would become:

	echo "$ls_remote_result" |
-       sed -n	-e 's|^\('"$_x40"'\)	\(refs/tags/.*\)^{}$|\1 \2|p' \
-               -e 's|^\('"$_x40"'\)	\(refs/tags/.*\)$|\1 \2|p' |
+	git show-ref --exclude-existing=refs/tags/ |
        while read sha1 name
        do
-		git-show-ref --verify --quiet -- "$name" && continue
-		git-check-ref-format "$name" || {
-			echo >&2 "warning: tag ${name} ignored"
-			continue

The 'exclude-existing' flag would filter out the ones that do not
head-match the specified hierarchy, the ones that we have, and
the ones that do not conform to a valid refname pattern (which
would filter out ^{} entries).

How about this as a replacement?

---

 builtin-show-ref.c |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 git-fetch.sh       |   12 ++-------
 2 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index 0739798..b36f15e 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -2,8 +2,9 @@
 #include "refs.h"
 #include "object.h"
 #include "tag.h"
+#include "path-list.h"
 
-static const char show_ref_usage[] = "git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--dereference] [-s|--hash[=<length>]] [--abbrev[=<length>]] [--tags] [--heads] [--] [pattern*]";
+static const char show_ref_usage[] = "git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--dereference] [-s|--hash[=<length>]] [--abbrev[=<length>]] [--tags] [--heads] [--] [pattern*] | --filter-invalid < ref-list";
 
 static int deref_tags = 0, show_head = 0, tags_only = 0, heads_only = 0,
 	found_match = 0, verify = 0, quiet = 0, hash_only = 0, abbrev = 0;
@@ -86,6 +87,59 @@ match:
 	return 0;
 }
 
+static int add_existing(const char *refname, const unsigned char *sha1, int flag, void *cbdata)
+{
+	struct path_list *list = (struct path_list *)cbdata;
+	path_list_insert(refname, list);
+	return 0;
+}
+
+/*
+ * read "^(?:<anything>\s)?<refname>(?:\^\{\})?$" from the standard input,
+ * and
+ * (1) strip "^{}" at the end of line if any;
+ * (2) ignore if match is provided and does not head-match refname;
+ * (3) warn if refname is not a well-formed refname and skip;
+ * (4) ignore if refname is a ref that exists in the local repository;
+ * (5) otherwise output the line.
+ */
+static int exclude_existing(const char *match)
+{
+	static struct path_list existing_refs = { NULL, 0, 0, 0 };
+	char buf[1024];
+	int matchlen = match ? strlen(match) : 0;
+
+	for_each_ref(add_existing, &existing_refs);
+	while (fgets(buf, sizeof(buf), stdin)) {
+		int len = strlen(buf);
+		char *ref;
+		if (len > 0 && buf[len - 1] == '\n')
+			buf[--len] = '\0';
+		if (!strcmp(buf + len - 3, "^{}")) {
+			len -= 3;
+			buf[len] = '\0';
+		}
+		for (ref = buf + len; buf < ref; ref--)
+			if (isspace(ref[-1]))
+				break;
+		if (match) {
+			int reflen = buf + len - ref;
+			if (reflen < matchlen)
+				continue;
+			if (strncmp(ref, match, matchlen))
+				continue;
+		}
+		if (check_ref_format(ref)) {
+			fprintf(stderr, "warning: ref '%s' ignored\n", ref);
+			continue;
+		}
+		if (!path_list_has_path(&existing_refs, ref)) {
+			printf("%s\n", buf);
+		}
+	}
+	return 0;
+}
+
 int cmd_show_ref(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -153,6 +207,10 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 			heads_only = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--exclude-existing"))
+			return exclude_existing(NULL);
+		if (!strncmp(arg, "--exclude-existing=", 19))
+			return exclude_existing(arg + 19);
 		usage(show_ref_usage);
 	}
 	if (show_head)
diff --git a/git-fetch.sh b/git-fetch.sh
index fb35815..38101a6 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -242,7 +242,7 @@ esac
 reflist=$(get_remote_refs_for_fetch "$@")
 if test "$tags"
 then
-	taglist=`IFS="	" &&
+	taglist=`IFS='	' &&
 		  echo "$ls_remote_result" |
 	          while read sha1 name
 		  do
@@ -438,17 +438,11 @@ case "$no_tags$tags" in
 	*:refs/*)
 		# effective only when we are following remote branch
 		# using local tracking branch.
-		taglist=$(IFS=" " &&
+		taglist=$(IFS='	' &&
 		echo "$ls_remote_result" |
-		sed -n	-e 's|^\('"$_x40"'\)	\(refs/tags/.*\)^{}$|\1 \2|p' \
-			-e 's|^\('"$_x40"'\)	\(refs/tags/.*\)$|\1 \2|p' |
+		git-show-ref --exclude-existing=refs/tags/ |
 		while read sha1 name
 		do
-			git-show-ref --verify --quiet -- "$name" && continue
-			git-check-ref-format "$name" || {
-				echo >&2 "warning: tag ${name} ignored"
-				continue
-			}
 			git-cat-file -t "$sha1" >/dev/null 2>&1 || continue
 			echo >&2 "Auto-following $name"
 			echo ".${name}:${name}"
