From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: core.ignorecase = true support for .gitignore, status, ls-files,
 and add
Date: Thu, 22 Apr 2010 20:26:21 -0600
Message-ID: <4BD1054D.4000402@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 23 04:33:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O58hm-00021j-MO
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 04:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755341Ab0DWCdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 22:33:15 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:48636 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150Ab0DWCdO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 22:33:14 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Apr 2010 22:33:14 EDT
Received: (qmail 13939 invoked by uid 399); 22 Apr 2010 20:26:31 -0600
Received: from unknown (HELO ?192.168.1.107?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 22 Apr 2010 20:26:31 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.9) Gecko/20100317 Lightning/1.0b2pre Thunderbird/3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145582>

This is a follow up patch to one I posted mid last year.  At that time, 
unfortunately, I was unable to make the updates to the patch requested 
by list members.  Still, I continued to use the .gitignore case 
insensitivity updates.  In recent days, I have been able to clean up the 
code and provide some other useful features.  I am still in the progress 
of testing the behavior to ensure it works the way I intend it to.  I 
also need to clean up my case insensitivity updates to fast-import and 
git-p4.  Those aren't included (yet) in this patch.  When I have answers 
to my questions and the code is properly cleaned up, I'll sign off on 
the patch and submit it to the list.

I have a few questions.

git status and add both use an update made to name-hash.c where 
directories, specifically names with a trailing slash, can be looked up 
in a case insensitive manner.  After trying a myriad of solutions, this 
seemed to be the cleanest.  Does anyone see a problem with embedding the 
directory names in the same hash as the file names?  I couldn't find 
one, especially since I append a slash to each directory name.

The new directory_exists_in_index_icase() duplicates some of the 
functionality in directory_exists_in_index().  I don't understand some 
of the functionality I just mindlessly cloned.  Can anyone clue me in on 
what directory_exists_in_index() achieves in the case of S_ISGITLINK()?

Updating match_one() bought case insensitive matching support for git 
ls-files?  Are there other side effects I haven't found yet?

The git add path case "normalization" functionality is a somewhat 
radical departure from what Git does now.  I describe it in detail 
below.  Does anyone have any concerns?

Thanks for the help!

Josh

---------------------------------------------------------------------------------------

 From 6acd0b78400cf4f0249eaab0e7da922d5f961860 Mon Sep 17 00:00:00 2001
From: Joshua Jensen <jjensen@workspacewhiz.com>
Date: Thu, 22 Apr 2010 20:00:24 -0600
Subject: [PATCH] core.ignorecase=true support for .gitignore, status, 
ls-files, and add.

* .gitignore exclusions are processed in a case insensitive manner.  This
is especially beneficial when using Windows and Perforce and the git-p4
bridge. Perforce preserves a given file's full path including case. When
syncing a file down, directories are created, if necessary, using the case
as stored with the filename. Unfortunately, two files in the same
directory can have differing cases for their respective paths, such as
/dirA/file1.c and /DirA/file2.c. Depending on sync order, DirA/ may get
created instead of dirA/.

Trying to catch all case combinations for a set of gitignore entries is
very difficult. Having the exclusions honor the core.ignorecase=true makes
the process less error prone.

* git status - When mydir/filea.txt is added and mydir/ is renamed to
MyDir/, git status shows MyDir/ in the Untracked files section.  There are
other combinations where this happens, too.  Support was added in
name-hash.c for hashing directories with a terminating slash into the
name hash.  When index_name_exists() is called with a directory (a name
with a terminating slash), the name is not found via the normal
cache_name_compare() call, but it is found in slow_same_name().

* git ls-files - When mydir/filea.txt is added, mydir/ is renamed to
MyDir/, and MyDir/fileb.txt is added, previous to this patch, running
git ls-files mydir only shows mydir/filea.txt.  Running git ls-files
MyDir shows MyDir/fileb.txt.  Running git ls-files mYdIR shows nothing.
When the patch to dir.c's match_one() is applied, running git ls-files
for mydir, MyDir, and mYdIR shows mydir/filea.txt and MyDir/fileb.txt.

* git add - When MyDir/ABC/filea.txt is added, MyDir/ABC/ is renamed to
mydir/aBc/, and mydir/aBc/fileb.txt is added, previous to this patch, the
index will contain MyDir/ABC/filea.txt and mydir/aBc/fileb.txt.  Although
the rest of this patch accounts for those differences in case, this patch
makes the pathing consistent based on the first file added with that path.

In read-cache.c's add_to_index(), the index_name_exists() support used for
git status's case insensitive directory lookups is used to find the proper
directory case according to what the user already checked in.  That is,
MyDir/ABC/'s case is used to alter the stored path for fileb.txt to
MyDir/ABC/fileb.txt (instead of mydir/aBc/fileb.txt).

This is especially important when cloning a repository to a case sensitive
file system.  MyDir/ABC/ and mydir/aBc/ exist in the same directory on
a Windows machine, but on Linux, the files exist in two separate
directories.  The update to add_to_index(), in effect, treats a Windows
file system as case sensitive by making path case consistent.
---
  dir.c        |   91 
+++++++++++++++++++++++++++++++++++++++++++++------------
  name-hash.c  |   44 +++++++++++++++++++++++++++-
  read-cache.c |   16 ++++++++++
  3 files changed, 131 insertions(+), 20 deletions(-)

diff --git a/dir.c b/dir.c
index cb83332..ef97a2a 100644
--- a/dir.c
+++ b/dir.c
@@ -18,6 +18,22 @@ static int read_directory_recursive(struct dir_struct 
*dir, const char *path, in
      int check_only, const struct path_simplify *simplify);
  static int get_dtype(struct dirent *de, const char *path, int len);

+/* helper string functions with support for the ignore_case flag */
+int strcmp_icase(const char *a, const char *b)
+{
+    return ignore_case ? strcasecmp(a, b) : strcmp(a, b);
+}
+
+int strncmp_icase(const char *a, const char *b, size_t count)
+{
+    return ignore_case ? strncasecmp(a, b, count) : strncmp(a, b, count);
+}
+
+int fnmatch_icase(const char *pattern, const char *string, int flags)
+{
+    return fnmatch(pattern, string, flags | (ignore_case ? FNM_CASEFOLD 
: 0));
+}
+
  static int common_prefix(const char **pathspec)
  {
      const char *path, *slash, *next;
@@ -91,16 +107,30 @@ static int match_one(const char *match, const char 
*name, int namelen)
      if (!*match)
          return MATCHED_RECURSIVELY;

-    for (;;) {
-        unsigned char c1 = *match;
-        unsigned char c2 = *name;
-        if (c1 == '\0' || is_glob_special(c1))
-            break;
-        if (c1 != c2)
-            return 0;
-        match++;
-        name++;
-        namelen--;
+    if (ignore_case) {
+        for (;;) {
+            unsigned char c1 = tolower(*match);
+            unsigned char c2 = tolower(*name);
+            if (c1 == '\0' || is_glob_special(c1))
+                break;
+            if (c1 != c2)
+                return 0;
+            match++;
+            name++;
+            namelen--;
+        }
+    } else {
+        for (;;) {
+            unsigned char c1 = *match;
+            unsigned char c2 = *name;
+            if (c1 == '\0' || is_glob_special(c1))
+                break;
+            if (c1 != c2)
+                return 0;
+            match++;
+            name++;
+            namelen--;
+        }
      }


@@ -109,8 +139,8 @@ static int match_one(const char *match, const char 
*name, int namelen)
       * we need to match by fnmatch
       */
      matchlen = strlen(match);
-    if (strncmp(match, name, matchlen))
-        return !fnmatch(match, name, 0) ? MATCHED_FNMATCH : 0;
+    if (strncmp_icase(match, name, matchlen))
+        return !fnmatch_icase(match, name, 0) ? MATCHED_FNMATCH : 0;

      if (namelen == matchlen)
          return MATCHED_EXACTLY;
@@ -374,14 +404,14 @@ int excluded_from_list(const char *pathname,
              if (x->flags & EXC_FLAG_NODIR) {
                  /* match basename */
                  if (x->flags & EXC_FLAG_NOWILDCARD) {
-                    if (!strcmp(exclude, basename))
+                    if (!strcmp_icase(exclude, basename))
                          return to_exclude;
                  } else if (x->flags & EXC_FLAG_ENDSWITH) {
                      if (x->patternlen - 1 <= pathlen &&
-                        !strcmp(exclude + 1, pathname + pathlen - 
x->patternlen + 1))
+                        !strcmp_icase(exclude + 1, pathname + pathlen - 
x->patternlen + 1))
                          return to_exclude;
                  } else {
-                    if (fnmatch(exclude, basename, 0) == 0)
+                    if (fnmatch_icase(exclude, basename, 0) == 0)
                          return to_exclude;
                  }
              }
@@ -396,14 +426,14 @@ int excluded_from_list(const char *pathname,

                  if (pathlen < baselen ||
                      (baselen && pathname[baselen-1] != '/') ||
-                    strncmp(pathname, x->base, baselen))
+                    strncmp_icase(pathname, x->base, baselen))
                      continue;

                  if (x->flags & EXC_FLAG_NOWILDCARD) {
-                    if (!strcmp(exclude, pathname + baselen))
+                    if (!strcmp_icase(exclude, pathname + baselen))
                          return to_exclude;
                  } else {
-                    if (fnmatch(exclude, pathname+baselen,
+                    if (fnmatch_icase(exclude, pathname+baselen,
                              FNM_PATHNAME) == 0)
                          return to_exclude;
                  }
@@ -468,6 +498,24 @@ enum exist_status {
      index_gitdir,
  };

+static enum exist_status directory_exists_in_index_icase(const char 
*dirname, int len)
+{
+    struct cache_entry *ce = index_name_exists(&the_index, dirname, len 
+ 1, ignore_case);
+    if (!ce)
+        return index_nonexistent;
+
+    if (!strncmp_icase(ce->name, dirname, len)) {
+        unsigned char endchar = ce->name[len];
+        if (endchar <= '/') {
+            if (endchar == '/')
+                return index_directory;
+            if (!endchar && S_ISGITLINK(ce->ce_mode))
+                return index_gitdir;
+        }
+    }
+    return index_nonexistent;
+}
+
  /*
   * The index sorts alphabetically by entry name, which
   * means that a gitlink sorts as '\0' at the end, while
@@ -477,7 +525,12 @@ enum exist_status {
   */
  static enum exist_status directory_exists_in_index(const char 
*dirname, int len)
  {
-    int pos = cache_name_pos(dirname, len);
+    int pos;
+
+    if (ignore_case)
+        return directory_exists_in_index_icase(dirname, len);
+
+    pos = cache_name_pos(dirname, len);
      if (pos < 0)
          pos = -pos-1;
      while (pos < active_nr) {
diff --git a/name-hash.c b/name-hash.c
index 0031d78..b10b5b1 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -32,6 +32,30 @@ static unsigned int hash_name(const char *name, int 
namelen)
      return hash;
  }

+static void hash_index_entry_directories(struct index_state *istate, 
struct cache_entry *ce)
+{
+    /* throw each directory component in the hash for quick lookup 
during a git status */
+    unsigned int hash;
+    void **pos;
+
+    const char *ptr = ce->name;
+    while (*ptr) {
+        while (*ptr && *ptr != '/')
+            ++ptr;
+        if (*ptr == '/') {
+            ++ptr;
+            hash = hash_name(ce->name, ptr - ce->name);
+            if (!lookup_hash(hash, &istate->name_hash)) {
+                pos = insert_hash(hash, ce, &istate->name_hash);
+                if (pos) {
+                    ce->next = *pos;
+                    *pos = ce;
+                }
+            }
+        }
+    }
+}
+
  static void hash_index_entry(struct index_state *istate, struct 
cache_entry *ce)
  {
      void **pos;
@@ -47,6 +71,9 @@ static void hash_index_entry(struct index_state 
*istate, struct cache_entry *ce)
          ce->next = *pos;
          *pos = ce;
      }
+
+    if (ignore_case)
+        hash_index_entry_directories(istate, ce);
  }

  static void lazy_init_name_hash(struct index_state *istate)
@@ -97,7 +124,22 @@ static int same_name(const struct cache_entry *ce, 
const char *name, int namelen
      if (len == namelen && !cache_name_compare(name, namelen, ce->name, 
len))
          return 1;

-    return icase && slow_same_name(name, namelen, ce->name, len);
+    if (!icase)
+        return 0;
+
+    /*
+     * If the entry we're comparing is a filename (no trailing slash), 
then compare
+     * the lengths exactly.
+     */
+    if (name[namelen - 1] != '/') {
+        return slow_same_name(name, namelen, ce->name, len);
+    }
+
+    /*
+     * For a directory, we point to an arbitrary cache_entry filename.  
Just
+     * make sure the directory portion matches.
+     */
+    return slow_same_name(name, namelen, ce->name, namelen < len ? 
namelen : len);
  }

  struct cache_entry *index_name_exists(struct index_state *istate, 
const char *name, int namelen, int icase)
diff --git a/read-cache.c b/read-cache.c
index f1f789b..b3954d5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -608,6 +608,22 @@ int add_to_index(struct index_state *istate, const 
char *path, struct stat *st,
          ce->ce_mode = ce_mode_from_stat(ent, st_mode);
      }

+    if (ignore_case) {
+        const char *startPtr = ce->name;
+        const char *ptr = startPtr;
+        while (*ptr) {
+            while (*ptr && *ptr != '/')
+                ++ptr;
+            if (*ptr == '/') {
+                struct cache_entry *foundce;
+                ++ptr;
+                foundce = index_name_exists(&the_index, ce->name, ptr - 
ce->name, ignore_case);
+                if (foundce)
+                    memcpy((void*)startPtr, foundce->name + (startPtr - 
ce->name), ptr - startPtr);
+            }
+        }
+    }
+
      alias = index_name_exists(istate, ce->name, ce_namelen(ce), 
ignore_case);
      if (alias && !ce_stage(alias) && !ie_match_stat(istate, alias, st, 
ce_option)) {
          /* Nothing changed, really */
-- 
1.7.1.msysgit.0.dirty
