From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH 1/2] add macro REALLOCARRAY
Date: Sun, 14 Sep 2014 18:55:56 +0200
Message-ID: <5415C89C.4090509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 14 18:57:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTD6g-0000x9-TB
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 18:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbaINQ4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 12:56:49 -0400
Received: from mout.web.de ([212.227.15.4]:64138 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658AbaINQ4s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 12:56:48 -0400
Received: from [192.168.178.27] ([79.253.153.35]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LzVMw-1YOnsU2kkc-014jjD; Sun, 14 Sep 2014 18:56:36
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
X-Provags-ID: V03:K0:YQpezvIMYO6a54qKjopo8jvjgDKexxDTGtEApvc/YCVLuwhm7cA
 pdT6YwGpt5dpOyH1OeuqU2j9BVsTYIf57qod6xUvvKy76XAQCYYR7HQV4leAkQV3j1YMnDA
 SZFRMSGoC20yB9oOIGpZ8dFADgA2677sW3GkcD1mIb83E3LI/W4T07ncZAlMN2Lc57K1yBF
 LXXsHxU5HOF1o0BwfjwUw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257019>

The macro ALLOC_GROW manages several aspects of dynamic memory
allocations for arrays: It performs overprovisioning in order to avoid
reallocations in future calls, updates the allocation size variable,
multiplies the item size and thus allows users to simply specify the
item count, performs the reallocation and updates the array pointer.

Sometimes this is too much.  Add the macro REALLOCARRAY, which only
takes care of the latter three points and allows users to specify the
number of items an array can store directly.  It can increase and
also decrease its size.  Using this macro avoids duplicating the
array pointer name and takes care of item sizes automatically.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 Documentation/technical/api-allocation-growing.txt | 3 +++
 git-compat-util.h                                  | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/technical/api-allocation-growing.txt b/Documentation/technical/api-allocation-growing.txt
index 542946b..4b5f049 100644
--- a/Documentation/technical/api-allocation-growing.txt
+++ b/Documentation/technical/api-allocation-growing.txt
@@ -34,3 +34,6 @@ item[nr++] = value you like;
 ------------
 
 You are responsible for updating the `nr` variable.
+
+If you need to specify the number of elements to allocate explicitly
+then use the macro `REALLOCARRAY(item, alloc)` instead of `ALLOC_GROW`.
diff --git a/git-compat-util.h b/git-compat-util.h
index 4e7e3f8..d926e4c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -626,6 +626,8 @@ extern int odb_mkstemp(char *template, size_t limit, const char *pattern);
 extern int odb_pack_keep(char *name, size_t namesz, const unsigned char *sha1);
 extern char *xgetcwd(void);
 
+#define REALLOCARRAY(x, alloc) x = xrealloc((x), (alloc) * sizeof(*(x)))
+
 static inline size_t xsize_t(off_t len)
 {
 	if (len > (size_t) len)
-- 
2.1.0
