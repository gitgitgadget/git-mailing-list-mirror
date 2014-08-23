From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [BUG] resolved deltas
Date: Sat, 23 Aug 2014 12:12:08 +0200
Message-ID: <53F868F8.9080000@web.de>
References: <53F5D98F.4040700@redhat.com> <53F79CE3.60803@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Martin von Gagern <Martin.vGagern@gmx.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 12:12:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XL8JH-00022Y-5Z
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 12:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396AbaHWKMb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Aug 2014 06:12:31 -0400
Received: from mout.web.de ([212.227.15.14]:50174 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752190AbaHWKM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2014 06:12:29 -0400
Received: from [192.168.178.27] ([79.253.170.74]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LdEif-1WdVtp1TDF-00iWiS; Sat, 23 Aug 2014 12:12:24
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <53F79CE3.60803@gmx.net>
X-Provags-ID: V03:K0:Fq5/cRdBWil0eLmCBynyy29+YTht1NbzpCL7ah4gBuNpZPBUKju
 mlBT39igqluhdcPMkwSwUihIhX/t50WnTSTjdsaEd6KfgEkVORZrPsSVNNjT/yeqmUviRn+
 m1YFNLu3mr/JkDqCGz0LnlnDp61sZJUsOjoY51MQSKLLzpmbj7b/NB3XaItUT2nP4naySps
 JPlHwdVX9jM9BbsS8yfZQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255743>

Am 22.08.2014 um 21:41 schrieb Martin von Gagern:
> On 21.08.2014 13:35, Petr Stodulka wrote:
>> Hi guys,
>> I wanted post you patch here for this bug, but I can't find primary
>> source of this problem [0], because I don't understand some ideas in=
 the
>> code.
>>
>> [=E2=80=A6]
>>
>> Any next ideas/hints or explanation of these functions? I began stud=
y
>> source code and mechanisms of the git this week, so don't beat me ye=
t
>> please :-)
>>
>> Regards,
>> Petr
>>
>> [0] https://bugzilla.redhat.com/show_bug.cgi?id=3D1099919
>=20
> Some pointers to related reports and investigations:
>=20
> https://groups.google.com/forum/#!topic/mapsforge-dev/IF6mgmwvZmY
> https://groups.google.com/forum/#!topic/mapsforge-dev/f2KvFALlkvo
> https://code.google.com/p/support/issues/detail?id=3D31571
> https://groups.google.com/forum/#!topic/mapsforge-dev/nomzr5dkkqc
> http://thread.gmane.org/gmane.comp.version-control.git/254626
>=20
> The last is my own bug report to this mailing list here, which
> unfortunately received no reaction yet. In that report, I can confirm
> that the commit introducing the assertion is the same commit which
> causes things to fail:
> https://github.com/git/git/commit/7218a215efc7ae46f7ca8d82442f354e
>=20
> In this https://code.google.com/p/mapsforge/ repository, resolve_delt=
a
> gets called twice for some delta. The first time, type and real_type =
are
> identical, but by the second pass in find_unresolved_deltas the real
> type will have chaned to OBJ_TREE. This caused the old code to simply
> scip the object, but the new code aborts instead.
>=20
> So far my understanding. I'm not sure whether this kind of duplicate
> resolution is something normal or indicates some breakage in the
> repository in question. But aborting seems a bad solution in either c=
ase.

Git 1.7.6 clones the repo without reporting an error or warning, but a
check shows that a tree object is missing:

  $ git clone https://code.google.com/p/mapsforge/
  Cloning into mapsforge...
  remote: Counting objects: 12879, done.
  Receiving objects: 100% (12879/12879), 10.19 MiB | 2.48 MiB/s, done.
  Resolving deltas: 100% (4349/4349), done.
  $ cd mapsforge/
  $ git fsck
  broken link from    tree eb95fb0268c43f512e2ce512e6625072acafbdb5
                to    tree a0155d8d5bb58afb9a5d20459be023899c9a1cef
  missing tree a0155d8d5bb58afb9a5d20459be023899c9a1cef
  dangling tree b6f32087526f43205bf8b5e6539936da787ecb1a

Git 2.1.0 hits an assertion:

  $ git clone https://code.google.com/p/mapsforge/
  Cloning into 'mapsforge'...
  remote: Counting objects: 12879, done.
  Receiving objects: 100% (12879/12879), 10.19 MiB | 2.53 MiB/s, done.
  git: builtin/index-pack.c:918: find_unresolved_deltas_1: Assertion `c=
hild->real_type =3D=3D OBJ_REF_DELTA' failed.
  error: index-pack died of signal 6
  fatal: index-pack failed

The patch below, which makes index-pack ignore objects with unexpected
real_type as before, changes the shown error message, but clone still
fails:

  $ git clone https://code.google.com/p/mapsforge/
  Cloning into 'mapsforge'...
  remote: Counting objects: 12879, done.
  Receiving objects: 100% (12879/12879), 10.19 MiB | 2.43 MiB/s, done.
  Resolving deltas: 100% (4348/4348), done.
  fatal: did not receive expected object a0155d8d5bb58afb9a5d20459be023=
899c9a1cef
  fatal: index-pack failed

Turning that fatal error into a warning get us a bit further:

  $ git clone https://code.google.com/p/mapsforge/
  Cloning into 'mapsforge'...
  remote: Counting objects: 12879, done.
  Receiving objects: 100% (12879/12879), 10.19 MiB | 2.38 MiB/s, done.
  Resolving deltas: 100% (4350/4350), done.
  warning: did not receive expected object a0155d8d5bb58afb9a5d20459be0=
23899c9a1cef
  fatal: The same object bc386be34bd4781f71bb68d72a6e0aee3124201e appea=
rs twice in the pack
  fatal: index-pack failed

Disabling strict checking (WRITE_IDX_STRICT) as well lets clone
succeed, but a check shows that a tree is missing, as wiht git 1.7.6:

  $ git clone https://code.google.com/p/mapsforge/
  Cloning into 'mapsforge'...
  remote: Counting objects: 12879, done.
  Receiving objects: 100% (12879/12879), 10.19 MiB | 2.37 MiB/s, done.
  Resolving deltas: 100% (4349/4349), done.
  warning: did not receive expected object a0155d8d5bb58afb9a5d20459be0=
23899c9a1cef
  Checking connectivity... done.
  $ cd mapsforge/
  $ git fsck
  Checking object directories: 100% (256/256), done.
  Checking objects: 100% (12879/12879), done.
  broken link from    tree eb95fb0268c43f512e2ce512e6625072acafbdb5
                to    tree a0155d8d5bb58afb9a5d20459be023899c9a1cef
  missing tree a0155d8d5bb58afb9a5d20459be023899c9a1cef

Cloning the repo with Egit works fine, but git fsck shows the same
results as above.

https://github.com/applantation/mapsforge has that missing tree
object, by the way.

OK, what now?  It's better to show an error message instead of
failing an assertion if a repo is found to be corrupt because the
issue is caused by external input.  I don't know if the patch
below may have any bad side effects, though, so no sign-off at
this time.

Allowing git to clone a broken repo sounds useful, up to point.
In this particular case older versions had no problem doing that,
so it seems worth supporting.

And how did the tree object went missing in the first place?

Ren=C3=A9
---
 builtin/index-pack.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 5568a5b..f7dc5b0 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -913,28 +913,33 @@ static struct base_data *find_unresolved_deltas_1=
(struct base_data *base,
=20
 	if (base->ref_first <=3D base->ref_last) {
 		struct object_entry *child =3D objects + deltas[base->ref_first].obj=
_no;
-		struct base_data *result =3D alloc_base_data();
=20
-		assert(child->real_type =3D=3D OBJ_REF_DELTA);
-		resolve_delta(child, base, result);
-		if (base->ref_first =3D=3D base->ref_last && base->ofs_last =3D=3D -=
1)
-			free_base_data(base);
+		if (child->real_type =3D=3D OBJ_REF_DELTA) {
+			struct base_data *result =3D alloc_base_data();
=20
-		base->ref_first++;
-		return result;
+			resolve_delta(child, base, result);
+			if (base->ref_first =3D=3D base->ref_last &&
+			    base->ofs_last =3D=3D -1)
+				free_base_data(base);
+
+			base->ref_first++;
+			return result;
+		}
 	}
=20
 	if (base->ofs_first <=3D base->ofs_last) {
 		struct object_entry *child =3D objects + deltas[base->ofs_first].obj=
_no;
-		struct base_data *result =3D alloc_base_data();
=20
-		assert(child->real_type =3D=3D OBJ_OFS_DELTA);
-		resolve_delta(child, base, result);
-		if (base->ofs_first =3D=3D base->ofs_last)
-			free_base_data(base);
+		if (child->real_type =3D=3D OBJ_OFS_DELTA) {
+			struct base_data *result =3D alloc_base_data();
=20
-		base->ofs_first++;
-		return result;
+			resolve_delta(child, base, result);
+			if (base->ofs_first =3D=3D base->ofs_last)
+				free_base_data(base);
+
+			base->ofs_first++;
+			return result;
+		}
 	}
=20
 	unlink_base_data(base);
--=20
2.1.0
