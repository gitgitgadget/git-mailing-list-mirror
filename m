From: "=?UTF-8?Q?Andr=C3=A9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: [PATCH] Fix segmentation fault when user doesn't have access permission to the repository.
Date: Wed, 21 Nov 2007 22:59:00 -0200
Message-ID: <b8bf37780711211659i4d621533o6a3b97349bb75f8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_25919_8761066.1195693140258"
Cc: "Git Mailing List" <git@vger.kernel.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 22 01:59:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv0Pc-0001il-6x
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 01:59:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbXKVA7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 19:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbXKVA7F
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 19:59:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:41230 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbXKVA7D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 19:59:03 -0500
Received: by ug-out-1314.google.com with SMTP id z38so227802ugc
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 16:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        bh=MsGwtqzkriQS3YuDHT03cWaallOECTM33xqT7Nl0Ltc=;
        b=JbvAEqRJ+GZMt+fbAqFlKQrPCbgHtIiQL44wistOT6OliasrpaOsH4JzSNqL5dn/HNwTDj9QxBOyvbKV3/QIngL/4QRWJaA4W4Or7WcM+8RMltH0whQFp95Og3Dk38kpgIYNbPC/1jLQHKj88iE6FqAi4mmloyLT0zPdN3vTrBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=NSFABoxKjsxZmqFYecjPTnIhSLg/eRyBiXhkbE9HvjHmif73UXZ0a6qFtL/C1SZMzLPQ71c8UiwylBcFHfshowc2u80e0YMAyhjlnL5H8PS7UIVso3FKdbmawpO7TWLTAP6h6UBeYi45ecPdiSzoEqBZqcLA7KGfVFOlb/bLfFk=
Received: by 10.78.177.3 with SMTP id z3mr9089433hue.1195693140266;
        Wed, 21 Nov 2007 16:59:00 -0800 (PST)
Received: by 10.78.120.18 with HTTP; Wed, 21 Nov 2007 16:59:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65723>

------=_Part_25919_8761066.1195693140258
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, all!

    Please cc: me as I'm not subscribed. I'm sending the patch inline
only for review, probably it is mangled.
    Please use the attached patch if you agree with it. Sorry about
sending it attached.

>From b2af9e783e7d8974b969c01f7a2de07b9cd5cf70 Mon Sep 17 00:00:00 2001
From: Andre Goddard Rosa <andre.goddard@gmail.com>
Date: Tue, 27 Nov 2007 10:14:57 -0200
Subject: [PATCH] Fix segmentation fault when user doesn't have access
permission to the repository.

When trying to "git-pull" with my personal user in a tree owned by root,
git was crashing with segmentation fault.

Signed-off-by: Andre Goddard Rosa <andre.goddard@gmail.com>
---
 builtin-fetch--tool.c |   12 ++++++++++--
 builtin-fetch.c       |   14 +++++++++++---
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index ed60847..7460ab7 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -511,10 +511,14 @@ int cmd_fetch__tool(int argc, const char **argv,
const char *prefix)
 	if (!strcmp("append-fetch-head", argv[1])) {
 		int result;
 		FILE *fp;
+		char *filename;

 		if (argc != 8)
 			return error("append-fetch-head takes 6 args");
-		fp = fopen(git_path("FETCH_HEAD"), "a");
+		filename = git_path("FETCH_HEAD");
+		fp = fopen(filename, "a");
+		if (!fp)
+			return error("cannot open %s: %s\n", filename, strerror(errno));
 		result = append_fetch_head(fp, argv[2], argv[3],
 					   argv[4], argv[5],
 					   argv[6], !!argv[7][0],
@@ -525,10 +529,14 @@ int cmd_fetch__tool(int argc, const char **argv,
const char *prefix)
 	if (!strcmp("native-store", argv[1])) {
 		int result;
 		FILE *fp;
+		char *filename;

 		if (argc != 5)
 			return error("fetch-native-store takes 3 args");
-		fp = fopen(git_path("FETCH_HEAD"), "a");
+		filename = git_path("FETCH_HEAD");
+		fp = fopen(filename, "a");
+		if (!fp)
+			return error("cannot open %s: %s\n", filename, strerror(errno));
 		result = fetch_native_store(fp, argv[2], argv[3], argv[4],
 					    verbose, force);
 		fclose(fp);
diff --git a/builtin-fetch.c b/builtin-fetch.c
index be9e3ea..5909d2f 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -263,8 +263,11 @@ static void store_updated_refs(const char *url,
struct ref *ref_map)
 	char note[1024];
 	const char *what, *kind;
 	struct ref *rm;
+	char *filename = git_path("FETCH_HEAD");

-	fp = fopen(git_path("FETCH_HEAD"), "a");
+	fp = fopen(filename, "a");
+	if (!fp)
+		return error("cannot open %s: %s\n", filename, strerror(errno));
 	for (rm = ref_map; rm; rm = rm->next) {
 		struct ref *ref = NULL;

@@ -487,8 +490,13 @@ static int do_fetch(struct transport *transport,
 		die("Don't know how to fetch from %s", transport->url);

 	/* if not appending, truncate FETCH_HEAD */
-	if (!append)
-		fclose(fopen(git_path("FETCH_HEAD"), "w"));
+	if (!append) {
+		char *filename = git_path("FETCH_HEAD");
+		int fd = fopen(filename, "w");
+		if (!fd)
+			return error("cannot open %s: %s\n", filename, strerror(errno));
+		fclose(fd);
+	}

 	ref_map = get_ref_map(transport, refs, ref_count, tags, &autotags);

-- 
1.5.3.6.861.gd794-dirty

------=_Part_25919_8761066.1195693140258
Content-Type: text/x-patch;
 name=0001-Fix-segmentation-fault-when-user-doesn-t-have-access.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f9ake2zp0
Content-Disposition: attachment;
 filename=0001-Fix-segmentation-fault-when-user-doesn-t-have-access.patch

RnJvbSBiMmFmOWU3ODNlN2Q4OTc0Yjk2OWMwMWY3YTJkZTA3YjljZDVjZjcwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZSBHb2RkYXJkIFJvc2EgPGFuZHJlLmdvZGRhcmRAZ21h
aWwuY29tPgpEYXRlOiBUdWUsIDI3IE5vdiAyMDA3IDEwOjE0OjU3IC0wMjAwClN1YmplY3Q6IFtQ
QVRDSF0gRml4IHNlZ21lbnRhdGlvbiBmYXVsdCB3aGVuIHVzZXIgZG9lc24ndCBoYXZlIGFjY2Vz
cyBwZXJtaXNzaW9uIHRvIHRoZSByZXBvc2l0b3J5LgoKV2hlbiB0cnlpbmcgdG8gImdpdC1wdWxs
IiB3aXRoIG15IHBlcnNvbmFsIHVzZXIgaW4gYSB0cmVlIG93bmVkIGJ5IHJvb3QsCmdpdCB3YXMg
Y3Jhc2hpbmcgd2l0aCBzZWdtZW50YXRpb24gZmF1bHQuCgpTaWduZWQtb2ZmLWJ5OiBBbmRyZSBH
b2RkYXJkIFJvc2EgPGFuZHJlLmdvZGRhcmRAZ21haWwuY29tPgotLS0KIGJ1aWx0aW4tZmV0Y2gt
LXRvb2wuYyB8ICAgMTIgKysrKysrKysrKy0tCiBidWlsdGluLWZldGNoLmMgICAgICAgfCAgIDE0
ICsrKysrKysrKysrLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDUgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYnVpbHRpbi1mZXRjaC0tdG9vbC5jIGIvYnVpbHRpbi1m
ZXRjaC0tdG9vbC5jCmluZGV4IGVkNjA4NDcuLjc0NjBhYjcgMTAwNjQ0Ci0tLSBhL2J1aWx0aW4t
ZmV0Y2gtLXRvb2wuYworKysgYi9idWlsdGluLWZldGNoLS10b29sLmMKQEAgLTUxMSwxMCArNTEx
LDE0IEBAIGludCBjbWRfZmV0Y2hfX3Rvb2woaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2LCBj
b25zdCBjaGFyICpwcmVmaXgpCiAJaWYgKCFzdHJjbXAoImFwcGVuZC1mZXRjaC1oZWFkIiwgYXJn
dlsxXSkpIHsKIAkJaW50IHJlc3VsdDsKIAkJRklMRSAqZnA7CisJCWNoYXIgKmZpbGVuYW1lOwog
CiAJCWlmIChhcmdjICE9IDgpCiAJCQlyZXR1cm4gZXJyb3IoImFwcGVuZC1mZXRjaC1oZWFkIHRh
a2VzIDYgYXJncyIpOwotCQlmcCA9IGZvcGVuKGdpdF9wYXRoKCJGRVRDSF9IRUFEIiksICJhIik7
CisJCWZpbGVuYW1lID0gZ2l0X3BhdGgoIkZFVENIX0hFQUQiKTsKKwkJZnAgPSBmb3BlbihmaWxl
bmFtZSwgImEiKTsKKwkJaWYgKCFmcCkKKwkJCXJldHVybiBlcnJvcigiY2Fubm90IG9wZW4gJXM6
ICVzXG4iLCBmaWxlbmFtZSwgc3RyZXJyb3IoZXJybm8pKTsKIAkJcmVzdWx0ID0gYXBwZW5kX2Zl
dGNoX2hlYWQoZnAsIGFyZ3ZbMl0sIGFyZ3ZbM10sCiAJCQkJCSAgIGFyZ3ZbNF0sIGFyZ3ZbNV0s
CiAJCQkJCSAgIGFyZ3ZbNl0sICEhYXJndls3XVswXSwKQEAgLTUyNSwxMCArNTI5LDE0IEBAIGlu
dCBjbWRfZmV0Y2hfX3Rvb2woaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2LCBjb25zdCBjaGFy
ICpwcmVmaXgpCiAJaWYgKCFzdHJjbXAoIm5hdGl2ZS1zdG9yZSIsIGFyZ3ZbMV0pKSB7CiAJCWlu
dCByZXN1bHQ7CiAJCUZJTEUgKmZwOworCQljaGFyICpmaWxlbmFtZTsKIAogCQlpZiAoYXJnYyAh
PSA1KQogCQkJcmV0dXJuIGVycm9yKCJmZXRjaC1uYXRpdmUtc3RvcmUgdGFrZXMgMyBhcmdzIik7
Ci0JCWZwID0gZm9wZW4oZ2l0X3BhdGgoIkZFVENIX0hFQUQiKSwgImEiKTsKKwkJZmlsZW5hbWUg
PSBnaXRfcGF0aCgiRkVUQ0hfSEVBRCIpOworCQlmcCA9IGZvcGVuKGZpbGVuYW1lLCAiYSIpOwor
CQlpZiAoIWZwKQorCQkJcmV0dXJuIGVycm9yKCJjYW5ub3Qgb3BlbiAlczogJXNcbiIsIGZpbGVu
YW1lLCBzdHJlcnJvcihlcnJubykpOwogCQlyZXN1bHQgPSBmZXRjaF9uYXRpdmVfc3RvcmUoZnAs
IGFyZ3ZbMl0sIGFyZ3ZbM10sIGFyZ3ZbNF0sCiAJCQkJCSAgICB2ZXJib3NlLCBmb3JjZSk7CiAJ
CWZjbG9zZShmcCk7CmRpZmYgLS1naXQgYS9idWlsdGluLWZldGNoLmMgYi9idWlsdGluLWZldGNo
LmMKaW5kZXggYmU5ZTNlYS4uNTkwOWQyZiAxMDA2NDQKLS0tIGEvYnVpbHRpbi1mZXRjaC5jCisr
KyBiL2J1aWx0aW4tZmV0Y2guYwpAQCAtMjYzLDggKzI2MywxMSBAQCBzdGF0aWMgdm9pZCBzdG9y
ZV91cGRhdGVkX3JlZnMoY29uc3QgY2hhciAqdXJsLCBzdHJ1Y3QgcmVmICpyZWZfbWFwKQogCWNo
YXIgbm90ZVsxMDI0XTsKIAljb25zdCBjaGFyICp3aGF0LCAqa2luZDsKIAlzdHJ1Y3QgcmVmICpy
bTsKKwljaGFyICpmaWxlbmFtZSA9IGdpdF9wYXRoKCJGRVRDSF9IRUFEIik7CiAKLQlmcCA9IGZv
cGVuKGdpdF9wYXRoKCJGRVRDSF9IRUFEIiksICJhIik7CisJZnAgPSBmb3BlbihmaWxlbmFtZSwg
ImEiKTsKKwlpZiAoIWZwKQorCQlyZXR1cm4gZXJyb3IoImNhbm5vdCBvcGVuICVzOiAlc1xuIiwg
ZmlsZW5hbWUsIHN0cmVycm9yKGVycm5vKSk7CiAJZm9yIChybSA9IHJlZl9tYXA7IHJtOyBybSA9
IHJtLT5uZXh0KSB7CiAJCXN0cnVjdCByZWYgKnJlZiA9IE5VTEw7CiAKQEAgLTQ4Nyw4ICs0OTAs
MTMgQEAgc3RhdGljIGludCBkb19mZXRjaChzdHJ1Y3QgdHJhbnNwb3J0ICp0cmFuc3BvcnQsCiAJ
CWRpZSgiRG9uJ3Qga25vdyBob3cgdG8gZmV0Y2ggZnJvbSAlcyIsIHRyYW5zcG9ydC0+dXJsKTsK
IAogCS8qIGlmIG5vdCBhcHBlbmRpbmcsIHRydW5jYXRlIEZFVENIX0hFQUQgKi8KLQlpZiAoIWFw
cGVuZCkKLQkJZmNsb3NlKGZvcGVuKGdpdF9wYXRoKCJGRVRDSF9IRUFEIiksICJ3IikpOworCWlm
ICghYXBwZW5kKSB7CisJCWNoYXIgKmZpbGVuYW1lID0gZ2l0X3BhdGgoIkZFVENIX0hFQUQiKTsK
KwkJaW50IGZkID0gZm9wZW4oZmlsZW5hbWUsICJ3Iik7CisJCWlmICghZmQpCisJCQlyZXR1cm4g
ZXJyb3IoImNhbm5vdCBvcGVuICVzOiAlc1xuIiwgZmlsZW5hbWUsIHN0cmVycm9yKGVycm5vKSk7
CisJCWZjbG9zZShmZCk7CisJfQogCiAJcmVmX21hcCA9IGdldF9yZWZfbWFwKHRyYW5zcG9ydCwg
cmVmcywgcmVmX2NvdW50LCB0YWdzLCAmYXV0b3RhZ3MpOwogCi0tIAoxLjUuMy42Ljg2MS5nZDc5
NC1kaXJ0eQoK
------=_Part_25919_8761066.1195693140258--
