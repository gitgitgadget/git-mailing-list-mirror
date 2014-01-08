From: Jeff King <peff@peff.net>
Subject: [PATCH v2 5/5] get_sha1: drop object/refname ambiguity flag
Date: Tue, 7 Jan 2014 19:00:09 -0500
Message-ID: <20140108000009.GE10657@sigill.intra.peff.net>
References: <20140107235631.GA10503@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brodie Rao <brodie@sf.io>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 01:00:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0gZL-0003H7-Oi
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 01:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855AbaAHAAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 19:00:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:56854 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754829AbaAHAAL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 19:00:11 -0500
Received: (qmail 1840 invoked by uid 102); 8 Jan 2014 00:00:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jan 2014 18:00:11 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jan 2014 19:00:09 -0500
Content-Disposition: inline
In-Reply-To: <20140107235631.GA10503@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240187>

Now that our object/refname ambiguity test is much faster
(thanks to the previous commit), there is no reason for code
like "cat-file --batch-check" to turn it off. Here are
before and after timings with this patch (on git.git):

  $ git rev-list --objects --all | cut -d' ' -f1 >objects

  [with flag]
  $ best-of-five -i objects ./git cat-file --batch-check
  real    0m0.392s
  user    0m0.368s
  sys     0m0.024s

  [without flag, without speedup; i.e., pre-25fba78]
  $ best-of-five -i objects ./git cat-file --batch-check
  real    0m1.652s
  user    0m0.904s
  sys     0m0.748s

  [without flag, with speedup]
  $ best-of-five -i objects ./git cat-file --batch-check
  real    0m0.388s
  user    0m0.356s
  sys     0m0.028s

So the new implementation does just as well as we did with
the flag turning the whole thing off (better actually, but
that is within the noise).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 9 ---------
 cache.h            | 1 -
 environment.c      | 1 -
 sha1_name.c        | 2 +-
 4 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index ce79103..afba21f 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -285,15 +285,6 @@ static int batch_objects(struct batch_options *opt)
 	if (opt->print_contents)
 		data.info.typep = &data.type;
 
-	/*
-	 * We are going to call get_sha1 on a potentially very large number of
-	 * objects. In most large cases, these will be actual object sha1s. The
-	 * cost to double-check that each one is not also a ref (just so we can
-	 * warn) ends up dwarfing the actual cost of the object lookups
-	 * themselves. We can work around it by just turning off the warning.
-	 */
-	warn_on_object_refname_ambiguity = 0;
-
 	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
 		if (data.split_on_whitespace) {
 			/*
diff --git a/cache.h b/cache.h
index ce377e1..73afc38 100644
--- a/cache.h
+++ b/cache.h
@@ -566,7 +566,6 @@ extern int assume_unchanged;
 extern int prefer_symlink_refs;
 extern int log_all_ref_updates;
 extern int warn_ambiguous_refs;
-extern int warn_on_object_refname_ambiguity;
 extern int shared_repository;
 extern const char *apply_default_whitespace;
 extern const char *apply_default_ignorewhitespace;
diff --git a/environment.c b/environment.c
index 3c76905..c59f6d4 100644
--- a/environment.c
+++ b/environment.c
@@ -22,7 +22,6 @@ int prefer_symlink_refs;
 int is_bare_repository_cfg = -1; /* unspecified */
 int log_all_ref_updates = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
-int warn_on_object_refname_ambiguity = 1;
 int repository_format_version;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
diff --git a/sha1_name.c b/sha1_name.c
index f83ecb7..b9aaf74 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -451,7 +451,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	int at, reflog_len, nth_prior = 0;
 
 	if (len == 40 && !get_sha1_hex(str, sha1)) {
-		if (warn_ambiguous_refs && warn_on_object_refname_ambiguity) {
+		if (warn_ambiguous_refs) {
 			if (sha1_is_ambiguous_with_ref(sha1)) {
 				warning(warn_msg, len, str);
 				if (advice_object_name_warning)
-- 
1.8.5.2.500.g8060133
