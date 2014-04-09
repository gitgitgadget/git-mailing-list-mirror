From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] Unicode: update of combining code points
Date: Wed, 09 Apr 2014 18:48:29 +0200
Message-ID: <534579DD.1060607@web.de>
References: <201404072139.42519.tboegi@web.de> <20140407195458.GA3912@google.com> <xmqq61mj30tg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 18:50:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXvhJ-0002Ow-3u
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 18:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933344AbaDIQt4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Apr 2014 12:49:56 -0400
Received: from mout.web.de ([212.227.15.3]:63824 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932898AbaDIQtz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 12:49:55 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LmcN9-1X7XXa3FI3-00aCgx; Wed, 09 Apr 2014 18:48:29
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <xmqq61mj30tg.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:ZGQqOvDJQ+seJ/tDb8FmPwpt8gnAQoH9gIRdYCFoAVw2zLlMTih
 1Jh5eaoOsw7tjxhmDjM2hMV3Pzj11OFdRhCsoHGkn8AOdAkJZVStJQZFEqlpi2VHAaRvwvs
 XThd8tWW+i1U3r7wcmEfQWA5zG4nqYA3SP9F6o7Abgjy98zjvHovywXBOxetVbsd8EvouIo
 Dx8m0/CUC8ehz5PCpigAQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245979>

On 04/09/2014 12:37 AM, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Torsten B=C3=B6gershausen wrote:
>>
>>> Unicode 6.3 defines the following code as combining or accents,
>>> git_wcwidth() should return 0.
>>>
>>> Earlier unicode standards had defined these code point as "reserved=
":
>> Thanks for the update.  Could the commit message also explain how th=
is
>> was noticed and what the user-visible effect is?
>>
>> For example:
>>
>>  "Unicode just announced that <...>.  That means we should mark the
>>   relevant code points as combining characters so git knows they are
>>   zero-width and doesn't screw up the alignment when presenting bran=
ch
>>   names in columns with 'git branch --column'"
>>
>> or something like that.
> Perhaps (the original read clearly enough for me, though).
>
>> [...]
>>> 358 COMBINING DOT ABOVE RIGHT
>>> 359 COMBINING ASTERISK BELOW
>> I'm not sure this list is needed --- the code + the reference to the
>> Unicode 6.3 standard seems like enough (but if you think otherwise,
>> I don't really mind).
> I can go either way.
>
>>> This commit touches only the range 300-6FF, there may be more to be=
 updated.
>> The "there may be more" here sounds ominous.
> Indeed it does ;-)
>
>> Does that mean Unicode
>> 6.3 also added some zero-width characters in other ranges that shoul=
d
>> be dealt with in the future?  How many such ranges?  How do we know
>> when we're done?
>>
>> Just biting off the most important characters first and putting off
>> the rest for later sounds fine to me --- my complaint is that the
>> above comment doesn't make clear what the to-do list is for finishin=
g
>> the update later.
> I'll queue this at the tip of 'pu', not to forget about it while
> waiting for a clarification.
>
> Thanks.
Thanks for comments, here comes the long version of the strory:
I recently fooled myself by running
"git config --global user.name" with a decomposed "=C3=B6" on a new Mac=
 OS X machine.

While there was little problems on Mac OS, all Windows and Linux machin=
es stumbled
over the decomposed =C3=B6, to be more exact over 0x308, COMBINING DIAR=
ESIS, (the 2 dots),
giving all kind of weired output in "git log".

Looking into commit.c and utf8.c, how to improve the situation, I made =
this observations:
- Some code from commit.c can possibly be moved into utf8.c, so that we=
 only
  have 1 utf8 code parser.
- A solution would be to run precompose_string() under Mac OS (which is=
 a nop otherwise).
  This could have saved my day. Probably I will make a patch some day.
- Some of the combining code points exist in Unicode 6.3, but not in ut=
f8.c
  (which seams to be based on Unicode >2.0 <6.3)
  I found some in the 0x300 area, and looked at the neighbors, and had =
enough time to
  read all code pages up to 0x7FF.=20

 So if somebody knows how to find out which code points that are combin=
ed, accents,,, or in other words should return 0 in git_wcwidth(), plea=
se let me know.

How about this as a commit message:

Unicode: partially update to version 6.3

Unicode 6.3 defines the following code points as combining or accents,
git_wcwidth() should return 0.

Earlier unicode standards had defined these code point as "reserved":
358--35C
487
5A2, 5BA, 5C5, 5C7
604, 616--61A, 659--65F

Note: for this commit only the range 0..7FF has been checked,
more updates may be needed.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
