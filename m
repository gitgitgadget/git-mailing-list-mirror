From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: t1450-fsck (sometimes/often) failes on Mac OS X
Date: Wed, 19 Sep 2012 18:04:53 +0200
Message-ID: <5059ED25.9090002@web.de>
References: <5001644F.10901@web.de> <20120715090849.GB18385@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 19 18:05:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEMm6-0002wY-5h
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 18:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756563Ab2ISQFJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Sep 2012 12:05:09 -0400
Received: from mout.web.de ([212.227.15.4]:57534 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754200Ab2ISQFH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 12:05:07 -0400
Received: from wanderer.site ([195.67.191.22]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MZUnl-1SvJHw17wj-00KyDZ; Wed, 19 Sep 2012 18:05:05
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120825 Thunderbird/15.0
In-Reply-To: <20120715090849.GB18385@sigill.intra.peff.net>
X-Provags-ID: V02:K0:tEbvEs2s++90ib47x8GTlw4ezLGzbyqH/6v424Gqh44
 f8W6gMWCmnDn8KQ0T1hxWFjOnY20swbHX7vYwWrI9WuwtSDE6/
 BOsrn0qkKl3kA5eYOcdQh1cVMQI90iUZ9ibsiUeYfCEoV10ewa
 kIsu2Yyb/U8k9QadKUI8JcXkfYanX41TEOL70TlwRMQR5NsBm+
 aDyhICwU4PhWO9ebAI1+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205944>

On 07/15/2012 11:08 AM, Jeff King wrote:
> On Sat, Jul 14, 2012 at 02:21:35PM +0200, Torsten B=C3=B6gershausen w=
rote:
>
>> I saw the problem first on pu, some time ago,
>> but it dissappeared after cloning git.git into another directory.
>>
>> Now it appeared on next as well, so it's time to look a little bit d=
eeper.
>>
>> This test case of t1450 fails:
>> test_expect_success 'tag pointing to something else than its type' '
>
> I can't reproduce this failure; I tried both pu or next, on Linux and=
 OS
> X (10.7).
>
>> Linux:
>> error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a blob, no=
t a commit
>> error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: broken links
>> error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: could not loa=
d tagged object
>>
>> Mac OS X:
>> error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a commit, =
not a blob
>> error: 63499e4ea8e096b831515ceb1d5a7593e4d87ae5: object corrupt or m=
issing
>
> That seems very broken. That sha1 can have only one type, so OS X is
> actually mis-parsing the object type? Weird. I would suggest a memory
> error or race condition, but the test is valgrind-clean, and fsck sho=
uld
> not be threaded at all.
>
> What does "git show 63499e4" show when the test has failed? If you
> re-run "git fsck --tags", does it reproduce reliably (i.e., is it bog=
us
> data that something wrote to the object db, or is it good data being
> ruined during the reading process)?
>
>> I reverted the last change in fsck.c (Use the streaming interface), =
but that doesn't help
>>
>> Looking into the trash directory and looking at the files, we can se=
e that the .git/index is different
>> between Linux and Mac OS X.
>>
>> Is there a good way to debug the index file?
>
> git ls-files -s will dump the entries. But I'd expect them not to be
> byte-equivalent, because the index will contain things like mtimes fo=
r
> each entry, which will vary from run to run. Plus the error message
> above indicates something much more broken.
>
After some time, the problem is still there

When I make a fresh clone of git.git under Mac OS, 1450 passes.
After a while, running things like "git fetch && git checkout=20
origin/next && make clean && make test", it starts to fail.

(currently I have a couple of git repo-copies, t1450 fails in git.pu=20
and passes in git.next.
But that has nothing to do with next or pu)

When I run ssh into the Mac OS X machine, the test case passes even in =
pu.
Very strange, but reproducable.

Now things become more puzzled:
I managed to re-produce it on a Linux machine as well.
Using v1.7.12 and applying my i18.pathencoding patch,
t1450 fails on Linux, regardless if I use ssh or sit locally at the mac=
hine.

I make a new version of t1450-fsck.sh, called t1450-fsck2.sh
That uses git fsck --verbose, I add the log file here.
The short version:
- I can re-run the "git fsck", all files on disk have the same md5.
- The 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 has the same md5 as well
I added lots of printouts in git code, according to my understanding=20
63499  is checked/fsck'ed after being loaded into RAM, is that right?

=46or some reasons it is classified as "is a blob, not a commit" when i=
t=20
passes and "is a commit, not a blob" when it fails.

I want to debug when it is loaded into RAM, so that code is in=20
read-cache.c, isn't it?

Does anybody have a tool to debug the contents of the index file?
Even offline could help, I can send a bunch of files ;-)

And why doesn't fsck find the broken link?

Other ideas are welcome,
thanks everybody for reading/helping.
/Torsten

"out" after running git fsck --verbose --tags, t1450 failed
(no broken link)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Checking HEAD link
Checking object directory
Checking directory .git/objects/13
Checking directory .git/objects/15
Checking directory .git/objects/1b
Checking directory .git/objects/30
Checking directory .git/objects/35
Checking directory .git/objects/44
Checking directory .git/objects/56
Checking directory .git/objects/63
Checking directory .git/objects/66
Checking directory .git/objects/af
Checking directory .git/objects/b6
Checking directory .git/objects/bd
Checking directory .git/objects/c4
Checking directory .git/objects/c9
Checking directory .git/objects/f7
Checking tag 66f6581d549f70e05ca586bc2df5c15a95662c36
Checking commit 134756353796a5439d93586be27999eea3807a34
Checking blob 5626abf0f72e58d7a153368ba57db4c673c0e171
error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a commit, not=
=20
a blob
error: 63499e4ea8e096b831515ceb1d5a7593e4d87ae5: object corrupt or miss=
ing
Checking tree bd04fbdc74c1ad468ee1cc86d49860490ab3e6c7
Checking commit c9145d6720f85544cc4bb6009a2e541660aa156b
Checking tree c9176b0dd1a95c80ad8de21784b1eeffd3681f49
Checking blob f719efd430d52bcfc8566a43b2eb655688d38871
Checking cache tree
Checking connectivity (32 objects)
Checking 63499e4ea8e096b831515ceb1d5a7593e4d87ae5
Checking 66f6581d549f70e05ca586bc2df5c15a95662c36
Checking c9145d6720f85544cc4bb6009a2e541660aa156b
Checking c9176b0dd1a95c80ad8de21784b1eeffd3681f49
Checking 134756353796a5439d93586be27999eea3807a34
Checking 5626abf0f72e58d7a153368ba57db4c673c0e171
Checking f719efd430d52bcfc8566a43b2eb655688d38871
Checking bd04fbdc74c1ad468ee1cc86d49860490ab3e6c7
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


diff failed passed
diff out ../../../git.next/t/trash_directory.t1450-fsck2_120912_205305/=
out
17a18,20
 > Checking blob 5626abf0f72e58d7a153368ba57db4c673c0e171
 > Checking blob 63499e4ea8e096b831515ceb1d5a7593e4d87ae5
 > error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a blob, no=
t=20
a commit
18a22,23
 > error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: broken links
 > error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: could not loa=
d=20
tagged object
20,22d24
< Checking blob 5626abf0f72e58d7a153368ba57db4c673c0e171
< error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a commit,=20
not a blob
< error: 63499e4ea8e096b831515ceb1d5a7593e4d87ae5: object corrupt or mi=
ssing
