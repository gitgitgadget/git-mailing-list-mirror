From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] get_ref_states: strdup entries and free util in stale 
	list
Date: Tue, 1 Dec 2009 07:49:05 +0100
Message-ID: <36ca99e90911302249r5f77f031o73cc7bb13dc375cf@mail.gmail.com>
References: <0458f16c6ce906997aaf357c0c7368841ae83c36.1259625072.git.bert.wesarg@googlemail.com>
	 <7viqcrbl22.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 07:49:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFMXx-0003Z4-FM
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 07:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbZLAGtB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2009 01:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900AbZLAGtA
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 01:49:00 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:56750 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbZLAGtA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 01:49:00 -0500
Received: by fxm5 with SMTP id 5so4555980fxm.28
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 22:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8MRXBCzhTMBvfc6veTRMvSGdITKcxDcC6Mr18D7CWeg=;
        b=t5IR2836qmkCVpmHG4gCuKY0ke3Y7lGJpBaTtlIWoHUs8XHIeUvKFHuaGAG3zoi3Nt
         1EcZDpjInA2L+1ziO+l4abRncUaq63uFBpNsamboGVvBuJ+z+iGSe9HLqkq0j2WV3ozL
         OnKOKyt6X6YdthTTEtGEAdeYluN7MW/P6YIL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hEAqPE94f50HP5F6CR5Q/3iLJf1+JYN4esP7mwU3i1HmJ3kp0lemBZVk4042cmLG8i
         tPg7GiErKNHAQIPOYAyxPhhp3856iipyDqjSdXqWZchxaGjP9p03HoGrMQv1LdvAHgTR
         /hyxBReOA6XNrUKfs5zRd1Ebo3FZibU1OZd7E=
Received: by 10.223.132.207 with SMTP id c15mr820897fat.56.1259650145427; Mon, 
	30 Nov 2009 22:49:05 -0800 (PST)
In-Reply-To: <7viqcrbl22.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134166>

On Tue, Dec 1, 2009 at 01:21, Junio C Hamano <gitster@pobox.com> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
The entries of the stale branches string list are made of the stale
refs, which are immediately free'ed after the string list creation.
Therefore the list entries use memory after free. This resulted for me
in a corrupted branch list for 'git remote show' (duplicate entries
and cut-off entries). The .util member of the string list entries are
also strdup() of the branch (full)name itself, but at clear time we
request not to free the .util member. Which results in a memory leak.

>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
> Hmm, the Subject: matches what the code does, but nobody mentions why=
 it
> is necessary (iow, what breaks in the current code and what becomes b=
etter
> if the patch is applied). =C2=A0The blank space before your "S-o-b:" =
line is
> for you to describe these things.
Sure. unfortunately the code where the string list is filled is not in
the patch. But if you look at the code it should be self-explanatory.

>
>> ---

There is actually also an other solution: we could first strdup the
ref name to the .util member and take this as the input for the
abbrev_ref()/string list entry and safe there the strdup.

Bert
>> =C2=A0builtin-remote.c | =C2=A0 =C2=A06 ++++--
>> =C2=A01 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin-remote.c b/builtin-remote.c
>> index 7916626..bb72e27 100644
>> --- a/builtin-remote.c
>> +++ b/builtin-remote.c
>> @@ -272,7 +272,9 @@ static int get_ref_states(const struct ref *remo=
te_refs, struct ref_states *stat
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die("Could not get fetch map for refspec %s",
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 states->remote->fetch_refspec[i]);
>>
>> - =C2=A0 =C2=A0 states->new.strdup_strings =3D states->tracked.strdu=
p_strings =3D 1;
>> + =C2=A0 =C2=A0 states->new.strdup_strings =3D
>> + =C2=A0 =C2=A0 states->tracked.strdup_strings =3D
>> + =C2=A0 =C2=A0 states->stale.strdup_strings =3D 1;
>> =C2=A0 =C2=A0 =C2=A0 for (ref =3D fetch_map; ref; ref =3D ref->next)=
 {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char sha1[=
20];
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ref->peer_ref =
|| read_ref(ref->peer_ref->name, sha1))
>> @@ -768,7 +770,7 @@ static void clear_push_info(void *util, const ch=
ar *string)
>> =C2=A0static void free_remote_ref_states(struct ref_states *states)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 string_list_clear(&states->new, 0);
>> - =C2=A0 =C2=A0 string_list_clear(&states->stale, 0);
>> + =C2=A0 =C2=A0 string_list_clear(&states->stale, 1);
>> =C2=A0 =C2=A0 =C2=A0 string_list_clear(&states->tracked, 0);
>> =C2=A0 =C2=A0 =C2=A0 string_list_clear(&states->heads, 0);
>> =C2=A0 =C2=A0 =C2=A0 string_list_clear_func(&states->push, clear_pus=
h_info);
>> --
>> 1.6.6.rc0.253.g1ec3
>
