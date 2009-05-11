From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add a reminder test case for a merge with F/D transition
Date: Mon, 11 May 2009 11:42:17 +0200
Message-ID: <81b0412b0905110242u3624f0eeyc0dc9b2b987bfa2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636457c723fdade04699fcb27
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org,
	Samuel Tardieu <sam@rfc1149.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 11 11:42:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3S1l-00018Y-EF
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 11:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755129AbZEKJmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 05:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754218AbZEKJmS
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 05:42:18 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:39105 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbZEKJmS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 05:42:18 -0400
Received: by bwz22 with SMTP id 22so2489613bwz.37
        for <git@vger.kernel.org>; Mon, 11 May 2009 02:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=UTmxeeAfXWyc1jbTXLIUoR/bFS95aw9zN2fLSAmBS5k=;
        b=mxOmTjGQigjQfFwy609bVzYxOrhkVmgq6zBROmcblMmXwUW0YMlWhUfCYNOlVAPNp5
         pnoyCiEYPLc0BF5l+ptvaX0AG0sD8QWrKe3WpM15bwKMA+7rMWJo1sBI8hXsx1rDZdJX
         iJfsz/9QWpyCCLjutbFIB0fWk1E3mtvsecl48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=gKycHcm0QLhxAlx8wF1gVQrUzwxXMm00mKV5PtHFYYKDHj/cKS9VOrnkwZCB9XTKW3
         5F+uidxiq26CM4YS5rsJskBDUxOf7/ecva6EIoYdrBif+Yv0b+ZT3Z+US5UFHZ8v4oaQ
         FELOALW+afeIfog/EtsdI5U32umSekKIP2Hk4=
Received: by 10.204.97.204 with SMTP id m12mr6707608bkn.22.1242034937518; Mon, 
	11 May 2009 02:42:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118787>

--001636457c723fdade04699fcb27
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The problem is that if a file was replaced with a directory containing
another file with the same content and mode, an attempt to merge it
with a branch descended from a commit before this F->D transition will
cause merge-recursive to break. It breaks even if there were no
conflicting changes on that other branch.

Originally reported by Anders Melchiorsen.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

2009/5/11 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>
> Maybe you can turn this into a patch adding a test (with
> test_expect_failure to mark it as a bug)? =C2=A0This would make debugging=
 a lot
> easier, as a non-installed Git could be tested.

Here.

 t/t6020-merge-df.sh |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/t/t6020-merge-df.sh b/t/t6020-merge-df.sh
index a19d49d..b62b52a 100755
--- a/t/t6020-merge-df.sh
+++ b/t/t6020-merge-df.sh
@@ -22,4 +22,27 @@ git commit -m "File: dir"'

 test_expect_code 1 'Merge with d/f conflicts' 'git merge "merge msg" B mas=
ter'

+test_expect_failure 'F/D conflict' '
+	git reset --hard &&
+	git checkout master &&
+	rm .git/index &&
+
+	mkdir before &&
+	echo FILE >before/one &&
+	echo FILE >after &&
+	git add . &&
+	git commit -mfirst &&
+
+	rm -f after &&
+	git mv before after &&
+	git commit -mmove &&
+
+	git checkout -b para HEAD^ &&
+	echo COMPLETELY ANOTHER FILE >another &&
+	git add . &&
+	git commit -mpara &&
+
+	git merge master
+'
+
 test_done
--=20
1.6.3.28.ga852b

--001636457c723fdade04699fcb27
Content-Type: text/plain; charset=US-ASCII; 
	name="0001-Add-a-reminder-test-case-for-a-merge-with-F-D-transi.txt"
Content-Disposition: attachment; 
	filename="0001-Add-a-reminder-test-case-for-a-merge-with-F-D-transi.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fukzi57x0

RnJvbSAwNTQzM2E2Zjg5NmM0MGU0YTAzOTgxNWQ4NjYxM2Q3ZTM1MWVmMGRhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBNb24sIDExIE1heSAyMDA5IDExOjMxOjQyICswMjAwClN1YmplY3Q6IFtQQVRDSF0gQWRkIGEg
cmVtaW5kZXIgdGVzdCBjYXNlIGZvciBhIG1lcmdlIHdpdGggRi9EIHRyYW5zaXRpb24KClRoZSBw
cm9ibGVtIGlzIHRoYXQgaWYgYSBmaWxlIHdhcyByZXBsYWNlZCB3aXRoIGEgZGlyZWN0b3J5IGNv
bnRhaW5pbmcKYW5vdGhlciBmaWxlIHdpdGggdGhlIHNhbWUgY29udGVudCBhbmQgbW9kZSwgYW4g
YXR0ZW1wdCB0byBtZXJnZSBpdAp3aXRoIGEgYnJhbmNoIGRlc2NlbmRlZCBmcm9tIGEgY29tbWl0
IGJlZm9yZSB0aGlzIEYtPkQgdHJhbnNpdGlvbiB3aWxsCmNhdXNlIG1lcmdlLXJlY3Vyc2l2ZSB0
byBicmVhay4gSXQgYnJlYWtzIGV2ZW4gaWYgdGhlcmUgd2VyZSBubwpjb25mbGljdGluZyBjaGFu
Z2VzIG9uIHRoYXQgb3RoZXIgYnJhbmNoLgoKT3JpZ2luYWxseSByZXBvcnRlZCBieSBBbmRlcnMg
TWVsY2hpb3JzZW4uCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwu
Y29tPgotLS0KIHQvdDYwMjAtbWVyZ2UtZGYuc2ggfCAgIDIzICsrKysrKysrKysrKysrKysrKysr
KysrCiAxIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvdC90NjAyMC1tZXJnZS1kZi5zaCBiL3QvdDYwMjAtbWVyZ2UtZGYuc2gKaW5k
ZXggYTE5ZDQ5ZC4uYjYyYjUyYSAxMDA3NTUKLS0tIGEvdC90NjAyMC1tZXJnZS1kZi5zaAorKysg
Yi90L3Q2MDIwLW1lcmdlLWRmLnNoCkBAIC0yMiw0ICsyMiwyNyBAQCBnaXQgY29tbWl0IC1tICJG
aWxlOiBkaXIiJwogCiB0ZXN0X2V4cGVjdF9jb2RlIDEgJ01lcmdlIHdpdGggZC9mIGNvbmZsaWN0
cycgJ2dpdCBtZXJnZSAibWVyZ2UgbXNnIiBCIG1hc3RlcicKIAordGVzdF9leHBlY3RfZmFpbHVy
ZSAnRi9EIGNvbmZsaWN0JyAnCisJZ2l0IHJlc2V0IC0taGFyZCAmJgorCWdpdCBjaGVja291dCBt
YXN0ZXIgJiYKKwlybSAuZ2l0L2luZGV4ICYmCisKKwlta2RpciBiZWZvcmUgJiYKKwllY2hvIEZJ
TEUgPmJlZm9yZS9vbmUgJiYKKwllY2hvIEZJTEUgPmFmdGVyICYmCisJZ2l0IGFkZCAuICYmCisJ
Z2l0IGNvbW1pdCAtbWZpcnN0ICYmCisKKwlybSAtZiBhZnRlciAmJgorCWdpdCBtdiBiZWZvcmUg
YWZ0ZXIgJiYKKwlnaXQgY29tbWl0IC1tbW92ZSAmJgorCisJZ2l0IGNoZWNrb3V0IC1iIHBhcmEg
SEVBRF4gJiYKKwllY2hvIENPTVBMRVRFTFkgQU5PVEhFUiBGSUxFID5hbm90aGVyICYmCisJZ2l0
IGFkZCAuICYmCisJZ2l0IGNvbW1pdCAtbXBhcmEgJiYKKworCWdpdCBtZXJnZSBtYXN0ZXIKKycK
KwogdGVzdF9kb25lCi0tIAoxLjYuMy4yOC5nYTg1MmIKCg==
--001636457c723fdade04699fcb27--
