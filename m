From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/17] Introduce new config option for mmap limit.
Date: Sat, 23 Dec 2006 02:33:35 -0500
Message-ID: <20061223073335.GC9837@spearce.org>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 08:33:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy1O4-0001mU-PN
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 08:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbWLWHdj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 02:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752636AbWLWHdj
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 02:33:39 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38733 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbWLWHdi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 02:33:38 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gy1NY-00035e-P1; Sat, 23 Dec 2006 02:33:12 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6C17920FB65; Sat, 23 Dec 2006 02:33:35 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35282>

Rather than hardcoding the maximum number of bytes which can be
mmapped from pack files we should make this value configurable,
allowing the end user to increase or decrease this limit on a
per-repository basis depending on the size of the repository
and the capabilities of their operating system.

In general users should not need to manually tune such a low-level
setting within the core code, but being able to artifically limit
the number of bytes which we can mmap at once from pack files will
make it easier to craft test cases for the new mmap sliding window
implementation.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/config.txt |    9 +++++++++
 cache.h                  |    1 +
 config.c                 |    5 +++++
 environment.c            |    1 +
 sha1_file.c              |    3 +--
 5 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 22482d6..4e93066 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -118,6 +118,15 @@ core.legacyheaders::
 	database directly (where the "http://" and "rsync://" protocols
 	count as direct access).
 
+core.packedGitLimit::
+	Maximum number of bytes to map simultaneously into memory
+	from pack files.  If Git needs to access more than this many
+	bytes at once to complete an operation it will unmap existing
+	regions to reclaim virtual address space within the process.
+	Default is 256 MiB, which should be reasonable for all
+	users/operating systems, except on largest Git projects.
+	You probably do not need to adjust this value.
+
 alias.*::
 	Command aliases for the gitlink:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
diff --git a/cache.h b/cache.h
index 38db1bf..ad94c3f 100644
--- a/cache.h
+++ b/cache.h
@@ -196,6 +196,7 @@ extern int warn_ambiguous_refs;
 extern int shared_repository;
 extern const char *apply_default_whitespace;
 extern int zlib_compression_level;
+extern size_t packed_git_limit;
 
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
diff --git a/config.c b/config.c
index 1662a46..1e79f09 100644
--- a/config.c
+++ b/config.c
@@ -298,6 +298,11 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.packedgitlimit")) {
+		packed_git_limit = git_config_int(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "user.name")) {
 		strlcpy(git_default_name, value, sizeof(git_default_name));
 		return 0;
diff --git a/environment.c b/environment.c
index f8c7dbc..8a09df2 100644
--- a/environment.c
+++ b/environment.c
@@ -22,6 +22,7 @@ char git_commit_encoding[MAX_ENCODING_LENGTH] = "utf-8";
 int shared_repository = PERM_UMASK;
 const char *apply_default_whitespace;
 int zlib_compression_level = Z_DEFAULT_COMPRESSION;
+size_t packed_git_limit = 256 * 1024 * 1024;
 int pager_in_use;
 int pager_use_color = 1;
 
diff --git a/sha1_file.c b/sha1_file.c
index 4824a5d..4183f59 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -397,7 +397,6 @@ static char *find_sha1_file(const unsigned char *sha1, struct stat *st)
 	return NULL;
 }
 
-#define PACK_MAX_SZ (1<<26)
 static int pack_used_ctr;
 static unsigned long pack_mapped;
 struct packed_git *packed_git;
@@ -490,7 +489,7 @@ int use_packed_git(struct packed_git *p)
 		struct pack_header *hdr;
 
 		pack_mapped += p->pack_size;
-		while (PACK_MAX_SZ < pack_mapped && unuse_one_packed_git())
+		while (packed_git_limit < pack_mapped && unuse_one_packed_git())
 			; /* nothing */
 		fd = open(p->pack_name, O_RDONLY);
 		if (fd < 0)
-- 
1.4.4.3.g87d8
