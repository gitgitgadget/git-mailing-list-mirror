From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] Use clean.requireforce to protect untracked files.
Date: Sat, 04 Jun 2011 00:20:37 +0800
Message-ID: <4DE909D5.9050805@gmail.com>
References: <4DE8C1AE.4000007@gmail.com> <7vipsnar23.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 18:20:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSX7D-00084G-J4
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 18:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946Ab1FCQUq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2011 12:20:46 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:62134 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926Ab1FCQUp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 12:20:45 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so1333348pxi.10
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=lX35REpsYkRHzfE4mn0FJ7b+8wKV8I47f1wbESh5xHU=;
        b=FlALToJU7qsl2P8qP7OnhocY4LU3EUNkPdCFgzWEvF+9kjH5mtrHTMGQgCybBlBL65
         k+/QqgkkXkbuS63AU4Oxo1YJw+rNBK23TLXgT014/rGKeUzv6TvsM1H6Hf78uaCAnjQC
         j3mBq9SFoQJAcZAJKDtWc/Vc8ddXAvzKjXDAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=sq+AqmrO4wq7Uoo3VfSDaTo68oxEUQs2Dl5PbnoqTXb+W/cfLBEAt2w7jxhHUTkUIp
         uPbTxPNFvxQlA8MQ9jdcsOk+j9p5jgRYbHOi/MA0q5wZMh7Mn8JpkHFM8QiIkFYvFbJR
         MHCFBYuUHJ4ddvv4s3/xiNIAFPA+36jQInpFk=
Received: by 10.142.128.13 with SMTP id a13mr342983wfd.18.1307118045394;
        Fri, 03 Jun 2011 09:20:45 -0700 (PDT)
Received: from [192.168.0.51] ([123.116.243.168])
        by mx.google.com with ESMTPS id x8sm1126860wfx.19.2011.06.03.09.20.40
        (version=SSLv3 cipher=OTHER);
        Fri, 03 Jun 2011 09:20:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; zh-CN; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <7vipsnar23.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175014>

I do agree there are ignored-but-precious type of files exist in practi=
ce.
Introducing such ignored-but-precious class through attributes or .giti=
gnore
is fine, and the definition of the class can broadcast to others throug=
h
=2Egitattributes or .gitignore, it's cool. But it sounds a bit complica=
ted.

This afternoon's hack on config variable "clean.requestForce" feets my =
needs,
but it also has drawbacks:

1. Define a global "clean.requestForce" variable like this:

    $ git config --global clean.requestForce LockIgnored

2. Then in one repository,

    * You can : git clean -f
    * But you cannot : git clean -f -x

3. If want to override such global setting, simply

    $ git config clean.requestForce true

The side-effect of this hack is that an unhacked git will complain:

    fatal: bad config value for 'clean.requireforce' in .git/config


=E4=BA=8E 11-6-3 =E4=B8=8B=E5=8D=8811:11, Junio C Hamano =E5=86=99=E9=81=
=93:
> Jiang Xin <worldhello.net@gmail.com> writes:
>=20
>> Untracked files may be significant for certain repositories, but if =
run the
>> command "git clean -fdx" by accident, all untracked files will be lo=
st.
>=20
> Don't add -x without thinking, then. It is the way to tell the comman=
d "I
> want to remove all the untracked files and I REALLY MEAN IT".  It is =
often
> used to say "I do not trust Makefile and I want to remove what 'make
> clean' would leave behind".
>=20
> A slightly related tangent is that we only have three classes of path=
s:
>=20
>  - tracked ones
>  - untracked ones, where there are two subclasses
>    - unignored ones (e.g. new source file you haven't added)
>    - ignored ones (e.g. build artifacts like *.o files)
>=20
> and because of that, the general design is to consider "ignored" file=
s
> expendable during various operations. Sometimes people deliberately "=
ignore"
> files that they consider not expendable, which is (by today's definit=
ion)
> a wrong thing to do, but I think in the longer term we should add a w=
ay to
> mark them as "ignored but precious".
>=20
>   http://thread.gmane.org/gmane.comp.version-control.git/172818/focus=
=3D172846
>=20
> Nobody has designed how this fourth class should behave (and how the
> behaviour of the "ignored" should change, if any) yet, but a rough ou=
tline
> would probably be:
>=20
>  - precious files are the ones that are ignored (by today's definitio=
n,
>    i.e. .gitignore mechanism consideres they are ignored) but marked =
as
>    "precious" in some other way [*1*]. They will
>=20
>    - not appear in "Untracked files:" section in "git status" output;
>    - not be added by "git add" without "-f", just like other ignored =
files;
>    - not be overwritten or removed to make room while switching branc=
hes;
>    - not be removed with "clean -f -x" [*2*].
>=20
>  - ignored files will stay to be "expendable".
>=20
> I suspect there may be some codepaths that incorrectly treat them as =
not
> expendable, and protect their lossage. We would want to fix them afte=
r we
> introduce the "precious" class.
>=20
> [Footnotes]
>=20
> *1* We could invent a way to sneak such entries in .gitignore, but I =
am
> inclined to think it would be cleaner to define "precious" attribute =
and
> let the attributes mechanism handle this.
>=20
> *2* This is just off the top of my head without thinking things
> through. It might turn out that it makes more sense ot remove them.


--=20
=E8=92=8B=E9=91=AB

=E5=8C=97=E4=BA=AC=E7=BE=A4=E8=8B=B1=E6=B1=87=E4=BF=A1=E6=81=AF=E6=8A=80=
=E6=9C=AF=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8
=E9=82=AE=E4=BB=B6: worldhello.net@gmail.com
=E7=BD=91=E5=9D=80: http://www.ossxp.com/
=E3=80=80=E3=80=80  http://blog.ossxp.com/
=E7=94=B5=E8=AF=9D: 010-51262007, 13910430470
=E4=BC=A0=E7=9C=9F: 010-51262007
