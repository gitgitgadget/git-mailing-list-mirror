Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F80C2D0CE
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038F82073B
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 00:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgAYAND (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 19:13:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:44266 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729147AbgAYAND (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 19:13:03 -0500
Received: (qmail 9227 invoked by uid 109); 25 Jan 2020 00:13:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 25 Jan 2020 00:13:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12391 invoked by uid 111); 25 Jan 2020 00:20:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Jan 2020 19:20:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Jan 2020 19:13:01 -0500
From:   Jeff King <peff@peff.net>
To:     David =?utf-8?B?QnVyc3Ryw7Zt?= <davidburstrom@spotify.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 3/3] sha1-name: mark get_oid() error messages for translation
Message-ID: <20200125001301.GC567109@coredump.intra.peff.net>
References: <20200125000542.GA566779@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200125000542.GA566779@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are several error messages in get_oid() and its children that are
clearly intended for humans, but aren't marked for translation. E.g.:

  $ git show :1:foo
  fatal: Path 'foo' is in the index, but not at stage 1.
  Did you mean ':0:foo'?

Let's mark these for translation. While we're at it, let's switch the
style to be more like our usual error messages: start with a lowercase
letter and omit a period at the end of the line.

This does mean that multi-line messages like the one above don't have
any punctuation between the two sentences. I solved that by adding a
"hint" marker like we'd see from advise(). So the result is:

  $ git show :1:foo
  fatal: path 'foo' is in the index, but not at stage 1
  hint: Did you mean ':0:foo'?

A few tests had to be switched to test_i18ngrep and test_i18ncmp. Since
we were touching them anyway, I also simplified the ones using i18ngrep
a bit for readability.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm on the fence about whether the resulting message is clear enough.
Certainly we could just mark them for translation but leave the
capitalization and punctuation as-is.

I actually think _both_ of those lines could be considered hints. And
something like:

  hint: path 'foo' is in the index, but not at stage 1;
  hint: did you mean ':0:foo'?
  fatal: unable to resolve object name ':1:foo'

might be better still. But I suspect the text in that final "fatal"
could be better if done by the caller of get_oid(). So that takes me
back to my earlier suggestion that get_oid() should actually be
collecting this hints as it runs and making them available to the
caller. I punted on that for now, though.

 sha1-name.c                    | 30 +++++++++++++++---------------
 t/t1400-update-ref.sh          | 12 ++++++------
 t/t1506-rev-parse-diagnosis.sh | 22 +++++++++++-----------
 3 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 200eb373ad..75235cb490 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -919,15 +919,15 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 			}
 			if (at_time) {
 				if (!(flags & GET_OID_QUIETLY)) {
-					warning("Log for '%.*s' only goes "
-						"back to %s.", len, str,
+					warning(_("log for '%.*s' only goes back to %s"),
+						len, str,
 						show_date(co_time, co_tz, DATE_MODE(RFC2822)));
 				}
 			} else {
 				if (flags & GET_OID_QUIETLY) {
 					exit(128);
 				}
-				die("Log for '%.*s' only has %d entries.",
+				die(_("log for '%.*s' only has %d entries"),
 				    len, str, co_cnt);
 			}
 		}
@@ -1692,22 +1692,22 @@ static void diagnose_invalid_oid_path(struct repository *r,
 		prefix = "";
 
 	if (file_exists(filename))
-		die("Path '%s' exists on disk, but not in '%.*s'.",
+		die(_("path '%s' exists on disk, but not in '%.*s'"),
 		    filename, object_name_len, object_name);
 	if (is_missing_file_error(errno)) {
 		char *fullname = xstrfmt("%s%s", prefix, filename);
 
 		if (!get_tree_entry(r, tree_oid, fullname, &oid, &mode)) {
-			die("Path '%s' exists, but not '%s'.\n"
-			    "Did you mean '%.*s:%s' aka '%.*s:./%s'?",
+			die(_("path '%s' exists, but not '%s'\n"
+			    "hint: Did you mean '%.*s:%s' aka '%.*s:./%s'?"),
 			    fullname,
 			    filename,
 			    object_name_len, object_name,
 			    fullname,
 			    object_name_len, object_name,
 			    filename);
 		}
-		die("Path '%s' does not exist in '%.*s'",
+		die(_("path '%s' does not exist in '%.*s'"),
 		    filename, object_name_len, object_name);
 	}
 }
@@ -1735,8 +1735,8 @@ static void diagnose_invalid_index_path(struct repository *r,
 		ce = istate->cache[pos];
 		if (ce_namelen(ce) == namelen &&
 		    !memcmp(ce->name, filename, namelen))
-			die("Path '%s' is in the index, but not at stage %d.\n"
-			    "Did you mean ':%d:%s'?",
+			die(_("path '%s' is in the index, but not at stage %d\n"
+			    "hint: Did you mean ':%d:%s'?"),
 			    filename, stage,
 			    ce_stage(ce), filename);
 	}
@@ -1751,17 +1751,17 @@ static void diagnose_invalid_index_path(struct repository *r,
 		ce = istate->cache[pos];
 		if (ce_namelen(ce) == fullname.len &&
 		    !memcmp(ce->name, fullname.buf, fullname.len))
-			die("Path '%s' is in the index, but not '%s'.\n"
-			    "Did you mean ':%d:%s' aka ':%d:./%s'?",
+			die(_("path '%s' is in the index, but not '%s'\n"
+			    "hint: Did you mean ':%d:%s' aka ':%d:./%s'?"),
 			    fullname.buf, filename,
 			    ce_stage(ce), fullname.buf,
 			    ce_stage(ce), filename);
 	}
 
 	if (repo_file_exists(r, filename))
-		die("Path '%s' exists on disk, but not in the index.", filename);
+		die(_("path '%s' exists on disk, but not in the index"), filename);
 	if (is_missing_file_error(errno))
-		die("Path '%s' does not exist (neither on disk nor in the index).",
+		die(_("path '%s' does not exist (neither on disk nor in the index)"),
 		    filename);
 
 	strbuf_release(&fullname);
@@ -1774,7 +1774,7 @@ static char *resolve_relative_path(struct repository *r, const char *rel)
 		return NULL;
 
 	if (r != the_repository || !is_inside_work_tree())
-		die("relative path syntax can't be used outside working tree.");
+		die(_("relative path syntax can't be used outside working tree"));
 
 	/* die() inside prefix_path() if resolved path is outside worktree */
 	return prefix_path(startup_info->prefix,
@@ -1912,7 +1912,7 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			return ret;
 		} else {
 			if (only_to_die)
-				die("Invalid object name '%.*s'.", len, name);
+				die(_("invalid object name '%.*s'."), len, name);
 		}
 	}
 	return ret;
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index a86dd2fbd9..a6224ef65f 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -363,24 +363,24 @@ test_expect_success 'Query "master@{May 25 2005}" (before history)' '
 	git rev-parse --verify "master@{May 25 2005}" >o 2>e &&
 	echo "$C" >expect &&
 	test_cmp expect o &&
-	echo "warning: Log for '\''master'\'' only goes back to $ed." >expect &&
-	test_cmp expect e
+	echo "warning: log for '\''master'\'' only goes back to $ed" >expect &&
+	test_i18ncmp expect e
 '
 test_expect_success 'Query master@{2005-05-25} (before history)' '
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify master@{2005-05-25} >o 2>e &&
 	echo "$C" >expect &&
 	test_cmp expect o &&
-	echo "warning: Log for '\''master'\'' only goes back to $ed." >expect &&
-	test_cmp expect e
+	echo "warning: log for '\''master'\'' only goes back to $ed" >expect &&
+	test_i18ncmp expect e
 '
 test_expect_success 'Query "master@{May 26 2005 23:31:59}" (1 second before history)' '
 	test_when_finished "rm -f o e" &&
 	git rev-parse --verify "master@{May 26 2005 23:31:59}" >o 2>e &&
 	echo "$C" >expect &&
 	test_cmp expect o &&
-	echo "warning: Log for '\''master'\'' only goes back to $ed." >expect &&
-	test_cmp expect e
+	echo "warning: log for '\''master'\'' only goes back to $ed" >expect &&
+	test_i18ncmp expect e
 '
 test_expect_success 'Query "master@{May 26 2005 23:32:00}" (exactly history start)' '
 	test_when_finished "rm -f o e" &&
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index f49fc770d6..c2b5125c12 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -9,8 +9,8 @@ exec </dev/null
 test_did_you_mean ()
 {
 	cat >expected <<-EOF &&
-	fatal: Path '$2$3' $4, but not ${5:-$SQ$3$SQ}.
-	Did you mean '$1:$2$3'${2:+ aka $SQ$1:./$3$SQ}?
+	fatal: path '$2$3' $4, but not ${5:-$SQ$3$SQ}
+	hint: Did you mean '$1:$2$3'${2:+ aka $SQ$1:./$3$SQ}?
 	EOF
 	test_cmp expected error
 }
@@ -103,26 +103,26 @@ test_expect_success 'correct relative file objects (6)' '
 
 test_expect_success 'incorrect revision id' '
 	test_must_fail git rev-parse foobar:file.txt 2>error &&
-	grep "Invalid object name '"'"'foobar'"'"'." error &&
+	test_i18ngrep "invalid object name .foobar." error &&
 	test_must_fail git rev-parse foobar 2>error &&
 	test_i18ngrep "unknown revision or path not in the working tree." error
 '
 
 test_expect_success 'incorrect file in sha1:path' '
 	test_must_fail git rev-parse HEAD:nothing.txt 2>error &&
-	grep "fatal: Path '"'"'nothing.txt'"'"' does not exist in '"'"'HEAD'"'"'" error &&
+	test_i18ngrep "path .nothing.txt. does not exist in .HEAD." error &&
 	test_must_fail git rev-parse HEAD:index-only.txt 2>error &&
-	grep "fatal: Path '"'"'index-only.txt'"'"' exists on disk, but not in '"'"'HEAD'"'"'." error &&
+	test_i18ngrep "path .index-only.txt. exists on disk, but not in .HEAD." error &&
 	(cd subdir &&
 	 test_must_fail git rev-parse HEAD:file2.txt 2>error &&
 	 test_did_you_mean HEAD subdir/ file2.txt exists )
 '
 
 test_expect_success 'incorrect file in :path and :N:path' '
 	test_must_fail git rev-parse :nothing.txt 2>error &&
-	grep "fatal: Path '"'"'nothing.txt'"'"' does not exist (neither on disk nor in the index)." error &&
+	test_i18ngrep "path .nothing.txt. does not exist (neither on disk nor in the index)" error &&
 	test_must_fail git rev-parse :1:nothing.txt 2>error &&
-	grep "Path '"'"'nothing.txt'"'"' does not exist (neither on disk nor in the index)." error &&
+	test_i18ngrep "path .nothing.txt. does not exist (neither on disk nor in the index)" error &&
 	test_must_fail git rev-parse :1:file.txt 2>error &&
 	test_did_you_mean ":0" "" file.txt "is in the index" "at stage 1" &&
 	(cd subdir &&
@@ -133,16 +133,16 @@ test_expect_success 'incorrect file in :path and :N:path' '
 	 test_must_fail git rev-parse :2:file2.txt 2>error &&
 	 test_did_you_mean :0 subdir/ file2.txt "is in the index") &&
 	test_must_fail git rev-parse :disk-only.txt 2>error &&
-	grep "fatal: Path '"'"'disk-only.txt'"'"' exists on disk, but not in the index." error
+	test_i18ngrep "path .disk-only.txt. exists on disk, but not in the index" error
 '
 
 test_expect_success 'invalid @{n} reference' '
 	test_must_fail git rev-parse master@{99999} >output 2>error &&
 	test_must_be_empty output &&
-	grep "fatal: Log for [^ ]* only has [0-9][0-9]* entries." error  &&
+	test_i18ngrep "log for [^ ]* only has [0-9][0-9]* entries" error  &&
 	test_must_fail git rev-parse --verify master@{99999} >output 2>error &&
 	test_must_be_empty output &&
-	grep "fatal: Log for [^ ]* only has [0-9][0-9]* entries." error
+	test_i18ngrep "log for [^ ]* only has [0-9][0-9]* entries" error
 '
 
 test_expect_success 'relative path not found' '
@@ -162,7 +162,7 @@ test_expect_success 'relative path outside worktree' '
 test_expect_success 'relative path when cwd is outside worktree' '
 	test_must_fail git --git-dir=.git --work-tree=subdir rev-parse HEAD:./file.txt >output 2>error &&
 	test_must_be_empty output &&
-	grep "relative path syntax can.t be used outside working tree." error
+	test_i18ngrep "relative path syntax can.t be used outside working tree" error
 '
 
 test_expect_success '<commit>:file correctly diagnosed after a pathname' '
-- 
2.25.0.421.gb74d19af79
