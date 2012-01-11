From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Fix incorrect ref namespace check
Date: Wed, 11 Jan 2012 05:49:51 +0100
Message-ID: <4F0D14EF.4000908@alum.mit.edu>
References: <1325766924-14943-1-git-send-email-pclouds@gmail.com> <1325767180-15083-1-git-send-email-pclouds@gmail.com> <7v39bunmno.fsf@alter.siamese.dyndns.org> <CACsJy8Af=PjXE4sHqSk1v8qoraivOnT2w495W1c1dVQBW1s-cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 05:50:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkq8Q-0007Dk-19
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 05:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516Ab2AKEt4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 23:49:56 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:60278 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756739Ab2AKEtz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 23:49:55 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BED6D5.dip.t-dialin.net [84.190.214.213])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q0B4nphf007521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 11 Jan 2012 05:49:52 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <CACsJy8Af=PjXE4sHqSk1v8qoraivOnT2w495W1c1dVQBW1s-cQ@mail.gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188329>

On 01/11/2012 02:54 AM, Nguyen Thai Ngoc Duy wrote:
> Any comments Mike?

Looks fine to me.

Theoretically, we could add an API for iterating over references
*excluding* a particular namespace, which (after hierarchical refs is
accepted) could be implemented a bit more efficiently than iterating
over all references and then excluding those in the unwanted namespace.
 But I think it would be far more trouble than it's worth.

Michael

> 2012/1/5 Junio C Hamano <gitster@pobox.com>:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> The reason why the trailing slash is needed is obvious. refs/stash =
and
>>> HEAD are not namespace, but complete refs. Do full string compare o=
n them.
>>>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>> ---
>>>  I missed prefixcmp(..., "HEAD") right below prefixcmp(..., "refs/s=
tash")
>>
>> As Michael has been actively showing interest in cleaning up the are=
a, he
>> should have been CC'ed, I would think.
>>
>>>
>>>  builtin/fetch.c  |    2 +-
>>>  builtin/remote.c |    2 +-
>>>  log-tree.c       |    4 ++--
>>>  3 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>>> index 33ad3aa..daa68d2 100644
>>> --- a/builtin/fetch.c
>>> +++ b/builtin/fetch.c
>>> @@ -573,7 +573,7 @@ static void find_non_local_tags(struct transpor=
t *transport,
>>>
>>>       for_each_ref(add_existing, &existing_refs);
>>>       for (ref =3D transport_get_remote_refs(transport); ref; ref =3D=
 ref->next) {
>>> -             if (prefixcmp(ref->name, "refs/tags"))
>>> +             if (prefixcmp(ref->name, "refs/tags/"))
>>>                       continue;
>>>
>>>               /*
>>> diff --git a/builtin/remote.c b/builtin/remote.c
>>> index 583eec9..f54a89a 100644
>>> --- a/builtin/remote.c
>>> +++ b/builtin/remote.c
>>> @@ -534,7 +534,7 @@ static int add_branch_for_removal(const char *r=
efname,
>>>       }
>>>
>>>       /* don't delete non-remote-tracking refs */
>>> -     if (prefixcmp(refname, "refs/remotes")) {
>>> +     if (prefixcmp(refname, "refs/remotes/")) {
>>>               /* advise user how to delete local branches */
>>>               if (!prefixcmp(refname, "refs/heads/"))
>>>                       string_list_append(branches->skipped,
>>> diff --git a/log-tree.c b/log-tree.c
>>> index 319bd31..535b905 100644
>>> --- a/log-tree.c
>>> +++ b/log-tree.c
>>> @@ -119,9 +119,9 @@ static int add_ref_decoration(const char *refna=
me, const unsigned char *sha1, in
>>>               type =3D DECORATION_REF_REMOTE;
>>>       else if (!prefixcmp(refname, "refs/tags/"))
>>>               type =3D DECORATION_REF_TAG;
>>> -     else if (!prefixcmp(refname, "refs/stash"))
>>> +     else if (!strcmp(refname, "refs/stash"))
>>>               type =3D DECORATION_REF_STASH;
>>> -     else if (!prefixcmp(refname, "HEAD"))
>>> +     else if (!strcmp(refname, "HEAD"))
>>>               type =3D DECORATION_REF_HEAD;
>>>
>>>       if (!cb_data || *(int *)cb_data =3D=3D DECORATE_SHORT_REFS)
>=20
>=20
>=20


--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
