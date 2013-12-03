From: Nick Townsend <nick.townsend@mac.com>
Subject: Fwd: [PATCH] submodule recursion in git-archive
Date: Mon, 02 Dec 2013 16:03:37 -0800
Message-ID: <D8D13DC5-0E93-4900-A738-A4A6700BC92F@mac.com>
References: <3651F1C2-741E-4170-9468-0EF07F120CB9@mac.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 03 01:04:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VndTK-0008OE-I6
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 01:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442Ab3LCAEK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Dec 2013 19:04:10 -0500
Received: from nk11p03mm-asmtp002.mac.com ([17.158.232.237]:45936 "EHLO
	nk11p03mm-asmtp002.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750874Ab3LCAEI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 Dec 2013 19:04:08 -0500
Received: from [172.16.1.4]
 (99-120-78-245.lightspeed.sntcca.sbcglobal.net [99.120.78.245])
 by nk11p03mm-asmtp002.mac.com
 (Oracle Communications Messaging Server 7u4-27.08(7.0.4.27.7) 64bit (built Aug
 22 2013)) with ESMTPSA id <0MX7003M0EUVWD00@nk11p03mm-asmtp002.mac.com> for
 git@vger.kernel.org; Tue, 03 Dec 2013 00:04:08 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.11.72,1.0.14,0.0.0000
 definitions=2013-12-02_04:2013-12-02,2013-12-02,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=13 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=7.0.1-1308280000 definitions=main-1312020193
X-Mailer: Apple Mail (2.1822)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238664>



Begin forwarded message:

> From: Nick Townsend <nick.townsend@mac.com>
> Subject: Re: [PATCH] submodule recursion in git-archive
> Date: 2 December 2013 16:00:50 GMT-8
> To: Junio C Hamano <gitster@pobox.com>
> Cc: Ren=E9 Scharfe <l.s.r@web.de>, Jens Lehmann <Jens.Lehmann@web.de>=
, git@vger.kernel.org, Jeff King <peff@peff.net>
>=20
>=20
> On 27 Nov 2013, at 11:43, Junio C Hamano <gitster@pobox.com> wrote:
>=20
>> Nick Townsend <nick.townsend@mac.com> writes:
>>=20
>>> On 26 Nov 2013, at 14:18, Junio C Hamano <gitster@pobox.com> wrote:
>>>=20
>>>> Even if the code is run inside a repository with a working tree,
>>>> when producing a tarball out of an ancient commit that had a
>>>> submodule not at its current location, --recurse-submodules option
>>>> should do the right thing, so asking for working tree location of
>>>> that submodule to find its repository is wrong, I think.  It may
>>>> happen to find one if the archived revision is close enough to wha=
t
>>>> is currently checked out, but that may not necessarily be the case=
=2E
>>>>=20
>>>> At that point when the code discovers an S_ISGITLINK entry, it
>>>> should have both a pathname to the submodule relative to the
>>>> toplevel and the commit object name bound to that submodule
>>>> location.  What it should do, when it does not find the repository
>>>> at the given path (maybe because there is no working tree, or the
>>>> sudmodule directory has moved over time) is roughly:
>>>>=20
>>>> - Read from .gitmodules at the top-level from the tree it is
>>>> creating the tarball out of;
>>>>=20
>>>> - Find "submodule.$name.path" entry that records that path to the
>>>> submodule; and then
>>>>=20
>>>> - Using that $name, find the stashed-away location of the submodul=
e
>>>> repository in $GIT_DIR/modules/$name.
>>>>=20
>>>> or something like that.
>>>>=20
>>>> This is a related tangent, but when used in a repository that peop=
le
>>>> often use as their remote, the repository discovery may have to
>>>> interact with the relative URL.  People often ship .gitmodules wit=
h
>>>>=20
>>>> 	[submodule "bar"]
>>>>      	URL =3D ../bar.git
>>>> 		path =3D barDir
>>>>=20
>>>> for a top-level project "foo" that can be cloned thusly:
>>>>=20
>>>> 	git clone git://site.xz/foo.git
>>>>=20
>>>> and host bar.git to be clonable with
>>>>=20
>>>> 	git clone git://site.xz/bar.git barDir/
>>>>=20
>>>> inside the working tree of the foo project.  In such a case, when
>>>> "archive --recurse-submodules" is running, it would find the
>>>> repository for the "bar" submodule at "../bar.git", I would think.
>>>>=20
>>>> So this part needs a bit more thought, I am afraid.
>>>=20
>>> I see that there is a lot of potential complexity around setting up=
 a submodule:
>>=20
>> No question about it.
>>=20
>>> * The .gitmodules file can be dirty (easy to flag, but should we
>>> allow archive to proceed?)
>>=20
>> As we are discussing "archive", which takes a tree object from the
>> top-level project that is recorded in the object database, the
>> information _about_ the submodule in question should come from the
>> given tree being archived.  There is no reason for the .gitmodules
>> file that happens to be sitting in the working tree of the top-level
>> project to be involved in the decision, so its dirtyness should not
>> matter, I think.  If the tree being archived has a submodule whose
>> name is "kernel" at path "linux/" (relative to the top-level
>> project), its repository should be at .git/modules/kernel in the
>> layout recent git-submodule prepares, and we should find that
>> path-and-name mapping from .gitmodules recorded in that tree object
>> we are archiving. The version that happens to be checked out to the
>> working tree may have moved the submodule to a new path "linux-3.0/"
>> and "linux-3.0/.git" may have "gitdir: .git/modules/kernel" in it,
>> but when archiving a tree that has the submodule at "linux/", it
>> would not help---we would not know to look at "linux-3.0/.git" to
>> learn that information anyway because .gitmodules in the working
>> tree would say that the submodule at path "linux-3.0/" is with name
>> "kernel", and would not tell us anything about "linux/".
>>=20
>>> * Users can mess with settings both prior to git submodule init
>>> and before git submodule update.
>>=20
>> I think this is irrelevant for exactly the same reason as above.
>>=20
>> What makes this tricker, however, is how to deal with an old-style
>> repository, where the submodule repositories are embedded in the
>> working tree that happens to be checked out.  In that case, we may
>> have to read .gitmodules from two places, i.e.
>>=20
>> (1) We are archiving a tree with a submodule at "linux/";
>>=20
>> (2) We read .gitmodules from that tree and learn that the submodule
>>    has name "kernel";
>>=20
>> (3) There is no ".git/modules/kernel" because the repository uses
>>    the old layout (if the user never was interested in this
>>    submodule, .git/modules/kernel may also be missing, and we
>>    should tell these two cases apart by checking .git/config to
>>    see if a corresponding entry for the "kernel" submodule exists
>>    there);
>>=20
>> (4) In a repository that uses the old layout, there must be the
>>    repository somewhere embedded in the current working tree (this
>>    inability to remove is why we use the new layout these days).
>>    We can learn where it is by looking at .gitmodules in the
>>    working tree---map the name "kernel" we learned earlier, and
>>    map it to the current path ("linux-3.0/" if you have been
>>    following this example so far).
>>=20
>> And in that fallback context, I would say that reading from a dirty
>> (or "messed with by the user") .gitmodules is the right thing to
>> do.  Perhaps the user may be in the process of moving the submodule
>> in his working tree with
>>=20
>>   $ mv linux-3.0 linux-3.2
>>   $ git config -f .gitmodules submodule.kernel.path linux-3.2
>>=20
>> but hasn't committed the change yet.
>>=20
>>> For those reasons I deliberately decided not to reproduce the
>>> above logic all by myself.
>>=20
>> As I already hinted, I agree that the "how to find the location of
>> submodule repository, given a particular tree in the top-level
>> project the submodule belongs to and the path to the submodule in
>> question" deserves a separate thread to discuss with area experts.
>=20
> As per my email to Heiko on this thread, I=92m happy to start such=20
> a discussion - I=92ll use your notes as a starting point. I=92m much =
more comfortable
> using a wiki for this - is this common or should I start a new mail t=
hread
> with RFC in the title or similar?
>=20
> I did complete my work on my version of git-archive (for internal use=
) and added some regression tests
> for current behaviour. Also the add_submodule_odb patch should IMHO b=
e incorporated
> anyway. I=92ll resubmit those two for consideration in a new thread.
>=20
> Kind Regards
> Nick Townsend
>=20
