From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 2/3] remote: reorganize check_pattern_match()
Date: Wed, 22 Feb 2012 22:15:41 +0200
Message-ID: <CAMP44s2HUG_ocHBaVpcsZHWMf2Tww+=bVun5H9+S5EGkoiJHRQ@mail.gmail.com>
References: <1329505957-24595-1-git-send-email-felipe.contreras@gmail.com>
	<1329505957-24595-3-git-send-email-felipe.contreras@gmail.com>
	<7vvcn5qecl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 21:15:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0IbM-0005oH-GK
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 21:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681Ab2BVUPn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 15:15:43 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58423 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751871Ab2BVUPm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 15:15:42 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id u2so485743lag.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 12:15:42 -0800 (PST)
Received-SPF: pass (google.com: domain of felipe.contreras@gmail.com designates 10.112.84.233 as permitted sender) client-ip=10.112.84.233;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of felipe.contreras@gmail.com designates 10.112.84.233 as permitted sender) smtp.mail=felipe.contreras@gmail.com; dkim=pass header.i=felipe.contreras@gmail.com
Received: from mr.google.com ([10.112.84.233])
        by 10.112.84.233 with SMTP id c9mr10924111lbz.1.1329941742073 (num_hops = 1);
        Wed, 22 Feb 2012 12:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=nSQlbnduiJhajL7H5uoFUNDauROBIt0awcXey/x0xXs=;
        b=EnSJblFtKE2QUheCsZ8AB0sXMf/OEQHhDmsSPv+RbyDmTR4BFCB7ipYzqZo1PLmbqQ
         ppqFs0UH6ytmWMiZZZPFkYV9UFFLb5zzBgOH55N2FM7zQxIpbB/BDvwlNc0UBEbpMC6A
         PtNqZO5TaihLrlIcYl6MqDfbxw0pP0e95b7rI=
Received: by 10.112.84.233 with SMTP id c9mr9163481lbz.1.1329941741989; Wed,
 22 Feb 2012 12:15:41 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Wed, 22 Feb 2012 12:15:41 -0800 (PST)
In-Reply-To: <7vvcn5qecl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191277>

On Sat, Feb 18, 2012 at 12:34 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> There's a lot of code that can be consolidated there, and will be us=
eful
>> for next patches.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>> =C2=A0remote.c | =C2=A0 59 ++++++++++++++++++++++++++++++-----------=
------------------
>> =C2=A01 files changed, 30 insertions(+), 29 deletions(-)
>>
>> diff --git a/remote.c b/remote.c
>> index 55d68d1..019aafc 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -1110,10 +1110,11 @@ static int match_explicit_refs(struct ref *s=
rc, struct ref *dst,
>> =C2=A0 =C2=A0 =C2=A0 return errs;
>> =C2=A0}
>>
>> -static const struct refspec *check_pattern_match(const struct refsp=
ec *rs,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0int rs_nr,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0const struct ref *src)
>> +static char *check_pattern_match(const struct refspec *rs, int rs_n=
r, struct ref *ref,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int send_mirror, const s=
truct refspec **ret_pat)
>> =C2=A0{
>
> For a change that not just adds parameters but removes an existing on=
e,
> this is way under-described with neither in-code comment nor log mess=
age.

But it doesn't. src is renamed to ref.

>> + =C2=A0 =C2=A0 const struct refspec *pat;
>> + =C2=A0 =C2=A0 char *name;
>> =C2=A0 =C2=A0 =C2=A0 int i;
>> =C2=A0 =C2=A0 =C2=A0 int matching_refs =3D -1;
>> =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < rs_nr; i++) {
>> @@ -1123,14 +1124,31 @@ static const struct refspec *check_pattern_m=
atch(const struct refspec *rs,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 continue;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rs[i].pattern && mat=
ch_name_with_pattern(rs[i].src, src->name,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NU=
LL))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return rs + i;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rs[i].pattern) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 const char *dst_side =3D rs[i].dst ? rs[i].dst : rs[i].src;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (match_name_with_pattern(rs[i].src, ref->name, dst_side, &name))=
 {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 matching_refs =3D i;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>
> We used to discard what match_name_with_pattern() finds out by matchi=
ng a
> wildcard refspec against the ref by passing two NULLs. =C2=A0This upd=
ates the
> code to capture what destination ref ref->name is mapped to, by using=
 the
> same logic as the original and only caller, i.e. 'foo' without destin=
ation
> maps to the same 'foo' destination, 'foo:bar' maps to the named 'bar'=
=2E
>
> This function is not used by fetching side of the codepath, so we do =
not
> have to worry about its need to use different dst_side selection logi=
c
> (i.e. 'foo' without destination maps to "do not store anywhere other =
than
> FETCH_HEAD"). =C2=A0Good.

I actually didn't parse a lot of that.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 }
>> -...
>> + =C2=A0 =C2=A0 if (matching_refs =3D=3D -1)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
>> +
>> + =C2=A0 =C2=A0 pat =3D rs + matching_refs;
>> + =C2=A0 =C2=A0 if (pat->matching) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* "matching refs";=
 traditionally we pushed everything
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* including refs o=
utside refs/heads/ hierarchy, but
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* that does not ma=
ke much sense these days.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!send_mirror && pref=
ixcmp(ref->name, "refs/heads/"))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return NULL;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name =3D xstrdup(ref->na=
me);
>> + =C2=A0 =C2=A0 }
>
> So you are moving some code from what the sole caller of this functio=
n
> does after calling us, and that is where the new parameters come from=
=2E
> And by doing so, you do not have to run the same match_name_with_patt=
ern()
> again. =C2=A0OK.

Indeed.

--=20
=46elipe Contreras
