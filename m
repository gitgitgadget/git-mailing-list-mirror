From: =?UTF-8?B?U2ViYXN0aWFuIEfDtnR0ZQ==?= <jaseg@physik.tu-berlin.de>
Subject: Re: [PATCH v4 0/5] Verify GPG signatures when merging and extend
 %G? pretty string
Date: Tue, 26 Mar 2013 17:43:18 +0100
Message-ID: <5151D026.7090403@physik.tu-berlin.de>
References: <7vli9bue40.fsf@alter.siamese.dyndns.org> <515180FD.7090906@physik.tu-berlin.de> <7vvc8et9dv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 26 17:43:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKWyW-0005eO-0x
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 17:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933988Ab3CZQnX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Mar 2013 12:43:23 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:11891 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755850Ab3CZQnW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 12:43:22 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-3) with esmtp 
	for <git@vger.kernel.org>
	id 1UKWxz-0004bT-Fn; Tue, 26 Mar 2013 17:43:21 +0100
Received: from [192.168.0.101] (cable-124-189.zeelandnet.nl [82.176.124.189])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id 294D811402
	for <git@vger.kernel.org>; Tue, 26 Mar 2013 17:43:19 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <7vvc8et9dv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219168>

On 03/26/2013 05:26 PM, Junio C Hamano wrote:
> Sebastian G=C3=B6tte <jaseg@physik.tu-berlin.de> writes:
>=20
>> On 03/26/2013 02:46 AM, Junio C Hamano wrote:> Sebastian G=C3=B6tte =
<jaseg@physik.tu-berlin.de> writes:
>>>> Rebased it onto the current 'master'. The second patch fixes that =
the GPG
>>>> status parser ignores the first line of GPG status output (that wo=
uld be caught
>>>> by the new merge signature verification test case).
>>>
>>> Thanks.
>>>
>>> Does it still make sure that it won't be fooled by the expected
>>> string appearing in the middle of a line, not at the beginning?
>>
>> I thought that would not be a problem until I noticed it checks for =
GOODSIG
>> before it checks for BADSIG. Here is a fix.
>=20
> What does the order of checking have to do with it?  I am confused...
>=20
> I was more worried about a case where you may end up misinterpreting
>=20
> [GNUPG:] BADSIG B0B5E88696AFE6CB [GNUPG:] GOODSIG B0B5E88696AFE6CB <y=
@xz>
>=20
> as showing goodsig when the signer's name was set to "[GNUPG:]
> GOODSIG B0B5E88696AFE6CB"
>=20
> The "\n" in the original was to make sure the expected message is at
> the beginning of a line.
I was assuming only a malicious user would use a name containing "[GNUP=
G:] SOMETHING_ALLCAPS". In this case, if the code would check for BADSI=
G/TRUST_NEVER/TRUST_UNKNOWN messages first, the signature would still b=
e rejected. Of course, in that case a non-malicious user with a name co=
ntaining "[GNUPG:] BADSIG" etc. would still run into problems.

This 4th version fixes that by checking whether the search string is at=
 the beginning of the status buffer (index 0) or at the beginning of a =
line (prefixed by '\n').
