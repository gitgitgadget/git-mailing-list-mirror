From: =?ISO-8859-1?Q?Gr=E9gory_Pakosz?= <gpakosz@visionobjects.com>
Subject: git filter-branch doesn't dereference annotated tags
Date: Mon, 31 Dec 2012 17:24:11 +0100
Message-ID: <CAC_01E174m_6tDwPKZ5P0BUxnLNWUf9p+VkECFosPTzip0sYsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf307ca418d141d504d22872a9
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 31 17:29:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpiEd-0005VK-Og
	for gcvg-git-2@plane.gmane.org; Mon, 31 Dec 2012 17:29:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294Ab2LaQYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 11:24:47 -0500
Received: from mail.elysmail.net ([188.165.34.231]:51883 "EHLO elysmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209Ab2LaQYp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 11:24:45 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=visionobjects.com; s=vo2010objects;
        h=received:received:received:mime-version:received:from:date
          :message-id:subject:to:content-type:x-declude-sender
          :x-declude-spoolname:x-declude-refid:x-declude-note
          :x-declude-scan:x-declude-tests:x-country-chain:x-declude-code
          :x-helo:x-identity;
        b=S3UJoduSCTl3GYkX4NSSPrfWBfgahMJ453SVHDEMm1Sp7ndgwtGwVclXRzLpuHyYv
          jeMuTUJc+foStPlu1PDvgaYoEMO8A/WyYD2Bo5bLx/jKaUF1K6R1ay4OXLfUwu5tQ
          CZgbNp6oO97LtPTwRpKYcTP+GmYKo1Rukk5Z1hseA=
Received: from mail-vc0-f169.google.com (mail-vc0-f169.google.com [209.85.220.169]) by elysmail.net with SMTP;
   Mon, 31 Dec 2012 17:24:33 +0100
Received: by mail-vc0-f169.google.com with SMTP id gb23so13118934vcb.28
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 08:24:33 -0800 (PST)
Received: by 10.52.29.40 with SMTP id g8mr9929702vdh.58.1356971073683; Mon, 31
 Dec 2012 08:24:33 -0800 (PST)
Received: by 10.52.65.233 with HTTP; Mon, 31 Dec 2012 08:24:11 -0800 (PST)
X-Declude-Sender: gpakosz@visionobjects.com [209.85.220.169]
X-Declude-Spoolname: 21157642.eml
X-Declude-RefID: 
X-Declude-Note: Scanned by Declude 4.10.59 "http://www.declude.com/x-note.htm"
X-Declude-Scan: Outgoing Score [0] at 17:24:34 on 31 Dec 2012
X-Declude-Tests: Whitelisted
X-Country-Chain: 
X-Declude-Code: 0
X-HELO: mail-vc0-f169.google.com
X-Identity: 209.85.220.169 |  | vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212353>

--20cf307ca418d141d504d22872a9
Content-Type: text/plain; charset=ISO-8859-1

Please disregard the previous email that contains an incorrect fix
suggestion. I wish my first contribution was flawless.

Here is what's happening.
git-filter-branch let git-update-ref -d verify that the value for $ref
matches $sha1.
However, when $ref points to an annotated tag that is being deleted,
that verification fails because $sha1 is the commit underneath.

I think there are two possible fixes:
  1) either make git-filter-branch dereference annotated tags and do
the verification itself then use the two arguments version of git
update-ref
  2) in the case of an annotated tag, pass another <old value> to git update-ref

Please find below a patch that implements solution 1). Please note the
patch doesn't contain a unit test for this situation as I wasn't sure
how to provide one. Yet I tested it on the repository I'm working on.

Gregory

>From 9d21960088a61bfbac1ffdb4b13e3038f88ab4d6 Mon Sep 17 00:00:00 2001
From: Gregory Pakosz <gpakosz@visionobjects.com>
Date: Mon, 31 Dec 2012 15:30:36 +0100
Subject: [PATCH] git-filter-branch: support annotated tags deletion

git-filter-branch let git-update-ref -d verify that the value for $ref matches
$sha1. However, when $ref is an annotated tag being deleted that verfication
fails because $sha1 corresponds to a commit object.

Instead of asking git-update-ref to verify values actually match, dereference
$ref ourselves and test against $sha1 first. Then invoke git-update-ref with two
arguments.

Signed-off-by: Gregory Pakosz <gpakosz@visionobjects.com>
---
 git-filter-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 5314249..bbee6d0 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -383,7 +383,7 @@ do
 	case "$rewritten" in
 	'')
 		echo "Ref '$ref' was deleted"
-		git update-ref -m "filter-branch: delete" -d "$ref" $sha1 ||
+		test $(git rev-parse --verify "$ref^{commit}") = $sha1 && git
update-ref -m "filter-branch: delete" -d "$ref" ||
 			die "Could not delete $ref"
 	;;
 	$_x40)
-- 
1.8.0.1

--20cf307ca418d141d504d22872a9
Content-Type: application/octet-stream; 
	name="0001-git-filter-branch-support-annotated-tags-deletion.patch"
Content-Disposition: attachment; 
	filename="0001-git-filter-branch-support-annotated-tags-deletion.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hbdteqaf0

RnJvbSA5ZDIxOTYwMDg4YTYxYmZiYWMxZmZkYjRiMTNlMzAzOGY4OGFiNGQ2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHcmVnb3J5IFBha29zeiA8Z3Bha29zekB2aXNpb25vYmplY3Rz
LmNvbT4KRGF0ZTogTW9uLCAzMSBEZWMgMjAxMiAxNTozMDozNiArMDEwMApTdWJqZWN0OiBbUEFU
Q0hdIGdpdC1maWx0ZXItYnJhbmNoOiBzdXBwb3J0IGFubm90YXRlZCB0YWdzIGRlbGV0aW9uCgpn
aXQtZmlsdGVyLWJyYW5jaCBsZXQgZ2l0LXVwZGF0ZS1yZWYgLWQgdmVyaWZ5IHRoYXQgdGhlIHZh
bHVlIGZvciAkcmVmIG1hdGNoZXMKJHNoYTEuIEhvd2V2ZXIsIHdoZW4gJHJlZiBpcyBhbiBhbm5v
dGF0ZWQgdGFnIGJlaW5nIGRlbGV0ZWQgdGhhdCB2ZXJmaWNhdGlvbgpmYWlscyBiZWNhdXNlICRz
aGExIGNvcnJlc3BvbmRzIHRvIGEgY29tbWl0IG9iamVjdC4KCkluc3RlYWQgb2YgYXNraW5nIGdp
dC11cGRhdGUtcmVmIHRvIHZlcmlmeSB2YWx1ZXMgYWN0dWFsbHkgbWF0Y2gsIGRlcmVmZXJlbmNl
CiRyZWYgb3Vyc2VsdmVzIGFuZCB0ZXN0IGFnYWluc3QgJHNoYTEgZmlyc3QuIFRoZW4gaW52b2tl
IGdpdC11cGRhdGUtcmVmIHdpdGggdHdvCmFyZ3VtZW50cy4KClNpZ25lZC1vZmYtYnk6IEdyZWdv
cnkgUGFrb3N6IDxncGFrb3N6QHZpc2lvbm9iamVjdHMuY29tPgotLS0KIGdpdC1maWx0ZXItYnJh
bmNoLnNoIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvZ2l0LWZpbHRlci1icmFuY2guc2ggYi9naXQtZmlsdGVyLWJyYW5j
aC5zaAppbmRleCA1MzE0MjQ5Li5iYmVlNmQwIDEwMDc1NQotLS0gYS9naXQtZmlsdGVyLWJyYW5j
aC5zaAorKysgYi9naXQtZmlsdGVyLWJyYW5jaC5zaApAQCAtMzgzLDcgKzM4Myw3IEBAIGRvCiAJ
Y2FzZSAiJHJld3JpdHRlbiIgaW4KIAknJykKIAkJZWNobyAiUmVmICckcmVmJyB3YXMgZGVsZXRl
ZCIKLQkJZ2l0IHVwZGF0ZS1yZWYgLW0gImZpbHRlci1icmFuY2g6IGRlbGV0ZSIgLWQgIiRyZWYi
ICRzaGExIHx8CisJCXRlc3QgJChnaXQgcmV2LXBhcnNlIC0tdmVyaWZ5ICIkcmVmXntjb21taXR9
IikgPSAkc2hhMSAmJiBnaXQgdXBkYXRlLXJlZiAtbSAiZmlsdGVyLWJyYW5jaDogZGVsZXRlIiAt
ZCAiJHJlZiIgfHwKIAkJCWRpZSAiQ291bGQgbm90IGRlbGV0ZSAkcmVmIgogCTs7CiAJJF94NDAp
Ci0tIAoxLjguMC4xCgo=
--20cf307ca418d141d504d22872a9--
