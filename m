From: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
Subject: [PATCH/RFC 3/4] Handle arg as revision first, then option.
Date: Mon, 30 Mar 2015 13:41:54 -0400
Message-ID: <1427737315-7229-4-git-send-email-kenny.lee28@gmail.com>
References: <1427737315-7229-1-git-send-email-kenny.lee28@gmail.com>
Cc: gitster@pobox.com, Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 19:43:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycdi8-0002zy-OU
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 19:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758AbbC3Rme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 13:42:34 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33248 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740AbbC3Rmc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 13:42:32 -0400
Received: by iecvj10 with SMTP id vj10so124150943iec.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 10:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MJvYH/M7pEtaeemZR5TVwIQi+VudursJZs1lEuWAjtI=;
        b=b/hVehqQs4bPUEYnVmu9hDvNjfr0PWkNU7eJghkq+PQO1+uh6aWNnsZEvl74L54sIx
         UH9J7DVeBorYrD0jtt/wSZ/I7WByDfLJcVyO0BKley6pz762x4EMziv4aLDAWkWkJUY8
         xm19CPZbFuErYAChK6QOR88mm4i2EdRunu8oMbn8Hn2gqvheQrzpa9LP38p9tMC3y70i
         tFlKkqhLIXbbYLeeEkzddc9wh/tKGHQZ4GjKXNTb2WMp/oYlc3LISJM0Ay1B7AY//n/o
         mfzK6T9hYPVXG+6tD8XqijtmUErSvX0mvPZWvhfR3caF/YK4FcXgNxqXFc7RYkBjTJYv
         RMMQ==
X-Received: by 10.107.37.132 with SMTP id l126mr33568003iol.42.1427737351572;
        Mon, 30 Mar 2015 10:42:31 -0700 (PDT)
Received: from fujitsu.wireless.concordia.ca ([132.205.236.26])
        by mx.google.com with ESMTPSA id x9sm8246356igl.2.2015.03.30.10.42.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Mar 2015 10:42:31 -0700 (PDT)
X-Mailer: git-send-email 2.3.3.203.g8ffb468.dirty
In-Reply-To: <1427737315-7229-1-git-send-email-kenny.lee28@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266466>

Check the argument as a revision at first. If it fails, then tries to
check it as an option, and finally as a pathspec.

Returns -1 when we have an ambiguous revision range, such as
"master..next", to allow the argument to get checked as an option before
calling die() from verify_non_filename(). This is because we are
allowing "-" to be given in a revision range, but making the revision
check first. Otherwise, an ambiguous argument that starts with
"-" (let's say an option) would die even though its normal behaviour is
to silently return. Instead we check for ambiguity in a revision after
making sure that the argument cannot be parsed as an option.

This problem is discussed in:
http://article.gmane.org/gmane.comp.version-control.git/265672

Signed-off-by: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
---
 revision.c  | 61 +++++++++++++++++++++++++++++++++----------------------------
 sha1_name.c |  2 +-
 2 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/revision.c b/revision.c
index 570945a..1ea290f 100644
--- a/revision.c
+++ b/revision.c
@@ -1516,7 +1516,10 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 
 			if (!cant_be_filename) {
 				*dotdot = '.';
-				verify_non_filename(revs->prefix, arg);
+				if (is_inside_work_tree() && !is_inside_git_dir() &&
+				    check_filename(revs->prefix, arg)) {
+					return -1;
+				}
 			}
 
 			a_obj = parse_object(from_sha1);
@@ -2198,40 +2201,39 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	read_from_stdin = 0;
 	for (left = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
-		if (arg[0] == '-' && arg[1] && !starts_with(arg + 1, "..")) {
-			int opts;
-
-			opts = handle_revision_pseudo_opt(submodule,
-						revs, argc - i, argv + i,
-						&flags);
-			if (opts > 0) {
-				i += opts - 1;
-				continue;
-			}
+		if (handle_revision_arg(arg, revs, flags, revarg_opt)) {
+			if (arg[0] == '-' && arg[1] && !starts_with(arg + 1, "..")) {
+				int opts;
+
+				opts = handle_revision_pseudo_opt(submodule,
+								  revs, argc - i, argv + i,
+								  &flags);
+				if (opts > 0) {
+					i += opts - 1;
+					continue;
+				}
 
-			if (!strcmp(arg, "--stdin")) {
-				if (revs->disable_stdin) {
-					argv[left++] = arg;
+				if (!strcmp(arg, "--stdin")) {
+					if (revs->disable_stdin) {
+						argv[left++] = arg;
+						continue;
+					}
+					if (read_from_stdin++)
+						die("--stdin given twice?");
+					read_revisions_from_stdin(revs, &prune_data);
 					continue;
 				}
-				if (read_from_stdin++)
-					die("--stdin given twice?");
-				read_revisions_from_stdin(revs, &prune_data);
-				continue;
-			}
 
-			opts = handle_revision_opt(revs, argc - i, argv + i, &left, argv);
-			if (opts > 0) {
-				i += opts - 1;
+				opts = handle_revision_opt(revs, argc - i, argv + i, &left, argv);
+				if (opts > 0) {
+					i += opts - 1;
+					continue;
+				}
+				if (opts < 0)
+					exit(128);
 				continue;
 			}
-			if (opts < 0)
-				exit(128);
-			continue;
-		}
-
 
-		if (handle_revision_arg(arg, revs, flags, revarg_opt)) {
 			int j;
 			if (seen_dashdash || *arg == '^')
 				die("bad revision '%s'", arg);
@@ -2249,6 +2251,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			break;
 		}
 		else
+			/* Make sure that a filename doesn't get interpreted as a revision */
+			if (!seen_dashdash)
+				verify_non_filename(revs->prefix, arg);
 			got_rev_arg = 1;
 	}
 
diff --git a/sha1_name.c b/sha1_name.c
index 7a621ba..b99b1dc 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -483,7 +483,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
 				break;
 			}
 		}
-	} else if (len == 1 && str[0] == '-') {
+	} else if (len == 1 && str[0] == '-' && !str[1]) {
 		nth_prior = 1;
 	}
 
-- 
2.3.3.203.g8ffb468.dirty
