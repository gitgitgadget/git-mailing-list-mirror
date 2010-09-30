From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 13/16] send-email: extract_valid_address use qr// regexes
 and /o
Date: Thu, 30 Sep 2010 16:33:59 +0000
Message-ID: <AANLkTimSHxU8EhuOHn77kw+ASCCeg_Bjg2or7L=G_o=M@mail.gmail.com>
References: <1285854189-10240-1-git-send-email-avarab@gmail.com>
	<1285854189-10240-14-git-send-email-avarab@gmail.com>
	<20100930161912.GA8707@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ryan Anderson <rda@google.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 30 18:34:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1M59-0003Gm-JR
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 18:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755534Ab0I3QeB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 12:34:01 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48203 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab0I3QeA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 12:34:00 -0400
Received: by iwn5 with SMTP id 5so2631499iwn.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 09:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6GRybMvq8JQVg+eCcNd8v2qwzslzKAOkV1359tb9G7M=;
        b=ik38WM2ZI8+y70OAhJIOl9cousl5BxGIucE9oBqrJwP7jzeP/YBUnybJh6G8pFsymj
         l+ItQ4I9c3sXV8C+rtjyFTwHzI8kc/LYfd2vV98MCPQ+hxn6D1VMWc9XCDIvi8dSbUAa
         5/KAK7PUoapzdCXtjiaTCAjzRkr1i2e9o51fo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xOYm2CkofjakGCpIUrJ75yEhDmdv0WNw72QdLfZTQMAEZZG1RaHYxrFaRPwFcmmvef
         MWQilUbzCSucoc05/je5NQWLiQSiDNXmgeTrRwBPnN73jCHtg4riuirJzukfHpIfX+Tb
         QsB0uv/ZpkZXY/X86iMq0s6XGgotgzD2pCGQ0=
Received: by 10.231.182.5 with SMTP id ca5mr4019418ibb.68.1285864439986; Thu,
 30 Sep 2010 09:33:59 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Thu, 30 Sep 2010 09:33:59 -0700 (PDT)
In-Reply-To: <20100930161912.GA8707@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157688>

On Thu, Sep 30, 2010 at 16:19, Jeff King <peff@peff.net> wrote:
> On Thu, Sep 30, 2010 at 01:43:06PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> Change the regex fragment in extract_valid_address to use the qr//
>> syntax for compiled regexes, and when they're used add a /o flag so
>> they're only compiled once for the lifetime of the program.
>> [...]
>> =C2=A0sub extract_valid_address {
>> =C2=A0 =C2=A0 =C2=A0 my $address =3D shift;
>> - =C2=A0 =C2=A0 my $local_part_regexp =3D '[^<>"\s@]+';
>> - =C2=A0 =C2=A0 my $domain_regexp =3D '[^.<>"\s@]+(?:\.[^.<>"\s@]+)+=
';
>> + =C2=A0 =C2=A0 my $local_part_regexp =3D qr/[^<>"\s@]+/;
>> + =C2=A0 =C2=A0 my $domain_regexp =3D qr/[^.<>"\s@]+(?:\.[^.<>"\s@]+=
)+/;
>>
>
> Hmm. But these are lexical variables, so won't we recompile them each
> time we enter the subroutine? I don't think it affects correctness, a=
s
> this "/o":
>
>> + =C2=A0 =C2=A0 return $address if ($address =3D~ /^($local_part_reg=
exp)$/o);
>
> means that we will compile and use the value from the first time we r=
un
> the function.
>
> But we are unnecessarily compiling the sub-regexes each time. Not tha=
t
> this is probably a performance critical piece of code, but your "/o" =
is
> doing very little, and this is exactly the sort perl wankery that I f=
ind
> interesting.

IIRC different perl versions treat this differently. In more recent
versions doing:

    perl -Mre=3Ddebug -E 'sub x { my $x =3D qr/foo/; my $y =3D qr/bar/;
/$x$y/ } x($_) for 1..2'

Will only compile all of those regexes once, since perl can see that
they're constant. So the /o does nothing.

We might want to keep it for self-documentation purposes to indicate
that the $local_part_regexp would never change, but it's probably best
to drop that /o altogether.

> Sadly, there is no real perl equivalent of C static local variables,
> which is what you really want. =C2=A0Usually I would do:
>
> =C2=A0{
> =C2=A0 =C2=A0my $local_part_regexp =3D qr/.../;
> =C2=A0 =C2=A0sub extract_valid_address {
> =C2=A0 =C2=A0 =C2=A0...
> =C2=A0 =C2=A0}
> =C2=A0}
>
> but beware of the execution order. That works well in a module, where
> the module code is executed before anybody calls the function. But it
> breaks in something like this:
>
> =C2=A0foo();
> =C2=A0{
> =C2=A0 =C2=A0my $foo_static_local =3D 5;
> =C2=A0 =C2=A0sub foo {
> =C2=A0 =C2=A0 =C2=A0print "$foo_static_local\n";
> =C2=A0 =C2=A0}
> =C2=A0}
>
> I think you could get by with:
>
> =C2=A0{
> =C2=A0 =C2=A0my $local_part_regexp;
> =C2=A0 =C2=A0sub extract_valid_address {
> =C2=A0 =C2=A0 =C2=A0$local_part_regexp ||=3D qr/.../;
> =C2=A0 =C2=A0 =C2=A0...
> =C2=A0 =C2=A0}
> =C2=A0}

Perl has static variables like that, just not in the ancient version
we're pinned to:

    sub foo {
        state $foo =3D qr/$_[0]/
    }
