From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH/RFC] Revoke write access to refs and odb after importing
 another repo's odb
Date: Wed, 23 Jan 2013 21:38:15 +0100
Message-ID: <51004A37.6040301@web.de>
References: <1358948067-2792-1-git-send-email-pclouds@gmail.com> <7v1udbj0kt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 21:38:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty75l-0005RE-FO
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 21:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513Ab3AWUiV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jan 2013 15:38:21 -0500
Received: from mout.web.de ([212.227.15.4]:59174 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167Ab3AWUiT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 15:38:19 -0500
Received: from [192.168.178.41] ([91.3.166.4]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0MUF4Q-1UP1cb1yte-00RBuO; Wed, 23 Jan 2013 21:38:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7v1udbj0kt.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5
X-Provags-ID: V02:K0:OaCJWBU3MS6g01l5jQ2BVBlmcxl37Ud6b5E3e41hAcl
 es7gLSyndlKCLjSjpjU6IOx9ox+E7u94nMl4cf2jA/dokPpI2Q
 3vhIuf4K7NUgDfk7Z5aLkBqJun4sOpaCoTXy/yEGil8DcVJ9F5
 ivAUoRswPRrlD4AIvgNy7YA1YJEsymlfEwHxPpC6w7frtNagoM
 zbYHJNzzclAmAQY40I/iw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214360>

Am 23.01.2013 18:01, schrieb Junio C Hamano:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>=20
>> add_submodule_odb() can be used to import objects from another
>> repository temporarily. After this point we don't know which objects
>> are ours, which are external. If we create an object that refers to =
an
>> external object, next time git runs, it may find a hole in the objec=
t
>> graph because the external repository may not be imported. The same
>> goes for pointing a ref to an external SHA-1.
>>
>> To protect ourselves, once add_submodule_odb() is used:
>>
>>  - trees, tags and commits cannot be created
>>  - refs cannot be updated
>>
>> In certain cases that submodule code knows that it's safe to write, =
it
>> can turn the readonly flag off.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  I think this is a good safety check.
>=20
> Two step implementation to bring "read-only" support into a testable
> shape and then flip that bit in add_submdule_odb() would be a
> sensible approach.

I agree this is a worthwhile change so nobody accidentally screws
things up.

>>  It catches at least a case in
>>  t7405.3. I did not investigate further though.

This is a false positive. The merge algorithm picked a fast-forward
in a submodule as a proper merge result and records that in a
gitlink. But as Duy pointed out this could be easily fixed by
turning the readonly flag off in that case.

> I however have this suspicion that this will become a losing battle
> and we would be better off getting rid of add_submodule_odb();
> instead operations that work across repositories will be done as a
> subprocess, which will get us back closer to one of the original
> design goals of submodule support to have a clear separation between
> the superproject and its submodules.

Please don't. While I agree with your goal, I'd be unhappy to do
that because of the performance drop (especially on fork-challenged
operating systems).
