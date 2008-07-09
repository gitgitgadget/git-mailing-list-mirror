From: "Geoffrey Irving" <irving@naml.us>
Subject: [PATCH 3/3] cherry: add cherry.cachepatchids option
Date: Tue, 8 Jul 2008 20:57:18 -0700
Message-ID: <7f9d599f0807082057s6415598fh2f37aa27432e882e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 05:58:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGQor-0000v8-An
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 05:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbYGID5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 23:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753138AbYGID5U
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 23:57:20 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:36885 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbYGID5T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 23:57:19 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3410718rvb.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 20:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=yk6R+Zgl+n1iroy8mGocJ7yG6JcFMMqNsh154YjX/nk=;
        b=Td7ZtBo3boTuMQiex1e4TLPEKmyFPpMBzDpGeyyQRk3CLcmZMRyclbc8hf7Iv6iyiv
         L5FGrLFviLkU946KVPSwMvaF3+yl2JbiQZSwMq1ODDnlpKgbf/JrpWV7lGEVHPL5gq16
         ooWdQLAln3HAeJEde7872YGS4eh9pv1wj8cQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=h4R6ooTjh3qBKQMOeWhZ9yd16hfKFN87CPqn1ijNHkDnuzT1c0s/sALzpI4p5lerzV
         hrZH7WCVQb/8RDkpgL52gChOpNJ5UlC+RMOrdlr81IeJeqiQ1n2qJjeDMwkKGHRmMn2M
         QfyFJS4hllaFPToNAu2URhFk+9wFK2i6OOwRA=
Received: by 10.141.180.5 with SMTP id h5mr3663528rvp.240.1215575838671;
        Tue, 08 Jul 2008 20:57:18 -0700 (PDT)
Received: by 10.141.202.6 with HTTP; Tue, 8 Jul 2008 20:57:18 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 4049b18a12dd3c13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87837>

>From 7a51a1808fb440b1aca58780ccc09ffe11d4d3d6 Mon Sep 17 00:00:00 2001
From: Geoffrey Irving <irving@naml.us>
Date: Tue, 8 Jul 2008 20:25:53 -0700
Subject: [PATCH 3/3] cherry: add cherry.cachepatchids option

The patch-id caching optimization in git-cherry is still enabled by default,
but now it can be disabled by setting cherry.cachepatchids = false.
---
 Documentation/config.txt |    5 +++++
 builtin-log.c            |   12 ++++++++++++
 patch-ids.c              |   12 +++++++++---
 patch-ids.h              |    2 ++
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 838794d..02b8113 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -468,6 +468,11 @@ browser.<tool>.path::
 	browse HTML help (see '-w' option in linkgit:git-help[1]) or a
 	working repository in gitweb (see linkgit:git-instaweb[1]).

+cherry.cachepatchids::
+	If true, linkgit:git-cherry will store a cache of computed patch-ids
+	in $GIT_DIR/patch-id-cache in order to make repeated invocations faster.
+	Defaults to true.
+
 clean.requireForce::
 	A boolean to make git-clean do nothing unless given -f
 	or -n.   Defaults to true.
diff --git a/builtin-log.c b/builtin-log.c
index 430d876..fbfefbd 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1081,6 +1081,16 @@ static int add_pending_commit(const char *arg,
struct rev_info *revs, int flags)
 	return -1;
 }

+static int git_cherry_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "cherry.cachepatchids")) {
+		cache_patch_ids = git_config_bool(var, value);
+		return 0;
+	}
+
+	return 0;
+}
+
 static const char cherry_usage[] =
 "git-cherry [-v] <upstream> [<head>] [<limit>]";
 int cmd_cherry(int argc, const char **argv, const char *prefix)
@@ -1094,6 +1104,8 @@ int cmd_cherry(int argc, const char **argv,
const char *prefix)
 	const char *limit = NULL;
 	int verbose = 0;

+	git_config(git_cherry_config, NULL);
+
 	if (argc > 1 && !strcmp(argv[1], "-v")) {
 		verbose = 1;
 		argc--;
diff --git a/patch-ids.c b/patch-ids.c
index 36332f3..7e3a563 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -4,6 +4,7 @@
 #include "patch-ids.h"
 #include "cached-sha1-map.h"

+int cache_patch_ids = 1;
 struct cached_sha1_map patch_id_cache;

 static int commit_patch_id(struct commit *commit, struct diff_options *options,
@@ -11,7 +12,8 @@ static int commit_patch_id(struct commit *commit,
struct diff_options *options,
 {
 	/* pull patch-id out of the cache if possible */
 	patch_id_cache.filename = "patch-id-cache";
-	if (!get_cached_sha1_entry(&patch_id_cache, commit->object.sha1, sha1))
+	if (cache_patch_ids && !get_cached_sha1_entry(&patch_id_cache,
+			commit->object.sha1, sha1))
 		return 0;

 	if (commit->parents)
@@ -25,7 +27,8 @@ static int commit_patch_id(struct commit *commit,
struct diff_options *options,
 		return ret;

 	/* record commit, patch-id pair in cache */
-	set_cached_sha1_entry(&patch_id_cache, commit->object.sha1, sha1);
+	if (cache_patch_ids)
+		set_cached_sha1_entry(&patch_id_cache, commit->object.sha1, sha1);
 	return 0;
 }

@@ -151,7 +154,10 @@ int free_patch_ids(struct patch_ids *ids)
 		free(patches);
 	}

-	write_cached_sha1_map(&patch_id_cache);
+	/* write cached patch-ids and ignore any errors that arise
+	 * (e.g. if the repository is write protected) */
+	if (cache_patch_ids)
+		write_cached_sha1_map(&patch_id_cache);
 	return 0;
 }

diff --git a/patch-ids.h b/patch-ids.h
index c8c7ca1..c0ebdc1 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -18,4 +18,6 @@ int free_patch_ids(struct patch_ids *);
 struct patch_id *add_commit_patch_id(struct commit *, struct patch_ids *);
 struct patch_id *has_commit_patch_id(struct commit *, struct patch_ids *);

+extern int cache_patch_ids;
+
 #endif /* PATCH_IDS_H */
-- 
1.5.6.2.258.g7a51a
