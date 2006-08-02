From: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 5/10] Add NO_C99_FORMAT to support older compilers.
Date: Wed, 2 Aug 2006 02:03:34 +0100
Message-ID: <00b201c6b5cf$7a59c8c0$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00B3_01C6B5D7.DC1E30C0"
X-From: git-owner@vger.kernel.org Wed Aug 02 03:03:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G858y-00071U-AT
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 03:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWHBBDS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 21:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWHBBDS
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 21:03:18 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:50697 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750904AbWHBBDR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 21:03:17 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-35.mail.demon.net with smtp (Exim 4.42)
	id 1G858j-000C1I-J8
	for git@vger.kernel.org; Wed, 02 Aug 2006 01:03:16 +0000
To: <git@vger.kernel.org>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24624>

This is a multi-part message in MIME format.

------=_NextPart_000_00B3_01C6B5D7.DC1E30C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

The NO_C99_FORMAT macro allows compilers that lack support for the
ll,hh,j,z,t size specifiers (eg. gcc 2.95.2) to adapt the code to avoid
runtime errors in the formatted IO functions.

Signed-off-by: Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
---
 Makefile |    8 ++++++++
 alloc.c  |   15 ++++++++++++++-
 mktag.c  |   18 +++++++++++++-----
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 180dbd0..2b72c79 100644
--- a/Makefile
+++ b/Makefile
@@ -24,6 +24,11 @@ #
 # Define NO_D_TYPE_IN_DIRENT if your platform defines DT_UNKNOWN but lacks
 # d_type in struct dirent (latest Cygwin -- will be fixed soonish).
 #
+# Define NO_C99_FORMAT if your formatted IO functions (printf/scanf et.al.)
+# do not support the 'size specifiers' introduced by C99, namely ll, hh,
+# j, z, t. (representing long long int, char, intmax_t, size_t, ptrdiff_t).
+# some c compilers supported these specifiers prior to C99 as an extension.
+#
 # Define NO_STRCASESTR if you don't have strcasestr.
 #
 # Define NO_STRLCPY if you don't have strlcpy.
@@ -406,6 +411,9 @@ endif
 ifdef NO_D_INO_IN_DIRENT
 	ALL_CFLAGS += -DNO_D_INO_IN_DIRENT
 endif
+ifdef NO_C99_FORMAT
+	ALL_CFLAGS += -DNO_C99_FORMAT
+endif
 ifdef NO_SYMLINK_HEAD
 	ALL_CFLAGS += -DNO_SYMLINK_HEAD
 endif
diff --git a/alloc.c b/alloc.c
index e3b22f4..460db19 100644
--- a/alloc.c
+++ b/alloc.c
@@ -39,8 +39,21 @@ DEFINE_ALLOCATOR(tree)
 DEFINE_ALLOCATOR(commit)
 DEFINE_ALLOCATOR(tag)

+#ifdef NO_C99_FORMAT
+#define SZ_FMT "%u"
+#else
+#define SZ_FMT "%zu"
+#endif
+
+static void report(const char* name, unsigned int count, size_t size)
+{
+    fprintf(stderr, "%10s: %8u (" SZ_FMT " kB)\n", name, count, size);
+}
+
+#undef SZ_FMT
+
 #define REPORT(name)	\
-	fprintf(stderr, "%10s: %8u (%zu kB)\n", #name, name##_allocs,
name##_allocs*sizeof(struct name) >> 10)
+    report(#name, name##_allocs, name##_allocs*sizeof(struct name) >> 10)

 void alloc_report(void)
 {
diff --git a/mktag.c b/mktag.c
index 9bae223..be41513 100644
--- a/mktag.c
+++ b/mktag.c
@@ -39,6 +39,12 @@ static int verify_object(unsigned char *
 	return ret;
 }

+#ifdef NO_C99_FORMAT
+#define PD_FMT "%d"
+#else
+#define PD_FMT "%td"
+#endif
+
 static int verify_tag(char *buffer, unsigned long size)
 {
 	int typelen;
@@ -67,15 +73,15 @@ static int verify_tag(char *buffer, unsi
 	/* Verify tag-line */
 	tag_line = strchr(type_line, '\n');
 	if (!tag_line)
-		return error("char%td: could not find next \"\\n\"", type_line - buffer);
+		return error("char" PD_FMT ": could not find next \"\\n\"", type_line -
buffer);
 	tag_line++;
 	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
-		return error("char%td: no \"tag \" found", tag_line - buffer);
+		return error("char" PD_FMT ": no \"tag \" found", tag_line - buffer);

 	/* Get the actual type */
 	typelen = tag_line - type_line - strlen("type \n");
 	if (typelen >= sizeof(type))
-		return error("char%td: type too long", type_line+5 - buffer);
+		return error("char" PD_FMT ": type too long", type_line+5 - buffer);

 	memcpy(type, type_line+5, typelen);
 	type[typelen] = 0;
@@ -92,14 +98,14 @@ static int verify_tag(char *buffer, unsi
 			break;
 		if (c > ' ')
 			continue;
-		return error("char%td: could not verify tag name", tag_line - buffer);
+		return error("char" PD_FMT ": could not verify tag name", tag_line -
buffer);
 	}

 	/* Verify the tagger line */
 	tagger_line = tag_line;

 	if (memcmp(tagger_line, "tagger", 6) || (tagger_line[6] == '\n'))
-		return error("char%td: could not find \"tagger\"", tagger_line - buffer);
+		return error("char" PD_FMT ": could not find \"tagger\"", tagger_line -
buffer);

 	/* TODO: check for committer info + blank line? */
 	/* Also, the minimum length is probably + "tagger .", or 63+8=71 */
@@ -108,6 +114,8 @@ static int verify_tag(char *buffer, unsi
 	return 0;
 }

+#undef PD_FMT
+
 int main(int argc, char **argv)
 {
 	unsigned long size = 4096;
--
1.4.1

------=_NextPart_000_00B3_01C6B5D7.DC1E30C0
Content-Type: text/plain;
	name="P0005.TXT"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="P0005.TXT"

RnJvbSBiMTQ1NmZmN2ZhMmIxYTAyZjNjZDcxZWY1OTZmMzBkZjlkNjM0ZDk5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYW1zYXkgQWxsYW4gSm9uZXMgPHJhbXNheUByYW1zYXkxLmRl
bW9uLmNvLnVrPgpEYXRlOiBTdW4sIDMwIEp1bCAyMDA2IDE2OjM4OjI4ICswMTAwClN1YmplY3Q6
IFtQQVRDSCA1LzEwXSBBZGQgTk9fQzk5X0ZPUk1BVCB0byBzdXBwb3J0IG9sZGVyIGNvbXBpbGVy
cy4KClRoZSBOT19DOTlfRk9STUFUIG1hY3JvIGFsbG93cyBjb21waWxlcnMgdGhhdCBsYWNrIHN1
cHBvcnQgZm9yIHRoZQpsbCxoaCxqLHosdCBzaXplIHNwZWNpZmllcnMgKGVnLiBnY2MgMi45NS4y
KSB0byBhZGFwdCB0aGUgY29kZSB0byBhdm9pZApydW50aW1lIGVycm9ycyBpbiB0aGUgZm9ybWF0
dGVkIElPIGZ1bmN0aW9ucy4KClNpZ25lZC1vZmYtYnk6IFJhbXNheSBBbGxhbiBKb25lcyA8cmFt
c2F5QHJhbXNheTEuZGVtb24uY28udWs+Ci0tLQogTWFrZWZpbGUgfCAgICA4ICsrKysrKysrCiBh
bGxvYy5jICB8ICAgMTUgKysrKysrKysrKysrKystCiBta3RhZy5jICB8ICAgMTggKysrKysrKysr
KysrKy0tLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvTWFrZWZpbGUgYi9NYWtlZmlsZQppbmRleCAxODBkYmQwLi4yYjcy
Yzc5IDEwMDY0NAotLS0gYS9NYWtlZmlsZQorKysgYi9NYWtlZmlsZQpAQCAtMjQsNiArMjQsMTEg
QEAgIwogIyBEZWZpbmUgTk9fRF9UWVBFX0lOX0RJUkVOVCBpZiB5b3VyIHBsYXRmb3JtIGRlZmlu
ZXMgRFRfVU5LTk9XTiBidXQgbGFja3MKICMgZF90eXBlIGluIHN0cnVjdCBkaXJlbnQgKGxhdGVz
dCBDeWd3aW4gLS0gd2lsbCBiZSBmaXhlZCBzb29uaXNoKS4KICMKKyMgRGVmaW5lIE5PX0M5OV9G
T1JNQVQgaWYgeW91ciBmb3JtYXR0ZWQgSU8gZnVuY3Rpb25zIChwcmludGYvc2NhbmYgZXQuYWwu
KQorIyBkbyBub3Qgc3VwcG9ydCB0aGUgJ3NpemUgc3BlY2lmaWVycycgaW50cm9kdWNlZCBieSBD
OTksIG5hbWVseSBsbCwgaGgsCisjIGosIHosIHQuIChyZXByZXNlbnRpbmcgbG9uZyBsb25nIGlu
dCwgY2hhciwgaW50bWF4X3QsIHNpemVfdCwgcHRyZGlmZl90KS4KKyMgc29tZSBjIGNvbXBpbGVy
cyBzdXBwb3J0ZWQgdGhlc2Ugc3BlY2lmaWVycyBwcmlvciB0byBDOTkgYXMgYW4gZXh0ZW5zaW9u
LgorIwogIyBEZWZpbmUgTk9fU1RSQ0FTRVNUUiBpZiB5b3UgZG9uJ3QgaGF2ZSBzdHJjYXNlc3Ry
LgogIwogIyBEZWZpbmUgTk9fU1RSTENQWSBpZiB5b3UgZG9uJ3QgaGF2ZSBzdHJsY3B5LgpAQCAt
NDA2LDYgKzQxMSw5IEBAIGVuZGlmCiBpZmRlZiBOT19EX0lOT19JTl9ESVJFTlQKIAlBTExfQ0ZM
QUdTICs9IC1ETk9fRF9JTk9fSU5fRElSRU5UCiBlbmRpZgoraWZkZWYgTk9fQzk5X0ZPUk1BVAor
CUFMTF9DRkxBR1MgKz0gLUROT19DOTlfRk9STUFUCitlbmRpZgogaWZkZWYgTk9fU1lNTElOS19I
RUFECiAJQUxMX0NGTEFHUyArPSAtRE5PX1NZTUxJTktfSEVBRAogZW5kaWYKZGlmZiAtLWdpdCBh
L2FsbG9jLmMgYi9hbGxvYy5jCmluZGV4IGUzYjIyZjQuLjQ2MGRiMTkgMTAwNjQ0Ci0tLSBhL2Fs
bG9jLmMKKysrIGIvYWxsb2MuYwpAQCAtMzksOCArMzksMjEgQEAgREVGSU5FX0FMTE9DQVRPUih0
cmVlKQogREVGSU5FX0FMTE9DQVRPUihjb21taXQpCiBERUZJTkVfQUxMT0NBVE9SKHRhZykKIAor
I2lmZGVmIE5PX0M5OV9GT1JNQVQKKyNkZWZpbmUgU1pfRk1UICIldSIKKyNlbHNlCisjZGVmaW5l
IFNaX0ZNVCAiJXp1IgorI2VuZGlmCisKK3N0YXRpYyB2b2lkIHJlcG9ydChjb25zdCBjaGFyKiBu
YW1lLCB1bnNpZ25lZCBpbnQgY291bnQsIHNpemVfdCBzaXplKQoreworICAgIGZwcmludGYoc3Rk
ZXJyLCAiJTEwczogJTh1ICgiIFNaX0ZNVCAiIGtCKVxuIiwgbmFtZSwgY291bnQsIHNpemUpOwor
fQorCisjdW5kZWYgU1pfRk1UCisKICNkZWZpbmUgUkVQT1JUKG5hbWUpCVwKLQlmcHJpbnRmKHN0
ZGVyciwgIiUxMHM6ICU4dSAoJXp1IGtCKVxuIiwgI25hbWUsIG5hbWUjI19hbGxvY3MsIG5hbWUj
I19hbGxvY3Mqc2l6ZW9mKHN0cnVjdCBuYW1lKSA+PiAxMCkKKyAgICByZXBvcnQoI25hbWUsIG5h
bWUjI19hbGxvY3MsIG5hbWUjI19hbGxvY3Mqc2l6ZW9mKHN0cnVjdCBuYW1lKSA+PiAxMCkKIAog
dm9pZCBhbGxvY19yZXBvcnQodm9pZCkKIHsKZGlmZiAtLWdpdCBhL21rdGFnLmMgYi9ta3RhZy5j
CmluZGV4IDliYWUyMjMuLmJlNDE1MTMgMTAwNjQ0Ci0tLSBhL21rdGFnLmMKKysrIGIvbWt0YWcu
YwpAQCAtMzksNiArMzksMTIgQEAgc3RhdGljIGludCB2ZXJpZnlfb2JqZWN0KHVuc2lnbmVkIGNo
YXIgKgogCXJldHVybiByZXQ7CiB9CiAKKyNpZmRlZiBOT19DOTlfRk9STUFUCisjZGVmaW5lIFBE
X0ZNVCAiJWQiCisjZWxzZQorI2RlZmluZSBQRF9GTVQgIiV0ZCIKKyNlbmRpZgorCiBzdGF0aWMg
aW50IHZlcmlmeV90YWcoY2hhciAqYnVmZmVyLCB1bnNpZ25lZCBsb25nIHNpemUpCiB7CiAJaW50
IHR5cGVsZW47CkBAIC02NywxNSArNzMsMTUgQEAgc3RhdGljIGludCB2ZXJpZnlfdGFnKGNoYXIg
KmJ1ZmZlciwgdW5zaQogCS8qIFZlcmlmeSB0YWctbGluZSAqLwogCXRhZ19saW5lID0gc3RyY2hy
KHR5cGVfbGluZSwgJ1xuJyk7CiAJaWYgKCF0YWdfbGluZSkKLQkJcmV0dXJuIGVycm9yKCJjaGFy
JXRkOiBjb3VsZCBub3QgZmluZCBuZXh0IFwiXFxuXCIiLCB0eXBlX2xpbmUgLSBidWZmZXIpOwor
CQlyZXR1cm4gZXJyb3IoImNoYXIiIFBEX0ZNVCAiOiBjb3VsZCBub3QgZmluZCBuZXh0IFwiXFxu
XCIiLCB0eXBlX2xpbmUgLSBidWZmZXIpOwogCXRhZ19saW5lKys7CiAJaWYgKG1lbWNtcCh0YWdf
bGluZSwgInRhZyAiLCA0KSB8fCB0YWdfbGluZVs0XSA9PSAnXG4nKQotCQlyZXR1cm4gZXJyb3Io
ImNoYXIldGQ6IG5vIFwidGFnIFwiIGZvdW5kIiwgdGFnX2xpbmUgLSBidWZmZXIpOworCQlyZXR1
cm4gZXJyb3IoImNoYXIiIFBEX0ZNVCAiOiBubyBcInRhZyBcIiBmb3VuZCIsIHRhZ19saW5lIC0g
YnVmZmVyKTsKIAogCS8qIEdldCB0aGUgYWN0dWFsIHR5cGUgKi8KIAl0eXBlbGVuID0gdGFnX2xp
bmUgLSB0eXBlX2xpbmUgLSBzdHJsZW4oInR5cGUgXG4iKTsKIAlpZiAodHlwZWxlbiA+PSBzaXpl
b2YodHlwZSkpCi0JCXJldHVybiBlcnJvcigiY2hhciV0ZDogdHlwZSB0b28gbG9uZyIsIHR5cGVf
bGluZSs1IC0gYnVmZmVyKTsKKwkJcmV0dXJuIGVycm9yKCJjaGFyIiBQRF9GTVQgIjogdHlwZSB0
b28gbG9uZyIsIHR5cGVfbGluZSs1IC0gYnVmZmVyKTsKIAogCW1lbWNweSh0eXBlLCB0eXBlX2xp
bmUrNSwgdHlwZWxlbik7CiAJdHlwZVt0eXBlbGVuXSA9IDA7CkBAIC05MiwxNCArOTgsMTQgQEAg
c3RhdGljIGludCB2ZXJpZnlfdGFnKGNoYXIgKmJ1ZmZlciwgdW5zaQogCQkJYnJlYWs7CiAJCWlm
IChjID4gJyAnKQogCQkJY29udGludWU7Ci0JCXJldHVybiBlcnJvcigiY2hhciV0ZDogY291bGQg
bm90IHZlcmlmeSB0YWcgbmFtZSIsIHRhZ19saW5lIC0gYnVmZmVyKTsKKwkJcmV0dXJuIGVycm9y
KCJjaGFyIiBQRF9GTVQgIjogY291bGQgbm90IHZlcmlmeSB0YWcgbmFtZSIsIHRhZ19saW5lIC0g
YnVmZmVyKTsKIAl9CiAKIAkvKiBWZXJpZnkgdGhlIHRhZ2dlciBsaW5lICovCiAJdGFnZ2VyX2xp
bmUgPSB0YWdfbGluZTsKIAogCWlmIChtZW1jbXAodGFnZ2VyX2xpbmUsICJ0YWdnZXIiLCA2KSB8
fCAodGFnZ2VyX2xpbmVbNl0gPT0gJ1xuJykpCi0JCXJldHVybiBlcnJvcigiY2hhciV0ZDogY291
bGQgbm90IGZpbmQgXCJ0YWdnZXJcIiIsIHRhZ2dlcl9saW5lIC0gYnVmZmVyKTsKKwkJcmV0dXJu
IGVycm9yKCJjaGFyIiBQRF9GTVQgIjogY291bGQgbm90IGZpbmQgXCJ0YWdnZXJcIiIsIHRhZ2dl
cl9saW5lIC0gYnVmZmVyKTsKIAogCS8qIFRPRE86IGNoZWNrIGZvciBjb21taXR0ZXIgaW5mbyAr
IGJsYW5rIGxpbmU/ICovCiAJLyogQWxzbywgdGhlIG1pbmltdW0gbGVuZ3RoIGlzIHByb2JhYmx5
ICsgInRhZ2dlciAuIiwgb3IgNjMrOD03MSAqLwpAQCAtMTA4LDYgKzExNCw4IEBAIHN0YXRpYyBp
bnQgdmVyaWZ5X3RhZyhjaGFyICpidWZmZXIsIHVuc2kKIAlyZXR1cm4gMDsKIH0KIAorI3VuZGVm
IFBEX0ZNVAorCiBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiB7CiAJdW5zaWduZWQg
bG9uZyBzaXplID0gNDA5NjsKLS0gCjEuNC4xCgo=

------=_NextPart_000_00B3_01C6B5D7.DC1E30C0--
