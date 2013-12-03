From: Nick Townsend <nick.townsend@mac.com>
Subject: [PATCH] submodule recursion in git-archive
Date: Mon, 02 Dec 2013 16:05:08 -0800
Message-ID: <7E48A538-D4C6-4E46-8147-092A5470EC8C@mac.com>
References: <3C71BC83-4DD0-43F8-9E36-88594CA63FC5@mac.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 03 01:05:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VndUO-0000ds-6q
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 01:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569Ab3LCAFQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Dec 2013 19:05:16 -0500
Received: from nk11p03mm-asmtp002.mac.com ([17.158.232.237]:49268 "EHLO
	nk11p03mm-asmtp002.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750874Ab3LCAFP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 Dec 2013 19:05:15 -0500
Received: from [172.16.1.4]
 (99-120-78-245.lightspeed.sntcca.sbcglobal.net [99.120.78.245])
 by nk11p03mm-asmtp002.mac.com
 (Oracle Communications Messaging Server 7u4-27.08(7.0.4.27.7) 64bit (built Aug
 22 2013)) with ESMTPSA id <0MX7003M0EUVWD00@nk11p03mm-asmtp002.mac.com> for
 git@vger.kernel.org; Tue, 03 Dec 2013 00:05:08 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.11.72,1.0.14,0.0.0000
 definitions=2013-12-02_04:2013-12-02,2013-12-02,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=14 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=7.0.1-1308280000 definitions=main-1312020193
X-Mailer: Apple Mail (2.1822)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238665>


=46rom: Nick Townsend <nick.townsend@mac.com>
Subject: Re: [PATCH] submodule recursion in git-archive
Date: 2 December 2013 15:55:36 GMT-8
To: Heiko Voigt <hvoigt@hvoigt.net>
Cc: Junio C Hamano <gitster@pobox.com>, Ren=E9 Scharfe <l.s.r@web.de>, =
Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org, Jeff King <pef=
f@peff.net>


On 29 Nov 2013, at 14:38, Heiko Voigt <hvoigt@hvoigt.net> wrote:

> On Wed, Nov 27, 2013 at 11:43:44AM -0800, Junio C Hamano wrote:
>> Nick Townsend <nick.townsend@mac.com> writes:
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
>>     has name "kernel";
>>=20
>> (3) There is no ".git/modules/kernel" because the repository uses
>>     the old layout (if the user never was interested in this
>>     submodule, .git/modules/kernel may also be missing, and we
>>     should tell these two cases apart by checking .git/config to
>>     see if a corresponding entry for the "kernel" submodule exists
>>     there);
>>=20
>> (4) In a repository that uses the old layout, there must be the
>>     repository somewhere embedded in the current working tree (this
>>     inability to remove is why we use the new layout these days).
>>     We can learn where it is by looking at .gitmodules in the
>>     working tree---map the name "kernel" we learned earlier, and
>>     map it to the current path ("linux-3.0/" if you have been
>>     following this example so far).
>>=20
>> And in that fallback context, I would say that reading from a dirty
>> (or "messed with by the user") .gitmodules is the right thing to
>> do.  Perhaps the user may be in the process of moving the submodule
>> in his working tree with
>>=20
>>    $ mv linux-3.0 linux-3.2
>>    $ git config -f .gitmodules submodule.kernel.path linux-3.2
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
> FYI, I already started to implement this lookup of submodule paths ea=
rly
> this year[1] but have not found the time to proceed on that yet. I am
> planning to continue on that topic soonish. We need it to implement a
> correct recursive fetch with clone on-demand as a basis for the futur=
e
> recursive checkout.
>=20
> During the work on this I hit too many open questions. Thats why I am
> currently working on a complete plan[2] so we can discuss and define =
how
> this needs to be implemented. It is an asciidoc document which I will
> send out once I am finished with it.
>=20
> Cheers Heiko
>=20
> [1] http://article.gmane.org/gmane.comp.version-control.git/217020
> [2] https://github.com/hvoigt/git/wiki/submodule-fetch-config

Heiko
It seems to me that the question that you are trying to solve is
more complex than the problem I faced in git-archive, where we have a
single commit of the top-level repository that we are chasing.=20
Perhaps we should split the work into two pieces:

a. Identifying the complete submodule configuration for a single commit=
, and
b. the complexity of behaviour when fetching and cloning recursively (w=
hich=20
    of course requires a.)

I=92m very happy to work on the first, but the second seems to me to re=
quire more
understanding than I currently possess. In order to do this it would he=
lp to have a
place to discuss this. I see you have used the wiki of your fork of git=
 on GitHub.
Is that the right place to solicit input?

Kind Regards
Nick
