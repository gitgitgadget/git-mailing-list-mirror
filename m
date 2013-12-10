From: Nick Townsend <nick.townsend@mac.com>
Subject: Re: [PATCH] Additional git-archive tests
Date: Mon, 09 Dec 2013 21:26:42 -0800
Message-ID: <3943DF12-8FE8-4664-8901-C243D588BE82@mac.com>
References: <C74C17E7-0780-4FE1-B916-D1A444F3B592@mac.com>
 <8143BEDD-8CFA-46ED-9B52-760BBB1DACE8@mac.com>
 <CAPig+cTUjvfWLC5vX0=BwtSDb613E9jMoyVXWp=de_Tyb5Ei7w@mail.gmail.com>
 <xmqq61r5q0qs.fsf@gitster.dls.corp.google.com>
 <CA9E9538-E39B-41CA-BB82-BDD8CF7A2E3F@mac.com>
 <xmqqwqjj3wit.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?windows-1252?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 06:27:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqFrB-0008Kb-B1
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 06:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096Ab3LJF1h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Dec 2013 00:27:37 -0500
Received: from nk11p03mm-asmtp002.mac.com ([17.158.232.237]:38266 "EHLO
	nk11p03mm-asmtp002.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750764Ab3LJF1f convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 00:27:35 -0500
Received: from [172.16.1.4]
 (99-120-78-245.lightspeed.sntcca.sbcglobal.net [99.120.78.245])
 by nk11p03mm-asmtp002.mac.com
 (Oracle Communications Messaging Server 7u4-27.08(7.0.4.27.7) 64bit (built Aug
 22 2013)) with ESMTPSA id <0MXK005UKSHDNBA0@nk11p03mm-asmtp002.mac.com> for
 git@vger.kernel.org; Tue, 10 Dec 2013 05:27:14 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.11.72,1.0.14,0.0.0000
 definitions=2013-12-10_03:2013-12-10,2013-12-10,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=7.0.1-1308280000 definitions=main-1312090256
In-reply-to: <xmqqwqjj3wit.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1822)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239127>


On 5 Dec 2013, at 11:52, Junio C Hamano <gitster@pobox.com> wrote:

> Nick Townsend <nick.townsend@mac.com> writes:
>=20
>> Interplay between paths specified in three ways now tested:
>> * After a : in the tree-ish,
>> * As a pathspec in the command,
>> * By virtue of the current working directory
>>=20
>> Note that these tests are based on the behaviours
>> as found in 1.8.5. They may not be intentional.
>> They were developed to regression test enhancements
>> made to parse_treeish_arg() in archive.c
>=20
> In other words, are all these new tests expected to pass?
>=20
Sorry about that - the first four tests do pass with 1.8.5, the last
three tests do not currently pass. I believe they should pass and
with my reworked git-archive patch (similar to the previous one)they do=
=2E
(though I removed that update from this set pending the discussion).
Currently 5 and 6 fail with the message:
=91fatal: current working directory is untracked=92
and  number 7 fails with: =91fatal: Not a valid object name'

> My cursory read of parse_treeish_arg() in archive.c is:
>=20
> - It reads the given object with get_sha1(), checking if it is a
>   commit-ish or tree-ish to decide if it wants to add the pax
>   header to record the commit object name;
>=20
> - It parses the tree object;
>=20
> - If run from a subdirectory, attempts to grab the "prefix"
>   (i.e. the path to the current subdirectory---in the tests you
>   added, they are all "a/") out of that tree object (it errors out
>   if it can't); and then
>=20
> - It archives the tree object.
>=20
> So I do not think it is expected to accept tree object names with
> the HEAD:<path> style syntax, if the user expects a predictable and
> consistent result.  The third step above attempts to make sure that
> you name a tree-ish that corresponds to the top-level of the
> project, i.e. with no <path>.
>=20
That=92s not quite right - paths do work from the root directory - see =
tests.
It was this very useful capability that I sought to add and generalized
the code to do.=20
> What seems to be supported are:
>=20
>    cd a && git archive HEAD ;# archives HEAD:a tree
>    cd a && git archive HEAD -- b ;# archives a/b/ part of HEAD:a as b=
/
>=20
> Specifically, it appears that HEAD:./b, HEAD:b etc. are not designed
> to work, at least to me.
>=20
Clearly when you specify them today they don=92t work, but I believe th=
ey
should work.

> I am not saying that these should _not_ work, but it is unclear what
> it means to "work".  For example, what should this do?
>=20
>    cd a && git archive HEAD:./b $pathspec
>=20
I think we can clear this up by documenting the cases and choosing
sensible behaviour _for git-archive_ ie. what people might expect.
Here is a suggestion:

a. The pathspec is used as a selector to include things in the archive.
it is applied after the cwd and treeish selection.

b. The current working directory (if present) prefixes a path in the ob=
ject
if one is present.

c. The path in the object (if present) is prefixed by the cwd (if prese=
nt) and
used to select items for archiving. However the composite path so creat=
ed
*is not present* in the archive - ie. the leading components are stripp=
ed.
(This is very useful behaviour for creating archives without leading pa=
ths)

d. As currently the =97prefix option (not the prefix from setup_git_dir=
ectory)
 is prepended to all entries in the archive.

These correspond to the use cases that I have for git archive - extract=
ing all
or part of a multiple submodule tree into a tgz file, with or without l=
eading
directories.

> The extended SHA-1 expression HEAD:./b in the subdirectory a/ is
> interpreted by get_sha1_with_context_1() to be the name of the tree
> object at path "a/b" in the commit HEAD.  Further, you are giving a
> pathspec while in a subdirectory a/ to the command.  What should
> that pathspec be relative to?
>=20
> In a normal Git command, the pathspec always is relative to the
> current subdirectory, so, the way to learn about the tree object
> a/b/c in the HEAD while in subdirectory a/ would be:
>=20
>    cd a && git ls-tree HEAD b/c
>=20
> But what should the command line for archive to grab HEAD:a/b/c be?
> It feels wrong to say:
>=20
>    cd a && git archive HEAD:./b b/c
It=92s clear to me that if you are in a subdirectory, that is an implic=
it prefix on the=20
=2E/b so you retrieve HEAD:a/b  which then archives everything in b wit=
hout the
leading a/b. The pathspec is wrong (including the b) and this archive i=
s empty.=20
>=20
> and it also feels wrong to say
>=20
>    cd a && git archive HEAD:./b c
>=20
That looks fine to me given the rules suggested above. Also git-parse m=
anages
to return the correct thing in this case, so I=92d expect this to work.

> No matter what we would do, we should behave consistently with this
> case:
>=20
>    treeish=3D$(git rev-parse HEAD:a/b) &&
>    cd a &&
>    git archive $treeish -- $pathspec
>=20
Well this will fail both in the existing case (=91fatal: current workin=
g directory is  untracked=92)
and with the scheme proposed above (=91fatal: invalid object name $tree=
ish:a/=91)=20

> so "take the pathspec relative to the tree when the treeish was
> given with '<treeish>:<path>' syntax, and otherwise treat it
> relative to the cwd" is not a workable solution.

I=92m not seeing that - that=92s not quite the same as the algorithm ab=
ove is it?
>=20
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Nick Townsend <nick.townsend@mac.com>
>> ---
>> t/t5004-archive-corner-cases.sh | 71 +++++++++++++++++++++++++++++++=
++++++++++
>> 1 file changed, 71 insertions(+)
>>=20
>> diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corne=
r-cases.sh
>> index 67f3b54..a81a836 100755
>> --- a/t/t5004-archive-corner-cases.sh
>> +++ b/t/t5004-archive-corner-cases.sh
>> @@ -113,4 +113,75 @@ test_expect_success 'archive empty subtree by d=
irect pathspec' '
>> 	check_dir extract sub
>> '
>>=20
>> +test_expect_success 'setup - repository with subdirs' '
>> +	mkdir -p a/b/c a/b/d &&
>> +	echo af >a/af &&
>> +	echo bf >a/b/bf &&
>> +	echo cf >a/b/c/cf &&
>> +	git add a &&
>> +	git commit -m "commit 1" &&
>> +	git tag -a -m "rev-1" rev-1
>> +'
>> +
>> +test_expect_success 'archive subtree from root by treeish' '
>> +	git archive --format=3Dtar HEAD:a >atreeroot.tar &&
>> +	make_dir extract &&
>> +	"$TAR" xf atreeroot.tar -C extract &&
>> +	check_dir extract af b b/bf b/c b/c/cf
>> +'
>> +
>> +test_expect_success 'archive subtree from root with pathspec' '
>> +	git archive --format=3Dtar HEAD a >atreepath.tar &&
>> +	make_dir extract &&
>> +	"$TAR" xf atreepath.tar -C extract &&
>> +	check_dir extract a a/af a/b a/b/bf a/b/c a/b/c/cf
>> +'
>> +
>> +test_expect_success 'archive subtree from root by 2-level treeish' =
'
>> +	git archive --format=3Dtar HEAD:a/b >abtreeroot.tar &&
>> +	make_dir extract &&
>> +	"$TAR" xf abtreeroot.tar -C extract &&
>> +	check_dir extract bf c c/cf
>> +'
>> +
>> +test_expect_success 'archive subtree from subdir' '
>> +	(
>> +		cd a &&
>> +		git archive --format=3Dtar HEAD >../asubtree.tar
>> +	) &&
>> +	make_dir extract &&
>> +	"$TAR" xf asubtree.tar -C extract &&
>> +	check_dir extract af b b/bf b/c b/c/cf
>> +'
>> +
>> +test_expect_success 'archive subtree from subdir with treeish' '
>> +	(
>> +		cd a &&
>> +		git archive --format=3Dtar HEAD:./b >../absubtree.tar
>> +	) &&
>> +	make_dir extract &&
>> +	"$TAR" xf absubtree.tar -C extract &&
>> +	check_dir extract bf c c/cf
>> +'
>> +
>> +test_expect_success 'archive subtree from subdir with treeish and p=
athspec' '
>> +	(
>> +		cd a &&
>> +		git archive --format=3Dtar HEAD:./b c >../absubtree.tar
>> +	) &&
>> +	make_dir extract &&
>> +	"$TAR" xf absubtree.tar -C extract &&
>> +	check_dir extract c c/cf
>> +'
>> +
>> +test_expect_success 'archive subtree from subdir with alt treeish' =
'
>> +	(
>> +		cd a &&
>> +		git archive --format=3Dtar HEAD:b >../abxsubtree.tar
>> +	) &&
>> +	make_dir extract &&
>> +	"$TAR" xf abxsubtree.tar -C extract &&
>> +	check_dir extract bf c c/cf
>> +'
>> +
>> test_done
