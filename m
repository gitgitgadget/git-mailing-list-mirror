From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Rewrite bulk-checkin.c:finish_bulk_checkin() to use a
 strbuf for handling packname
Date: Fri, 28 Feb 2014 15:42:02 -0500
Message-ID: <CAPig+cTdMZw=tiJyr-0v_ZE_P92Yjc1g2YhhBF_Jv+ML87kz2Q@mail.gmail.com>
References: <1393576104-1758-1-git-send-email-sunheehnus@gmail.com>
	<CAPig+cSvkmZH2qEqKd=sjaMO8bfnxiKiuTKtfOuMCDwDfCDciw@mail.gmail.com>
	<CAPig+cSN1WGj9aMKHEo+JO6xN2dT_+0fEjPG3bK=ZsA4dwyWBw@mail.gmail.com>
	<CAJr59C2YTW-k=ujioUDfebf5koT4viB7NLtPk-do4T5Vo1Aqjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: =?UTF-8?B?5a2Z6LWr?= <sunheehnus@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 21:42:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJUG2-0002TW-N1
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 21:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbaB1UmF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Feb 2014 15:42:05 -0500
Received: from mail-yk0-f173.google.com ([209.85.160.173]:50367 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbaB1UmE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 15:42:04 -0500
Received: by mail-yk0-f173.google.com with SMTP id 10so3365314ykt.4
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 12:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=pJ6/F0EFegnJQXN8kgEf7zQhMbW9riSAVCxLanBelxE=;
        b=hlNy2lWQuZogAqrv4xIIKzI79Fr2lxO30NhireDPx2eq+NXYSIHWDFoysJZ0YkiNsA
         WvG2DHzIzu/UWQX5vmbps2yCQ4igi7FKVyOT6Cd20AfZ4xTUJKPZTJJFoH9LuIE41KMM
         VmDa1wk6/JPcZvlbqKNlFzO5dIO5KsOd8fQuU/tWv/n0rZn/IcuNrZ6pKOCNVrx63AUO
         LTve7qn/SdasSfZAT9CzjG7UrqVXQnRXutCcTHGGAXXEOUO2IqzEVKjqE52UCkeGtx/F
         Y7GRPGA/FF0wHQzmliuurily25dvKHiV9V/UO7HgeG2bijf/ZQ3ireunIVjEBtQuxZEW
         ByJA==
X-Received: by 10.236.74.73 with SMTP id w49mr4065790yhd.87.1393620122106;
 Fri, 28 Feb 2014 12:42:02 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Fri, 28 Feb 2014 12:42:02 -0800 (PST)
In-Reply-To: <CAJr59C2YTW-k=ujioUDfebf5koT4viB7NLtPk-do4T5Vo1Aqjw@mail.gmail.com>
X-Google-Sender-Auth: 27_9j7eYgt42DPSMNTB0HaeKQRU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243014>

On Fri, Feb 28, 2014 at 9:17 AM, =E5=AD=99=E8=B5=AB <sunheehnus@gmail.c=
om> wrote:
> 2014-02-28 21:12 GMT+08:00 Eric Sunshine [via git]
> <ml-node+s661346n7604500h1@n2.nabble.com>:
>> On Fri, Feb 28, 2014 at 4:46 AM, Eric Sunshine <[hidden email]> wrot=
e:
>>
>>> On Fri, Feb 28, 2014 at 3:28 AM, Sun He <[hidden email]> wrote:
>>>> Signed-off-by: Sun He <[hidden email]>
>>>> ---
>>>
>>> Nicely done.
>>>
>>> Due to the necessary changes to finish_tmp_packfile(), the focus of
>>> this patch has changed slightly from that suggested by the
>>> microproject. It's really now about finish_tmp_packfile() rather th=
an
>>> finish_bulk_checkin(). As such, it may make sense to adjust the pat=
ch
>>> subject to reflect this. For instance:
>>>
>>>   Subject: finish_tmp_packfile(): use strbuf for pathname construct=
ion
>>
>> You may also want your commit message to explain why you chose this
>> approach over other legitimate approaches. For instance, your change
>> places extra burden on callers of finish_tmp_packfile() by leaking a
>> detail of its implementation: namely that it wants to manipulate
>> pathnames easily (via strbuf). An equally valid and more encapsulate=
d
>> approach would be for finish_tmp_packfile() to accept a 'const char =
*'
>> and construct its own strbuf internally.
>>
>> If the extra strbuf creation in the alternate approach is measurably
>> slower, then you could use that fact to justify your implementation
>> choice in the commit message. On the other hand, if it's not
>> measurably slower, then perhaps the more encapsulated approach with
>> cleaner API might be preferable.
>>
>
> Thank you for your explaination. I get the point.
> And I think if it is proved that the strbuf way is measurably slower.
> We should add a check for the length of string before we sprintf().

I'm not sure what you mean by checking the string length before sprintf=
().

My point was that if there are multiple ways of solving the same
problem, it can be helpful for reviewers if your commit message
explains why the solution you chose is better than the others.

Slowness and/or cleanliness of API were just examples you might use in
your commit message for justifying why you chose one approach over
another.
