From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] t9001: avoid not portable '\n' with sed
Date: Wed, 04 Jun 2014 20:42:35 +0200
Message-ID: <538F689B.1020804@web.de>
References: <538ED6DF.5020505@web.de>	<xmqqr434vaeh.fsf@gitster.dls.corp.google.com> <xmqqd2eov8ys.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 04 20:43:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsG9g-0005OJ-CL
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 20:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbaFDSnP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2014 14:43:15 -0400
Received: from mout.web.de ([212.227.15.4]:61923 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109AbaFDSnO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 14:43:14 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LlayN-1WHHV81ryp-00bKnj; Wed, 04 Jun 2014 20:42:41
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <xmqqd2eov8ys.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:K8PgLCfqs57HOl38T4gJ73rFfXBCA9gr9YlLb8CD4kysjL4Q0aE
 WE7oa9GZyp/m4WjT1UnNmGTNeaf4txhDhihW65OUgYvKxh/rPoXDlr+M0Z476bMHyHnJmDk
 XMR+yT0aoQ4b1XKkRumG1i6IZcJA2ursm5WUdGipeN8gs5Yh1hQmAgshdkyQvej42tl5H/m
 3Tg+8CDvoZxJ7who/NBow==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250755>

On 2014-06-04 20.13, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>>
>>> t9001 used a '\n' in a sed expression to split one line into two li=
nes.
>>> Some versions of sed simply ignore the '\' before the 'n', treating
>>> '\n' as 'n'.
>>>
>>> As the test already requires perl as a prerequisite, use perl inste=
ad of sed.
>>>
>>> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
>>> ---
>>
>> Hmph.  I read this in pubs.opengroup.org/onlinepubs/9699919799/utili=
ties/sed.html
>>
>>     The escape sequence '\n' shall match a <newline> embedded in the
>>     pattern space.
>>
>> so it may be better to be a bit more explicit in the log message to
>> say whose implementation has this issue to warn people.
>>
>>>  t/t9001-send-email.sh | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
>>> index 64d9434..2bf48d1 100755
>>> --- a/t/t9001-send-email.sh
>>> +++ b/t/t9001-send-email.sh
>>> @@ -1342,7 +1342,7 @@ test_cover_addresses () {
>>>  	git format-patch --cover-letter -2 -o outdir &&
>>>  	cover=3D`echo outdir/0000-*.patch` &&
>>>  	mv $cover cover-to-edit.patch &&
>>> -	sed "s/^From:/$header: extra@address.com\nFrom:/" cover-to-edit.p=
atch >"$cover" &&
>>> +	"$PERL_PATH" -pe "s/^From:/$header: extra\@address.com\nFrom:/" c=
over-to-edit.patch | tr Q "$LF" >"$cover" &&
>>
>> We have a shell function "perl" in test-lib-function.sh these days
>> so that you do not have to write "$PERL_PATH" yourself in tests ;-)
>=20
> Also, piping output from perl to tr feels somewhat suboptimal.  I do
> not see where in the test material we use "Q to LF", and we may want
> to remove that altogether, but without that removal, an updated
> patch may look like this.
>=20
>  t/t9001-send-email.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 64d9434..9f06b8c 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -1342,7 +1342,10 @@ test_cover_addresses () {
>  	git format-patch --cover-letter -2 -o outdir &&
>  	cover=3D`echo outdir/0000-*.patch` &&
>  	mv $cover cover-to-edit.patch &&
> -	sed "s/^From:/$header: extra@address.com\nFrom:/" cover-to-edit.pat=
ch >"$cover" &&
> +	perl -pe "
> +		s/^From:/$header: extra\@address.com\nFrom:/;
> +		y/Q/\n/;
> +	" cover-to-edit.patch >"$cover" &&
>  	git send-email \
>  	  --force \
>  	  --from=3D"Example <nobody@example.com>" \
Good catch, the "tr" should had been removed.
My first version used
sed "s/^From:/$header: extra@address.comQFrom:/"
and the Q was replaced by tr with a literal LF.
So I think the 'Q' -> '\n' conversion should be removed completely :-)

The sed in question is /usr/bin/sed under Mac OS X.
Then we have the question: What exactly is the pattern space?

>In default operation, sed cyclically shall append a line of input, les=
s its terminating <newline> >character, into the pattern space....

Isn't that the stuff from the input?
But that doesn't make too much sence to me, since "input lines" are ter=
minated by \n.
So pattern space seems to mean output when they talk about the \n
Anyway, the \n (to insert a newline into the output) works under Linux,=
 but not Mac OS.




=20
