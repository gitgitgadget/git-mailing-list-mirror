From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/28] Store references hierarchically in cache
Date: Fri, 28 Oct 2011 20:45:21 +0200
Message-ID: <4EAAF841.3090900@alum.mit.edu>
References: <1319804921-17545-1-git-send-email-mhagger@alum.mit.edu> <CALkWK0=Hsq_yg1Vyr-3_jf9n=WcB_XNYRQa0SEhSWD5VxKBXQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 20:45:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJrRA-0005Xo-Hl
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 20:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933102Ab1J1Sps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 14:45:48 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:52316 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933096Ab1J1Spr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 14:45:47 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.133] (p54BEBE28.dip.t-dialin.net [84.190.190.40])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9SIjL4c009901
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 28 Oct 2011 20:45:21 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <CALkWK0=Hsq_yg1Vyr-3_jf9n=WcB_XNYRQa0SEhSWD5VxKBXQg@mail.gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184427>

On 10/28/2011 03:07 PM, Ramkumar Ramachandra wrote:
> Michael Haggerty writes:
>> Therefore, this patch series changes the data structure used to store
>> the reference cache from a single array of pointers-to-struct into a
>> tree-like structure in which each subdirectory of the reference
>> namespace is stored as an array of pointers-to-entry and entries can
>> be either references or subdirectories containing more references.
> 
> Very nice! I like the idea. Can't wait to start reading the series.
> 
>>  * refs/replace is almost *always* needed even though it often
>>    doesn't even exist.  Thus the presence of many loose references
>>    slows down *many* git commands for no reason whatsoever.
> 
> Was this one of your primary inspirations for writing this series?

My primary inspiration was that "git filter-branch" was so slow, which
is partly because of the refs/replace thing and partly just the built-in
inefficiency of the old reference cache.

>> * the time to create a new branch goes from 180 ms to less than 10 ms
>>  (my test resolution only includes two decimal places) and the time
>>  to checkout a new branch does the same.
> 
> I'm interested in seeing how the callgraph changed.  Assuming you used
> Valgrind to profile it, could you publish the outputs?

I didn't use valgrind; I just timed commands using time(1).

>> The efficiency gains are such that some operations are now faster with
>> loose references than with packed references; however, some operations
>> with packed references slow down a bit.
> 
> Curiously, why do operations with packed references slow down?  (I'll
> probably find out in a few minutes after reading the series, but I'm
> asking anyway because it it's very non-obvious to me now)

I think it's just because the new data structure is slightly slower than
the old one for the task of appending thousands of refs without doing
any searching or sorting.  Since packed refs are read all-or-nothing
(even after my changes), there is no way to read the packed refs only
for the directory that you are interested in.

>> Patches 11-24 change most of the internal functions to work with
>> "struct ref_entry *" (namely the kind of ref_entry that holds a
>> directory of references) instead of "struct ref_dir *".  The reason
>> for this change it to allow these functions access to the "flag" and
>> "name" fields that are stored in ref_entry and thereby avoid having to
>> store redundant information in "struct ref_dir" (which would increase
>> the size of *every* ref_entry because of its presence in the union).
> 
> Hm, I was wondering why the series was looking so intimidating.  Is it
> not possible to squash all (or atleast some) of these together?

Why would I possibly want to squash them together?  Each one is
self-contained and logically separate from the rest.  After each commit
the code compiles and works.  Squashing them together wouldn't increase
the cognitive burden of reading them; on the contrary, it would make it
harder to read them because several logically-separate changes would be
confounded into a single patch.  Most of these patches have only a few
nontrivial lines which you can read at a glance.  And if the series ever
has to be bisected, the error can be narrowed down to a very small diff.

>> From: Michael Haggerty <mhagger@alum.mit.edu>
> 
> Nit: Can't you configure your email client to put this in the "From: "
> header of your emails?

I'm not sure where those extra lines come from.  My email client is
git-send-email.  I just checked, and they have appeared in patch series
sent through two completely different SMTP servers, so it seems unlikely
that the SMTP server is guilty.  I'll see if I can figure it out.

> Thanks for the interesting read.

Thanks for reading :-)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
