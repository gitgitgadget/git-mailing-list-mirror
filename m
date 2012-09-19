From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: t1450-fsck (sometimes/often) failes on Mac OS X
Date: Wed, 19 Sep 2012 22:23:59 +0200
Message-ID: <505A29DF.6030501@web.de>
References: <5001644F.10901@web.de> <20120715090849.GB18385@sigill.intra.peff.net> <5059ED25.9090002@web.de> <7va9wlhnl3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 22:24:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEQoh-0006oY-0S
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 22:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626Ab2ISUYF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Sep 2012 16:24:05 -0400
Received: from mout.web.de ([212.227.17.12]:54882 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510Ab2ISUYE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 16:24:04 -0400
Received: from birne.lan ([195.67.191.22]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0McWnE-1Swtvc0EjY-00Hq9Q; Wed, 19 Sep 2012 22:24:00 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <7va9wlhnl3.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:9ihHD3zW5+LCH6P/9iviBmiIRfuwh+o3Clhr0bkXDA6
 /aE+HQ5n8lX4gZ57drY3gf1tMNKWIkktFFfuWsEwmI6GJvAk13
 j6HdEJm8iRE5MFN/JLWL4rTiAxEoVz6UA+BB/SB1/KkjLYLNt9
 xF30cUzcZVHwWPQnHO3hEKZSpXfpfLR22IA+QxOfj3E8DcD81D
 AXl4l1xn+xHyXIzTmCi9w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205994>

Thanks Junio,
and all readers
commenst and answers are inline

On 19.09.12 20:30, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>>>> Linux:
>>>> error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a blob, =
not a commit
>>>> error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: broken link=
s
>>>> error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: could not l=
oad tagged object
>>>>
>>>> Mac OS X:
>>>> error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a commit=
, not a blob
>>>> error: 63499e4ea8e096b831515ceb1d5a7593e4d87ae5: object corrupt or=
 missing
>=20
> Interesting difference.
>=20
>>> That seems very broken. That sha1 can have only one type, so OS X i=
s
>>> actually mis-parsing the object type? Weird. I would suggest a memo=
ry
>>> error or race condition, but the test is valgrind-clean, and fsck s=
hould
>>> not be threaded at all.
>=20
> "is a blob, not a commit" is likely to come from validating of the
> tag 66f6581d that presumably point at 63499e4; it reads the tag,
> learns the name of the object that is tagged and the type of it,
> remembers that the object pointed at (which it hasn't and is going
> to validate next) _must_ be a commit (because tag says so) and then
> realizes when it reads 63499e4 it is a blob and barfs.
>=20
> And that is what _should_ happen in that test.  It crafts a
> malformed tag that points at a blob and claims that it is a commit.
> The test makes sure fsck catches that, and it does.
>=20
> On the other hand, "is a commit, not a blob", unless you have a tag
> that directly points at a blob, is more likely to come from
> validating some tree object.  It reads the tree, learns the name of
> the object contained in the tree and infers the type of that object
> from the mode bits in the tree (100644 or 100755 would mean the
> object must be a blob), goes on to validate that object and realizes
> it is a commit and barfs.
Sorry for not knowing better and asking stupid questions.
"Reads the tree", does it mean "read the index file" and put all object=
s into memory
or does it mean "scan the file system using readdir()"
Or is both done?

It looks as if there is a different execution order (wild speculation)

>=20
> It is veriy unusual to get, even on two different platforms, both
> messages for the same object.
>=20
> Could it be that you have i18n on "Object %s is a %s, not a %s" with
> a wrong .po file that swaps the latter two parameters in the output?
I'm using=20
LANG=3Den_US.UTF-8

>=20
>>> What does "git show 63499e4" show when the test has failed?
>=20
> Was this question ever answered (I would prever "cat-file -t"
> followed by "cat-file <type>" instead of "show" for things like
> this)?  It should show that it is a blob whose contents is "blob\n".

The question was never answered - I recently learnt that 63499e4 has be=
en removed by this line:=20
	test_when_finished "remove_object $sha" &&
And when I remove that line in the modified test case, I get:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Mac OS X, failed
--------------
find . -name "499e4*"=20
=2E/.git/objects/63/499e4ea8e096b831515ceb1d5a7593e4d87ae5

find . -name "499e4*" | xargs xxd
0000000: 7801 4bca c94f 5230 6548 0252 5c00 1938  x.K..OR0eH.R\..8
0000010: 039e                                     ..

git show 63499e4
blob

git cat-file -t 63499e4
blob

git cat-file blob 63499e4
blob
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Mac OS X passed
---------------
~/projects/git/git.next/t/trash_directory.t1450-fsck2_120919_214913> ..=
/../../errors_on_master/1450/junio.sh
find . -name "499e4*"=20
=2E/.git/objects/63/499e4ea8e096b831515ceb1d5a7593e4d87ae5

find . -name "499e4*" | xargs xxd
0000000: 7801 4bca c94f 5230 6548 0252 5c00 1938  x.K..OR0eH.R\..8
0000010: 039e                                     ..

git show 63499e4
blob

git cat-file -t 63499e4
blob

git cat-file blob 63499e4
blob

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Linux failed
----------
find . -name "499e4*"=20
=2E/.git/objects/63/499e4ea8e096b831515ceb1d5a7593e4d87ae5

find . -name "499e4*" | xargs xxd
0000000: 7801 4bca c94f 5230 6548 0252 5c00 1938  x.K..OR0eH.R\..8
0000010: 039e                                     ..

git show 63499e4
blob

git cat-file -t 63499e4
blob

git cat-file blob 63499e4
blob
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
So unless I'm too tired to see, there doesn't seem to be a difference
[snip]
>>
>> diff failed passed
>> diff out ../../../git.next/t/trash_directory.t1450-fsck2_120912_2053=
05/out
>> 17a18,20
>>> Checking blob 5626abf0f72e58d7a153368ba57db4c673c0e171
>>> Checking blob 63499e4ea8e096b831515ceb1d5a7593e4d87ae5
>>> error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a blob, n=
ot a commit
>=20
> This is the correct behaviour.
>=20
>> 18a22,23
>>> error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: broken links
>>> error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: could not lo=
ad tagged object
>=20
> This too.
>=20
>> 20,22d24
>> < Checking blob 5626abf0f72e58d7a153368ba57db4c673c0e171
>> < error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a commit=
, not a blob
>> < error: 63499e4ea8e096b831515ceb1d5a7593e4d87ae5: object corrupt or=
 missing

OK, both are correct. But why isn't the "broken links" not detected?
Does fsck stop in one case, but continue in the other?

/Torsten
