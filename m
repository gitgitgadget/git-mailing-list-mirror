From: Yurii Shevtsov <ungetch@gmail.com>
Subject: [PATCH V2/RFC][GSoC] diff-no-index: transform "$directory $file" args
 to "$directory/$file $file"
Date: Thu, 26 Mar 2015 22:54:40 +0200
Message-ID: <CAHLaBN+nE9tmGMdJM65V-bONKe8CE9PZ1Ottc1R9D=Pm0X7k_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e01537a1e8499c60512373905
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 21:55:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbEne-0000UW-Ow
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 21:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002AbbCZUyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 16:54:43 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34648 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbbCZUyl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 16:54:41 -0400
Received: by obbgg8 with SMTP id gg8so56337531obb.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2015 13:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=KjZnFPJLk8A5gzCQG97SBS5DArVrS9CWeqv7LxruDmg=;
        b=vLy7DP8sQTR/91cbC7177nqjwNl0ShtmIn8qHD3Cv/Tky9kUsqTrCi8ZkAGvSELkk0
         G+w0MTgR/qxEHeeHCQ1NF0KYFBJZxZ4qOAmHb5Ldzj7qZJ+Tb9j9nCMC026QRIDckMYh
         hDxSBFT85FttgOXewPALeUHm4Z6li9p4cqPdhYcqBWAkjT8re+9l17ZqvsrdqgPryFmw
         564Z1+OAXkBb08bvq8XcTBpenIYbAYaPhYQEnmtAhDBmVREQvkzV8ECyV9xyRRTLu4r9
         eVvIHJgMTrnZiYQ986qBTs5qt/zFrFLmJKftmPz6vkiPZWUvfCEAezncOU+S15bZ1Ypt
         wA2Q==
X-Received: by 10.182.55.68 with SMTP id q4mr1145785obp.33.1427403280984; Thu,
 26 Mar 2015 13:54:40 -0700 (PDT)
Received: by 10.76.10.170 with HTTP; Thu, 26 Mar 2015 13:54:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266347>

--089e01537a1e8499c60512373905
Content-Type: text/plain; charset=UTF-8

git diff --no-index refuses to compare if args are directory and file,
instead of usual diff.

Now git diff --no-index modifies args, if they're directory and file,
and diffs files, as usual diff does.

Changes are done in diff_no_index().

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Yurii Shevtsov <ungetch@gmail.com>
---
 diff-no-index.c |   31 +++++++++++++++++++++++++++++--
 1 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 265709b..ecff15e 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -186,7 +186,7 @@ void diff_no_index(struct rev_info *revs,
            int argc, const char **argv,
            const char *prefix)
 {
-    int i, prefixlen;
+    int i, prefixlen, mode1 = 0, mode2 = 0;
     const char *paths[2];

     diff_setup(&revs->diffopt);
@@ -229,8 +229,35 @@ void diff_no_index(struct rev_info *revs,
     setup_diff_pager(&revs->diffopt);
     DIFF_OPT_SET(&revs->diffopt, EXIT_WITH_STATUS);

-    if (queue_diff(&revs->diffopt, paths[0], paths[1]))
+    if (get_mode(paths[0], &mode1) || get_mode(paths[1], &mode2))
+        exit(2);
+
+    if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2)) {
+        struct strbuf pathtofile;
+        const char *dir, *file;
+        char *filename;
+        int ret;
+
+        dir = S_ISDIR(mode1) ? paths[0] : paths[1];
+        file = (dir == paths[0]) ? paths[1] : paths[0];
+        strbuf_init(&pathtofile, strlen(paths[0]) + strlen(paths[1]) + 1);
+        strbuf_addstr(&pathtofile, dir);
+        if (pathtofile.len && pathtofile.buf[pathtofile.len - 1] != '/')
+               strbuf_addch(&pathtofile, '/');
+        filename = strrchr(file, '/');
+        strbuf_addstr(&pathtofile, filename ? (filename + 1) : file);
+
+        if (file == paths[0])
+            ret = queue_diff(&revs->diffopt, file, pathtofile.buf);
+        else
+            ret = queue_diff(&revs->diffopt, pathtofile.buf, file);
+        strbuf_release(&pathtofile);
+        if (ret)
+            exit(1);
+    }
+    else if (queue_diff(&revs->diffopt, paths[0], paths[1]))
         exit(1);
+
     diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
     diffcore_std(&revs->diffopt);
     diff_flush(&revs->diffopt);
-- 

Attached patch file because gmail always replaces tabs with spaces and
refuses to authorize 'git send-email'

--089e01537a1e8499c60512373905
Content-Type: application/octet-stream; 
	name="0001-git-diff-no-index-refuses-to-compare-if-args-are-dir.patch"
Content-Disposition: attachment; 
	filename="0001-git-diff-no-index-refuses-to-compare-if-args-are-dir.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i7qmzj770

RnJvbSAwZTE2MGI0Nzk2MGRkNDM2YjMyZTU1MjI5MTg0Njg4YzBhOWRhMDY5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdXJpaSBTaGV2dHNvdiA8dW5nZXRjaEBnbWFpbC5jb20+CkRh
dGU6IFRodSwgMjUgTWFyIDIwMTUgMTg6NDM6MjQgKzAyMDAKU3ViamVjdDogW1BBVENIXSAgZGlm
Zi1uby1pbmRleDogdHJhbnNmb3JtICIkZGlyZWN0b3J5ICRmaWxlIiBhcmdzIHRvICIkZGlyZWN0
b3J5LyRmaWxlICRmaWxlIgpnaXQgZGlmZiAtLW5vLWluZGV4IHJlZnVzZXMgdG8gY29tcGFyZSBp
ZiBhcmdzIGFyZSBkaXJlY3RvcnkgYW5kIGZpbGUsIGluc3RlYWQgb2YgdXN1YWwgZGlmZi4KCk5v
dyBnaXQgZGlmZiAtLW5vLWluZGV4IG1vZGlmaWVzIGFyZ3MsIGlmIHRoZXkncmUgZGlyZWN0b3J5
IGFuZCBmaWxlLCBhbmQKZGlmZnMgZmlsZXMsIGFzIHVzdWFsIGRpZmYgZG9lcy4KCkNoYW5nZXMg
YXJlIGRvbmUgaW4gZGlmZl9ub19pbmRleCgpLgoKSGVscGVkLWJ5OiBKdW5pbyBDIEhhbWFubyA8
Z2l0c3RlckBwb2JveC5jb20+ClNpZ25lZC1vZmYtYnk6IFl1cmlpIFNoZXZ0c292IDx1bmdldGNo
QGdtYWlsLmNvbT4KLS0tCiBkaWZmLW5vLWluZGV4LmMgfCAgIDMxICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0KIDEgZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kaWZmLW5vLWluZGV4LmMgYi9kaWZmLW5vLWluZGV4LmMK
aW5kZXggMjY1NzA5Yi4uZWNmZjE1ZSAxMDA2NDQKLS0tIGEvZGlmZi1uby1pbmRleC5jCisrKyBi
L2RpZmYtbm8taW5kZXguYwpAQCAtMTg2LDcgKzE4Niw3IEBAIHZvaWQgZGlmZl9ub19pbmRleChz
dHJ1Y3QgcmV2X2luZm8gKnJldnMsCiAJCSAgIGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndiwK
IAkJICAgY29uc3QgY2hhciAqcHJlZml4KQogewotCWludCBpLCBwcmVmaXhsZW47CisJaW50IGks
IHByZWZpeGxlbiwgbW9kZTEgPSAwLCBtb2RlMiA9IDA7CiAJY29uc3QgY2hhciAqcGF0aHNbMl07
CiAKIAlkaWZmX3NldHVwKCZyZXZzLT5kaWZmb3B0KTsKQEAgLTIyOSw4ICsyMjksMzUgQEAgdm9p
ZCBkaWZmX25vX2luZGV4KHN0cnVjdCByZXZfaW5mbyAqcmV2cywKIAlzZXR1cF9kaWZmX3BhZ2Vy
KCZyZXZzLT5kaWZmb3B0KTsKIAlESUZGX09QVF9TRVQoJnJldnMtPmRpZmZvcHQsIEVYSVRfV0lU
SF9TVEFUVVMpOwogCi0JaWYgKHF1ZXVlX2RpZmYoJnJldnMtPmRpZmZvcHQsIHBhdGhzWzBdLCBw
YXRoc1sxXSkpCisJaWYgKGdldF9tb2RlKHBhdGhzWzBdLCAmbW9kZTEpIHx8IGdldF9tb2RlKHBh
dGhzWzFdLCAmbW9kZTIpKQorCQlleGl0KDIpOworCisJaWYgKG1vZGUxICYmIG1vZGUyICYmIFNf
SVNESVIobW9kZTEpICE9IFNfSVNESVIobW9kZTIpKSB7CisJCXN0cnVjdCBzdHJidWYgcGF0aHRv
ZmlsZTsKKwkJY29uc3QgY2hhciAqZGlyLCAqZmlsZTsKKwkJY2hhciAqZmlsZW5hbWU7CisJCWlu
dCByZXQ7CisKKwkJZGlyID0gU19JU0RJUihtb2RlMSkgPyBwYXRoc1swXSA6IHBhdGhzWzFdOwor
CQlmaWxlID0gKGRpciA9PSBwYXRoc1swXSkgPyBwYXRoc1sxXSA6IHBhdGhzWzBdOworCQlzdHJi
dWZfaW5pdCgmcGF0aHRvZmlsZSwgc3RybGVuKHBhdGhzWzBdKSArIHN0cmxlbihwYXRoc1sxXSkg
KyAxKTsKKwkJc3RyYnVmX2FkZHN0cigmcGF0aHRvZmlsZSwgZGlyKTsKKwkJaWYgKHBhdGh0b2Zp
bGUubGVuICYmIHBhdGh0b2ZpbGUuYnVmW3BhdGh0b2ZpbGUubGVuIC0gMV0gIT0gJy8nKQorCQkJ
ICAgc3RyYnVmX2FkZGNoKCZwYXRodG9maWxlLCAnLycpOworCQlmaWxlbmFtZSA9IHN0cnJjaHIo
ZmlsZSwgJy8nKTsKKwkJc3RyYnVmX2FkZHN0cigmcGF0aHRvZmlsZSwgZmlsZW5hbWUgPyAoZmls
ZW5hbWUgKyAxKSA6IGZpbGUpOworCisJCWlmIChmaWxlID09IHBhdGhzWzBdKQorCQkJcmV0ID0g
cXVldWVfZGlmZigmcmV2cy0+ZGlmZm9wdCwgZmlsZSwgcGF0aHRvZmlsZS5idWYpOworCQllbHNl
CisJCQlyZXQgPSBxdWV1ZV9kaWZmKCZyZXZzLT5kaWZmb3B0LCBwYXRodG9maWxlLmJ1ZiwgZmls
ZSk7CisJCXN0cmJ1Zl9yZWxlYXNlKCZwYXRodG9maWxlKTsKKwkJaWYgKHJldCkKKwkJCWV4aXQo
MSk7CisJfQorCWVsc2UgaWYgKHF1ZXVlX2RpZmYoJnJldnMtPmRpZmZvcHQsIHBhdGhzWzBdLCBw
YXRoc1sxXSkpCiAJCWV4aXQoMSk7CisKIAlkaWZmX3NldF9tbmVtb25pY19wcmVmaXgoJnJldnMt
PmRpZmZvcHQsICIxLyIsICIyLyIpOwogCWRpZmZjb3JlX3N0ZCgmcmV2cy0+ZGlmZm9wdCk7CiAJ
ZGlmZl9mbHVzaCgmcmV2cy0+ZGlmZm9wdCk7Ci0tIAoxLjcuMQoK
--089e01537a1e8499c60512373905--
