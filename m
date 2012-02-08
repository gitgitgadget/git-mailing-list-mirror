From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [StGit PATCH] Parse commit object header correctly
Date: Wed, 08 Feb 2012 17:17:24 +0100
Message-ID: <4F32A014.1000608@alum.mit.edu>
References: <4F3120D4.1050604@warmcat.com>	<7vvcni1r5u.fsf@alter.siamese.dyndns.org>	<7vd39pzsmq.fsf_-_@alter.siamese.dyndns.org>	<4F3247CA.1020904@alum.mit.edu> <CAH6sp9P=vNjLycgzoWzRbeEsW-kQ5e4HgGYf2jP1+u9rtWV4dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?S2FybCBIYXNzZWxzdHLDtm0=?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	=?UTF-8?B?IkFuZHkgR3JlZW4gKOael+WuieW7uCki?= <andy@warmcat.com>,
	git@vger.kernel.org
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 08 17:18:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvADb-0001Z4-Sg
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 17:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757291Ab2BHQR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 11:17:56 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50101 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535Ab2BHQRz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 11:17:55 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q18GHPBv026139
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 8 Feb 2012 17:17:25 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <CAH6sp9P=vNjLycgzoWzRbeEsW-kQ5e4HgGYf2jP1+u9rtWV4dg@mail.gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190243>

On 02/08/2012 11:43 AM, Frans Klaver wrote:
> On Wed, Feb 8, 2012 at 11:00 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 02/08/2012 08:33 AM, Junio C Hamano wrote:
>>> +            line = lines[i].rstrip('\n')
>>> +            ix = line.find(' ')
>>> +            if 0 <= ix:
>>> +                key, value = line[0:ix], line[ix+1:]
>>
>> The above five lines can be written
>>
>>           for line in lines:
>>               if ' ' in line:
>>                   key, value = line.rstrip('\n').split(' ', 1)
>>
>> or (if the lack of a space should be treated more like an exception)
>>
>>           for line in lines:
>>               try:
>>                   key, value = line.rstrip('\n').split(' ', 1)
>>               except ValueError:
>>                   continue
> 
> This is generally considered more pythonic: "It's easier to ask for
> forgiveness than to get permission".

Given that Junio explicitly wanted to allow lines with no spaces, I
assume that lack of a space is not an error but rather a conceivable
future extension.  If my assumption is correct, then it is misleading
(and inefficient) to handle it via an exception.

>>> +                if key == 'tree':
>>> +                    cd = cd.set_tree(repository.get_tree(value))
>>> +                elif key == 'parent':
>>> +                    cd = cd.add_parent(repository.get_commit(value))
>>> +                elif key == 'author':
>>> +                    cd = cd.set_author(Person.parse(value))
>>> +                elif key == 'committer':
>>> +                    cd = cd.set_committer(Person.parse(value))
>>
>> All in all, I would recommend something like (untested):
>>
>>        @return: A new L{CommitData} object
>>        @rtype: L{CommitData}"""
>>        cd = cls(parents = [])
>>        lines = []
>>        raw_lines = s.split('\n')
>>        # Collapse multi-line header lines
>>        for i, line in enumerate(raw_lines):
>>            if not line:
>>                cd.set_message('\n'.join(raw_lines[i+1:]))
>>                break
>>            if line.startswith(' '):
>>                # continuation line
>>                lines[-1] += '\n' + line[1:]
>>            else:
>>                lines.append(line)
>>
>>        for line in lines:
>>            if ' ' in line:
>>                key, value = line.split(' ', 1)
>>                if key == 'tree':
>>                    cd = cd.set_tree(repository.get_tree(value))
>>                elif key == 'parent':
>>                    cd = cd.add_parent(repository.get_commit(value))
>>                elif key == 'author':
>>                    cd = cd.set_author(Person.parse(value))
>>                elif key == 'committer':
>>                    cd = cd.set_committer(Person.parse(value))
>>        return cd
> 
> One could also take the recommended python approach for
> switch/case-like if/elif/else statements:
>
> updater = { 'tree': lambda cd, value: cd.set_tree(repository.get_tree(value),
>                  'parent': lambda cd, value:
> cd.add_parent(repository.get_commit(value)),
>                  'author': lambda cd, value: cd.set_author(Person.parse(value)),
>                  'committer': lambda cd, value:
> cd.set_committer(Person.parse(value))
>               }
> for line in lines:
>     try:
>         key, value = line.split(' ', 1)
>         cd = updater[key](cd, value)
>     except ValueError:
>         continue
>     except KeyError:
>         continue
> 
> It documents about the same, but adds checking on double 'case'
> statements. The resulting for loop is rather cleaner and the exception
> approach becomes even more logical. I rather like the result, but I
> guess it's mostly a matter of taste.

I know this approach and use it frequently, but when one has to resort
to lambdas and there are only four cases, it becomes IMHO less readable
than the if..else version.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
