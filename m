From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 3/3] contrib/subtree: replace echo options with printf
Date: Sun, 24 Mar 2013 19:37:43 +0000
Message-ID: <1364153863-27437-4-git-send-email-pcampbell@kemitix.net>
References: <1364153863-27437-1-git-send-email-pcampbell@kemitix.net>
Cc: greened@obbligato.org, Paul Campbell <pcampbell@kemitix.net>,
	"Avery Pennarun" <apenwarr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 24 20:38:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJqko-0001BB-0r
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 20:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674Ab3CXTiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 15:38:20 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:50068 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577Ab3CXTiH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 15:38:07 -0400
Received: by mail-wi0-f173.google.com with SMTP id ez12so1323489wid.6
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 12:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=cNpjWfZFTPWiOi2aX7cLxrprIoE9E+FjKSztV1Sqnog=;
        b=IL9D+TVepKzkP8pmBJ4UDuUG+iRLDY376v2xFcDFwXsgGi93TsKMIymhmVrf/67HB6
         DI/EbKo8oOA/eJSs9O2EFy4s5FqZaldFmQoiJjoqibj86cRv9w59SThEl2SGCVksFYjW
         UO0kuQKcYSnBUsFthSHmkNmctwgWfr5N0KJ2N4YOcq6cDYL97u4+fBxpDPreygvr5rA6
         QjXXKRJD+mOeoeGNfteOYw88A00oUvtlsMw9gMt4XuEviRkpsBD8N+KH49d9/xzaiSST
         WFwiwNoJZd9e8s3/nLevTTTdHJHkLQxxOBy7K6PIGnUvRC69+rt1o/xKOynK0pJ5zChR
         RXHQ==
X-Received: by 10.180.7.133 with SMTP id j5mr13477949wia.15.1364153886299;
        Sun, 24 Mar 2013 12:38:06 -0700 (PDT)
Received: from coyote.home (host-2-102-87-178.as13285.net. [2.102.87.178])
        by mx.google.com with ESMTPS id ek4sm23825220wib.11.2013.03.24.12.38.04
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 24 Mar 2013 12:38:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364153863-27437-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQlvhloy7UnKfNlZXrPbYB1biYinEvS781PGp4G6WRuYyQhVSHP+mD28pf+AMa9ukmUsGSwF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218970>

Options to echo are not portable. In particular, the echo -e option is
implemented by some shells, including bash, to expand escape sequences.

Use the printf command instead, which is portable and much more reliable.

Only instances of echo and say (a wrapper for echo) where they are used
with options have been replaced with printf.

say_progress() is added to mirror the behaviour of say() in respecting
the -q/--quiet option.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---

This is a better version of the previously submitted patch 
(http://article.gmane.org/gmane.comp.version-control.git/218103) which
added another option to echo.

 contrib/subtree/git-subtree.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 884cbfb..35caf12 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -61,6 +61,13 @@ say()
 	fi
 }
 
+say_progress()
+{
+	if [ -z "$quiet" ]; then
+		printf "%s\r" "$@" >&2
+	fi
+}
+
 assert()
 {
 	if "$@"; then
@@ -311,7 +318,7 @@ copy_commit()
 			GIT_COMMITTER_NAME \
 			GIT_COMMITTER_EMAIL \
 			GIT_COMMITTER_DATE
-		(echo -n "$annotate"; cat ) |
+		(printf "$annotate"; cat ) |
 		git commit-tree "$2" $3  # reads the rest of stdin
 	) || die "Can't copy commit $1"
 }
@@ -592,7 +599,7 @@ cmd_split()
 	eval "$grl" |
 	while read rev parents; do
 		revcount=$(($revcount + 1))
-		say -n "$revcount/$revmax ($createcount)
"
+		say_progress "$revcount/$revmax ($createcount)"
 		debug "Processing commit: $rev"
 		exists=$(cache_get $rev)
 		if [ -n "$exists" ]; then
-- 
1.8.2
