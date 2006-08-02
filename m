From: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 4/10] New tests and en-passant modifications to mktag.
Date: Wed, 2 Aug 2006 02:03:22 +0100
Message-ID: <00ae01c6b5cf$737a7220$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00AF_01C6B5D7.D53EDA20"
X-From: git-owner@vger.kernel.org Wed Aug 02 03:03:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G858o-0006zO-8g
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 03:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWHBBDO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 21:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWHBBDO
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 21:03:14 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:45577 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750901AbWHBBDN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 21:03:13 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-35.mail.demon.net with smtp (Exim 4.42)
	id 1G858a-000C1I-If
	for git@vger.kernel.org; Wed, 02 Aug 2006 01:03:11 +0000
To: <git@vger.kernel.org>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24623>

This is a multi-part message in MIME format.

------=_NextPart_000_00AF_01C6B5D7.D53EDA20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

These changes were originally part of the next patch, but have been
split out since they were peripheral to the main purpose of that patch.

  - update comment describing the signature format to reflect
    the current code.
  - remove trailing \n in calls to error(), since a \n is already
    provided by error().
  - remove redundant call to get_sha1_hex().
  - call sha1_to_hex(sha1) to convert to ascii, rather than attempting
    to print the raw sha1.

The new tests provide a regression suite to support the modifications
to git-mktag in this and the next patch.

Signed-off-by: Ramsay Allan Jones <ramsay@ramsay1.demon.co.uk>
---
 mktag.c          |   35 ++++----
 t/t3800-mktag.sh |  227
++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 245 insertions(+), 17 deletions(-)

diff --git a/mktag.c b/mktag.c
index f0fe528..9bae223 100644
--- a/mktag.c
+++ b/mktag.c
@@ -2,10 +2,11 @@ #include "cache.h"
 #include "tag.h"

 /*
- * A signature file has a very simple fixed format: three lines
- * of "object <sha1>" + "type <typename>" + "tag <tagname>",
- * followed by some free-form signature that git itself doesn't
- * care about, but that can be verified with gpg or similar.
+ * A signature file has a very simple fixed format: four lines
+ * of "object <sha1>" + "type <typename>" + "tag <tagname>" +
+ * "tagger <committer>", followed by a blank line, a free-form tag
+ * message and a signature block that git itself doesn't care about,
+ * but that can be verified with gpg or similar.
  *
  * The first three lines are guaranteed to be at least 63 bytes:
  * "object <sha1>\n" is 48 bytes, "type tag\n" at 9 bytes is the
@@ -46,45 +47,42 @@ static int verify_tag(char *buffer, unsi
 	const char *object, *type_line, *tag_line, *tagger_line;

 	if (size < 64)
-		return error("wanna fool me ? you obviously got the size wrong !\n");
+		return error("wanna fool me ? you obviously got the size wrong !");

 	buffer[size] = 0;

 	/* Verify object line */
 	object = buffer;
 	if (memcmp(object, "object ", 7))
-		return error("char%d: does not start with \"object \"\n", 0);
+		return error("char%d: does not start with \"object \"", 0);

 	if (get_sha1_hex(object + 7, sha1))
-		return error("char%d: could not get SHA1 hash\n", 7);
+		return error("char%d: could not get SHA1 hash", 7);

 	/* Verify type line */
 	type_line = object + 48;
 	if (memcmp(type_line - 1, "\ntype ", 6))
-		return error("char%d: could not find \"\\ntype \"\n", 47);
+		return error("char%d: could not find \"\\ntype \"", 47);

 	/* Verify tag-line */
 	tag_line = strchr(type_line, '\n');
 	if (!tag_line)
-		return error("char%td: could not find next \"\\n\"\n", type_line -
buffer);
+		return error("char%td: could not find next \"\\n\"", type_line - buffer);
 	tag_line++;
 	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
-		return error("char%td: no \"tag \" found\n", tag_line - buffer);
+		return error("char%td: no \"tag \" found", tag_line - buffer);

 	/* Get the actual type */
 	typelen = tag_line - type_line - strlen("type \n");
 	if (typelen >= sizeof(type))
-		return error("char%td: type too long\n", type_line+5 - buffer);
+		return error("char%td: type too long", type_line+5 - buffer);

 	memcpy(type, type_line+5, typelen);
 	type[typelen] = 0;

 	/* Verify that the object matches */
-	if (get_sha1_hex(object + 7, sha1))
-		return error("char%d: could not get SHA1 hash but this is really odd
since i got it before !\n", 7);
-
 	if (verify_object(sha1, type))
-		return error("char%d: could not verify object %s\n", 7, sha1);
+		return error("char%d: could not verify object %s", 7, sha1_to_hex(sha1));

 	/* Verify the tag-name: we don't allow control characters or spaces in it
*/
 	tag_line += 4;
@@ -94,14 +92,17 @@ static int verify_tag(char *buffer, unsi
 			break;
 		if (c > ' ')
 			continue;
-		return error("char%td: could not verify tag name\n", tag_line - buffer);
+		return error("char%td: could not verify tag name", tag_line - buffer);
 	}

 	/* Verify the tagger line */
 	tagger_line = tag_line;

 	if (memcmp(tagger_line, "tagger", 6) || (tagger_line[6] == '\n'))
-		return error("char%td: could not find \"tagger\"\n", tagger_line -
buffer);
+		return error("char%td: could not find \"tagger\"", tagger_line - buffer);
+
+	/* TODO: check for committer info + blank line? */
+	/* Also, the minimum length is probably + "tagger .", or 63+8=71 */

 	/* The actual stuff afterwards we don't care about.. */
 	return 0;
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
new file mode 100755
index 0000000..b833e19
--- /dev/null
+++ b/t/t3800-mktag.sh
@@ -0,0 +1,227 @@
+#!/bin/sh
+#
+#
+
+test_description='git-mktag: tag object verify test'
+
+. ./test-lib.sh
+
+###########################################################
+# check the tag.sig file, expecting verify_tag() to fail,
+# and checking that the error message matches the pattern
+# given in the expect.pat file.
+
+check_verify_failure () {
+    test_expect_success \
+        "$1" \
+        'git-mktag <tag.sig 2>message ||
+         egrep -q -f expect.pat message'
+}
+
+###########################################################
+# first create a commit, so we have a valid object/type
+# for the tag.
+echo Hello >A
+git-update-index --add A
+git-commit -m "Initial commit"
+head=$(git-rev-parse --verify HEAD)
+
+############################################################
+#  1. length check
+
+cat >tag.sig <<EOF
+too short for a tag
+EOF
+
+cat >expect.pat <<EOF
+^error: .*size wrong.*$
+EOF
+
+check_verify_failure 'Tag object length check'
+
+############################################################
+#  2. object line label check
+
+cat >tag.sig <<EOF
+xxxxxx 139e9b33986b1c2670fff52c5067603117b3e895
+type tag
+tag mytag
+EOF
+
+cat >expect.pat <<EOF
+^error: char0: .*"object "$
+EOF
+
+check_verify_failure '"object" line label check'
+
+############################################################
+#  3. object line SHA1 check
+
+cat >tag.sig <<EOF
+object zz9e9b33986b1c2670fff52c5067603117b3e895
+type tag
+tag mytag
+EOF
+
+cat >expect.pat <<EOF
+^error: char7: .*SHA1 hash$
+EOF
+
+check_verify_failure '"object" line SHA1 check'
+
+############################################################
+#  4. type line label check
+
+cat >tag.sig <<EOF
+object 779e9b33986b1c2670fff52c5067603117b3e895
+xxxx tag
+tag mytag
+EOF
+
+cat >expect.pat <<EOF
+^error: char47: .*"[\]ntype "$
+EOF
+
+check_verify_failure '"type" line label check'
+
+############################################################
+#  5. type line eol check
+
+echo "object 779e9b33986b1c2670fff52c5067603117b3e895" >tag.sig
+echo -n "type tagsssssssssssssssssssssssssssssss" >>tag.sig
+
+cat >expect.pat <<EOF
+^error: char48: .*"[\]n"$
+EOF
+
+check_verify_failure '"type" line eol check'
+
+############################################################
+#  6. tag line label check #1
+
+cat >tag.sig <<EOF
+object 779e9b33986b1c2670fff52c5067603117b3e895
+type tag
+xxx mytag
+EOF
+
+cat >expect.pat <<EOF
+^error: char57: no "tag " found$
+EOF
+
+check_verify_failure '"tag" line label check #1'
+
+############################################################
+#  7. tag line label check #2
+
+cat >tag.sig <<EOF
+object 779e9b33986b1c2670fff52c5067603117b3e895
+type taggggggggggggggggggggggggggggggg
+tag
+EOF
+
+cat >expect.pat <<EOF
+^error: char87: no "tag " found$
+EOF
+
+check_verify_failure '"tag" line label check #2'
+
+############################################################
+#  8. type line type-name length check
+
+cat >tag.sig <<EOF
+object 779e9b33986b1c2670fff52c5067603117b3e895
+type taggggggggggggggggggggggggggggggg
+tag mytag
+EOF
+
+cat >expect.pat <<EOF
+^error: char53: type too long$
+EOF
+
+check_verify_failure '"type" line type-name length check'
+
+############################################################
+#  9. verify object (SHA1/type) check
+
+cat >tag.sig <<EOF
+object 779e9b33986b1c2670fff52c5067603117b3e895
+type tagggg
+tag mytag
+EOF
+
+cat >expect.pat <<EOF
+^error: char7: could not verify object.*$
+EOF
+
+check_verify_failure 'verify object (SHA1/type) check'
+
+############################################################
+# 10. verify tag-name check
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag my	tag
+EOF
+
+cat >expect.pat <<EOF
+^error: char67: could not verify tag name$
+EOF
+
+check_verify_failure 'verify tag-name check'
+
+############################################################
+# 11. tagger line lable check #1
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+EOF
+
+cat >expect.pat <<EOF
+^error: char70: could not find "tagger"$
+EOF
+
+check_verify_failure '"tagger" line label check #1'
+
+############################################################
+# 12. tagger line lable check #2
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+tagger
+EOF
+
+cat >expect.pat <<EOF
+^error: char70: could not find "tagger"$
+EOF
+
+check_verify_failure '"tagger" line label check #2'
+
+############################################################
+# 13. create valid tag
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+tagger another@example.com
+EOF
+
+test_expect_success \
+    'create valid tag' \
+    'git-mktag <tag.sig >.git/refs/tags/mytag 2>message'
+
+############################################################
+# 14. check mytag
+
+test_expect_success \
+    'check mytag' \
+    'git-tag -l | grep mytag'
+
+
+test_done
--
1.4.1

------=_NextPart_000_00AF_01C6B5D7.D53EDA20
Content-Type: text/plain;
	name="P0004.TXT"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="P0004.TXT"

RnJvbSAzOTE2YjkzN2U3MzVlNzFiNmJjMmYyMjAzOGNjMjFjYmQ0YTE1ZWIxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYW1zYXkgQWxsYW4gSm9uZXMgPHJhbXNheUByYW1zYXkxLmRl
bW9uLmNvLnVrPgpEYXRlOiBTYXQsIDI5IEp1bCAyMDA2IDE4OjE1OjQ3ICswMTAwClN1YmplY3Q6
IFtQQVRDSCA0LzEwXSBOZXcgdGVzdHMgYW5kIGVuLXBhc3NhbnQgbW9kaWZpY2F0aW9ucyB0byBt
a3RhZy4KClRoZXNlIGNoYW5nZXMgd2VyZSBvcmlnaW5hbGx5IHBhcnQgb2YgdGhlIG5leHQgcGF0
Y2gsIGJ1dCBoYXZlIGJlZW4Kc3BsaXQgb3V0IHNpbmNlIHRoZXkgd2VyZSBwZXJpcGhlcmFsIHRv
IHRoZSBtYWluIHB1cnBvc2Ugb2YgdGhhdCBwYXRjaC4KCiAgLSB1cGRhdGUgY29tbWVudCBkZXNj
cmliaW5nIHRoZSBzaWduYXR1cmUgZm9ybWF0IHRvIHJlZmxlY3QKICAgIHRoZSBjdXJyZW50IGNv
ZGUuCiAgLSByZW1vdmUgdHJhaWxpbmcgXG4gaW4gY2FsbHMgdG8gZXJyb3IoKSwgc2luY2UgYSBc
biBpcyBhbHJlYWR5CiAgICBwcm92aWRlZCBieSBlcnJvcigpLgogIC0gcmVtb3ZlIHJlZHVuZGFu
dCBjYWxsIHRvIGdldF9zaGExX2hleCgpLgogIC0gY2FsbCBzaGExX3RvX2hleChzaGExKSB0byBj
b252ZXJ0IHRvIGFzY2lpLCByYXRoZXIgdGhhbiBhdHRlbXB0aW5nCiAgICB0byBwcmludCB0aGUg
cmF3IHNoYTEuCgpUaGUgbmV3IHRlc3RzIHByb3ZpZGUgYSByZWdyZXNzaW9uIHN1aXRlIHRvIHN1
cHBvcnQgdGhlIG1vZGlmaWNhdGlvbnMKdG8gZ2l0LW1rdGFnIGluIHRoaXMgYW5kIHRoZSBuZXh0
IHBhdGNoLgoKU2lnbmVkLW9mZi1ieTogUmFtc2F5IEFsbGFuIEpvbmVzIDxyYW1zYXlAcmFtc2F5
MS5kZW1vbi5jby51az4KLS0tCiBta3RhZy5jICAgICAgICAgIHwgICAzNSArKysrLS0tLQogdC90
MzgwMC1ta3RhZy5zaCB8ICAyMjcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDI0NSBpbnNlcnRpb25zKCspLCAx
NyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ta3RhZy5jIGIvbWt0YWcuYwppbmRleCBmMGZl
NTI4Li45YmFlMjIzIDEwMDY0NAotLS0gYS9ta3RhZy5jCisrKyBiL21rdGFnLmMKQEAgLTIsMTAg
KzIsMTEgQEAgI2luY2x1ZGUgImNhY2hlLmgiCiAjaW5jbHVkZSAidGFnLmgiCiAKIC8qCi0gKiBB
IHNpZ25hdHVyZSBmaWxlIGhhcyBhIHZlcnkgc2ltcGxlIGZpeGVkIGZvcm1hdDogdGhyZWUgbGlu
ZXMKLSAqIG9mICJvYmplY3QgPHNoYTE+IiArICJ0eXBlIDx0eXBlbmFtZT4iICsgInRhZyA8dGFn
bmFtZT4iLAotICogZm9sbG93ZWQgYnkgc29tZSBmcmVlLWZvcm0gc2lnbmF0dXJlIHRoYXQgZ2l0
IGl0c2VsZiBkb2Vzbid0Ci0gKiBjYXJlIGFib3V0LCBidXQgdGhhdCBjYW4gYmUgdmVyaWZpZWQg
d2l0aCBncGcgb3Igc2ltaWxhci4KKyAqIEEgc2lnbmF0dXJlIGZpbGUgaGFzIGEgdmVyeSBzaW1w
bGUgZml4ZWQgZm9ybWF0OiBmb3VyIGxpbmVzCisgKiBvZiAib2JqZWN0IDxzaGExPiIgKyAidHlw
ZSA8dHlwZW5hbWU+IiArICJ0YWcgPHRhZ25hbWU+IiArCisgKiAidGFnZ2VyIDxjb21taXR0ZXI+
IiwgZm9sbG93ZWQgYnkgYSBibGFuayBsaW5lLCBhIGZyZWUtZm9ybSB0YWcKKyAqIG1lc3NhZ2Ug
YW5kIGEgc2lnbmF0dXJlIGJsb2NrIHRoYXQgZ2l0IGl0c2VsZiBkb2Vzbid0IGNhcmUgYWJvdXQs
CisgKiBidXQgdGhhdCBjYW4gYmUgdmVyaWZpZWQgd2l0aCBncGcgb3Igc2ltaWxhci4KICAqCiAg
KiBUaGUgZmlyc3QgdGhyZWUgbGluZXMgYXJlIGd1YXJhbnRlZWQgdG8gYmUgYXQgbGVhc3QgNjMg
Ynl0ZXM6CiAgKiAib2JqZWN0IDxzaGExPlxuIiBpcyA0OCBieXRlcywgInR5cGUgdGFnXG4iIGF0
IDkgYnl0ZXMgaXMgdGhlCkBAIC00Niw0NSArNDcsNDIgQEAgc3RhdGljIGludCB2ZXJpZnlfdGFn
KGNoYXIgKmJ1ZmZlciwgdW5zaQogCWNvbnN0IGNoYXIgKm9iamVjdCwgKnR5cGVfbGluZSwgKnRh
Z19saW5lLCAqdGFnZ2VyX2xpbmU7CiAKIAlpZiAoc2l6ZSA8IDY0KQotCQlyZXR1cm4gZXJyb3Io
Indhbm5hIGZvb2wgbWUgPyB5b3Ugb2J2aW91c2x5IGdvdCB0aGUgc2l6ZSB3cm9uZyAhXG4iKTsK
KwkJcmV0dXJuIGVycm9yKCJ3YW5uYSBmb29sIG1lID8geW91IG9idmlvdXNseSBnb3QgdGhlIHNp
emUgd3JvbmcgISIpOwogCiAJYnVmZmVyW3NpemVdID0gMDsKIAogCS8qIFZlcmlmeSBvYmplY3Qg
bGluZSAqLwogCW9iamVjdCA9IGJ1ZmZlcjsKIAlpZiAobWVtY21wKG9iamVjdCwgIm9iamVjdCAi
LCA3KSkKLQkJcmV0dXJuIGVycm9yKCJjaGFyJWQ6IGRvZXMgbm90IHN0YXJ0IHdpdGggXCJvYmpl
Y3QgXCJcbiIsIDApOworCQlyZXR1cm4gZXJyb3IoImNoYXIlZDogZG9lcyBub3Qgc3RhcnQgd2l0
aCBcIm9iamVjdCBcIiIsIDApOwogCiAJaWYgKGdldF9zaGExX2hleChvYmplY3QgKyA3LCBzaGEx
KSkKLQkJcmV0dXJuIGVycm9yKCJjaGFyJWQ6IGNvdWxkIG5vdCBnZXQgU0hBMSBoYXNoXG4iLCA3
KTsKKwkJcmV0dXJuIGVycm9yKCJjaGFyJWQ6IGNvdWxkIG5vdCBnZXQgU0hBMSBoYXNoIiwgNyk7
CiAKIAkvKiBWZXJpZnkgdHlwZSBsaW5lICovCiAJdHlwZV9saW5lID0gb2JqZWN0ICsgNDg7CiAJ
aWYgKG1lbWNtcCh0eXBlX2xpbmUgLSAxLCAiXG50eXBlICIsIDYpKQotCQlyZXR1cm4gZXJyb3Io
ImNoYXIlZDogY291bGQgbm90IGZpbmQgXCJcXG50eXBlIFwiXG4iLCA0Nyk7CisJCXJldHVybiBl
cnJvcigiY2hhciVkOiBjb3VsZCBub3QgZmluZCBcIlxcbnR5cGUgXCIiLCA0Nyk7CiAKIAkvKiBW
ZXJpZnkgdGFnLWxpbmUgKi8KIAl0YWdfbGluZSA9IHN0cmNocih0eXBlX2xpbmUsICdcbicpOwog
CWlmICghdGFnX2xpbmUpCi0JCXJldHVybiBlcnJvcigiY2hhciV0ZDogY291bGQgbm90IGZpbmQg
bmV4dCBcIlxcblwiXG4iLCB0eXBlX2xpbmUgLSBidWZmZXIpOworCQlyZXR1cm4gZXJyb3IoImNo
YXIldGQ6IGNvdWxkIG5vdCBmaW5kIG5leHQgXCJcXG5cIiIsIHR5cGVfbGluZSAtIGJ1ZmZlcik7
CiAJdGFnX2xpbmUrKzsKIAlpZiAobWVtY21wKHRhZ19saW5lLCAidGFnICIsIDQpIHx8IHRhZ19s
aW5lWzRdID09ICdcbicpCi0JCXJldHVybiBlcnJvcigiY2hhciV0ZDogbm8gXCJ0YWcgXCIgZm91
bmRcbiIsIHRhZ19saW5lIC0gYnVmZmVyKTsKKwkJcmV0dXJuIGVycm9yKCJjaGFyJXRkOiBubyBc
InRhZyBcIiBmb3VuZCIsIHRhZ19saW5lIC0gYnVmZmVyKTsKIAogCS8qIEdldCB0aGUgYWN0dWFs
IHR5cGUgKi8KIAl0eXBlbGVuID0gdGFnX2xpbmUgLSB0eXBlX2xpbmUgLSBzdHJsZW4oInR5cGUg
XG4iKTsKIAlpZiAodHlwZWxlbiA+PSBzaXplb2YodHlwZSkpCi0JCXJldHVybiBlcnJvcigiY2hh
ciV0ZDogdHlwZSB0b28gbG9uZ1xuIiwgdHlwZV9saW5lKzUgLSBidWZmZXIpOworCQlyZXR1cm4g
ZXJyb3IoImNoYXIldGQ6IHR5cGUgdG9vIGxvbmciLCB0eXBlX2xpbmUrNSAtIGJ1ZmZlcik7CiAK
IAltZW1jcHkodHlwZSwgdHlwZV9saW5lKzUsIHR5cGVsZW4pOwogCXR5cGVbdHlwZWxlbl0gPSAw
OwogCiAJLyogVmVyaWZ5IHRoYXQgdGhlIG9iamVjdCBtYXRjaGVzICovCi0JaWYgKGdldF9zaGEx
X2hleChvYmplY3QgKyA3LCBzaGExKSkKLQkJcmV0dXJuIGVycm9yKCJjaGFyJWQ6IGNvdWxkIG5v
dCBnZXQgU0hBMSBoYXNoIGJ1dCB0aGlzIGlzIHJlYWxseSBvZGQgc2luY2UgaSBnb3QgaXQgYmVm
b3JlICFcbiIsIDcpOwotCiAJaWYgKHZlcmlmeV9vYmplY3Qoc2hhMSwgdHlwZSkpCi0JCXJldHVy
biBlcnJvcigiY2hhciVkOiBjb3VsZCBub3QgdmVyaWZ5IG9iamVjdCAlc1xuIiwgNywgc2hhMSk7
CisJCXJldHVybiBlcnJvcigiY2hhciVkOiBjb3VsZCBub3QgdmVyaWZ5IG9iamVjdCAlcyIsIDcs
IHNoYTFfdG9faGV4KHNoYTEpKTsKIAogCS8qIFZlcmlmeSB0aGUgdGFnLW5hbWU6IHdlIGRvbid0
IGFsbG93IGNvbnRyb2wgY2hhcmFjdGVycyBvciBzcGFjZXMgaW4gaXQgKi8KIAl0YWdfbGluZSAr
PSA0OwpAQCAtOTQsMTQgKzkyLDE3IEBAIHN0YXRpYyBpbnQgdmVyaWZ5X3RhZyhjaGFyICpidWZm
ZXIsIHVuc2kKIAkJCWJyZWFrOwogCQlpZiAoYyA+ICcgJykKIAkJCWNvbnRpbnVlOwotCQlyZXR1
cm4gZXJyb3IoImNoYXIldGQ6IGNvdWxkIG5vdCB2ZXJpZnkgdGFnIG5hbWVcbiIsIHRhZ19saW5l
IC0gYnVmZmVyKTsKKwkJcmV0dXJuIGVycm9yKCJjaGFyJXRkOiBjb3VsZCBub3QgdmVyaWZ5IHRh
ZyBuYW1lIiwgdGFnX2xpbmUgLSBidWZmZXIpOwogCX0KIAogCS8qIFZlcmlmeSB0aGUgdGFnZ2Vy
IGxpbmUgKi8KIAl0YWdnZXJfbGluZSA9IHRhZ19saW5lOwogCiAJaWYgKG1lbWNtcCh0YWdnZXJf
bGluZSwgInRhZ2dlciIsIDYpIHx8ICh0YWdnZXJfbGluZVs2XSA9PSAnXG4nKSkKLQkJcmV0dXJu
IGVycm9yKCJjaGFyJXRkOiBjb3VsZCBub3QgZmluZCBcInRhZ2dlclwiXG4iLCB0YWdnZXJfbGlu
ZSAtIGJ1ZmZlcik7CisJCXJldHVybiBlcnJvcigiY2hhciV0ZDogY291bGQgbm90IGZpbmQgXCJ0
YWdnZXJcIiIsIHRhZ2dlcl9saW5lIC0gYnVmZmVyKTsKKworCS8qIFRPRE86IGNoZWNrIGZvciBj
b21taXR0ZXIgaW5mbyArIGJsYW5rIGxpbmU/ICovCisJLyogQWxzbywgdGhlIG1pbmltdW0gbGVu
Z3RoIGlzIHByb2JhYmx5ICsgInRhZ2dlciAuIiwgb3IgNjMrOD03MSAqLwogCiAJLyogVGhlIGFj
dHVhbCBzdHVmZiBhZnRlcndhcmRzIHdlIGRvbid0IGNhcmUgYWJvdXQuLiAqLwogCXJldHVybiAw
OwpkaWZmIC0tZ2l0IGEvdC90MzgwMC1ta3RhZy5zaCBiL3QvdDM4MDAtbWt0YWcuc2gKbmV3IGZp
bGUgbW9kZSAxMDA3NTUKaW5kZXggMDAwMDAwMC4uYjgzM2UxOQotLS0gL2Rldi9udWxsCisrKyBi
L3QvdDM4MDAtbWt0YWcuc2gKQEAgLTAsMCArMSwyMjcgQEAKKyMhL2Jpbi9zaAorIworIworCit0
ZXN0X2Rlc2NyaXB0aW9uPSdnaXQtbWt0YWc6IHRhZyBvYmplY3QgdmVyaWZ5IHRlc3QnCisKKy4g
Li90ZXN0LWxpYi5zaAorCisjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIworIyBjaGVjayB0aGUgdGFnLnNpZyBmaWxlLCBleHBlY3Rpbmcg
dmVyaWZ5X3RhZygpIHRvIGZhaWwsCisjIGFuZCBjaGVja2luZyB0aGF0IHRoZSBlcnJvciBtZXNz
YWdlIG1hdGNoZXMgdGhlIHBhdHRlcm4KKyMgZ2l2ZW4gaW4gdGhlIGV4cGVjdC5wYXQgZmlsZS4K
KworY2hlY2tfdmVyaWZ5X2ZhaWx1cmUgKCkgeworICAgIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgXAor
ICAgICAgICAiJDEiIFwKKyAgICAgICAgJ2dpdC1ta3RhZyA8dGFnLnNpZyAyPm1lc3NhZ2UgfHwK
KyAgICAgICAgIGVncmVwIC1xIC1mIGV4cGVjdC5wYXQgbWVzc2FnZScKK30KKworIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKKyMgZmly
c3QgY3JlYXRlIGEgY29tbWl0LCBzbyB3ZSBoYXZlIGEgdmFsaWQgb2JqZWN0L3R5cGUKKyMgZm9y
IHRoZSB0YWcuCitlY2hvIEhlbGxvID5BCitnaXQtdXBkYXRlLWluZGV4IC0tYWRkIEEKK2dpdC1j
b21taXQgLW0gIkluaXRpYWwgY29tbWl0IgoraGVhZD0kKGdpdC1yZXYtcGFyc2UgLS12ZXJpZnkg
SEVBRCkKKworIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjCisjICAxLiBsZW5ndGggY2hlY2sKKworY2F0ID50YWcuc2lnIDw8RU9GCit0
b28gc2hvcnQgZm9yIGEgdGFnCitFT0YKKworY2F0ID5leHBlY3QucGF0IDw8RU9GCiteZXJyb3I6
IC4qc2l6ZSB3cm9uZy4qJAorRU9GCisKK2NoZWNrX3ZlcmlmeV9mYWlsdXJlICdUYWcgb2JqZWN0
IGxlbmd0aCBjaGVjaycKKworIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjCisjICAyLiBvYmplY3QgbGluZSBsYWJlbCBjaGVjaworCitj
YXQgPnRhZy5zaWcgPDxFT0YKK3h4eHh4eCAxMzllOWIzMzk4NmIxYzI2NzBmZmY1MmM1MDY3NjAz
MTE3YjNlODk1Cit0eXBlIHRhZwordGFnIG15dGFnCitFT0YKKworY2F0ID5leHBlY3QucGF0IDw8
RU9GCiteZXJyb3I6IGNoYXIwOiAuKiJvYmplY3QgIiQKK0VPRgorCitjaGVja192ZXJpZnlfZmFp
bHVyZSAnIm9iamVjdCIgbGluZSBsYWJlbCBjaGVjaycKKworIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCisjICAzLiBvYmplY3QgbGlu
ZSBTSEExIGNoZWNrCisKK2NhdCA+dGFnLnNpZyA8PEVPRgorb2JqZWN0IHp6OWU5YjMzOTg2YjFj
MjY3MGZmZjUyYzUwNjc2MDMxMTdiM2U4OTUKK3R5cGUgdGFnCit0YWcgbXl0YWcKK0VPRgorCitj
YXQgPmV4cGVjdC5wYXQgPDxFT0YKK15lcnJvcjogY2hhcjc6IC4qU0hBMSBoYXNoJAorRU9GCisK
K2NoZWNrX3ZlcmlmeV9mYWlsdXJlICcib2JqZWN0IiBsaW5lIFNIQTEgY2hlY2snCisKKyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwor
IyAgNC4gdHlwZSBsaW5lIGxhYmVsIGNoZWNrCisKK2NhdCA+dGFnLnNpZyA8PEVPRgorb2JqZWN0
IDc3OWU5YjMzOTg2YjFjMjY3MGZmZjUyYzUwNjc2MDMxMTdiM2U4OTUKK3h4eHggdGFnCit0YWcg
bXl0YWcKK0VPRgorCitjYXQgPmV4cGVjdC5wYXQgPDxFT0YKK15lcnJvcjogY2hhcjQ3OiAuKiJb
XF1udHlwZSAiJAorRU9GCisKK2NoZWNrX3ZlcmlmeV9mYWlsdXJlICcidHlwZSIgbGluZSBsYWJl
bCBjaGVjaycKKworIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjCisjICA1LiB0eXBlIGxpbmUgZW9sIGNoZWNrCisKK2VjaG8gIm9iamVj
dCA3NzllOWIzMzk4NmIxYzI2NzBmZmY1MmM1MDY3NjAzMTE3YjNlODk1IiA+dGFnLnNpZworZWNo
byAtbiAidHlwZSB0YWdzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3NzIiA+PnRhZy5zaWcK
KworY2F0ID5leHBlY3QucGF0IDw8RU9GCiteZXJyb3I6IGNoYXI0ODogLioiW1xdbiIkCitFT0YK
KworY2hlY2tfdmVyaWZ5X2ZhaWx1cmUgJyJ0eXBlIiBsaW5lIGVvbCBjaGVjaycKKworIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCisj
ICA2LiB0YWcgbGluZSBsYWJlbCBjaGVjayAjMQorCitjYXQgPnRhZy5zaWcgPDxFT0YKK29iamVj
dCA3NzllOWIzMzk4NmIxYzI2NzBmZmY1MmM1MDY3NjAzMTE3YjNlODk1Cit0eXBlIHRhZworeHh4
IG15dGFnCitFT0YKKworY2F0ID5leHBlY3QucGF0IDw8RU9GCiteZXJyb3I6IGNoYXI1Nzogbm8g
InRhZyAiIGZvdW5kJAorRU9GCisKK2NoZWNrX3ZlcmlmeV9mYWlsdXJlICcidGFnIiBsaW5lIGxh
YmVsIGNoZWNrICMxJworCisjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMKKyMgIDcuIHRhZyBsaW5lIGxhYmVsIGNoZWNrICMyCisKK2Nh
dCA+dGFnLnNpZyA8PEVPRgorb2JqZWN0IDc3OWU5YjMzOTg2YjFjMjY3MGZmZjUyYzUwNjc2MDMx
MTdiM2U4OTUKK3R5cGUgdGFnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnCit0YWcKK0VP
RgorCitjYXQgPmV4cGVjdC5wYXQgPDxFT0YKK15lcnJvcjogY2hhcjg3OiBubyAidGFnICIgZm91
bmQkCitFT0YKKworY2hlY2tfdmVyaWZ5X2ZhaWx1cmUgJyJ0YWciIGxpbmUgbGFiZWwgY2hlY2sg
IzInCisKKyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIworIyAgOC4gdHlwZSBsaW5lIHR5cGUtbmFtZSBsZW5ndGggY2hlY2sKKworY2F0
ID50YWcuc2lnIDw8RU9GCitvYmplY3QgNzc5ZTliMzM5ODZiMWMyNjcwZmZmNTJjNTA2NzYwMzEx
N2IzZTg5NQordHlwZSB0YWdnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2dnZ2cKK3RhZyBteXRh
ZworRU9GCisKK2NhdCA+ZXhwZWN0LnBhdCA8PEVPRgorXmVycm9yOiBjaGFyNTM6IHR5cGUgdG9v
IGxvbmckCitFT0YKKworY2hlY2tfdmVyaWZ5X2ZhaWx1cmUgJyJ0eXBlIiBsaW5lIHR5cGUtbmFt
ZSBsZW5ndGggY2hlY2snCisKKyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIworIyAgOS4gdmVyaWZ5IG9iamVjdCAoU0hBMS90eXBlKSBj
aGVjaworCitjYXQgPnRhZy5zaWcgPDxFT0YKK29iamVjdCA3NzllOWIzMzk4NmIxYzI2NzBmZmY1
MmM1MDY3NjAzMTE3YjNlODk1Cit0eXBlIHRhZ2dnZwordGFnIG15dGFnCitFT0YKKworY2F0ID5l
eHBlY3QucGF0IDw8RU9GCiteZXJyb3I6IGNoYXI3OiBjb3VsZCBub3QgdmVyaWZ5IG9iamVjdC4q
JAorRU9GCisKK2NoZWNrX3ZlcmlmeV9mYWlsdXJlICd2ZXJpZnkgb2JqZWN0IChTSEExL3R5cGUp
IGNoZWNrJworCisjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMKKyMgMTAuIHZlcmlmeSB0YWctbmFtZSBjaGVjaworCitjYXQgPnRhZy5z
aWcgPDxFT0YKK29iamVjdCAkaGVhZAordHlwZSBjb21taXQKK3RhZyBteQl0YWcKK0VPRgorCitj
YXQgPmV4cGVjdC5wYXQgPDxFT0YKK15lcnJvcjogY2hhcjY3OiBjb3VsZCBub3QgdmVyaWZ5IHRh
ZyBuYW1lJAorRU9GCisKK2NoZWNrX3ZlcmlmeV9mYWlsdXJlICd2ZXJpZnkgdGFnLW5hbWUgY2hl
Y2snCisKKyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIworIyAxMS4gdGFnZ2VyIGxpbmUgbGFibGUgY2hlY2sgIzEKKworY2F0ID50YWcu
c2lnIDw8RU9GCitvYmplY3QgJGhlYWQKK3R5cGUgY29tbWl0Cit0YWcgbXl0YWcKK0VPRgorCitj
YXQgPmV4cGVjdC5wYXQgPDxFT0YKK15lcnJvcjogY2hhcjcwOiBjb3VsZCBub3QgZmluZCAidGFn
Z2VyIiQKK0VPRgorCitjaGVja192ZXJpZnlfZmFpbHVyZSAnInRhZ2dlciIgbGluZSBsYWJlbCBj
aGVjayAjMScKKworIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjCisjIDEyLiB0YWdnZXIgbGluZSBsYWJsZSBjaGVjayAjMgorCitjYXQg
PnRhZy5zaWcgPDxFT0YKK29iamVjdCAkaGVhZAordHlwZSBjb21taXQKK3RhZyBteXRhZwordGFn
Z2VyCitFT0YKKworY2F0ID5leHBlY3QucGF0IDw8RU9GCiteZXJyb3I6IGNoYXI3MDogY291bGQg
bm90IGZpbmQgInRhZ2dlciIkCitFT0YKKworY2hlY2tfdmVyaWZ5X2ZhaWx1cmUgJyJ0YWdnZXIi
IGxpbmUgbGFiZWwgY2hlY2sgIzInCisKKyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIworIyAxMy4gY3JlYXRlIHZhbGlkIHRhZworCitj
YXQgPnRhZy5zaWcgPDxFT0YKK29iamVjdCAkaGVhZAordHlwZSBjb21taXQKK3RhZyBteXRhZwor
dGFnZ2VyIGFub3RoZXJAZXhhbXBsZS5jb20KK0VPRgorCit0ZXN0X2V4cGVjdF9zdWNjZXNzIFwK
KyAgICAnY3JlYXRlIHZhbGlkIHRhZycgXAorICAgICdnaXQtbWt0YWcgPHRhZy5zaWcgPi5naXQv
cmVmcy90YWdzL215dGFnIDI+bWVzc2FnZScKKworIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCisjIDE0LiBjaGVjayBteXRhZworCit0
ZXN0X2V4cGVjdF9zdWNjZXNzIFwKKyAgICAnY2hlY2sgbXl0YWcnIFwKKyAgICAnZ2l0LXRhZyAt
bCB8IGdyZXAgbXl0YWcnCisKKwordGVzdF9kb25lCi0tIAoxLjQuMQoK

------=_NextPart_000_00AF_01C6B5D7.D53EDA20--
