From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 5/5] log: do not segfault on gmtime errors
Date: Mon, 24 Mar 2014 23:03:42 +0100
Message-ID: <5330ABBE.3080106@web.de>
References: <20140224073348.GA20221@sigill.intra.peff.net> <20140224074905.GE9969@sigill.intra.peff.net> <532D58B5.1080309@web.de> <20140324213342.GE13728@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 24 23:04:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSCyd-0007VG-9t
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 23:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbaCXWEJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2014 18:04:09 -0400
Received: from mout.web.de ([212.227.15.3]:57513 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbaCXWEI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 18:04:08 -0400
Received: from [192.168.178.27] ([79.250.180.170]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MOB7M-1WOviN0d1w-005cZh; Mon, 24 Mar 2014 23:04:07
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140324213342.GE13728@sigill.intra.peff.net>
X-Provags-ID: V03:K0:2GhXPAdOYe9d1ZjeedPZYi0/WU/uGy53ksuOuvwWLsSnkCAts3B
 wCWCdbIj5b1jiG514hNYf72q6JywImnZECAmurCUC4jAAEo0eNoGfuoUPLZ1BilbvyFSvg4
 J6n+xnLErrvfGuCx7ZwL8SB8CUp3KMP0J1UlRTXhrBkLIpvdFoY1OIhz6R3Io1tPz0sOICL
 H1CFBARASFYDr4l6kMJqw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244888>

Am 24.03.2014 22:33, schrieb Jeff King:
> On Sat, Mar 22, 2014 at 10:32:37AM +0100, Ren=C3=A9 Scharfe wrote:
>>> @@ -184,8 +184,10 @@ const char *show_date(unsigned long time, int =
tz, enum date_mode mode)
>>>   		tz =3D local_tzoffset(time);
>>>
>>>   	tm =3D time_to_tm(time, tz);
>>> -	if (!tm)
>>> -		return NULL;
>>> +	if (!tm) {
>>
>> Would it make sense to work around the FreeBSD issue by adding a che=
ck like
>> this?
>>
>> 	if (!tm || tm->tm_year < 70) {
>
> That feels like a bit of a maintenance headache.  Right now we do not
> internally represent times prior to the epoch, since we mostly use
> "unsigned long" through the code. So anything < 70 has to be an error=
=2E
> But it would be nice one day to consistently use a 64-bit signed time=
_t
> throughout git, and represent even ancient timestamps (e.g., for peop=
le
> doing historical projects, like importing laws into git). This would =
set
> quite a trap for people working later on the code.
>
> If the result is all-zeroes, can we check for that case instead? I
> suppose that will eventually create a "trap" at midnight on January 1=
st
> of the year 0 (though I am not sure such a date is even meaningful,
> given the history of our calendars).

Makes sense. That would be "Sun Jan 0 00:00:00 1900", however -- days=20
are 1-based and years 1900-based in struct tm.  Since a zeroth day is=20
invalid, would this suffice:

	if (!tm || !tm->tm_mday) {

(Yes, I'm lazy. :)

Ren=C3=A9
