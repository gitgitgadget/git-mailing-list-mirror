From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCHv2 3/4] bundle: don't leak an fd in case of early return
Date: Fri, 1 Apr 2016 08:26:18 +0100
Organization: OPDS
Message-ID: <55AD693FD6AC44119B8368ABC36FB1A9@PhilipOakley>
References: <1459357518-14913-1-git-send-email-sbeller@google.com><1459357518-14913-4-git-send-email-sbeller@google.com><9C112693D94545DC917C90299E52A719@PhilipOakley> <CAGZ79kYMxJdh_8n8zaaaEQP_BqWfS12JEry1MHkYqwQPJTWTNw@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Eric Sunshine" <sunshine@sunshineco.com>,
	"Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
	<git@vger.kernel.org>
To: "Stefan Beller" <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 09:26:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1altTQ-0004XZ-Bk
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 09:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758386AbcDAH0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 03:26:22 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:63314 "EHLO
	smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758314AbcDAH0V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 03:26:21 -0400
Received: from PhilipOakley ([2.96.204.202])
	by smtp.talktalk.net with SMTP
	id ltTGagldWavFfltTGaFdz5; Fri, 01 Apr 2016 08:26:19 +0100
X-Originating-IP: [2.96.204.202]
X-Spam: 0
X-OAuthority: v=2.1 cv=M9ntU3Es c=1 sm=1 tr=0 a=nBDDDTVn/lToA/VoCIgfnQ==:117
 a=nBDDDTVn/lToA/VoCIgfnQ==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8 a=xtxXYLxNAAAA:8
 a=PKzvZo6CAAAA:8 a=FShkX---Heui2Daei4wA:9 a=QEXdDO2ut3YA:10
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfCstSV5ATXltpNFmN7frA7VRT3SUQAOVNtLuxT5g1El7PJC8glM9J79khhNMxwfSOqiBHbrSEYW8udOH1G0Eqmf7GTXfGBkNhK/ssvqXkBtWGn6V2Vud
 ubZRwk2c0O/SIb5JwXBzC/sH8b/VL8v67nAX3xrZNUTt6UNsQMoxxVdKxVH6pLJMvIGlC+mxPKTCVPWmLX2tDx3jtEpbKscH+WiTmjBB3YoJOSVirKmBv4af
 5WrhnQ2nNGkSURegVQdMgJ14wztL7K1JXCD0LvPtJOHWb7a3XcJq6WNB8t9Ovpf2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290511>

From: "Stefan Beller" <sbeller@google.com>
> On Thu, Mar 31, 2016 at 12:00 PM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> From: "Stefan Beller" <sbeller@google.com>
>>>
>>> In successful operation `write_pack_data` will close the `bundle_fd`,
>>> but when we exit early, we need to take care of the file descriptor
>>> as well as the lock file ourselves. The lock file may be deleted at the
>>> end of running the program, but we are in library code, so we should
>>> not rely on that.
>>>
>>> Helped-by: Jeff King <peff@peff.net>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>
>>
>> Has this been tested on Windows? I had a similar problem very recently
>> https://groups.google.com/forum/#!msg/git-for-windows/6LPxf9xZKhI/-s7XD18yCwAJ
>> where a bad rev-list-arg would cause the `bundle create` to die, and, on
>> windows, leave the incomplete bundle file locked.
>>
>> dscho suggested one possible solution for that, but I haven't had any 
>> time
>> to try any patches.
>
> I think with Jeffs suggestion to only rollback the lock in case of
> (!bundle_to_stdout)
> we're not making it worse. I do not have a Windows machine at hand to test 
> it :(

Thant's fine. I just wanted to make folks aware of the problem so it doesn't 
get worse.

It looks like the cause is that the 
bundle.c:compute_and_write_prerequisites(), which includes parsing the 
arg-list (and die on bad arg), is called after the creation and locking of 
the bundle file descriptor and header, thus leaving it hanging on Windows.

--

Philip 
