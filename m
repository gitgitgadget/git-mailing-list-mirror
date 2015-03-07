From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] daemon: use strbuf for hostname info
Date: Sat, 07 Mar 2015 01:54:12 +0100
Message-ID: <54FA4C34.6080702@web.de>
References: <54F96BF2.5000504@web.de> <20150306210627.GA24267@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 07 01:54:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU30m-0000eU-Pg
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 01:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756141AbbCGAyc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2015 19:54:32 -0500
Received: from mout.web.de ([212.227.17.12]:57226 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752732AbbCGAyb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 19:54:31 -0500
Received: from [192.168.178.27] ([79.253.128.80]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MejmG-1Y5mxv2I8m-00OCu5; Sat, 07 Mar 2015 01:54:27
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150306210627.GA24267@peff.net>
X-Provags-ID: V03:K0:PUsXGA9GCUh3CQ6D5IzVmyT0NxY/UsXtsgBobJYw81C+HV0Cdjh
 iPcdhDC/j3WBSfNFThFnHBIPp2WmCQ873Wzu3y+kLxwYpoVA2q9jlrJt9GCJ4Q09HuJVliG
 hdLnyMQ29KYfB1oHkNZNFyKuqZOrJn4ZRQmv7GGRKBdPFsghOx2iY33DAu3qyuKJKc+xXtY
 KHvk3qIz4vSMnPwyGjpjg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264981>

Am 06.03.2015 um 22:06 schrieb Jeff King:
> On Fri, Mar 06, 2015 at 09:57:22AM +0100, Ren=C3=A9 Scharfe wrote:
>>   				if (port) {
>> -					free(tcp_port);
>> -					tcp_port =3D sanitize_client(port);
>> +					strbuf_reset(&tcp_port);
>> +					sanitize_client_strbuf(&tcp_port, port);
>
> The equivalent of free() is strbuf_release(). I think it is reasonabl=
e
> to strbuf_reset here, since we are about to write into it again anywa=
y
> (though I doubt it happens much in practice, since that would imply
> multiple `host=3D` segments sent by the client). But later...
>
>> -	free(hostname);
>> -	free(canon_hostname);
>> -	free(ip_address);
>> -	free(tcp_port);
>> -	hostname =3D canon_hostname =3D ip_address =3D tcp_port =3D NULL;
>> +	strbuf_reset(&hostname);
>> +	strbuf_reset(&canon_hostname);
>> +	strbuf_reset(&ip_address);
>> +	strbuf_reset(&tcp_port);
>
> These probably want to all be strbuf_release(). Again, I doubt it
> matters much because this is a forked daemon serving only a single
> request (so they'll get freed by the OS soon anyway), but I think
> freeing the memory here follows the original intent.

Using a static strbuf means (in my mind) "don't worry about freeing,
a memory leak won't happen anyway because we reuse allocations".
The new code adds recycling of allocations, which I somehow expect
in connection with static allocations where possible.  You're right
that using strbuf_release() would match the original code more
strictly.

But this block is a no-op anyway because it's the first thing we do
to these (initially empty) variables.  That's not immediately
obvious and should be addressed in a separate patch.

Ren=C3=A9
