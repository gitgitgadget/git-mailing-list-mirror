From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: t1450-fsck (sometimes/often) failes on Mac OS X
Date: Sun, 15 Jul 2012 15:03:04 +0200
Message-ID: <5002BF88.4090002@web.de>
References: <5001644F.10901@web.de> <20120715090849.GB18385@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 15 15:03:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqOTj-0007il-LZ
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 15:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735Ab2GONDK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Jul 2012 09:03:10 -0400
Received: from mout.web.de ([212.227.15.3]:54934 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752708Ab2GONDI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2012 09:03:08 -0400
Received: from birne.lan ([194.22.188.61]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LuuC9-1TqA0m28aP-00zr5A; Sun, 15 Jul 2012 15:03:05 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <20120715090849.GB18385@sigill.intra.peff.net>
X-Provags-ID: V02:K0:bERtZu8bOuVpQjLbfxdjBx+cvdLYeZ+2ENY55arRHZP
 fITRnupSXcnzA5PnukNoC7pQtSpeWc4c5T/gG0WV4AvW4uSkxZ
 lLqchDl9JlTZ5/8fVP8V/1Pexj1QNRL+RHPR934X5poKZ67YSI
 b4lw35Kicx5Vq7QOc2TTmf0oBRbAQ3wGjIKTmtkylaPiKyM90W
 AX9cTpwCvTQ3tJaOVVIWA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201478>

Peff, thanks for looking into this.

My answers are inline and at the end.

On 15.07.12 11:08, Jeff King wrote:
> On Sat, Jul 14, 2012 at 02:21:35PM +0200, Torsten B=C3=B6gershausen w=
rote:
>=20
>> I saw the problem first on pu, some time ago,=20
>> but it dissappeared after cloning git.git into another directory.
>>
>> Now it appeared on next as well, so it's time to look a little bit d=
eeper.
>>
>> This test case of t1450 fails:
>> test_expect_success 'tag pointing to something else than its type' '
>=20
> I can't reproduce this failure; I tried both pu or next, on Linux and=
 OS
> X (10.7).
>=20
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
>=20
> That seems very broken. That sha1 can have only one type, so OS X is
> actually mis-parsing the object type? Weird. I would suggest a memory
> error or race condition, but the test is valgrind-clean, and fsck sho=
uld
> not be threaded at all.
>=20
> What does "git show 63499e4" show when the test has failed?=20
 ../../git show 63499e4
blob


> If you re-run "git fsck --tags", does it reproduce reliably (i.e., is=
 it bogus
> data that something wrote to the object db, or is it good data being
> ruined during the reading process)?

 ../../git fsck --tags
Checking object directories: 100% (256/256), done.
error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a blob, not a=
 commit
error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: broken links
error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: could not load t=
agged object
broken link from     tag 66f6581d549f70e05ca586bc2df5c15a95662c36
broken link from unknown unknown
dangling blob 63499e4ea8e096b831515ceb1d5a7593e4d87ae5

>=20
>> I reverted the last change in fsck.c (Use the streaming interface), =
but that doesn't help
>>
>> Looking into the trash directory and looking at the files, we can se=
e that the .git/index is different
>> between Linux and Mac OS X.
>>
>> Is there a good way to debug the index file?
>=20
> git ls-files -s will dump the entries. But I'd expect them not to be
> byte-equivalent, because the index will contain things like mtimes fo=
r
> each entry, which will vary from run to run. Plus the error message
> above indicates something much more broken.
 ../../git ls-files -s
100644 5626abf0f72e58d7a153368ba57db4c673c0e171 0       fileA
100644 f719efd430d52bcfc8566a43b2eb655688d38871 0       fileB


I did some bisecting, and it didn't lead to a bad commit.
The problem goes away after another clone into a fresh directory.

Once it comes up, it seems to stay within that working tree.
Or it has something to do with the uptime of the machine (?)

Checking out v1.7.10 seems to make the problem go away, and
stepping up to e.g.
>commit d30ef5144cee3e9ed01a2a3f3b96d47c5322b20d
>    Merge branch 'jc/sha1-name-more' into next

brings the failure back.

This is probably not related to this very 2 commits, so may be a
"reverse bisect" would help, ("When does the problem go away?")

Thanks for helping

/Torsten












>=20
> -Peff
