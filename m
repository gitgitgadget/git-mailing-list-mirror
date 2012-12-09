From: Lukasz Stelmach <stlman@poczta.fm>
Subject: Re: [PATCH] gitk: read and write a repository specific configuration
 file
Date: Sun, 09 Dec 2012 14:13:14 +0100
Message-ID: <50C48E6A.5020609@poczta.fm>
References: <50BF6629.8050806@xiplink.com> <1354966067-2865-1-git-send-email-stlman@poczta.fm> <7vd2yjeg8f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mbranchaud@xiplink.com, paulus@samba.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 14:13:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThghT-0004dm-6g
	for gcvg-git-2@plane.gmane.org; Sun, 09 Dec 2012 14:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934129Ab2LINNW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Dec 2012 08:13:22 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.205]:48138 "EHLO
	smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934112Ab2LINNW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2012 08:13:22 -0500
Received: from [192.168.0.13] (87-207-152-6.dynamic.chello.pl [87.207.152.6])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTPSA;
	Sun,  9 Dec 2012 14:13:14 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.6esrpre) Gecko/20120825 Thunderbird/10.0.6
In-Reply-To: <7vd2yjeg8f.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.3.5
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
	s=biztos; t=1355058798;
	bh=gbEWZfkkBAHx89txonKCHeQcP60cBmIbxUkCxtk3ICo=;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:
	 Subject:References:In-Reply-To:X-Enigmail-Version:Content-Type:
	 Content-Transfer-Encoding:X-Interia-Antivirus;
	b=ZRdvkwBizu80M8bH9DrrOORGy4Ie8vbs2tbU6S2+6XHtyrbA8w1+P28xSc1OlfSJp
	 0L+ra+mPYRqGUerAYGiz64xR5oBvXNMpATWMYM1BwkIjwlKT14JrATFLYPQwsg8syZ
	 eBTEUJtVsloz58t14yaFXu3jAJ90KE+AYiR5HPg4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211237>

W dniu 09.12.2012 10:18, Junio C Hamano pisze:
> =C5=81ukasz Stelmach <stlman@poczta.fm> writes:
>=20
>> Enable gitk read and write repository specific configuration
>> file: ".git/k" if the file exists. To make gitk use the local
>> file simply create one, e.g. with the touch(1) command.
>>
>> This is very useful if one uses different views for different
>> repositories. Now there is no need to store all of them in
>> ~/.gitk and make the views list needlessly long.
>=20
> I do not use gitk heavily myself, but I have a mixed feeling about
> this patch.
>=20
> Forking the configuration from the one true ~/.gitk is easy; it is
> just the matter of copying it to repository specific location.  Once
> forked, however, it is very hard to merge these configuration files
> sprinkled across repositories back, or more importantly, change the
> settings globally.

=46or the record, I assumed someone using git is capable of doing some
simple tricks with find, sed and the like.


Merging configuration from the global file (~/.gitk) is quite easy as
the file is sourced just before the local file. If any option is not se=
t
in the local file the global value is effective.

To handle the case you describe below...

> Imagine you just got a new monitor that is a lot
> finer grained than the one you have been usingq, and your choice of
> font size has been specified in terms of pixels; you would want to
> show all gitk windows in larger font now, regardless of the
> repository, but you now have to go to 47 different configuration
> files and update them.


you need to (assume one keeps git repositoris below $HOME)

1. Enter a random repository
2. mv .git/gitk .git/gitk-local (see below)
3. Run gitk, configure fonts to your taste, save config (it will be
saved  globally)
4. mv .git/gitk-local .git/gitk
4 Do a trick
$ find ../ -name gitk -type f -path '*/.git/gitk' -print0 | \
  xargs -0 sed -i -e '/^set [a-z]\+font /d'

Now the font settings from ~/.gitk will be applied (and saved locally
when gitk exits) in every repository find(1) found.

> So I suspect that this may introduce more trouble than it is worth
> for users and should not be sold with a "This is very useful" label.
> At best, it is "This may be useful";

I work with more than two dozen different repositories and saving the
list of branches I want to see upon startup is quite important for me.

> otherwise the feature may end
> up harming our users.  I'd phrase it without judging if it is good
> or bad for the users, perhaps like this:
>=20
>     This allows one to specify different views for different
>     repositories.

At present the code won't harm anyone not willing to get harmed. To mak=
e
gitk save the configuration locally user needs to create the
configuration file manually, outside of gitk, for example with touch(1)
(yes it may be empty).

> In any case, the filename .git/k may be _cute_, but I do not think
> we would want to see:
>=20
>     $ ls .git
>     branches        config       HEAD   index  k     objects
>     COMMIT_EDITMSG  description  hooks  info   logs  refs

I agree this was just to draw your attention ;-)

> It is too cryptic, unless the user _knows_ 'k' is for gitk.  I'd
> call it $GIT_DIR/gitkconfig or something, if I were supportive for
> this feature (which I am not enthusiastic, yet).

I think simply $GIT_DIR/gitk as in ~/.gitk is going to be fine.


--=20
By=C5=82o mi bardzo mi=C5=82o.               Czwarta pospolita kl=C4=99=
ska, [...]
>=C5=81ukasz<                 Ju=C5=BC nie katolicka lecz z=C5=82odziej=
ska.  (c)PP
