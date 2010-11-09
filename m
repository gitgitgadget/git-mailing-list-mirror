From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH 1/5] gettext: fix bug in git-sh-i18n's eval_gettext()
 by using envsubst(1)
Date: Tue, 09 Nov 2010 12:42:55 +0100
Message-ID: <4CD933BF.6070105@viscovery.net>
References: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com>	<1288524860-538-2-git-send-email-avarab@gmail.com>	<4CCFCCC8.7080603@viscovery.net>	<AANLkTimjRwSxkemMffASvHCxK009b1fnvNRs05_T_1DF@mail.gmail.com>	<4CD8F965.6050402@viscovery.net>	<AANLkTinKYJtaDjwEk0OqebBnL6+wvVO4wfWg7G-VYh7d@mail.gmail.com>	<4CD918AB.6060206@viscovery.net>	<AANLkTi=23MXbZeBF=eJLRnQycx4Bdg_an2aa_3oGWR66@mail.gmail.com>	<4CD9241F.6070807@viscovery.net> <AANLkTins_qq=unv101JuV_CVvkp3KbTq5qycva7bZ7sm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 12:43:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFmbS-0000Ui-Ea
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 12:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473Ab0KILnB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 06:43:01 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:59841 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755392Ab0KILnA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 06:43:00 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PFmbH-00077X-UK; Tue, 09 Nov 2010 12:42:56 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A8F921660F;
	Tue,  9 Nov 2010 12:42:55 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <AANLkTins_qq=unv101JuV_CVvkp3KbTq5qycva7bZ7sm@mail.gmail.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161034>

Am 11/9/2010 11:52, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> On Tue, Nov 9, 2010 at 11:36, Johannes Sixt <j.sixt@viscovery.net> wr=
ote:
>> $ time (for i in {1..100}; do git version; done) > /dev/null
>>
>> real    0m5.610s
=2E..
>> $ time (for i in {1..100}; do eval_gettext foobar; done) > /dev/null
>>
>> real    0m20.578s
=2E..
>> Note that there are only 100 iterations, so we are talking about 0.2
>> seconds per eval_gettext call! That's an awful lot of time even for =
a
>> single error message.
>=20
> Thanks for elaborating. But just so I understand you correctly it's a
> cost of invoking *any* program in shellscripts on Windows? So e.g. 10
> sed calls would cost the same as 10 git-sh-i18n--envsubst calls (but
> of course 5 eval_gettext() calls, since it calls git-sh-i18n--envsubs=
t
> twice).

An invocation of sed, cat, etc. (POSIX/MSYS tools) is cheaper by a fact=
or
of 2 than a git invocation for a reason that I do not understand. (Perh=
aps
it has to do with the number of DLLs that are linked; git has 9 static
dependencies, MSYS tools only 3.)

eval_gettext involves 2 git invocation (git-sh-i18n--envsubst counts as
much as git) and 1 subshell in practice (some subshells are optimized a=
way).

> So e.g. using eval_gettext once isn't a bigger problem than calling
> some trivial sed substitution twice?

Look at the timings: In my book, eval_gettext counts like about 8 sed
substitutions.

-- Hannes
