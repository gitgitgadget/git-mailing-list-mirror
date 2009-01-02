From: david@lang.hm
Subject: Re: how to track the history of a line in a file
Date: Fri, 2 Jan 2009 15:56:05 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0901021554581.21567@asgard.lang.hm>
References: <alpine.DEB.1.10.0901021405460.21567@asgard.lang.hm> <20090102212655.GA24082@coredump.intra.peff.net> <alpine.DEB.1.10.0901021459480.21567@asgard.lang.hm> <alpine.DEB.1.10.0901021544580.21567@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 02 23:55:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIsv9-00070D-0Q
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 23:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758254AbZABWxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 17:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758216AbZABWxs
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 17:53:48 -0500
Received: from mail.lang.hm ([64.81.33.126]:60821 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758088AbZABWxr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 17:53:47 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n02MrhXv024236;
	Fri, 2 Jan 2009 14:53:43 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.DEB.1.10.0901021544580.21567@asgard.lang.hm>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104439>

On Fri, 2 Jan 2009, david@lang.hm wrote:

> On Fri, 2 Jan 2009, david@lang.hm wrote:
>
>> On Fri, 2 Jan 2009, Jeff King wrote:
>> 
>>> The tricky thing here is what is "this line"? Using the line number
>>> isn't right, since it will change based on other content coming in and
>>> out of the file. You can keep drilling down by reblaming parent commits,
>>> but remember that each time you do that you are manually looking at the
>>> content and saying "Oh, this is the line I am still interested in." So I
>>> a script would have to correlate the old version and new version of the
>>> line and realize how to follow the "interesting" thing.
>>> 
>>> In your case, I think you want to see any commit in Makefile which
>>> changed a line with SUBLEVEL in it. Which is maybe easiest done as:
>>>
>>>  git log -z -p Makefile |
>>>    perl -0ne 'print if /\n[+-]SUBLEVEL/' |
>>>    tr '\0' '\n'
>>> 
>>> and is pretty fast. But obviously we're leveraging some content-specific
>>> knowledge about what's in the Makefile.
>> 
>> Ok, I hacked togeather a quick bash script to try this
>> 
> <SNIP>
>> the problem that this has is that line 3 of $COMMIT may not be line 3 of 
>> $COMMIT^, and if they aren't it ends up hunting down the wrong data
>> 
>> either that or I am not understanding the output of git blame properly 
>> (also very possible)
>
> I was misunderstanding git blame
>
> new script is
>
> #!/bin/bash
> line=`git blame -n -b -l -L /$1/,+1 -M $2`
> echo "-$line"
> foundCOMMIT=`echo "$line" |cut -c -40`
> foundline=`echo "$line" |cut -c 42- |cut -f 1 -d " "`
> while [ "$foundCOMMIT" != "                                        " ] ;do
> #git diff -U0 $foundCOMMIT..$foundCOMMIT^ $2
> line=`git blame -n -b -l -L $foundline,+1 -M $2 $foundCOMMIT^`
> echo "-$line"
> foundCOMMIT=`echo "$line" |cut -c -40`
> foundline=`echo "$line" |cut -c 42- |cut -f 1 -d " "`
> done
>
> this seems to be working for me now.

not quite, it works as long as the line doesn't move in the commit where 
it changes.

David Lang
