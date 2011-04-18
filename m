From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: RFC: "negative" dirstat
Date: Mon, 18 Apr 2011 14:02:22 -0700
Message-ID: <BANLkTi=it7r7UsAZGYJC1mntL6wtFipB9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf30549f456396fe04a137b6b9
To: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 23:03:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBvbK-0002RI-BU
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 23:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921Ab1DRVDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 17:03:14 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34877 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751675Ab1DRVDM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2011 17:03:12 -0400
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p3IL2gn1022015
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Mon, 18 Apr 2011 14:02:42 -0700
Received: by iwn34 with SMTP id 34so4224555iwn.19
        for <git@vger.kernel.org>; Mon, 18 Apr 2011 14:02:42 -0700 (PDT)
Received: by 10.42.213.202 with SMTP id gx10mr6479919icb.498.1303160562092;
 Mon, 18 Apr 2011 14:02:42 -0700 (PDT)
Received: by 10.231.33.199 with HTTP; Mon, 18 Apr 2011 14:02:22 -0700 (PDT)
X-Spam-Status: No, hits=-102.373 required=5 tests=AWL,BAYES_05,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171756>

--20cf30549f456396fe04a137b6b9
Content-Type: text/plain; charset=ISO-8859-1

Ok, so this is just an RFC patch, but the concept is pretty simple..

In the kernel, the ARM platform is growing boundlessly, with platform
files being added for every random SoC out there. One of the things
that Russell King (arm maintainer) has worried about is that when they
try to clean stuff up, code *removal* also ends up adding to the
damage, so if ARM ever gets its act together and is able to
consolidate a lot of this, it's still going to look very bad in the
statistics because there will be a lot of damage due to removed files.

In the regular "--diffstat" output, this is all very obvious, because
if you actually remove more lines than you add, it will say so, and
people will be very happy.

But in --dirstat, removed lines are always counted towards damage.

So here's a total hacky RFC patch to add a "--negative" option, which
allows for dirstat to actually take the amount of added/removed code
into account, and make "damage" a signed integer instead.

Example case right now for my pulls today:

[torvalds@i5 linux]$ git diff --dirstat=1 --cumulative @{6am}..
  22.6% Documentation/input/
   1.4% arch/powerpc/include/asm/
   3.7% arch/powerpc/kernel/
   6.6% arch/powerpc/
   6.3% block/
   6.0% drivers/input/
  15.7% drivers/md/
  22.1% drivers/
  38.4% fs/btrfs/
  39.1% fs/
   2.7% include/linux/
[torvalds@i5 linux]$ git diff --dirstat=1 --cumulative --negative @{6am}..
  56.2% Documentation/input/
   1.9% arch/powerpc/include/asm/
   4.3% arch/powerpc/kernel/
   1.3% arch/powerpc/platforms/pseries/
   1.4% arch/powerpc/platforms/
   8.4% arch/powerpc/
   2.4% block/
   1.6% drivers/input/misc/
   8.4% drivers/input/
  -5.6% drivers/md/
   2.7% drivers/
  28.5% fs/btrfs/
  29.0% fs/

ie note how with "--negative", it becomes obvious that drivers/md
actually removed more than it added, while some subdirectories were
all about adding (Documentation/input got a new file), while others
were more about changing existing lines with not a lot of additional
actual new code.

The diffstat for drivers/md looks like this:

 7 files changed, 103 insertions(+), 137 deletions(-)

and I think most of the insertions were shorter lines than the deletions too.

NOTE! This is known-buggy in that you may end up in a situation where
the percentages are > 100% (the "total change" may be arbitrarily
small, since they all add up). In fact, you might get a
division-by-zero if the total change ends up being zero. This is a RFC
patch, nothing more. I don't know what the "right" solution for the
percentages should be (except that it obviously should never cause a
divide-by-zero).

Comments?

                        Linus "yeah, that option name sucks" Torvalds

--20cf30549f456396fe04a137b6b9
Content-Type: text/x-patch; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gmnw47gb0

IGRpZmYuYyB8ICAgMjYgKysrKysrKysrKysrKysrKystLS0tLS0tLS0KIGRpZmYuaCB8ICAgIDEg
KwogMiBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RpZmYuYyBiL2RpZmYuYwppbmRleCA5ZmE4NDEwMTBjYzIuLmM5M2ZkYWFhNTQx
ZiAxMDA2NDQKLS0tIGEvZGlmZi5jCisrKyBiL2RpZmYuYwpAQCAtMTQ0Nyw3ICsxNDQ3LDcgQEAg
c3RhdGljIHZvaWQgc2hvd19udW1zdGF0KHN0cnVjdCBkaWZmc3RhdF90ICpkYXRhLCBzdHJ1Y3Qg
ZGlmZl9vcHRpb25zICpvcHRpb25zKQogCiBzdHJ1Y3QgZGlyc3RhdF9maWxlIHsKIAljb25zdCBj
aGFyICpuYW1lOwotCXVuc2lnbmVkIGxvbmcgY2hhbmdlZDsKKwlsb25nIGNoYW5nZWQ7CiB9Owog
CiBzdHJ1Y3QgZGlyc3RhdF9kaXIgewpAQCAtMTQ1OCw3ICsxNDU4LDcgQEAgc3RydWN0IGRpcnN0
YXRfZGlyIHsKIHN0YXRpYyBsb25nIGdhdGhlcl9kaXJzdGF0KHN0cnVjdCBkaWZmX29wdGlvbnMg
Km9wdCwgc3RydWN0IGRpcnN0YXRfZGlyICpkaXIsCiAJCXVuc2lnbmVkIGxvbmcgY2hhbmdlZCwg
Y29uc3QgY2hhciAqYmFzZSwgaW50IGJhc2VsZW4pCiB7Ci0JdW5zaWduZWQgbG9uZyB0aGlzX2Rp
ciA9IDA7CisJbG9uZyB0aGlzX2RpciA9IDA7CiAJdW5zaWduZWQgaW50IHNvdXJjZXMgPSAwOwog
CWNvbnN0IGNoYXIgKmxpbmVfcHJlZml4ID0gIiI7CiAJc3RydWN0IHN0cmJ1ZiAqbXNnID0gTlVM
TDsKQEAgLTE0OTksMTIgKzE0OTksMTQgQEAgc3RhdGljIGxvbmcgZ2F0aGVyX2RpcnN0YXQoc3Ry
dWN0IGRpZmZfb3B0aW9ucyAqb3B0LCBzdHJ1Y3QgZGlyc3RhdF9kaXIgKmRpciwKIAkgKiAgICB1
bmRlciB0aGlzIGRpcmVjdG9yeSAoc291cmNlcyA9PSAxKS4KIAkgKi8KIAlpZiAoYmFzZWxlbiAm
JiBzb3VyY2VzICE9IDEpIHsKLQkJaW50IHBlcm1pbGxlID0gdGhpc19kaXIgKiAxMDAwIC8gY2hh
bmdlZDsKKwkJaW50IHBlcm1pbGxlID0gbGFicyh0aGlzX2RpcikgKiAxMDAwIC8gY2hhbmdlZDsK
IAkJaWYgKHBlcm1pbGxlKSB7Ci0JCQlpbnQgcGVyY2VudCA9IHBlcm1pbGxlIC8gMTA7CisJCQlk
b3VibGUgcGVyY2VudCA9IHBlcm1pbGxlIC8gMTAuMDsKIAkJCWlmIChwZXJjZW50ID49IGRpci0+
cGVyY2VudCkgewotCQkJCWZwcmludGYob3B0LT5maWxlLCAiJXMlNGQuJTAxZCUlICUuKnNcbiIs
IGxpbmVfcHJlZml4LAotCQkJCQlwZXJjZW50LCBwZXJtaWxsZSAlIDEwLCBiYXNlbGVuLCBiYXNl
KTsKKwkJCQlpZiAodGhpc19kaXIgPCAwKQorCQkJCQlwZXJjZW50ID0gLXBlcmNlbnQ7CisJCQkJ
ZnByaW50ZihvcHQtPmZpbGUsICIlcyU2LjFmJSUgJS4qc1xuIiwgbGluZV9wcmVmaXgsCisJCQkJ
CXBlcmNlbnQsIGJhc2VsZW4sIGJhc2UpOwogCQkJCWlmICghZGlyLT5jdW11bGF0aXZlKQogCQkJ
CQlyZXR1cm4gMDsKIAkJCX0KQEAgLTE1MzcsNyArMTUzOSw4IEBAIHN0YXRpYyB2b2lkIHNob3df
ZGlyc3RhdChzdHJ1Y3QgZGlmZl9vcHRpb25zICpvcHRpb25zKQogCWZvciAoaSA9IDA7IGkgPCBx
LT5ucjsgaSsrKSB7CiAJCXN0cnVjdCBkaWZmX2ZpbGVwYWlyICpwID0gcS0+cXVldWVbaV07CiAJ
CWNvbnN0IGNoYXIgKm5hbWU7Ci0JCXVuc2lnbmVkIGxvbmcgY29waWVkLCBhZGRlZCwgZGFtYWdl
OworCQl1bnNpZ25lZCBsb25nIGNvcGllZCwgYWRkZWQsIGRlbGV0ZWQ7CisJCWxvbmcgZGFtYWdl
OwogCiAJCW5hbWUgPSBwLT5vbmUtPnBhdGggPyBwLT5vbmUtPnBhdGggOiBwLT50d28tPnBhdGg7
CiAKQEAgLTE1NjcsNyArMTU3MCwxMSBAQCBzdGF0aWMgdm9pZCBzaG93X2RpcnN0YXQoc3RydWN0
IGRpZmZfb3B0aW9ucyAqb3B0aW9ucykKIAkJICogZGFtYWdlZCBmaWxlcywgbm90IGRhbWFnZWQg
bGluZXMuIFRoaXMgaXMgZG9uZSBieQogCQkgKiBjb3VudGluZyBvbmx5IGEgc2luZ2xlIGRhbWFn
ZWQgbGluZSBwZXIgZmlsZS4KIAkJICovCi0JCWRhbWFnZSA9IChwLT5vbmUtPnNpemUgLSBjb3Bp
ZWQpICsgYWRkZWQ7CisJCWRlbGV0ZWQgPSBwLT5vbmUtPnNpemUgLSBjb3BpZWQ7CisJCWlmIChE
SUZGX09QVF9UU1Qob3B0aW9ucywgRElGRlNUQVRfTkVHQVRJVkUpKQorCQkJZGFtYWdlID0gYWRk
ZWQgLSBkZWxldGVkOworCQllbHNlCisJCQlkYW1hZ2UgPSBhZGRlZCArIGRlbGV0ZWQ7CiAJCWlm
IChESUZGX09QVF9UU1Qob3B0aW9ucywgRElSU1RBVF9CWV9GSUxFKSAmJiBkYW1hZ2UgPiAwKQog
CQkJZGFtYWdlID0gMTsKIApAQCAtMzEzOSw3ICszMTQ2LDggQEAgaW50IGRpZmZfb3B0X3BhcnNl
KHN0cnVjdCBkaWZmX29wdGlvbnMgKm9wdGlvbnMsIGNvbnN0IGNoYXIgKiphdiwgaW50IGFjKQog
CQkJICAgJm9wdGlvbnMtPmRpcnN0YXRfcGVyY2VudCkpIHsKIAkJb3B0aW9ucy0+b3V0cHV0X2Zv
cm1hdCB8PSBESUZGX0ZPUk1BVF9ESVJTVEFUOwogCQlESUZGX09QVF9TRVQob3B0aW9ucywgRElS
U1RBVF9CWV9GSUxFKTsKLQl9CisJfSBlbHNlIGlmICghc3RyY21wKGFyZywgIi0tbmVnYXRpdmUi
KSkKKwkJRElGRl9PUFRfU0VUKG9wdGlvbnMsIERJRkZTVEFUX05FR0FUSVZFKTsKIAllbHNlIGlm
ICghc3RyY21wKGFyZywgIi0tY2hlY2siKSkKIAkJb3B0aW9ucy0+b3V0cHV0X2Zvcm1hdCB8PSBE
SUZGX0ZPUk1BVF9DSEVDS0RJRkY7CiAJZWxzZSBpZiAoIXN0cmNtcChhcmcsICItLXN1bW1hcnki
KSkKZGlmZiAtLWdpdCBhL2RpZmYuaCBiL2RpZmYuaAppbmRleCAwMDdhMDU1NGQ0YjIuLjk1ZDZl
NjUyNDdhZSAxMDA2NDQKLS0tIGEvZGlmZi5oCisrKyBiL2RpZmYuaApAQCAtNzgsNiArNzgsNyBA
QCB0eXBlZGVmIHN0cnVjdCBzdHJidWYgKigqZGlmZl9wcmVmaXhfZm5fdCkoc3RydWN0IGRpZmZf
b3B0aW9ucyAqb3B0LCB2b2lkICpkYXRhKQogI2RlZmluZSBESUZGX09QVF9JR05PUkVfVU5UUkFD
S0VEX0lOX1NVQk1PRFVMRVMgKDEgPDwgMjUpCiAjZGVmaW5lIERJRkZfT1BUX0lHTk9SRV9ESVJU
WV9TVUJNT0RVTEVTICgxIDw8IDI2KQogI2RlZmluZSBESUZGX09QVF9PVkVSUklERV9TVUJNT0RV
TEVfQ09ORklHICgxIDw8IDI3KQorI2RlZmluZSBESUZGX09QVF9ESUZGU1RBVF9ORUdBVElWRSAg
ICgxIDw8IDI4KQogCiAjZGVmaW5lIERJRkZfT1BUX1RTVChvcHRzLCBmbGFnKSAgICAoKG9wdHMp
LT5mbGFncyAmIERJRkZfT1BUXyMjZmxhZykKICNkZWZpbmUgRElGRl9PUFRfU0VUKG9wdHMsIGZs
YWcpICAgICgob3B0cyktPmZsYWdzIHw9IERJRkZfT1BUXyMjZmxhZykK
--20cf30549f456396fe04a137b6b9--
