From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH 3/5] tree-walk: micro-optimization in tree_entry_interesting
Date: Mon, 4 Apr 2011 19:22:39 -0500
Message-ID: <BANLkTi=yVrS9MsBF1YR9D-QWej-n1uDQyQ@mail.gmail.com>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
	<1301535481-1085-3-git-send-email-dpmcgee@gmail.com>
	<7vaag7dv0z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 02:22:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6u2s-0003io-Cj
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 02:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009Ab1DEAWm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Apr 2011 20:22:42 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36343 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab1DEAWl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Apr 2011 20:22:41 -0400
Received: by wwa36 with SMTP id 36so7067349wwa.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 17:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jxRn6Z/0gQFLBydcUOjOdGvJ3TN5+iWoUDvmUH47iTo=;
        b=vxVEg1Yi3Asq45B3kwWyAMm2O33KlKcF4SAOkFEyzXgDEERmiEA7Nzm1mgl8nn7miQ
         cHBt35KJUVN6byKZV+pQkK9iCvsX1SvZGdLAfG0W2BXfnxn4zqBjInEIv0TUP8JWTHmG
         trta1lQEbRzougywJS4GwplwDPlOtnECgvKNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XOLx+mASldQmIB0eXyfy78yDNvz1wp8D2GLwKC9Dp6SPqgdeDR64hDUwOiZEAWeZxn
         Z/FhBw9ctGwystnuYux5XInZC0Hg7Bks5ibTzMmisXhQu7/31eAqDrS06cy2tQw9FXHz
         yg0uQ2c5KXvhDuC7WeHbYxM0VFbXb3sKr0rN0=
Received: by 10.227.29.27 with SMTP id o27mr7660278wbc.16.1301962959451; Mon,
 04 Apr 2011 17:22:39 -0700 (PDT)
Received: by 10.227.147.16 with HTTP; Mon, 4 Apr 2011 17:22:39 -0700 (PDT)
In-Reply-To: <7vaag7dv0z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170850>

On Sun, Apr 3, 2011 at 1:55 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Dan McGee <dpmcgee@gmail.com> writes:
>
>> In the case of a wide breadth top-level tree (~2400 entries, all tre=
es
>> in this case), we can see a noticeable cost in the profiler calling
>> strncmp() here. Most of the time we are at the base level of the
>> repository, so base is "" and baselen =3D=3D 0, which means we will =
always
>> test true. Break out this one tiny case so we can short circuit the
>> strncmp() call.
>
> This sounds as if the patch helps only when you have a superfat tree =
at
> the "top-level" of the project, but wouldn't this benefit any superfa=
t
> tree at _any_ level while we recursively descend into it?

Correct. I looked at the fact that more often than not, we wouldn't
have to descend into subtrees unless searching for a path underneath
it, so that is why I phrased it that way. So the "in the case of" was
quite literally the case I was testing, but didn't mean to exclude
other potential test cases.

>> This resulted in an ~11% improvement (43 to 38 secs) for a reasonabl=
e
>> log operation on the Arch Linux Packages SVN clone repository, which
>> contained 117220 commits and the aforementioned 2400 top-level objec=
ts:
>> =C2=A0 =C2=A0 git log -- autogen/trunk pacman/trunk/ wget/trunk/
>>
>> Negligible slowdown was noted with other repositories (e.g. linux-2.=
6).
>
> It would have been easier to swallow if the last sentence were "This =
could
> lead to a slowdown in repositories without directories that are too w=
ide,
> but in practice it was not even measurable." =C2=A0"Negligible" sound=
s as if it
> had still measurable downside, and as if you decided that the slowdow=
n can
> be ignored---but obviously you are not an unbiased judge.

Perhaps I was too cautious with my words- but I was also trying to not
be biased. Considering this same operation takes < 1 second in
linux-2.6, I only wanted to mention it could have a slight effect. In
reality I saw nothing more than an extra 0.01s or so, and definitely
nothing significant. Let me know if you see otherwise.

dmcgee@galway ~/projects/linux-2.6 (master)
$ time ../git/git-log -- zzzzz_not_exist > /dev/null

real	0m0.945s
user	0m0.857s
sys	0m0.083s

> There is nothing wrong in the patch per-se, but I really wish we didn=
't
> have to do this; it feels like the compiler should be helping us in t=
his
> case.
>
>> Signed-off-by: Dan McGee <dpmcgee@gmail.com>
>> ---
>> =C2=A0tree-walk.c | =C2=A0 =C2=A04 ++--
>> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tree-walk.c b/tree-walk.c
>> index 9be8007..f386151 100644
>> --- a/tree-walk.c
>> +++ b/tree-walk.c
>> @@ -591,8 +591,8 @@ int tree_entry_interesting(const struct name_ent=
ry *entry,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ps->max_depth);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Does the base match? =
*/
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!strncmp(base_str, m=
atch, baselen)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Either there must be =
no base, or the base must match. */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (baselen =3D=3D 0 || =
!strncmp(base_str, match, baselen)) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (match_entry(entry, pathlen,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 match +=
 baselen, matchlen - baselen,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &never_=
interesting))
>
