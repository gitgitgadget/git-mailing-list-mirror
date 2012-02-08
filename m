From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: [StGit PATCH] Parse commit object header correctly
Date: Wed, 08 Feb 2012 21:04:16 +0100
Message-ID: <op.v9dl1e0v0aolir@keputer.lokaal>
References: <4F3120D4.1050604@warmcat.com>
 <7vvcni1r5u.fsf@alter.siamese.dyndns.org>
 <7vd39pzsmq.fsf_-_@alter.siamese.dyndns.org> <4F3247CA.1020904@alum.mit.edu>
 <CAH6sp9P=vNjLycgzoWzRbeEsW-kQ5e4HgGYf2jP1+u9rtWV4dg@mail.gmail.com>
 <4F32A014.1000608@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	=?utf-8?Q?Karl_Hasselstr=C3=B6m?= <kha@treskal.com>,
	"Catalin Marinas" <catalin.marinas@gmail.com>,
	=?utf-8?B?QW5keSBHcmVlbiAo5p6X5a6J5bu4KQ==?= <andy@warmcat.com>,
	git@vger.kernel.org
To: "Michael Haggerty" <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 08 21:04:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvDkc-0005oz-3Q
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 21:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757351Ab2BHUER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 15:04:17 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:65257 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756824Ab2BHUEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 15:04:16 -0500
Received: by eekc14 with SMTP id c14so308142eek.19
        for <git@vger.kernel.org>; Wed, 08 Feb 2012 12:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=1xurPtLPps7jFQ5f8EwyyaFsl0yYL8G+FgRnWEQqlMc=;
        b=OuM6XPz3IA+LSIUasM8FCjx3rvtjPsfQE2djzfOFGv1Xw8OTI9s52e9xfdmoJ+XjaP
         m3TtL3RQlq0IiaGVvUC+L+p0UuMfrOLroLt/HiFJuwGreZZZvYRbHqCBaDlcDP9qwjWJ
         hUz1KiWkoi55bCwVWb4KSSVEQ4116PyDMmdF8=
Received: by 10.213.26.14 with SMTP id b14mr2984306ebc.3.1328731454943;
        Wed, 08 Feb 2012 12:04:14 -0800 (PST)
Received: from keputer.lokaal (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id x4sm837888eeb.4.2012.02.08.12.04.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Feb 2012 12:04:14 -0800 (PST)
In-Reply-To: <4F32A014.1000608@alum.mit.edu>
User-Agent: Opera Mail/12.00 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190251>

On Wed, 08 Feb 2012 17:17:24 +0100, Michael Haggerty  
<mhagger@alum.mit.edu> wrote:

> On 02/08/2012 11:43 AM, Frans Klaver wrote:
>> On Wed, Feb 8, 2012 at 11:00 AM, Michael Haggerty  
>> <mhagger@alum.mit.edu> wrote:
>>> On 02/08/2012 08:33 AM, Junio C Hamano wrote:
>>>> +            line = lines[i].rstrip('\n')
>>>> +            ix = line.find(' ')
>>>> +            if 0 <= ix:
>>>> +                key, value = line[0:ix], line[ix+1:]
>>>
>>> The above five lines can be written
>>>
>>>           for line in lines:
>>>               if ' ' in line:
>>>                   key, value = line.rstrip('\n').split(' ', 1)
>>>
>>> or (if the lack of a space should be treated more like an exception)
>>>
>>>           for line in lines:
>>>               try:
>>>                   key, value = line.rstrip('\n').split(' ', 1)
>>>               except ValueError:
>>>                   continue
>>
>> This is generally considered more pythonic: "It's easier to ask for
>> forgiveness than to get permission".
>
> Given that Junio explicitly wanted to allow lines with no spaces, I
> assume that lack of a space is not an error but rather a conceivable
> future extension.  If my assumption is correct, then it is misleading
> (and inefficient) to handle it via an exception.

I find the documenting more convincing than the efficiency, but from the  
phrasing I think you do too.


>>>        for line in lines:
>>>            if ' ' in line:
>>>                key, value = line.split(' ', 1)
>>>                if key == 'tree':
>>>                    cd = cd.set_tree(repository.get_tree(value))
>>>                elif key == 'parent':
>>>                    cd = cd.add_parent(repository.get_commit(value))
>>>                elif key == 'author':
>>>                    cd = cd.set_author(Person.parse(value))
>>>                elif key == 'committer':
>>>                    cd = cd.set_committer(Person.parse(value))
>>>        return cd
>>
>> One could also take the recommended python approach for
>> switch/case-like if/elif/else statements:
>>
>> updater = { 'tree': lambda cd, value:  
>> cd.set_tree(repository.get_tree(value),
>>                  'parent': lambda cd, value:
>> cd.add_parent(repository.get_commit(value)),
>>                  'author': lambda cd, value:  
>> cd.set_author(Person.parse(value)),
>>                  'committer': lambda cd, value:
>> cd.set_committer(Person.parse(value))
>>               }
>> for line in lines:
>>     try:
>>         key, value = line.split(' ', 1)
>>         cd = updater[key](cd, value)
>>     except ValueError:
>>         continue
>>     except KeyError:
>>         continue
>>
>> It documents about the same, but adds checking on double 'case'
>> statements. The resulting for loop is rather cleaner and the exception
>> approach becomes even more logical. I rather like the result, but I
>> guess it's mostly a matter of taste.
>
> I know this approach and use it frequently, but when one has to resort
> to lambdas and there are only four cases, it becomes IMHO less readable
> than the if..else version.

Well, as I said, its largely a matter of taste; four items is a corner  
case to me when thinking maintainability vs. readability. On the other  
hand, this doesn't seem like an oft-changing piece of code, so a longer  
list of if..elif..else shouldn't be a problem either.

Frans
