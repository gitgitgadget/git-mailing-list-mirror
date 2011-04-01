From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Try to remove the given path even if it can't be opened
Date: Fri, 1 Apr 2011 10:29:16 +0200
Message-ID: <AANLkTikfmXiZQquWi4STTCUy0qoY9J_waJ44nrPAvB1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6d9a16eca69d0049fd73526
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 01 10:29:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Zjx-0000xz-B3
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 10:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149Ab1DAI3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 04:29:39 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53911 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123Ab1DAI3h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 04:29:37 -0400
Received: by bwz15 with SMTP id 15so2345212bwz.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 01:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=H1RYeB7o3q5zydycyyCFCV9vuJwSX3kLOHMjqcZ05BM=;
        b=x9dBniT5WfYTVknAy/1XuZbIS75zBfr42vKGGfgzURaknLwubEL2iSuRSCQ6VsH7jx
         pJKbQ7ZwV2tEKjvHxnshDRwaayVSa341WTElwOfqhenoQcqJelR2hMQBu8Ey3jhRYuLL
         EXqqMkFUtJaQwnxqM/HoXV9iPYJP3CH5hNKUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=SrQWq7AJ5dsMoObgVBVrfp55wosV0yNG2f/2WUD5gWWDl88Ij8dQcdk5LD0f8RqIF/
         5rahLZ20ssCp/8yg0trDgQ6nCY1N6r2JwuoIL2pAimz1y3AfO8pZomoNAT9Tej3BDLi6
         v0270CISE5sWp9H7NijcFrGRlLvcHbn/CmpBM=
Received: by 10.204.84.166 with SMTP id j38mr3312447bkl.84.1301646576085; Fri,
 01 Apr 2011 01:29:36 -0700 (PDT)
Received: by 10.204.29.2 with HTTP; Fri, 1 Apr 2011 01:29:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170560>

--0016e6d9a16eca69d0049fd73526
Content-Type: text/plain; charset=UTF-8

Consider unreadable empty directories. rmdir(2) will remove
them just fine, assuming the parent directory is modifiable.

Noticed by Linus.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
On Fri, Apr 1, 2011 at 00:01, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Which is kind of understandable, but at the same time, if it's empty,
> a "rmdir()" will just work. So git gave up a bit too soon.
...
> Now, I realize that if the directory isn't empty, and is unreadable,
> we really should give up (although a better error message about _why_
> we failed may be in order) rather than try to chmod it or anything
> like that. But the simple "try to rmdir it" might be a good addition
> for the trivial case.

It is not tested, but looks trivial. The system I made it on is a Cygwin
machine, and a test from last master pull is still running (since two days).
And sorry, it is not based on master. Should apply without problems, though.

---
 dir.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/dir.c b/dir.c
index 325fb56..7251426 100644
--- a/dir.c
+++ b/dir.c
@@ -1191,8 +1191,11 @@ int remove_dir_recursively(struct strbuf *path, int flag)
 		return 0;

 	dir = opendir(path->buf);
-	if (!dir)
+	if (!dir) {
+		if (rmdir(path->buf) == 0)
+			return 0;
 		return -1;
+	}
 	if (path->buf[original_len - 1] != '/')
 		strbuf_addch(path, '/');

-- 
1.7.2.2.240.g7d094

--0016e6d9a16eca69d0049fd73526
Content-Type: application/octet-stream; 
	name="0001-Try-to-remove-the-given-path-even-if-it-can-t-be-open.diff"
Content-Disposition: attachment; 
	filename="0001-Try-to-remove-the-given-path-even-if-it-can-t-be-open.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_glyumqgg0

RnJvbSA4NjE4NzFlYmZlNzJiNjgzOTUyNmVhYTRmZThlNWM0YjZlZWM5MjRlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBGcmksIDEgQXByIDIwMTEgMDk6Mzc6MDcgKzAyMDAKU3ViamVjdDogW1BBVENIXSBUcnkgdG8g
cmVtb3ZlIHRoZSBnaXZlbiBwYXRoIGV2ZW4gaWYgaXQgY2FuJ3QgYmUgb3BlbmVkCgpDb25zaWRl
ciB1bnJlYWRhYmxlIGVtcHR5IGRpcmVjdG9yaWVzLiBybWRpcigyKSB3aWxsIHJlbW92ZQp0aGVt
IGp1c3QgZmluZSwgYXNzdW1pbmcgdGhlIHBhcmVudCBkaXJlY3RvcnkgaXMgbW9kaWZpYWJsZS4K
Ck5vdGljZWQgYnkgTGludXMuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxA
Z21haWwuY29tPgotLS0KIGRpci5jIHwgICAgNSArKysrLQogMSBmaWxlcyBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZGlyLmMgYi9kaXIuYwpp
bmRleCAzMjVmYjU2Li43MjUxNDI2IDEwMDY0NAotLS0gYS9kaXIuYworKysgYi9kaXIuYwpAQCAt
MTE5MSw4ICsxMTkxLDExIEBAIGludCByZW1vdmVfZGlyX3JlY3Vyc2l2ZWx5KHN0cnVjdCBzdHJi
dWYgKnBhdGgsIGludCBmbGFnKQogCQlyZXR1cm4gMDsKIAogCWRpciA9IG9wZW5kaXIocGF0aC0+
YnVmKTsKLQlpZiAoIWRpcikKKwlpZiAoIWRpcikgeworCQlpZiAocm1kaXIocGF0aC0+YnVmKSA9
PSAwKQorCQkJcmV0dXJuIDA7CiAJCXJldHVybiAtMTsKKwl9CiAJaWYgKHBhdGgtPmJ1Zltvcmln
aW5hbF9sZW4gLSAxXSAhPSAnLycpCiAJCXN0cmJ1Zl9hZGRjaChwYXRoLCAnLycpOwogCi0tIAox
LjcuMi4yLjI0MC5nN2QwOTQKCg==
--0016e6d9a16eca69d0049fd73526--
