From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH 1/2] add macro REALLOC_ARRAY
Date: Tue, 16 Sep 2014 20:56:48 +0200
Message-ID: <541887F0.1050007@web.de>
References: <5415C89C.4090509@web.de> <CAPc5daXuYVXG=b3Mjn=8oE71FqE_PRZ=XHXW_0F5uHawWwy4HQ@mail.gmail.com> <541886D5.8060202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 20:57:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTxvu-00087o-A7
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 20:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754842AbaIPS4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 14:56:55 -0400
Received: from mout.web.de ([212.227.17.11]:54493 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754612AbaIPS4y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 14:56:54 -0400
Received: from [192.168.178.27] ([79.253.189.35]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0Lopa3-1XxH0J17EZ-00gm3S; Tue, 16 Sep 2014 20:56:52
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <541886D5.8060202@web.de>
X-Provags-ID: V03:K0:i/TMMf9BqgjA+l4XJHvZYoeZxSjwCeG+szoJXg315SUVqdlFLRr
 00w9Hg/RBTon5dlNZTVXEIex3WHNDHf7W1HBefFDzcJnigWSyWYW6v/ZxcTYoIhzyzHSGSW
 haATFjgNV6UezenjjAwqetwttlp0kxxGERBIViLI5WsIAf+iwfs08zP+v/wuD44k6V6hnkX
 6urfl+cjynT68UPr8QuzA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257143>

The macro ALLOC_GROW manages several aspects of dynamic memory
allocations for arrays: It performs overprovisioning in order to avoid
reallocations in future calls, updates the allocation size variable,
multiplies the item size and thus allows users to simply specify the
item count, performs the reallocation and updates the array pointer.

Sometimes this is too much.  Add the macro REALLOC_ARRAY, which only
takes care of the latter three points and allows users to specfiy the
number of items the array can store.  It can increase and also decrease
the size.  Using the macro avoid duplicating the variable name and
takes care of the item sizes automatically.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 Documentation/technical/api-allocation-growing.txt | 3 +++
 git-compat-util.h                                  | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/technical/api-allocation-growing.txt b/Documentation/technical/api-allocation-growing.txt
index 542946b..5a59b54 100644
--- a/Documentation/technical/api-allocation-growing.txt
+++ b/Documentation/technical/api-allocation-growing.txt
@@ -34,3 +34,6 @@ item[nr++] = value you like;
 ------------
 
 You are responsible for updating the `nr` variable.
+
+If you need to specify the number of elements to allocate explicitly
+then use the macro `REALLOC_ARRAY(item, alloc)` instead of `ALLOC_GROW`.
diff --git a/git-compat-util.h b/git-compat-util.h
index 4e7e3f8..5a15b53 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -626,6 +626,8 @@ extern int odb_mkstemp(char *template, size_t limit, const char *pattern);
 extern int odb_pack_keep(char *name, size_t namesz, const unsigned char *sha1);
 extern char *xgetcwd(void);
 
+#define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), (alloc) * sizeof(*(x)))
+
 static inline size_t xsize_t(off_t len)
 {
 	if (len > (size_t) len)
-- 
2.1.0
