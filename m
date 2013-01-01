From: =?ISO-8859-1?Q?Gr=E9gory_Pakosz?= <gpakosz@visionobjects.com>
Subject: Re: git filter-branch doesn't dereference annotated tags
Date: Tue, 1 Jan 2013 14:11:42 +0100
Message-ID: <CAC_01E3twtNq8YXQ8=SU5oXxmnAQS43L-46NF=7RyT4tFQvU5g@mail.gmail.com>
References: <CAC_01E174m_6tDwPKZ5P0BUxnLNWUf9p+VkECFosPTzip0sYsA@mail.gmail.com>
 <7vsj6mdqeo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=e89a8f50351e25bcb904d239e0b4
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 14:12:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq1dx-0000nn-Tm
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 14:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239Ab3AANMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 08:12:15 -0500
Received: from mail.elysmail.net ([188.165.34.231]:57016 "EHLO elysmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752215Ab3AANMN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 08:12:13 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=visionobjects.com; s=vo2010objects;
        h=received:received:received:mime-version:received:in-reply-to
          :references:from:date:message-id:subject:to:cc:content-type
          :x-declude-sender:x-declude-spoolname:x-declude-refid
          :x-declude-note:x-declude-scan:x-declude-tests:x-country-chain
          :x-declude-code:x-helo:x-identity;
        b=iVd6S3fE9LQytKNYjgYBUt1lopA+MRFCuFZUpur953kQ41zc+pKQgZv3ib3zY1CPu
          Jg1hiCnfgOZlgwyuCgAUeyrD8Mx53TeEnOvWR5sarImMVLhSot3wODAtcehdPkjEg
          BqOQMBc2JD9YWU7ThMVrECmonpC6Rstg7yXY5GoME=
Received: from mail-ie0-f172.google.com (mail-ie0-f172.google.com [209.85.223.172]) by elysmail.net with SMTP;
   Tue, 1 Jan 2013 14:12:02 +0100
Received: by mail-ie0-f172.google.com with SMTP id c13so16014637ieb.3
        for <git@vger.kernel.org>; Tue, 01 Jan 2013 05:12:02 -0800 (PST)
Received: by 10.50.1.169 with SMTP id 9mr32227541ign.101.1357045922380; Tue,
 01 Jan 2013 05:12:02 -0800 (PST)
Received: by 10.50.154.3 with HTTP; Tue, 1 Jan 2013 05:11:42 -0800 (PST)
In-Reply-To: <7vsj6mdqeo.fsf@alter.siamese.dyndns.org>
X-Declude-Sender: gpakosz@visionobjects.com [209.85.223.172]
X-Declude-Spoolname: 21161460.eml
X-Declude-RefID: 
X-Declude-Note: Scanned by Declude 4.10.59 "http://www.declude.com/x-note.htm"
X-Declude-Scan: Outgoing Score [0] at 14:12:04 on 01 Jan 2013
X-Declude-Tests: Whitelisted
X-Country-Chain: 
X-Declude-Code: 0
X-HELO: mail-ie0-f172.google.com
X-Identity: 209.85.223.172 |  | vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212423>

--e89a8f50351e25bcb904d239e0b4
Content-Type: text/plain; charset=ISO-8859-1

> Thanks.  A few comments.
>
> At the design level.  Where does this $sha1 come from in the first
> place?
>
actually, sha1=$(git rev-parse "$ref"^0)
(please remember that I'm discovering git internals while figuring out
how to make git filter-branch work in my use case)

in my use case, $ref is "refs/tags/4.0" which is an annotated tag

$ git rev-parse "refs/tags/4.0"
e941b1999906c17b59320f776d58b71fc2fcdb72

$ git cat-file -t e941b1999906c17b59320f776d58b71fc2fcdb72
tag

$ git rev-parse e941b1999906c17b59320f776d58b71fc2fcdb72^0
dcd7cdc18240dd9a54b30d757dd2347f52040490

$ git cat-file -t dcd7cdc18240dd9a54b30d757dd2347f52040490
commit

so $sha1 is dcd7cdc18240dd9a54b30d757dd2347f52040490

and then git-filter-branch calls git update-ref -m "filter-branch:
delete" -d "refs/tags/4.0" dcd7cdc18240dd9a54b30d757dd2347f52040490
which makes git update-index complains
e941b1999906c17b59320f776d58b71fc2fcdb72 !=
dcd7cdc18240dd9a54b30d757dd2347f52040490

so hmm, adding test $(git rev-parse --verify "$ref^{commit}") = $sha1
as I did in my patch is always true since sha1=$(git rev-parse
"$ref"^0)

>  If a ref that named the annotated tag was deleted, shouldn't
> we arrange things so this part of the code receives the $sha1 of the
> tag that corresponds to the $ref
>
I'm not sure what you mean by "a ref that named the annotated tag was deleted"
What's happening in my situation is that the commit the tag points to
gets rewritten to nothing as the result of my filtering:
"refs/tags/4.0" points to e941b1999906c17b59320f776d58b71fc2fcdb72
(tag) which points to dcd7cdc18240dd9a54b30d757dd2347f52040490
(commit) which gets rewritten to nothing so the tag must be deleted.

> so that "update-ref -d" can check
> that nobody tampered with the repository while the script was
> working?
>
I'm not quite sure what could possibly go well if somebody tampers
with the repository while it's being filtered with git filter-branch
anyways???

If we want to address "did somebody tamper with the repository while
the script was working?", then test $(git rev-parse --verify
"$ref^{commit}") = $sha1 verifies somebody didn't tamper with $ref
since we got $sha1 from it.
But that doesn't ensure tampering didn't take place in between
  test $(git rev-parse --verify "$ref^{commit}") = $sha1
and
  git update-ref -m "filter-branch: delete" -d "$ref".

How defensive should git filter-branch really be?

> At the implementation level.  When the ref being deleted pointed at
> a tree or a blob, the original would have correctly removed it, but
> will the updated one?
>
Yes.

Now that you made me think about it even more, the title of that
thread isn't "git filter-branch doesn't dereference annotated tags".
It in fact does as per sha1=$(git rev-parse "$ref"^0).

Maybe the suggested fix should be: in case the tag points to a commit
that has been rewritten to nothing, get $sha1 again without
dereferencing recursively with sha1=$(git rev-parse "$ref") then use
the 3 arguments versions of git update-ref as before.

Thanks for reading
Gregory

>From 59f86c9c07715734d59009c15816220f996b75be Mon Sep 17 00:00:00 2001
From: Gregory Pakosz <gpakosz@visionobjects.com>
Date: Mon, 31 Dec 2012 15:30:36 +0100
Subject: [PATCH] git-filter-branch: support annotated tags deletion

git-filter-branch let git-update-ref -d verify that the value for $ref matches
$sha1. $sha1 is obtained form dereferencing $ref recursively. In case $sha1 gets
rewritten to nothing as per result of the filtering, the tag should be deleted.
However, in case of an annotated tag, git-update-ref -d fails because $ref
doesn't directly point to $sha1.

To make git-filter-branch properly delete an annotated tag, obtain $sha1 again
withouth dereferencing the tag before asking git-update-ref to verify $ref and
$sha1 match.

Signed-off-by: Gregory Pakosz <gpakosz@visionobjects.com>
---
 git-filter-branch.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 5314249..7ae9912 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -383,6 +383,7 @@ do
 	case "$rewritten" in
 	'')
 		echo "Ref '$ref' was deleted"
+		test $(git cat-file -t "$ref") = 'tag' && sha1=$(git rev-parse "$ref")
 		git update-ref -m "filter-branch: delete" -d "$ref" $sha1 ||
 			die "Could not delete $ref"
 	;;
-- 
1.8.0.1

--e89a8f50351e25bcb904d239e0b4
Content-Type: application/octet-stream; 
	name="0001-git-filter-branch-support-annotated-tags-deletion.patch"
Content-Disposition: attachment; 
	filename="0001-git-filter-branch-support-annotated-tags-deletion.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hbf226pt0

RnJvbSA1OWY4NmM5YzA3NzE1NzM0ZDU5MDA5YzE1ODE2MjIwZjk5NmI3NWJlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHcmVnb3J5IFBha29zeiA8Z3Bha29zekB2aXNpb25vYmplY3Rz
LmNvbT4KRGF0ZTogTW9uLCAzMSBEZWMgMjAxMiAxNTozMDozNiArMDEwMApTdWJqZWN0OiBbUEFU
Q0hdIGdpdC1maWx0ZXItYnJhbmNoOiBzdXBwb3J0IGFubm90YXRlZCB0YWdzIGRlbGV0aW9uCgpn
aXQtZmlsdGVyLWJyYW5jaCBsZXQgZ2l0LXVwZGF0ZS1yZWYgLWQgdmVyaWZ5IHRoYXQgdGhlIHZh
bHVlIGZvciAkcmVmIG1hdGNoZXMKJHNoYTEuICRzaGExIGlzIG9idGFpbmVkIGZvcm0gZGVyZWZl
cmVuY2luZyAkcmVmIHJlY3Vyc2l2ZWx5LiBJbiBjYXNlICRzaGExIGdldHMKcmV3cml0dGVuIHRv
IG5vdGhpbmcgYXMgcGVyIHJlc3VsdCBvZiB0aGUgZmlsdGVyaW5nLCB0aGUgdGFnIHNob3VsZCBi
ZSBkZWxldGVkLgpIb3dldmVyLCBpbiBjYXNlIG9mIGFuIGFubm90YXRlZCB0YWcsIGdpdC11cGRh
dGUtcmVmIC1kIGZhaWxzIGJlY2F1c2UgJHJlZgpkb2Vzbid0IGRpcmVjdGx5IHBvaW50IHRvICRz
aGExLgoKVG8gbWFrZSBnaXQtZmlsdGVyLWJyYW5jaCBwcm9wZXJseSBkZWxldGUgYW4gYW5ub3Rh
dGVkIHRhZywgb2J0YWluICRzaGExIGFnYWluCndpdGhvdXRoIGRlcmVmZXJlbmNpbmcgdGhlIHRh
ZyBiZWZvcmUgYXNraW5nIGdpdC11cGRhdGUtcmVmIHRvIHZlcmlmeSAkcmVmIGFuZAokc2hhMSBt
YXRjaC4KClNpZ25lZC1vZmYtYnk6IEdyZWdvcnkgUGFrb3N6IDxncGFrb3N6QHZpc2lvbm9iamVj
dHMuY29tPgotLS0KIGdpdC1maWx0ZXItYnJhbmNoLnNoIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9naXQtZmlsdGVyLWJyYW5jaC5zaCBiL2dpdC1m
aWx0ZXItYnJhbmNoLnNoCmluZGV4IDUzMTQyNDkuLjdhZTk5MTIgMTAwNzU1Ci0tLSBhL2dpdC1m
aWx0ZXItYnJhbmNoLnNoCisrKyBiL2dpdC1maWx0ZXItYnJhbmNoLnNoCkBAIC0zODMsNiArMzgz
LDcgQEAgZG8KIAljYXNlICIkcmV3cml0dGVuIiBpbgogCScnKQogCQllY2hvICJSZWYgJyRyZWYn
IHdhcyBkZWxldGVkIgorCQl0ZXN0ICQoZ2l0IGNhdC1maWxlIC10ICIkcmVmIikgPSAndGFnJyAm
JiBzaGExPSQoZ2l0IHJldi1wYXJzZSAiJHJlZiIpCiAJCWdpdCB1cGRhdGUtcmVmIC1tICJmaWx0
ZXItYnJhbmNoOiBkZWxldGUiIC1kICIkcmVmIiAkc2hhMSB8fAogCQkJZGllICJDb3VsZCBub3Qg
ZGVsZXRlICRyZWYiCiAJOzsKLS0gCjEuOC4wLjEKCg==
--e89a8f50351e25bcb904d239e0b4--
