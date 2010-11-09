From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH 1/5] gettext: fix bug in git-sh-i18n's eval_gettext()
 by using envsubst(1)
Date: Tue, 09 Nov 2010 11:36:15 +0100
Message-ID: <4CD9241F.6070807@viscovery.net>
References: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com>	<1288524860-538-2-git-send-email-avarab@gmail.com>	<4CCFCCC8.7080603@viscovery.net>	<AANLkTimjRwSxkemMffASvHCxK009b1fnvNRs05_T_1DF@mail.gmail.com>	<4CD8F965.6050402@viscovery.net>	<AANLkTinKYJtaDjwEk0OqebBnL6+wvVO4wfWg7G-VYh7d@mail.gmail.com>	<4CD918AB.6060206@viscovery.net> <AANLkTi=23MXbZeBF=eJLRnQycx4Bdg_an2aa_3oGWR66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 11:36:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFlZ5-0006qC-Ed
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 11:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125Ab0KIKgX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 05:36:23 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:56041 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754857Ab0KIKgW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 05:36:22 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PFlYo-0007Rd-Uc; Tue, 09 Nov 2010 11:36:19 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 0BF1E1660F;
	Tue,  9 Nov 2010 11:36:15 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <AANLkTi=23MXbZeBF=eJLRnQycx4Bdg_an2aa_3oGWR66@mail.gmail.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161031>

Am 11/9/2010 10:49, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> On Tue, Nov 9, 2010 at 10:47, Johannes Sixt <j.sixt@viscovery.net> wr=
ote:
>> Am 11/9/2010 10:35, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>> Why is that a "*must*"?
>> ...
>>> But maybe you have reason to think otherwise? I haven't noticed any
>>> noticable slowdowns from doing it this way, but maybe I've been
>>> looking at the wrong thing.
>>
>> You didn't do your timings in Windows, did you? Every fork() that yo=
u can
>> avoid is a win.
>=20
> What's the result of timing it on Windows?

I do not have gettext, hence, I test 'git version' as a reference:

$ time (for i in {1..100}; do git version; done) > /dev/null

real    0m5.610s
user    0m1.707s
sys     0m0.712s

Then I tested this function. It is not exactly the same that you tested=
,
but it has the same number of subshells and builtin and external comman=
d
invocations:

eval_gettext ()
{
    gettext "$1" |
    ( : `git-sh-i18n--envsubst <<< "$1"`
      git-sh-i18n--envsubst <<< "$1"
    )
}

$ time (for i in {1..100}; do eval_gettext foobar; done) > /dev/null

real    0m20.578s
user    0m8.457s
sys     0m3.915s

Note that there are only 100 iterations, so we are talking about 0.2
seconds per eval_gettext call! That's an awful lot of time even for a
single error message.

-- Hannes
