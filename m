From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: First/oldest entry in reflog dropped
Date: Sun, 21 Nov 2010 17:57:46 -0500
Message-ID: <AANLkTikS00FN9-_MoSGvBMxdUefzk5K_8Zz2V14KCDLJ@mail.gmail.com>
References: <AANLkTiktGbeSmUB75kn3q=swnw=cHvivX21OkR3sJJDC@mail.gmail.com>
	<20101121053545.GA10520@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 21 23:58:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKIrM-0007kD-Sy
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 23:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596Ab0KUW5s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Nov 2010 17:57:48 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62889 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463Ab0KUW5r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Nov 2010 17:57:47 -0500
Received: by qwc9 with SMTP id 9so153116qwc.19
        for <git@vger.kernel.org>; Sun, 21 Nov 2010 14:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BPnge47D6v2Aj+zAlqZdLq0ff3vyP7cmjynY3gbf5P4=;
        b=fPCydhak0nKehyYfJ+4/BCPA72fh5cVECSqxBhPUKk8faxHuk+yu5Zppm4diPnTcba
         aafnfjBayrluUx/l42NmDBCUAdQSZTBtHPipnwu8oijtoB2wHlWV/TcHllb1HBhOek04
         Z6+AKeUIukjwnns132DnjNtyFXRWnD98jLT58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KRHFE3iL2EiAR3NpxA/ai+eDRR7X5BHIxKZaT1sPp1g06J1ATn3/usQAOUZGpA7XDd
         JtyCJumtJMuMyonVlTML5eQdWVlZPB6bRfThtoeKwxamh9qfDqyWcGJ8yrSh03wA4TCt
         pc0VOTtCDiVCKUCO5JvC+mACk4seH6aafKPbA=
Received: by 10.224.135.227 with SMTP id o35mr4573708qat.75.1290380266400;
 Sun, 21 Nov 2010 14:57:46 -0800 (PST)
Received: by 10.224.80.202 with HTTP; Sun, 21 Nov 2010 14:57:46 -0800 (PST)
In-Reply-To: <20101121053545.GA10520@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161873>

On Sun, Nov 21, 2010 at 12:35 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Nov 20, 2010 at 10:11:34PM -0500, Martin von Zweigbergk wrote=
:
>
>> Can someone explain the behavior in the execution below?
>>
>> # I expected this reflog...
>> $ git branch tmp
>> $ git reflog show refs/heads/tmp
>> b60a214 refs/heads/tmp@{0}: branch: Created from master
>>
>> # ... and this one as well...
>> $ git update-ref refs/heads/tmp HEAD^
>> $ git reflog show refs/heads/tmp
>> 7d1a0b8 refs/heads/tmp@{0}:
>> b60a214 refs/heads/tmp@{1}: branch: Created from master
>>
>> # ... but why is the first entry (i.e. "branch: Created from master"=
)
>> # dropped here?
>> $ git update-ref refs/heads/tmp HEAD
>> $ git reflog show refs/heads/tmp
>> b60a214 refs/heads/tmp@{0}:
>> 7d1a0b8 refs/heads/tmp@{1}:
>>
>> If the ref is updated once more (to e.g. HEAD^^) before being moved =
back
>> to HEAD, the first entry will be shown in the output.
>>
>> If this is a bug, it seems to be in reflog, rather than in update-re=
f,
>> because the first entry does exist in .git/logs/refs/heads/tmp.
>
> I think it's a bug in the reflog-walking machinery, which is sort of
> bolted onto the regular revision traversal machinery. When we hit
> b60a214 the first time, we show it and set the SHOWN flag (since the
> normal traversal machinery would not want to show a commit twice). Wh=
en
> we hit it again, simplify_commit() sees that it is SHOWN and tells us=
 to
> skip it.
>
> However, the bolted-on reflog-walking machinery does have a way of
> handling this. While we are traversing via get_revision(), we notice
> that we are doing a reflog walk and call fake_reflog_parent. This
> function is responsible for replacing the actual parents of the commi=
t
> with a fake list consisting of the previous reflog entry (so we
> basically pretend that the history consists of a string of commits, e=
ach
> one pointing to the previous reflog entry, not the actual parent).
>
> This function _also_ clears some flags, including the SHOWN flag, in
> what almost seems like a tacked-on side effect. So if we hit the same
> commit twice, we will actually show it again. Which is what makes
> reflogs with repeated commits work at all.
>
> However, there is a subtle bug: it clears the flags at the very end o=
f
> the function. But through the function, if we see that there are no f=
ake
> parents (because we are on the very first reflog entry), we do an ear=
ly
> return. But we not only skip the later "set up parents" code, we also
> accidentally skip the "clear SHOWN flag" side-effect code.
>
> So I believe we will always fail to show the very first reflog if it =
is
> a repeated commit.
>
> The fix, AFAICT, is to just move the flag clearing above the early
> returns (patch below). But I have to admit I do not quite understand
> what the ADDED and SEEN flags are doing here, as this is the first ti=
me
> I have ever looked at the reflog-walk code. So possibly just the SHOW=
N
> flag should be unconditionally cleared.
>
> This patch clears up your bug, and doesn't break any tests. But I'd
> really like to get a second opinion on the significance of those othe=
r
> flags, or why the flag clearing was at the bottom of the function in =
the
> first place.
>
> -Peff
>
> ---
> diff --git a/reflog-walk.c b/reflog-walk.c
> index 4879615..d5d055b 100644
> --- a/reflog-walk.c
> +++ b/reflog-walk.c
> @@ -210,44 +210,45 @@ int add_reflog_for_walk(struct reflog_walk_info=
 *info,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0add_commit_info(commit, commit_reflog, &in=
fo->reflogs);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> =C2=A0void fake_reflog_parent(struct reflog_walk_info *info, struct c=
ommit *commit)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct commit_info *commit_info =3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0get_commit_inf=
o(commit, &info->reflogs, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct commit_reflog *commit_reflog;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct reflog_info *reflog;
>
> + =C2=A0 =C2=A0 =C2=A0 commit->object.flags &=3D ~(ADDED | SEEN | SHO=
WN);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0info->last_commit_reflog =3D NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!commit_info)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0commit_reflog =3D commit_info->util;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (commit_reflog->recno < 0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0commit->parent=
s =3D NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0reflog =3D &commit_reflog->reflogs->items[=
commit_reflog->recno];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0info->last_commit_reflog =3D commit_reflog=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0commit_reflog->recno--;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0commit_info->commit =3D (struct commit *)p=
arse_object(reflog->osha1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!commit_info->commit) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0commit->parent=
s =3D NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0commit->parents =3D xcalloc(sizeof(struct =
commit_list), 1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0commit->parents->item =3D commit_info->com=
mit;
> - =C2=A0 =C2=A0 =C2=A0 commit->object.flags &=3D ~(ADDED | SEEN | SHO=
WN);
> =C2=A0}
>
> =C2=A0void get_reflog_selector(struct strbuf *sb,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 struct reflog_walk_info *reflog_info,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 enum date_mode dmode,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 int shorten)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct commit_reflog *commit_reflog =3D re=
flog_info->last_commit_reflog;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct reflog_info *info;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *printed_ref;
>
>

Good job! And yes, if the first commit is included in any cycles, it
seems to be dropped. I must have been blind yesterday...
