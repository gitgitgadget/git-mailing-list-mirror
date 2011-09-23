From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Bug: git log --numstat counts wrong
Date: Fri, 23 Sep 2011 17:18:15 +0800
Message-ID: <CALUzUxrswZ+AREq+OeqpTsnoB4J+_aExfmAA6X3cauJqj8RnpQ@mail.gmail.com>
References: <D3CF0A47-64DA-4EBB-9DCD-D2D714596C50@inf.fu-berlin.de>
	<7vr53a2icn.fsf@alter.siamese.dyndns.org>
	<3BF8BA51-4CAA-40A2-8B45-D39AAEE58E6F@inf.fu-berlin.de>
	<7vobyd1vmo.fsf@alter.siamese.dyndns.org>
	<7vobycxy71.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexander Pepper <pepper@inf.fu-berlin.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 11:18:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R71tm-0007lq-J5
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 11:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609Ab1IWJSR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Sep 2011 05:18:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45108 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231Ab1IWJSQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2011 05:18:16 -0400
Received: by fxe4 with SMTP id 4so3620334fxe.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 02:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Hfyw35HsNzv4M5bPu+Ty0xvP+5q03Xb2pghyMmqZ2lU=;
        b=BMhYLt9cmZIE8LmMwf3kBDGTIBZ8RBQskP9H6mlflZTLhzCJJd7myKJzzdYa62yCib
         Y7G7HuByP9qX2d3ugNS5oc06WkYCKbX2OapB4dGj484SSuyTwrSJhQ8/lV94UFc57FMS
         iVjgidyz2zdKlVXK66BwSa/eVj1A3bXn6Aj2Y=
Received: by 10.223.39.154 with SMTP id g26mr1116160fae.7.1316769495155; Fri,
 23 Sep 2011 02:18:15 -0700 (PDT)
Received: by 10.223.79.65 with HTTP; Fri, 23 Sep 2011 02:18:15 -0700 (PDT)
In-Reply-To: <7vobycxy71.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181951>

On Fri, Sep 23, 2011 at 1:51 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Alexander Pepper <pepper@inf.fu-berlin.de> writes:
>>
>>> Am 21.09.2011 um 14:24 schrieb Junio C Hamano:
>>>>> $ git log --numstat 48a07e7e533f507228e8d1c99d4d48e175e14260
>>>>> [...]
>>>>> 11 =A0 =A0 =A010 =A0 =A0 =A0src/java/voldemort/server/storage/Sto=
rageService.java
>>>>
>>>> Didn't we update it this already? I seem to get 10/9 here not 11/1=
0.
>>>
>>> Current 'maint' (cd2b8ae9), 'master' (4b5eac7f)...
>>
>> That's a tad old master you seem to have.
>>
>> Strangely, bisection points at 27af01d5523, which was supposed to be=
 only
>> about performance and never about correctness. There is something fi=
shy
>> going on....
>
> In any case, I think the real issue is that depending on how much con=
text
> you ask, the resulting diff is different (and both are valid diffs). =
If
> you ask "log -p" (or "diff" or "show") to produce a patch, then we us=
e the
> default 3-line context. And then you feed that to an external diffsta=
t to
> count the number of deleted and added lines to get one set of numbers=
=2E
>
> The --numstat (and --diffstat) code seems to be running the internal =
diff
> machinery with 0-line context and counting the resulting diff interna=
lly.
>
> And of course the results between the above two would be different be=
cause
> diff can match lines differently when given different number of conte=
xt
> lines to include in the result.
>
> So perhaps a good sanity-check for you to try (note: not checking you=
r
> sanity, but checking the sanity of the above analysis) would be to do=
:
>
> =A0$ git show 48a07e7e53 -- $that_path | diffstat
> =A0$ git show -U0 48a07e7e53 -- $that_path | diffstat
> =A0$ git show --numstat 48a07e7e53 -- $that_path
> =A0$ git show --stat 48a07e7e53 -- $that_path
>
> and see how they compare (make sure to use the same version of git fo=
r
> these experiments). The first one uses the default 3-lines context, t=
he
> second one forces 0-line context, and the last two uses 0-line contex=
t
> hardwired in the code.
>
> Applying the following patch should make the last two use the default
> context or -U$num given from the command line to be consistent with t=
he
> codepath where we generate textual patches.
>
> =A0diff.c | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 9038f19..302ef33 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2251,6 +2251,8 @@ static void builtin_diffstat(const char *name_a=
, const char *name_b,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memset(&xpp, 0, sizeof(xpp));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memset(&xecfg, 0, sizeof(xecfg));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xpp.flags =3D o->xdl_opts;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xecfg.ctxlen =3D o->context;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 xecfg.interhunkctxlen =3D o->interhunkc=
ontext;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0xdi_diff_outf(&mf1, &mf2, diffstat_con=
sume, diffstat,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&xpp, &xec=
fg);
> =A0 =A0 =A0 =A0}

Thanks Junio.

But wait, where does this patch go? Before or after 27af01d? If I'm
understanding the situation correctly, this patch won't change the
reporting 10/9 for --numstat, no?

Anyway, this patch looks right.

  Acked-by: Tay Ray Chuan <rctay89@gmail.com>

Interesting to find that we have many xdiff users that don't respect
diff options on the command line (or may not acess to them), like
patch-id, merge. I wonder if there would be less conflicts if merge's
ctxlen could be overriden...

--=20
Cheers,
Ray Chuan
