From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: Borrowing objects from nearby repositories
Date: Wed, 26 Mar 2014 09:36:09 -0400
Message-ID: <3533946C-DE97-4214-9B55-F5B788DDD952@kellerfarm.com>
References: <BFF5FBC7-8F53-4958-8D56-90EADD3AD626@kellerfarm.com> <CACBZZX5teZuqtNkPT4PdXJn=g34cOhRH2oNehROT8kJ_M2cgfg@mail.gmail.com> <xmqqtxammctc.fsf@gitster.dls.corp.google.com> <xmqqvbv1kjoc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 14:36:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSo0B-0004QK-8b
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 14:36:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545AbaCZNgO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 09:36:14 -0400
Received: from atl4mhob03.myregisteredsite.com ([209.17.115.41]:38810 "EHLO
	atl4mhob03.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753438AbaCZNgO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 09:36:14 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.203])
	by atl4mhob03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s2QDa9df011602
	for <git@vger.kernel.org>; Wed, 26 Mar 2014 09:36:09 -0400
Received: (qmail 3182 invoked by uid 0); 26 Mar 2014 13:36:09 -0000
X-TCPREMOTEIP: 69.41.14.217
X-Authenticated-UID: andrew@kellerfarm.com
Received: from unknown (HELO devnet.ces.cvnt.net) (andrew@kellerfarm.com@69.41.14.217)
  by 0 with ESMTPA; 26 Mar 2014 13:36:09 -0000
In-Reply-To: <xmqqvbv1kjoc.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245178>

On Mar 25, 2014, at 6:17 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>>=20
>>>> 1) Introduce '--borrow' to `git-fetch`.  This would behave similar=
ly
>>> to '--reference', except that it operates on a temporary basis, and
>>> does not assume that the reference repository will exist after the
>>> operation completes, so any used objects are copied into the local
>>> objects database.  In theory, this mechanism would be distinct from
>>> --reference', so if both are used, some objects would be copied, an=
d
>>> some objects would be accessible via a reference repository referen=
ced
>>> by the alternates file.
>>>=20
>>> Isn't this the same as git clone --reference <path> --no-hardlinks
>>> <url> ?
>>>=20
>>> Also without --no-hardlinks we're not assuming that the other repo
>>> doesn't go away (you could rm-rf it), just that the files won't be
>>> *modified*, which Git won't do, but you could manually do with othe=
r
>>> tools, so the default is to hardlink.
>>=20
>> I think that the standard practice with the existing toolset is to
>> clone with reference and then repack.  That is:
>>=20
>>    $ git clone --reference <borrowee> git://over/there mine
>>    $ cd mine
>>    $ git repack -a -d
>>=20
>> And then you can try this:
>>=20
>>    $ mv .git/objects/info/alternates .git/objects/info/alternates.di=
sabled
>>    $ git fsck
>>=20
>> to make sure that you are no longer borrowing anything from the
>> borrowee.  Once you are satisfied, you can remove the saved-away
>> alternates.disabled file.
>=20
> Oh, I forgot to say that I am not opposed if somebody wants to teach
> "git clone" a new option to copy its objects from two places,
> (hopefully) the majority from near-by reference repository and the
> remainder over the network, without permanently relying on the
> former via the alternates mechanism.  The implementation of such a
> feature could even literally be "clone with reference first and then
> repack" at least initially but even in the final version.

That was actually one of my first ideas - adding some sort of '--auto-r=
epack' option to git-clone.  It's a relatively small change, and would =
work.  However, keeping in mind my end goal of automating the feature t=
o the point where you could run simply 'git clone <url>', an '--auto-re=
pack' option is more difficult to undo.  You would need a new parameter=
 to disable the automatic adding of reference repositories, and a new p=
arameter to undo '--auto-repack', and you'd have to remember to actuall=
y undo both of those settings.

In contrast, if the new feature was '--borrow', and the evolution of th=
e feature was a global configuration 'fetch.autoBorrow', then to turn i=
t off temporarily, one only needs a single new parameter '--no-auto-bor=
row'.  I think this is a cleaner approach than the former, although muc=
h more work.

Thanks,
 - Andrew Keller
