From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH 19/21] t9003: become resilient to GETTEXT_POISON
Date: Thu, 19 May 2016 21:31:52 +0000
Message-ID: <573E30C8.4070600@sapo.pt>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
 <1463585274-9027-20-git-send-email-vascomalmeida@sapo.pt>
 <CAPig+cT3yf7D4xOmOhy5Y21qwHuA5Ny9ULEJhC1OBgrhiayQ3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu May 19 23:32:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3VYV-00061r-TB
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 23:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853AbcESVb6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2016 17:31:58 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:56600 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753782AbcESVb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 17:31:58 -0400
Received: (qmail 694 invoked from network); 19 May 2016 21:31:54 -0000
Received: (qmail 11753 invoked from network); 19 May 2016 21:31:54 -0000
Received: from unknown (HELO [192.168.1.66]) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <avarab@gmail.com>; 19 May 2016 21:31:54 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <CAPig+cT3yf7D4xOmOhy5Y21qwHuA5Ny9ULEJhC1OBgrhiayQ3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295104>

=C3=80s 18:34 de 19-05-2016, Eric Sunshine escreveu:
> On Wed, May 18, 2016 at 11:27 AM, Vasco Almeida <vascomalmeida@sapo.p=
t> wrote:
>> The test t9003-help-autocorrect.sh fails when run under GETTEXT_POIS=
ON,
>> because it's expecting to filter out the original output. Accommodat=
e
>> gettext poison case by also filtering out the default simulated outp=
ut.
>>
>> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
>> ---
>> diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.=
sh
>> @@ -31,10 +31,14 @@ test_expect_success 'autocorrect showing candida=
tes' '
>>         git config help.autocorrect 0 &&
>>
>>         test_must_fail git lfg 2>actual &&
>> -       sed -e "1,/^Did you mean this/d" actual | grep lgf &&
>> +       sed -e "1,/^Did you mean this/d" actual |
>> +       sed -e "/GETTEXT POISON/d" actual |
>=20
> Why not do so with a single sed invocation?
>=20
>    sed -e "..." -e "..." |
>=20
>> +       grep lgf &&
>>
>>         test_must_fail git distimdist 2>actual &&
>> -       sed -e "1,/^Did you mean this/d" actual | grep distimdistim
>> +       sed -e "1,/^Did you mean this/d" actual |
>> +       sed -e "/GETTEXT POISON/d" actual |
>=20
> Ditto.
>=20
>> +       grep distimdistim
>>  '

I tried but it seems not to work.

Actually I did this wrong, I haven't thought this through.

Under gettext poison:
sed -e "1,/^Did you mean this/d" removes all lines, gives no output.
And then the one second, sed -e "/GETTEXT POISON/d", outputs "lgf" as
expected.

But running normally (without gettext poison):
1st sed outputs "lgf" as expected
And then second one output the entire 'actual' file, like if it were
cat, undoing the first sed.

I think the sed here is superfluous in the first place.
Should we remove it? If it weren't the case of gettext poison it was ok
to have sed there, but it makes the test fail under gettext poison.
