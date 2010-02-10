From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] blame: allow -L n,m to have an m bigger than the file's 
	line count
Date: Wed, 10 Feb 2010 14:39:45 -0500
Message-ID: <76718491002101139m4061fb90qcee7d34fca9f242f@mail.gmail.com>
References: <1265786864-5460-1-git-send-email-bebarino@gmail.com>
	 <76718491002100537h521fcc26gb267ed7cd2b8db6f@mail.gmail.com>
	 <7vwrykapfp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 20:39:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfIPh-00081Q-7H
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 20:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019Ab0BJTjs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 14:39:48 -0500
Received: from mail-iw0-f185.google.com ([209.85.223.185]:45250 "EHLO
	mail-iw0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754444Ab0BJTjr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Feb 2010 14:39:47 -0500
Received: by iwn15 with SMTP id 15so416635iwn.19
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 11:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dFCwt+rNsJL0wrbaD4sv0zMzei9p6VXrazA86ae0bhM=;
        b=avOSCHdId6m4B1K7/l1yEc3xEadcubJQugt964lBzbhiNKFwboX8cJaz0UjWwQogwm
         sm0td8nODrzM1oXcfIkWV5S5cHmA/zrK3m6N9/wArypnbIyh7TIxc/ufGCbvLs13rc7Q
         Mmq5bxTi5j7t2CZklqEMzkzF9sBVn7piZ6J3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C4TtWrEdEyIFwtf8gqn0qD95ArvZen73O37Q7bvCruEXLg12JRLovIjgUp8oFnKXIC
         dcP6egSrBuUjMZjo5S91dI9PpanQFMVwu43eTonfpc0df7pqpo2cZm6hI3GwGn4dgYqz
         OrgHQQWnP3hCOzEIbBskJoIqfRT5W3wj1Erpw=
Received: by 10.231.146.66 with SMTP id g2mr189298ibv.60.1265830785343; Wed, 
	10 Feb 2010 11:39:45 -0800 (PST)
In-Reply-To: <7vwrykapfp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139537>

On Wed, Feb 10, 2010 at 1:58 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> While we are talking about touching the vicinity, I think we should
> tighten the -L s,e parsing rules a bit further.
>
> There is an undocumented code that swaps start and end if the given e=
nd is
> smaller than the start. =C2=A0This triggers even when "-L280,300" is =
mis-typed
> as "-L280,30". =C2=A0I was bitten by this more than once---when the i=
nput does
> not make sense, we should actively error out, instead of doing a wron=
g
> thing. =C2=A0I suspect that I coded it that way _only_ to support thi=
s pattern:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-L'/^#endif \/\* !WINDOWS \/\*/,-30'
>
> i.e. "blame 30 lines before the '#endif' line". =C2=A0But the code al=
so
> internally turns "-L50,-20" into "-L 50,30" and then swaps them to ma=
y
> make it "-L30,50"; this was merely an unintended side effect.

I was curious what sed does. At least on my system, sed -n -e '10,1p'
prints just line 1. Seems a bit odd. sed -n -e '1,10000p' just prints
to the end, and doesn't error out if there are less than 10k lines.

> I do want to see -L'/regexp/,-offset' keep working, I do not mind if =
we
> keep taking "-L50,-20" as an unintuitive way to spell "-L30,50", or r=
eject
> "-L50,-20" as a nonsense. =C2=A0But I do want to see us reject "-L280=
,30" as a
> typo.
>
> As to use of more than one -L option, especially when the start (or e=
nd
> for that matter) is specified with an regexp, I am of two minds.

Actually, I was not planning on supporting multiple -L options, but rat=
her...

> When annotating the body of two functions, frotz and nitfol, I might
> expect this to work:
>
> =C2=A0 =C2=A0-L'/^int frotz(/,/^}/' =C2=A0-L'/^int nitfol(/,/^}/'
>
> regardless of the order these functions appear in the blob (i.e. nitf=
ol
> may be defined first). =C2=A0This requires that parsing of "regexp" n=
eeds to
> reset to the beginning of blob for each -L option (iow, multiple -L a=
re
> parsed independently from each other).
>
> But at the same time, if I am actually looking at the blob contents i=
n one
> terminal while spelling the blame command line in another, it would b=
e
> nicer if the multiple -L looked for patterns incrementally. =C2=A0I m=
ay
> appreciate if I can write the above command line as:
>
> =C2=A0 =C2=A0-L'/^int frotz(/,/^}/' =C2=A0-L'/nitfol/,/^}/'
>
> when I can see in my "less" of the blob contents in the other termina=
l
> that the first line that has string "nitfol" after the end of the
> definition of "frotz" is the beginning of function "nitfol".
>
> Another thing we _might_ want to consider doing is something like:
>
> =C2=A0 =C2=A0-L'*/^#ifdef WINDOWS/,/^#endif \/\* WINDOWS \/\*/'
>
> to tell it "I don't care to count how many WINDOWS ifdef blocks there=
 are;
> grab all of them".

That was my aim, but the syntax I'd settled on was to use
-L/pattern/..END where END is either a numerical argument or another
pattern. IOW, ".." instead of ",".

> Regardless of how parsing of multiple -L goes, you need to be careful=
 to
> sort the resulting line ranges and possibly coalesce them when there =
are
> overlaps (e.g. "-L12,+7 -L10,+5" should become "-L10,17"). =C2=A0And =
be careful
> about refcounting of origin. =C2=A0You'll be making multiple blame_en=
t and
> queuing them to the scoreboard when starting, all pointing at the bla=
me
> target blob; the origin blob needs to start with the right number of
> references to keep origin_decref() discarding it.

Understood.

j.
