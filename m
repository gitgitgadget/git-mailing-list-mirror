From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] t3910: show failure of core.precomposeunicode with decomposed
 filenames
Date: Sun, 04 May 2014 08:13:15 +0200
Message-ID: <5365DA7B.6050000@web.de>
References: <20140428161630.GA9435@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 04 08:13:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wgpg8-0001Ob-Og
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 08:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbaEDGNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 02:13:32 -0400
Received: from mout.web.de ([212.227.15.4]:64508 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258AbaEDGNb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 02:13:31 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MZlNu-1WQo9l3fyw-00LaHb; Sun, 04 May 2014 08:13:16
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140428161630.GA9435@sigill.intra.peff.net>
X-Provags-ID: V03:K0:hp2EHD2ntozQq8kOaq3T6DKqGIl2Opd22BpNwuTuPM7vaKgTdl7
 xZDZeCXk52R8ZHW4QIH/8D4qB6kNY9i3Yt0YGHGA8XL9+bBYvNt44OzCR+LshctelJGKCtL
 jzV6ezGmTSCNMEoeV/h3zEmGArWTxqB8nLRyicaiJrzzNUu4AzJlZrfKqOyRGyx8+Cr2OPb
 rlXO/HG+Efwfy8pbeBHQQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248073>

(Sorry for the late reply, I'm handicapped by some local IT problems)
Peff, do you know if the fix below helps ?

On 2014-04-28 18.16, Jeff King wrote:
> If you have existing decomposed filenames in your git
> repository (e.g., that were created with older versions of
> git that did not precompose unicode), a modern git with
> core.precomposeunicode set does not handle them well.
Yes.
> The problem is that we normalize the paths coming from the
> disk into their precomposed form, and then compare them
> against the literal bytes in the index. This makes things
> better if you have the precomposed form in the index. It
> makes things worse if you actually have the decomposed form
> in the index.
>
> As a result, paths with decomposed filenames may have their
> precomposed variants listed as untracked files (even though
> the precomposed variants do not exist on-disk at all).
Yes
> This patch just adds a test to demonstrate the breakage.
> Some possible fixes are:
>
>   1. Tell everyone that NFD in the git repo is wrong, and
>      they should make a new commit to normalize all their
>      in-repo files to be precomposed.
>      This is probably not the right thing to do, because it
>      still doesn't fix checkouts of old history. And it
>      spreads the problem to people on byte-preserving
>      filesystems (like ext4), because now they have to start
>      precomposing their filenames as they are adde to git.
     (typo:                                                                  ^added)
I'm not sure if I follow. People running ext4 (or Linux in general,
or Windows, or Unix) do not suffer from file system
"feature" of Mac OS, which accepts precomposed/decomposed Unicode
but returns decompomsed.
>
>   2. Do all index filename comparisons using a UTF-8 aware
>      comparison function when core.precomposeunicode is set.
>      This would probably have bad performance, and somewhat
>      defeats the point of converting the filenames at the
>      readdir level in the first place.
>
>   3. Convert index filenames to their precomposed form when
>      we read the index from disk. This would be efficient,
>      but we would have to be careful not to write the
>      precomposed forms back out to disk.
Question:
How could we be careful?
Mac OS writes always decomposed Unicode to disk.
(And all other OS tend to use precomposed forms, mainly because the "keyboard
driver" generates it.)
>
>   4. Introduce some infrastructure to efficiently match up
>      the precomposed/decomposed forms. We already do
>      something similar for case-insensitive files using
>      name-hash.c. We might be able to adapt that strategy
>      here.
--------------------------

This is my understanding:
Some possible fixes are:

  1. Accept that NFD in a Git repo which is shared between Mac OS
     and Linux or Windows is problematic.
     Whenever core.precomposeunicode = true, do the following:
     Let Git under Mac OS change all file names in the index
     into the precomposed form when a new commit is done.
     This is probably not a wrong thing to do.

     When the index file is read into memory, precompose the file names and compare
     them with the precomposed form coming from precompose_utf8_readdir().
     This avoids decomposed file names to be reported as untracked by "git status.

  2. Do all index filename comparisons under Mac OS X using a UTF-8 aware
     comparison function regardless if core.precomposeunicode is set.
     This would probably have bad performance, and somewhat
     defeats the point of converting the filenames at the
     readdir level in the first place.

(The TC is good)

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t3910-mac-os-precompose.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.sh
> index e4ba601..23aa61e 100755
> --- a/t/t3910-mac-os-precompose.sh
> +++ b/t/t3910-mac-os-precompose.sh
> @@ -140,6 +140,16 @@ test_expect_success "Add long precomposed filename" '
>  	git add * &&
>  	git commit -m "Long filename"
>  '
> +
> +test_expect_failure 'handle existing decomposed filenames' '
> +	echo content >"verbatim.$Adiarnfd" &&
> +	git -c core.precomposeunicode=false add "verbatim.$Adiarnfd" &&
> +	git commit -m "existing decomposed file" &&
> +	>expect &&
> +	git ls-files --exclude-standard -o "verbatim*" >untracked &&
> +	test_cmp expect untracked
> +'
> +
>  # Test if the global core.precomposeunicode stops autosensing
>  # Must be the last test case
>  test_expect_success "respect git config --global core.precomposeunicode" '
On top of the we need to following:

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 95fe849..5ed3d17 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -57,6 +57,19 @@ void probe_utf8_pathname_composition(char *path, int len)
 }
 
 
+char *precompose_str_len(const char *in, size_t insz, int *outsz)
+{
+    char *prec_str = NULL;
+    if (precomposed_unicode != 1)
+        return NULL;
+
+    if (has_non_ascii(in, insz, NULL))
+        prec_str = reencode_string_len(in, insz, repo_encoding, path_encoding, outsz);
+
+    return prec_str;
+}
+
+
 void precompose_argv(int argc, const char **argv)
 {
     int i = 0;
diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
index 3b73585..28f6595 100644
--- a/compat/precompose_utf8.h
+++ b/compat/precompose_utf8.h
@@ -26,6 +26,7 @@ typedef struct {
     struct dirent_prec_psx *dirent_nfc;
 } PREC_DIR;
 
+char *precompose_str_len(const char *in, size_t insz, int *outsz);
 void precompose_argv(int argc, const char **argv);
 void probe_utf8_pathname_composition(char *, int);
 
diff --git a/git-compat-util.h b/git-compat-util.h
index d493a8c..de117d1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -180,7 +180,7 @@ typedef unsigned long uintptr_t;
 #ifdef PRECOMPOSE_UNICODE
 #include "compat/precompose_utf8.h"
 #else
-#define precompose_str(in,i_nfd2nfc)
+#define precompose_str_len(s,i,o) NULL
 #define precompose_argv(c,v)
 #define probe_utf8_pathname_composition(a,b)
 #endif
diff --git a/read-cache.c b/read-cache.c
index 4b4effd..0887835 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1330,7 +1330,7 @@ static inline uint32_t ntoh_l_force_align(void *p)
 #define ntoh_l(var) ntoh_l_force_align(&(var))
 #endif
 
-static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *ondisk,
+static struct cache_entry *cache_entry_from_ondisk_int(struct ondisk_cache_entry *ondisk,
                            unsigned int flags,
                            const char *name,
                            size_t len)
@@ -1355,6 +1355,22 @@ static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *on
     return ce;
 }
 
+static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache_entry *ondisk,
+                             unsigned int flags,
+                             const char *name,
+                             size_t len)
+{
+    int prec_len;
+    char *prec_name = precompose_str_len(name, len, &prec_len);
+    if (prec_name) {
+        struct cache_entry *ce;
+        ce = cache_entry_from_ondisk_int(ondisk, flags, prec_name, prec_len);
+        free(prec_name);
+        return ce;
+    }
+    return cache_entry_from_ondisk_int(ondisk, flags, name, len);
+}
+
 /*
  * Adjacent cache entries tend to share the leading paths, so it makes
  * sense to only store the differences in later entries.  In the v4
diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.sh
index 23aa61e..2c3965b 100755
--- a/t/t3910-mac-os-precompose.sh
+++ b/t/t3910-mac-os-precompose.sh
@@ -141,13 +141,14 @@ test_expect_success "Add long precomposed filename" '
     git commit -m "Long filename"
 '
 
-test_expect_failure 'handle existing decomposed filenames' '
+test_expect_success 'handle existing decomposed filenames' '
     echo content >"verbatim.$Adiarnfd" &&
     git -c core.precomposeunicode=false add "verbatim.$Adiarnfd" &&
     git commit -m "existing decomposed file" &&
     >expect &&
     git ls-files --exclude-standard -o "verbatim*" >untracked &&
     test_cmp expect untracked
+    exit 0
 '
 
 # Test if the global core.precomposeunicode stops autosensing
