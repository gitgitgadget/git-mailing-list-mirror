From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Minimum git commit abbrev length (Was Re: -tip: origin tree build failure
Date: Thu, 28 Oct 2010 19:14:47 -0500
Message-ID: <hLlFGy1hpSTOvcrpvhJQRcAUG1VZkpE60VKEYdmOahsCx20NXHe-iEJGidVS1iD1R38bnTIIrwU@cipher.nrlssc.navy.mil>
References: <AANLkTin=EeQx4pEPk9ST27kcRpDP65NQvL1c1m8UcRmO@mail.gmail.com>
Cc: tytso@mit.edu, mingo@elte.hu, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: torvalds@linux-foundation.org
X-From: git-owner@vger.kernel.org Fri Oct 29 02:16:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBcdb-0006Ms-Fo
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 02:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759764Ab0J2AQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 20:16:04 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:38471 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759034Ab0J2AP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 20:15:56 -0400
Received: by mail.nrlssc.navy.mil id o9T0FBa4018548; Thu, 28 Oct 2010 19:15:11 -0500
In-Reply-To: <AANLkTin=EeQx4pEPk9ST27kcRpDP65NQvL1c1m8UcRmO@mail.gmail.com>
X-OriginalArrivalTime: 29 Oct 2010 00:15:11.0178 (UTC) FILETIME=[59DF7AA0:01CB76FE]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160255>

From: Brandon Casey <drafnel@gmail.com>

[dropped linux-kernel list from discussion]

On 10/28/2010 01:54 PM, Linus Torvalds wrote:

> and in fact git itself has a few collisions (but currently just 44
> objects ending up sharing 22 SHA1 buckets in 7 digits).
> 
> With each digit, you'd expect the collisions to decrease by a factor
> of 16, and that is indeed exactly what happens. For my current kernel
> tree I get:
> 
>  - 7 digits: 5823 buckets with duplicates (ie 11646 objects that aren't unique)
>  - 8: 406
>  - 9: 30
>  - 10: 1
>  - 11: 0
> 
> so 12 hex digits is indeed pretty safe for the kernel, and is likely
> to remain so until the kernel history grows by a factor of 16.


Perhaps we should calculate DEFAULT_ABBREV dynamically?

Something like the code down below would use 11 digits for the current
kernel repo, and would bump up to 12 digits once it hit 4M objects.

It would use 9 digits for git.git.

The digits of abbrev are bumped up for each factor of 4 objects.
This seems to produce a desirable number for the git.git and
linux-2.6.git repos.

estimate_loose_objects() quickly estimates the number of loose
objects using Junio's code extracted from gc.c.

default_abbrev() estimates the loose objects, counts the number of
packed objects, and calculates a default abbreviation width.
Subsequent calls to default_abbrev() return the previously calculated
value.

This is obviously not a patch meant for inclusion, just an example.

---
 builtin/describe.c |    4 ++-
 cache.h            |    3 +-
 sha1_name.c        |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 43caff2..551b491 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -20,7 +20,7 @@ static int debug;	/* Display lots of verbose info */
 static int all;	/* Any valid ref can be used */
 static int tags;	/* Allow lightweight tags */
 static int longformat;
-static int abbrev = DEFAULT_ABBREV;
+static int abbrev;
 static int max_candidates = 10;
 static int found_names;
 static const char *pattern;
@@ -386,6 +386,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	abbrev = DEFAULT_ABBREV;
+
 	argc = parse_options(argc, argv, prefix, options, describe_usage, 0);
 	if (max_candidates < 0)
 		max_candidates = 0;
diff --git a/cache.h b/cache.h
index 33decd9..049ef2b 100644
--- a/cache.h
+++ b/cache.h
@@ -758,7 +758,7 @@ static inline unsigned int hexval(unsigned char c)
 
 /* Convert to/from hex/sha1 representation */
 #define MINIMUM_ABBREV 4
-#define DEFAULT_ABBREV 7
+#define DEFAULT_ABBREV default_abbrev()
 
 struct object_context {
 	unsigned char tree[20];
@@ -766,6 +766,7 @@ struct object_context {
 	unsigned mode;
 };
 
+extern int default_abbrev(void);
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern int get_sha1_with_mode_1(const char *str, unsigned char *sha1, unsigned *mode, int gently, const char *prefix);
 static inline int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode)
diff --git a/sha1_name.c b/sha1_name.c
index 484081d..8d622fe 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -7,6 +7,67 @@
 #include "refs.h"
 #include "remote.h"
 
+static unsigned long estimate_loose_objects(unsigned threshold)
+{
+	/*
+	 * Quickly estimate how many loose objects there are.
+	 * Because SHA-1 is evenly distributed, we can check
+	 * only one and get a reasonable estimate.
+	 */
+	char path[PATH_MAX];
+	const char *objdir = get_object_directory();
+	DIR *dir;
+	struct dirent *ent;
+	unsigned long num_loose = 0;
+
+	if (sizeof(path) <= snprintf(path, sizeof(path), "%s/17", objdir)) {
+		warning("insanely long object directory %.*s", 50, objdir);
+		return 0;
+	}
+
+	dir = opendir(path);
+	if (!dir)
+		return 0;
+
+	threshold = (threshold + 255) / 256;
+	while ((ent = readdir(dir)) != NULL) {
+		if (strspn(ent->d_name, "0123456789abcdef") != 38 ||
+		    ent->d_name[38] != '\0')
+			continue;
+		num_loose++;
+		if (threshold && num_loose > threshold)
+			break;
+	}
+	closedir(dir);
+	return num_loose * 256;
+}
+
+int default_abbrev(void)
+{
+	static int default_abbrev;
+	unsigned long count;
+	struct packed_git *p;
+
+	if (default_abbrev)
+		return default_abbrev;
+
+	count = estimate_loose_objects(0);
+
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next)
+		if (!open_pack_index(p))
+			count += p->num_objects;
+
+	default_abbrev = 1;
+	while ((count >>= 2))
+		default_abbrev++;
+
+	if (default_abbrev < MINIMUM_ABBREV)
+		default_abbrev = MINIMUM_ABBREV;
+
+	return default_abbrev;
+}
+
 static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
 {
 	struct alternate_object_database *alt;
-- 
1.7.3.1
