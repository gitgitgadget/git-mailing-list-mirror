From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: Re: CGIT 0.8.3.1 "chokes" on some bare repos
Date: Tue, 3 Aug 2010 22:20:12 +0200
Message-ID: <AANLkTimNyLBjVe+sWRJ+=eidazE-JP6Rshk1XzhrBCG3@mail.gmail.com>
References: <90e6ba53a8a0a88e46048cee6566@google.com>
	<AANLkTinDPa7ngcTEfYC8k2O3hwkYszEUsb3pZqnuOSo2@mail.gmail.com>
	<AANLkTindiOoy-4W5DJ9AGa8q29Tsm9P8K_4TEgRfmJW=@mail.gmail.com>
	<AANLkTin6+X=nTTqLG=xCYDSPKWX3CVPTxAhzDM9uKMW5@mail.gmail.com>
	<AANLkTi=Ho=ZiOpMszSEWTjY=PKg9AHp9wY-jxcd3H_jG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001485f629ca6214c3048cf10b5d
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 22:20:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgNyJ-0001sz-1Z
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 22:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757650Ab0HCUUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 16:20:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56401 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466Ab0HCUUO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 16:20:14 -0400
Received: by fxm14 with SMTP id 14so2145020fxm.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 13:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=tLGOAlR3tnVXNKytHQn8HmFCgjVDPvNem6qzS3Uq5kk=;
        b=mEcsafm/6jlDQ0eiYRvsFrbmxmgRoNGeFJtz3TmeGAP+gv+Vl9voRnpVvZ8V+w5EG+
         M2V7Vqlf0rBIhZ3035J4HDHU798sQ60f9BFlukNTuzjkV+pEQhvozcyFpBtBUgxS0kyM
         ygZMrIFW9sycHE9gq04GlP2ocPLcRTDquALW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jUEjPL5x891NeI8mY3bnGBfm089q3qvo8mo0cOgDXfQ3FpO82ELxTt2V8HRAI07AcY
         Q0M6OpB3VMk8QJL/KqKyY+EhoMb9sH0MlAdY1V1PG0diadxCLBSxrdUpnABKuh6lnT97
         UFKWAGAUuUkVkIgW+gs8VSaj/6TzLSd4Jd9T0=
Received: by 10.239.165.84 with SMTP id w20mr291043hbd.193.1280866812826; Tue, 
	03 Aug 2010 13:20:12 -0700 (PDT)
Received: by 10.239.165.79 with HTTP; Tue, 3 Aug 2010 13:20:12 -0700 (PDT)
In-Reply-To: <AANLkTi=Ho=ZiOpMszSEWTjY=PKg9AHp9wY-jxcd3H_jG@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152537>

--001485f629ca6214c3048cf10b5d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 3, 2010 at 21:34, Eugene Sajine <euguess@gmail.com> wrote:
> It segfaults:
>
> #0 =C2=A00x080538fa in cmp_tag_age (a=3D0x8bcc760, b=3D0x8bcc764) at ui-r=
efs.c:52

Great, thanks for pinpointing the bug. Could you test if the following
patch fixes the problem? I've also attached it since gmail tend to
damage patches...

---snip---
From: Lars Hjemli <hjemli@gmail.com>
Date: Tue, 3 Aug 2010 22:06:21 +0200
Subject: [PATCH] ui-refs.c: avoid segfault on unparsed ref objects

When a ref refers to something other then a commit or tag object, cgit
could segfault when trying to display the ref info.

Noticed-by: Eugene Sajine <euguess@gmail.com>
Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 ui-refs.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/ui-refs.c b/ui-refs.c
index d3b4f6e..6571cc4 100644
--- a/ui-refs.c
+++ b/ui-refs.c
@@ -42,23 +42,25 @@ static int cmp_branch_age(const void *a, const void *b)
 	return cmp_age(r1->commit->committer_date, r2->commit->committer_date);
 }

+static int get_ref_age(struct refinfo *ref)
+{
+	if (!ref->object)
+		return 0;
+	switch (ref->object->type) {
+	case OBJ_TAG:
+		return ref->tag ? ref->tag->tagger_date : 0;
+	case OBJ_COMMIT:
+		return ref->commit ? ref->commit->committer_date : 0;
+	}
+	return 0;
+}
+
 static int cmp_tag_age(const void *a, const void *b)
 {
 	struct refinfo *r1 =3D *(struct refinfo **)a;
 	struct refinfo *r2 =3D *(struct refinfo **)b;
-	int r1date, r2date;
-
-	if (r1->object->type !=3D OBJ_COMMIT)
-		r1date =3D r1->tag->tagger_date;
-	else
-		r1date =3D r1->commit->committer_date;
-
-	if (r2->object->type !=3D OBJ_COMMIT)
-		r2date =3D r2->tag->tagger_date;
-	else
-		r2date =3D r2->commit->committer_date;

-	return cmp_age(r1date, r2date);
+	return cmp_age(get_ref_age(r1), get_ref_age(r2));
 }

 static int print_branch(struct refinfo *ref)
--=20
1.7.1

--001485f629ca6214c3048cf10b5d
Content-Type: application/octet-stream; 
	name="0001-ui-refs.c-avoid-segfault-on-unparsed-ref-objects.patch"
Content-Disposition: attachment; 
	filename="0001-ui-refs.c-avoid-segfault-on-unparsed-ref-objects.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcf6y4fh1

RnJvbSAzNjg3YmUyMGJjNGFiZjBjMGMxOTdkNjE3YWZhYTNhNzE3YjFhYjljIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMYXJzIEhqZW1saSA8aGplbWxpQGdtYWlsLmNvbT4KRGF0ZTog
VHVlLCAzIEF1ZyAyMDEwIDIyOjA2OjIxICswMjAwClN1YmplY3Q6IFtQQVRDSF0gdWktcmVmcy5j
OiBhdm9pZCBzZWdmYXVsdCBvbiB1bnBhcnNlZCByZWYgb2JqZWN0cwoKV2hlbiBhIHJlZiByZWZl
cnMgdG8gc29tZXRoaW5nIG90aGVyIHRoZW4gYSBjb21taXQgb3IgdGFnIG9iamVjdCwgY2dpdApj
b3VsZCBzZWdmYXVsdCB3aGVuIHRyeWluZyB0byBkaXNwbGF5IHRoZSByZWYgaW5mby4KCk5vdGlj
ZWQtYnk6IEV1Z2VuZSBTYWppbmUgPGV1Z3Vlc3NAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBM
YXJzIEhqZW1saSA8aGplbWxpQGdtYWlsLmNvbT4KLS0tCiB1aS1yZWZzLmMgfCAgIDI2ICsrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyks
IDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3VpLXJlZnMuYyBiL3VpLXJlZnMuYwppbmRl
eCBkM2I0ZjZlLi42NTcxY2M0IDEwMDY0NAotLS0gYS91aS1yZWZzLmMKKysrIGIvdWktcmVmcy5j
CkBAIC00MiwyMyArNDIsMjUgQEAgc3RhdGljIGludCBjbXBfYnJhbmNoX2FnZShjb25zdCB2b2lk
ICphLCBjb25zdCB2b2lkICpiKQogCXJldHVybiBjbXBfYWdlKHIxLT5jb21taXQtPmNvbW1pdHRl
cl9kYXRlLCByMi0+Y29tbWl0LT5jb21taXR0ZXJfZGF0ZSk7CiB9CiAKK3N0YXRpYyBpbnQgZ2V0
X3JlZl9hZ2Uoc3RydWN0IHJlZmluZm8gKnJlZikKK3sKKwlpZiAoIXJlZi0+b2JqZWN0KQorCQly
ZXR1cm4gMDsKKwlzd2l0Y2ggKHJlZi0+b2JqZWN0LT50eXBlKSB7CisJY2FzZSBPQkpfVEFHOgor
CQlyZXR1cm4gcmVmLT50YWcgPyByZWYtPnRhZy0+dGFnZ2VyX2RhdGUgOiAwOworCWNhc2UgT0JK
X0NPTU1JVDoKKwkJcmV0dXJuIHJlZi0+Y29tbWl0ID8gcmVmLT5jb21taXQtPmNvbW1pdHRlcl9k
YXRlIDogMDsKKwl9CisJcmV0dXJuIDA7Cit9CisKIHN0YXRpYyBpbnQgY21wX3RhZ19hZ2UoY29u
c3Qgdm9pZCAqYSwgY29uc3Qgdm9pZCAqYikKIHsKIAlzdHJ1Y3QgcmVmaW5mbyAqcjEgPSAqKHN0
cnVjdCByZWZpbmZvICoqKWE7CiAJc3RydWN0IHJlZmluZm8gKnIyID0gKihzdHJ1Y3QgcmVmaW5m
byAqKiliOwotCWludCByMWRhdGUsIHIyZGF0ZTsKLQotCWlmIChyMS0+b2JqZWN0LT50eXBlICE9
IE9CSl9DT01NSVQpCi0JCXIxZGF0ZSA9IHIxLT50YWctPnRhZ2dlcl9kYXRlOwotCWVsc2UKLQkJ
cjFkYXRlID0gcjEtPmNvbW1pdC0+Y29tbWl0dGVyX2RhdGU7Ci0KLQlpZiAocjItPm9iamVjdC0+
dHlwZSAhPSBPQkpfQ09NTUlUKQotCQlyMmRhdGUgPSByMi0+dGFnLT50YWdnZXJfZGF0ZTsKLQll
bHNlCi0JCXIyZGF0ZSA9IHIyLT5jb21taXQtPmNvbW1pdHRlcl9kYXRlOwogCi0JcmV0dXJuIGNt
cF9hZ2UocjFkYXRlLCByMmRhdGUpOworCXJldHVybiBjbXBfYWdlKGdldF9yZWZfYWdlKHIxKSwg
Z2V0X3JlZl9hZ2UocjIpKTsKIH0KIAogc3RhdGljIGludCBwcmludF9icmFuY2goc3RydWN0IHJl
ZmluZm8gKnJlZikKLS0gCjEuNy4xCgo=
--001485f629ca6214c3048cf10b5d--
