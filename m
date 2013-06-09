From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v3 2/2] read-cache: plug a few leaks
Date: Sun, 09 Jun 2013 19:38:39 +0200
Message-ID: <51B4BD9F.6070107@lsrfire.ath.cx>
References: <1370644168-4745-1-git-send-email-felipe.contreras@gmail.com> <1370644168-4745-3-git-send-email-felipe.contreras@gmail.com> <51B31651.6020307@lsrfire.ath.cx> <CAMP44s2Bp5p1211e6Utdch4B+v3J83GCY0_ucG7duakswkb+pg@mail.gmail.com> <51B32FFD.5070302@lsrfire.ath.cx> <CAMP44s3K=VtkeCoKqnU9To9YbfO7vph9MsMWtgLWw0n=cYyq5g@mail.gmail.com> <51B35414.1090101@lsrfire.ath.cx> <CAMP44s3UYCX+DzgnErB=0GdD3w5k2GkNKjv46ZA_NVHm1Z0YLQ@mail.gmail.com> <51B36849.3030608@lsrfire.ath.cx> <CAMP44s1ffOUd3DkphHAj8ZmovBazPFdMgtvEptR6kW9+ZMLLjA@mail.gmail.com> <51B3E44C.4030304@lsrfire.ath.cx> <CAMP44s0RqtoP8iHZ+rEqPDKSLxZLESS8qKFhb2vzSd7-mtKreQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:38:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljZr-0002Cv-My
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485Ab3FIRis convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:38:48 -0400
Received: from india601.server4you.de ([85.25.151.105]:59090 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab3FIRir (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:38:47 -0400
Received: from [192.168.2.105] (p4FFD9DEC.dip0.t-ipconnect.de [79.253.157.236])
	by india601.server4you.de (Postfix) with ESMTPSA id 858961DA;
	Sun,  9 Jun 2013 19:38:45 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CAMP44s0RqtoP8iHZ+rEqPDKSLxZLESS8qKFhb2vzSd7-mtKreQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227045>

Am 09.06.2013 04:25, schrieb Felipe Contreras:
> On Sat, Jun 8, 2013 at 9:11 PM, Ren=C3=A9 Scharfe
> <rene.scharfe@lsrfire.ath.cx> wrote:
>> Am 08.06.2013 19:27, schrieb Felipe Contreras:
>>
>>> On Sat, Jun 8, 2013 at 12:22 PM, Ren=C3=A9 Scharfe
>>> <rene.scharfe@lsrfire.ath.cx> wrote:
>>>
>>>> Let's find and fix those leaks by freeing memory in the right plac=
es.
>>>> Freeing memory just in case in places where we can show that no le=
ak is
>>>> triggered by our test suite doesn't help.
>>>
>>>
>>> It helps; it prevents leaks. The real culprit is the bogus API, but=
 I
>>> don't see that changing anytime soon, so there are two options when
>>> somebody makes a mistake the API allows; leak or don't leak. And yo=
u
>>> seem to prefer the leak, even though it provides absolutely no
>>> advantage.
>>
>> It covers up bugs,
>
> It doesn't. I thought you already silently agreed that nobody would
> ever find that leak, as they haven't found the hundreds of leaks that
> plague Git's code.

Nah, I explained non-silently that leakage was a design decision for=20
short-running commands that allocate memory, use it and exit.  Reusing=20
such code without freeing allocated memory between runs explicitly turn=
s=20
a "good" leak into a "bad" one, as we saw with cherry-pick --stdin.

>> What would be a better API?  Making discard_index free the array is =
a good
>> first step; what else is bogus?
>
> 'initialized' for starters; it should be renamed to 'loaded' or
> removed, but removing it would require many more changes to make sure
> we don't load twice. Also, when loading cache entries, it might make
> sense to check if there's already entries that have not been
> previously discarded properly.

Adding diagnostics that help find leaks is a good idea.

So, from reading the code, this sequence is OK:

	discard_cache()		// defined starting point
	read_cache()		// reads the cache
	read_cache()		// does nothing

And I guess this one is not OK:

	discard_cache()		// defined starting point
	add_index_entry()	// add single entry
	read_cache()		// currently leaks, should warn/die

Any more sequences that we need to guard against, or counterexamples?

> In the meantime, just in case, the only sane thing to do is free the
> entries rather than leak.

I consider not plugging a leak which we don't know how to trigger with=20
existing code even more sane.  Yay, circles! ;-)

> That being said I'm not interested in this patch any more. The patch
> is good yet after three tries and countless arguments it's still not
> applied, nor is there any sign of getting there.

Let's take it step by step: Once the known leak is plugged we can worry=
=20
about the unknown ones.  I'll send small patches.

Ren=C3=A9
