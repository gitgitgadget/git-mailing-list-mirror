From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] t3910: show failure of core.precomposeunicode with decomposed
 filenames
Date: Wed, 30 Apr 2014 16:57:58 +0200
Message-ID: <53610F76.3050209@web.de>
References: <20140428161630.GA9435@sigill.intra.peff.net> <xmqqvbtskqjv.fsf@gitster.dls.corp.google.com> <20140429180210.GB11832@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 16:58:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfVy0-0000wa-7I
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 16:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759084AbaD3O6c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Apr 2014 10:58:32 -0400
Received: from mout.web.de ([212.227.15.4]:54834 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758698AbaD3O6b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 10:58:31 -0400
Received: from [192.168.209.20] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LtFAh-1Wr19j3cct-012pHj; Wed, 30 Apr 2014 16:58:05
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140429180210.GB11832@sigill.intra.peff.net>
X-Provags-ID: V03:K0:ofLX7u5odCmwQvYE93xHe2jObki5ObHOi89WNiGKTA8dmY5mESI
 kJrNY5Vxha3kmCMNTKyujPy9QrZ/koow9JjUwsjs17Yrf02PZqfvUTA+AMfM6nBA72yzk8k
 RuFkg+H7K+3ExH08TSGiyazfX7wPvnVqWLQ9dC4xx+SJDrOiSn635MoKmEcArKs1w7WQz+V
 5L64UHnZyRTX7jdSWF0+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247718>

On 29.04.14 20:02, Jeff King wrote:
> On Tue, Apr 29, 2014 at 10:12:52AM -0700, Junio C Hamano wrote:
>=20
>> Jeff King <peff@peff.net> writes:
>>
>>> This patch just adds a test to demonstrate the breakage.
>>> Some possible fixes are:
>>>
>>>   1. Tell everyone that NFD in the git repo is wrong, and
>>>      they should make a new commit to normalize all their
>>>      in-repo files to be precomposed.
>>>
>>>      This is probably not the right thing to do, because it
>>>      still doesn't fix checkouts of old history. And it
>>>      spreads the problem to people on byte-preserving
>>>      filesystems (like ext4), because now they have to start
>>>      precomposing their filenames as they are adde to git.
>>
>> Hmm, have we taught the "compare precomposed" for codepaths that
>> compare two trees and a tree and the index, too?  Otherwise, we
>> would have the same issue with commits in the old history.
>=20
> Ugh, yeah, I didn't think about that codepath. I think we would not w=
ant
> to precompose in that case. IOW, git works byte-wise internally, but =
it
> is only at the filesystem layer that we do such munging. The index
> straddles the line between the filesystem and git's internal
> representations.
>
[snip]
Please allow me to answer on this post-
I made a suggestion here:
https://github.com/tboegi/git/commit/85305ce306cb88a07dad6350d6ba8c5f2f=
817af6

The new test in t3910 passes, but the test suite hangs somewhere, there=
 is a whitespace
in precompose_utf8.c, so I don't know what to say.
But in case someone wants to make a code review:


commit 85305ce306cb88a07dad6350d6ba8c5f2f817af6
Author: Torsten B=C3=B6gershausen <tboegi@web.de>
Date:   Wed Apr 30 10:30:04 2014 +0200

    core.precomposeunicode with decomposed filenames
   =20
    Commit 750b2e4785e shows a failure of core.precomposeunicode
    when decomposed filenames are in the index.
   =20
    When decomposed file names are in the index and readdir()
    converts them into the decomposed form, "Git status" will report
    the precomposed file name as untracked.
   =20
    Solution:
    Precompose file names when reading the index file from disc into me=
mory.

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 95fe849..40ebc2e 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -57,6 +57,19 @@ void probe_utf8_pathname_composition(char *path, int=
 len)
 }
=20
=20
+char *precompose_str_len(const char *in, size_t insz, int *outsz)
+{
+	char *prec_str =3D NULL;
+	if (precomposed_unicode !=3D 1)
+		return NULL;
+
+	if (has_non_ascii(in, insz, NULL))
+		prec_str =3D reencode_string_len(in, insz, repo_encoding, path_encod=
ing, outsz);
+
+	return prec_str;
+}
+
+
 void precompose_argv(int argc, const char **argv)
 {
 	int i =3D 0;
diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
index 3b73585..28f6595 100644
--- a/compat/precompose_utf8.h
+++ b/compat/precompose_utf8.h
@@ -26,6 +26,7 @@ typedef struct {
 	struct dirent_prec_psx *dirent_nfc;
 } PREC_DIR;
=20
+char *precompose_str_len(const char *in, size_t insz, int *outsz);
 void precompose_argv(int argc, const char **argv);
 void probe_utf8_pathname_composition(char *, int);
=20
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
@@ -1330,7 +1330,7 @@ static inline uint32_t ntoh_l_force_align(void *p=
)
 #define ntoh_l(var) ntoh_l_force_align(&(var))
 #endif
=20
-static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache=
_entry *ondisk,
+static struct cache_entry *cache_entry_from_ondisk_int(struct ondisk_c=
ache_entry *ondisk,
 						   unsigned int flags,
 						   const char *name,
 						   size_t len)
@@ -1355,6 +1355,22 @@ static struct cache_entry *cache_entry_from_ondi=
sk(struct ondisk_cache_entry *on
 	return ce;
 }
=20
+static struct cache_entry *cache_entry_from_ondisk(struct ondisk_cache=
_entry *ondisk,
+							 unsigned int flags,
+							 const char *name,
+							 size_t len)
+{
+	int prec_len;
+	char *prec_name =3D precompose_str_len(name, len, &prec_len);
+	if (prec_name) {
+		struct cache_entry *ce;
+		ce =3D cache_entry_from_ondisk_int(ondisk, flags, prec_name, prec_le=
n);
+		free(prec_name);
+		return ce;
+	}
+	return cache_entry_from_ondisk_int(ondisk, flags, name, len);
+}
+
 /*
  * Adjacent cache entries tend to share the leading paths, so it makes
  * sense to only store the differences in later entries.  In the v4
diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.s=
h
index 23aa61e..d27c018 100755
--- a/t/t3910-mac-os-precompose.sh
+++ b/t/t3910-mac-os-precompose.sh
@@ -141,7 +141,7 @@ test_expect_success "Add long precomposed filename"=
 '
 	git commit -m "Long filename"
 '
=20
-test_expect_failure 'handle existing decomposed filenames' '
+test_expect_success 'handle existing decomposed filenames' '
 	echo content >"verbatim.$Adiarnfd" &&
 	git -c core.precomposeunicode=3Dfalse add "verbatim.$Adiarnfd" &&
 	git commit -m "existing decomposed file" &&
=20
