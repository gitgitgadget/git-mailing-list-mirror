From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] git-add--interactive: Preserve diff heading when
 splitting hunks
Date: Mon, 12 May 2014 21:42:56 +0200
Message-ID: <CACBZZX4W=1jPGcuBYstQkBDaT_wu38Fhxu642qwaFtCCqBdnyQ@mail.gmail.com>
References: <1399824596-4670-1-git-send-email-avarab@gmail.com> <20140512183955.GB31164@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 12 21:43:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wjw89-0006iX-Vy
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 21:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008AbaELTnS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 May 2014 15:43:18 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:33307 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685AbaELTnR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 May 2014 15:43:17 -0400
Received: by mail-oa0-f47.google.com with SMTP id i7so8809546oag.34
        for <git@vger.kernel.org>; Mon, 12 May 2014 12:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=T91g8f5yGVkyfv9nsp/bgJU44yeiPiwC27ZyEhgoSwU=;
        b=yXg7dnQS2wxRIG/BziyLCou8g2hgn0khTeqRFU5N4QXbTss2ETCnvDuce7Syz7yVYs
         eKc8tsM5RG2NzWv2K2hlybhc0w2WwgnPSLu7EQNg2PJQHtjKNViIX4R+KrtMXjKj7OfW
         bfBoO8ZFg50TY1+zRgRL0LsuTt5vNiy+8MJPtmjW8TeJGJN5aMdv32g1YUYCKtf/zgiz
         ek0QEWNDb78K12xZsHcNWKV9wyh1wxW41T0558YJYRdkBYnrVHi4qoD5+eTEO2neuoR/
         czV4U4luRTwPtOcPfHtzeWVzX3mXbuR5gy/xmhrOa+fyETe//weC0kYVV5G0a9fT8Y1l
         LfIQ==
X-Received: by 10.182.28.195 with SMTP id d3mr37285550obh.19.1399923796632;
 Mon, 12 May 2014 12:43:16 -0700 (PDT)
Received: by 10.76.176.40 with HTTP; Mon, 12 May 2014 12:42:56 -0700 (PDT)
In-Reply-To: <20140512183955.GB31164@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248725>

On Mon, May 12, 2014 at 8:39 PM, Jeff King <peff@peff.net> wrote:
> On Sun, May 11, 2014 at 04:09:56PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> Change the display of hunks in hunk splitting mode to preserve the d=
iff
>> heading, which hasn't been done ever since the hunk splitting was
>> initially added in v1.4.4.2-270-g835b2ae.
>>
>> Splitting the first hunk of this patch will now result in:
>>
>>     Stage this hunk [y,n,q,a,d,/,j,J,g,s,e,?]? s
>>     Split into 2 hunks.
>>     @@ -792,7 +792,7 @@ sub hunk_splittable {
>>     [...]
>>
>> Instead of:
>>
>>     Stage this hunk [y,n,q,a,d,/,j,J,g,s,e,?]? s
>>     Split into 2 hunks.
>>     @@ -792,7 +792,7 @@
>>     [...]
>>
>> This makes it easier to use the tool when you're splitting some gian=
t
>> hunk and can't remember in which function you are anymore.
>
> This makes a lot of sense to me. I did notice two interesting quirks,
> one of which might be worth addressing.
>
> One, there is a slightly funny artifact in that the hunk header comes
> from the top of the context line, and that top is a different positio=
n
> for each of the split hunks. So in a file like:
>
>   header_A
>       content
>   header_B
>       one
>       two
>       three
>       four
>
> you might have a diff like:
>
>   @@ ... @@ header_A
>    header_B
>        one
>        two
>   +    new line 1
>        three
>   +    new line 2
>        four
>
> The hunk header for "new line 1" is "A", because "B" itself is part o=
f
> the context. But the hunk header for "new line 2", if it were an
> independent hunk, would be "B". We print "A" because we copy it from =
the
> original hunk.
>
> It probably won't matter much in practice (and I can even see an
> argument that "A" is the "right" answer). And figuring out "B" here
> would be prohibitively difficult, I would think, as it would require
> applying the funcname rules internal to git-diff to a hunk that git-d=
iff
> itself never actually sees.
>
> Since the output from your patch is strictly better than what we saw
> before, I think there is no reason we cannot leave such an improvemen=
t
> to later (or never).

Good suggestion, but tricky as you point out. Another thing I've
wanted many times is to make it smart enough that when you edit code
like:

  A()
  B();

And change it to:

  X();

  Y();

The change from A->X and B->Y may be completely unrelated and just
made in code where the author didn't add whitespace between unrelated
statements.

But because you change all the lines the tool can't split them up, it
could try harder and split hunks like that if you add a whitespace
boundary, or just go all the way down to adding/removing individual
lines, so you wouldn't have to fall down to "edit" mode and do so
manually.


>> The diff is somewhat larger than I initially expected because in ord=
er
>> to display the headings in the same color scheme as the output from
>> git-diff(1) itself I had to split up the code that would previously
>> color diff output that previously consisted entirely of the fraginfo=
,
>> but now consists of the fraginfo and the diff heading (the latter of
>> which isn't colored).
>
> The func heading is not colored by default, but you can configure it =
to
> be so with color.diff.func. I double-checked the behavior with your
> patch: you end up with the uncolored header in the split hunks, becau=
se
> it is parsed from the uncolored line. Which is not bad, but I think w=
e
> can trivially do better, just by adding back in the color as we do wi=
th
> the fraginfo.
>
> Like:
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index ed1e564..ac5763d 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -29,6 +29,10 @@ my ($fraginfo_color) =3D
>         $diff_use_color ? (
>                 $repo->get_color('color.diff.frag', 'cyan'),
>         ) : ();
> +my ($funcname_color) =3D
> +       $diff_use_color ? (
> +               $repo->get_color('color.diff.func', ''),
> +       ) : ();
>  my ($diff_plain_color) =3D
>         $diff_use_color ? (
>                 $repo->get_color('color.diff.plain', ''),
> @@ -902,7 +906,7 @@ sub split_hunk {
>                 unshift @{$hunk->{DISPLAY}}, join(
>                         "",
>                         $diff_use_color ? colored($fraginfo_color, $f=
raginfo) : $fraginfo,
> -                       $heading,
> +                       $diff_use_color ? colored($funcname_color, $h=
eading) : $heading,
>                         "\n"
>                 );
>         }
>
> I didn't prepare a commit message because I think it should probably
> just be squashed in.

Well spotted, indeed, that should be squashed in.

On a related note I thought by doing color.ui=3Dauto I was turning on
all the colors, it would be nice if there was a built-in colorscheme
that added more coloring to items like these across our tools, it's
useful to have the hunk headers colored differently so they stand out
more.
