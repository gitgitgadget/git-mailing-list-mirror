From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Bug: git-upload-pack will return successfully even when it can't
 read all references
Date: Tue, 8 Sep 2015 14:16:03 +0200
Message-ID: <CACBZZX6Ag5pjx_AhS_aN=rvJBcy+Nh+PXfdeEqxFdgxvL3NMbw@mail.gmail.com>
References: <CACBZZX6ZYDEPrQorg=pVh734ua+x55SYoKKvSZ_h0GQaR=m+8w@mail.gmail.com>
 <20150908065347.GG26331@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 08 14:16:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZHp6-00069R-Ty
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 14:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180AbbIHMQZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2015 08:16:25 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34594 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931AbbIHMQX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Sep 2015 08:16:23 -0400
Received: by qkfq186 with SMTP id q186so41904293qkf.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2015 05:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=lpU3gKtLwYAIGdVENHavJvKLRLCORlW/jjIF9t26BKM=;
        b=RiZmm94UFUNVXmMruZ8Fm42TlGF+sT15n9iekTzdN3nItG5iTbl3JIIGk4Haf79qxG
         qfAtBrmNmisDV3F0GvFkMe+bAz0d4nbJslXvKUSBzsHcCWPLphR0x01bjdjbv72jkvJ7
         9F7lRs74JhLxAtpuQlUVHMVzUJECjQdsXNMeRqgY6QjlW+r42/9GLsbpjfOKQI4wZuv3
         vfrMZE+6g+rNbGiwPDak9R+A2XvXbF9UhKy0aFgrcgXoJO/U8ibwVJolbph9Joomt6ba
         RsTLxgJA62dMRRyc4hEUSzEi1Q6zYiIAq04E3mBLbp7EIpDIJFULTkNcWcZQbhYePTNI
         hdfA==
X-Received: by 10.55.192.75 with SMTP id o72mr33762002qki.88.1441714583081;
 Tue, 08 Sep 2015 05:16:23 -0700 (PDT)
Received: by 10.55.24.209 with HTTP; Tue, 8 Sep 2015 05:16:03 -0700 (PDT)
In-Reply-To: <20150908065347.GG26331@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277501>

On Tue, Sep 8, 2015 at 8:53 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Sep 07, 2015 at 02:11:15PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> This turned out to be a pretty trivial filesystem error.
>> refs/heads/master wasn't readable by the backup process, but some
>> other stuff in refs/heads and objects/* was.
>>
>> [...]
>>
>> I wanted to check if this was a regression and got as far back as
>> v1.4.3 with the same behavior before the commands wouldn't work
>> anymore due to changes in the git config parsing code.
>
> Right, it has basically always been this way. for_each_ref() silently
> eats oddities or errors while reading refs. Calling for_each_rawref()
> will include them, but we don't do it in most places; it would make
> non-critical operations on a corrupted repo barf.  And it is difficul=
t
> to know what is "critical" inside the code. You might be calling
> "upload-pack" to salvage what you can from a corrupted repo, or to ma=
ke
> a backup where you want to know what is corrupted and what is not.
>
> Commit 49672f2 introduced a "ref paranoia" environment variable to le=
t
> you specify this (and robust backups was definitely one of the use ca=
ses
> I had in mind). It's a little tricky to use with upload-pack because =
you
> may be crossing an ssh boundary, but:
>
>   git clone -u 'GIT_REF_PARANOIA=3D1 git-upload-pack' ...
>
> should work.
>
> With your case:
>
>   $ git clone --no-local -u 'GIT_REF_PARANOIA=3D1 git-upload-pack' re=
po repo-checkout
>   Cloning into 'repo-checkout'...
>   fatal: git upload-pack: not our ref 0000000000000000000000000000000=
000000000
>   fatal: The remote end hung up unexpectedly
>
> Without "--no-local" it behaves weirdly, but I would not recommend lo=
cal
> clones in general if you are trying to be careful. They optimize out =
a
> lot of the safety checks, and we do things like copy the packed-refs
> file wholesale.
>
> And certainly the error message is not the greatest. upload-pack is n=
ot
> checking for the REF_ISBROKEN flag, so it just dumps:
>
>   0000000000000000000000000000000000000000 refs/heads/master
>
> in the advertisement, and the client happily requests that object.
> REF_PARANOIA is really just a band-aid to feed the broken refs to the
> normal code paths, which typically barf on their own. :)
>
> Something like this:
>
> diff --git a/upload-pack.c b/upload-pack.c
> index 89e832b..3c621a5 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -731,6 +731,9 @@ static int send_ref(const char *refname, const st=
ruct object_id *oid,
>         if (mark_our_ref(refname, oid))
>                 return 0;
>
> +       if (flag & REF_ISBROKEN)
> +               warning("remote ref '%s' is broken", refname);
> +
>         if (capabilities) {
>                 struct strbuf symref_info =3D STRBUF_INIT;
>
> kind of helps, but the advertisement is too early for us to send
> sideband messages. So it makes it to the user if the transport is loc=
al
> or ssh, but not over git:// or http.
>
> That's something we could do better with protocol v2 (we'll negotiate
> capabilities before the advertisement).

=46antastic. REF_PARANOIA does exactly what I need, i.e. stall the fetc=
h
process so permissions can be manually repaired.

I think it makes sense to keep the default at "let's try to copy over
what we can", for salvage purposes. I think the bug is that we still
return success in that case, and should return non-zero, but as you
point out this is easier said than done due to needing to deal with
the case where the remote transport sends us the 0000... ref.

I wonder if --upload-pack=3D"GIT_REF_PARANOIA=3D1 git-upload-pack" shou=
ld
be the default when running fetch if you have --prune enabled. There's
a particularly bad edge case now where if you have permission errors
on the master repository and run --prune on your backup along with a
--mirror clone to mirror the refs, then when you have permission
issues you'll prune everything from the backup.

But yeah, a proper fix needs protocol v2. Because among other things
that --upload-pack hack will only work for ssh, not http.
