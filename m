From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH v3 05/10] abspath: convert real_path_internal() to strbuf
Date: Tue, 29 Jul 2014 02:04:59 +0200
Message-ID: <53D6E52B.1050006@web.de>
References: <53D694A2.8030007@web.de> <53D6964E.1070100@web.de>	<20140728191649.GE11265@peff.net> <xmqqiomh40ui.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 29 02:05:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuuk-0004pG-CX
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 02:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbaG2AFF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2014 20:05:05 -0400
Received: from mout.web.de ([212.227.17.12]:54716 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169AbaG2AFF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 20:05:05 -0400
Received: from [192.168.178.27] ([79.253.140.83]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LuuS5-1WTxC03wrx-0104Bt; Tue, 29 Jul 2014 02:05:02
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqqiomh40ui.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:Ku6wGVCJ7egP+YJnWsgeLIICu+PeTvwflJGQh5fPstDLgDblv1T
 iqz0Igpnuba7XUCBnuH2HllyFC9eaReh1huji+pJRKxDrk22vKCKReS4qjUm/1GYGk+OGDw
 fU+xqM8CDf+59hx/8wvYPk/q2TKmaBDhh2xh6VDuoau/3fZtd9xq7B3EzFlx9y6IyVZZNQW
 yOYpLQOdo6tN+CYmcCJpw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254383>

Am 28.07.2014 um 23:42 schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
>
>> On Mon, Jul 28, 2014 at 08:28:30PM +0200, Ren=C3=A9 Scharfe wrote:
>>
>>> @@ -60,26 +58,22 @@ static const char *real_path_internal(const cha=
r *path, int die_on_error)
>>>   			goto error_out;
>>>   	}
>>>
>>> -	if (strlcpy(buf, path, PATH_MAX) >=3D PATH_MAX) {
>>> -		if (die_on_error)
>>> -			die("Too long path: %.*s", 60, path);
>>> -		else
>>> -			goto error_out;
>>> -	}
>>> +	strbuf_init(&sb, 0);
>>> +	strbuf_addstr(&sb, path);
>>
>> As with the other patch I just mentioned, should this be strbuf_rese=
t,
>> not strbuf_init? We want to reset the static buffer back to zero-siz=
e,
>> not throw it away and leak whatever was there.
>>
>> -Peff
>
> Yes, this one seems to be leaking.
>
> "Next call to the function invalidates the return value the last
> caller received" feels like playing with fire.  Most existing
> callers are safe in that the first thing they do to the returned
> string is xstrdup() it, but we would need to check all the other
> callers.

That's the price we pay for using static variables, no?  Callers need t=
o=20
consume them as long as they're fresh and multi-threading is not=20
allowed.  Before, callers could use wrong buffer contents, after the=20
patch they could still have a pointer to freed memory, which should be=20
more noticeable in tests.

Getting a strbuf_add_real_path() in order to avoid static variables=20
would be nice.  And it would also be nice if it worked without calling=20
chdir().  Nice topics for follow-up patches. :)

> I briefly thought it is not OK for set_git_work_tree(), which gets
> new_work_tree, calls real_path() to receive the value from the
> function, and then calls real_path() again on it.  The "We've
> already done it" optimization is the only thing that makes it safe,
> which feels overly fragile.

It wasn't introduced as an optimization, but to silence valgrind=20
(1d679de5: make_absolute_path: return the input path if it points to ou=
r=20
buffer).  set_git_work_tree() calls real_path() only once in each of it=
s=20
two branches.  However, one caller (init) hands it a path returned by=20
real_path(); we can change that (sent a patch).

Ren=C3=A9
