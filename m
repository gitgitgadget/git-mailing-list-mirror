From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Migrating away from SHA-1?
Date: Tue, 12 Apr 2016 18:38:25 -0700
Message-ID: <570DA311.3000500@zytor.com>
References: <570D78CC.9030807@zytor.com>
 <20160412234251.GB2210@sigill.intra.peff.net>
 <xmqqlh4imibd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 13 03:38:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq9lg-0000AP-GH
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 03:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757227AbcDMBiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 21:38:52 -0400
Received: from terminus.zytor.com ([198.137.202.10]:45998 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757149AbcDMBiw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 21:38:52 -0400
Received: from carbon-x1.hos.anvin.org ([67.51.76.21])
	(authenticated bits=0)
	by mail.zytor.com (8.15.2/8.14.5) with ESMTPSA id u3D1cXgN008577
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Tue, 12 Apr 2016 18:38:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
In-Reply-To: <xmqqlh4imibd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291362>

On 04/12/16 18:03, Junio C Hamano wrote:
>>
>> and so on. Of course trees don't have any space for this; they have a
>> fixed-length for the hash part of each record, which is basically:
>>
>>    <mode> <name> NUL <20-byte-sha1>
>>
>> So we'd probably need a "treev2" object type that gives room for an
>> algorithm byte (or we'd have to try to shove it into the mode, but since
>> old versions won't know the new algorithm anyway, I don't think it
>> solves that much...). Or you can just define for the whole tree object
>> (either implicit in its type, or in a header) that it always uses
>> algorithm X.
>
> This will hurt the performance a lot during the transition period as
> it no longer will be possible to rely on "most of the time a fine
> grained commit changes only a small part of the tree, and we can
> cheaply avoid descending into trees that haven't changed because we
> can tell that the corresponding tree objects in the pre- and post-
> trees have the same object name" optimization.  But we cannot avoid
> it.
>

Not really, because you can point to the algoX hash even for the 
existing objects.

Perhaps the tree object can add a format descriptor at the beginning; 
something like:

<invalid mode number> <hash format used>

>> Transitioning to that would be something like:
>>
>>    0. Overhaul all of the git code to handle arbitrary-sized object ids.
>>
>>    1. Decide on the new algorithm and implement it in git.
>>
>>    2. Recognize parameterized object ids in commits and tags (designing
>>       format, implementing the reading side).
>>
>>    3. Recognize parameterized object ids somehow in trees (designing
>>       format, implementing the reading side).
>>
>>    4. Teach the object database to index objects by the new algorithm (or
>>       possibly both algorithms).
>>
>>    5. Add a protocol extension so that both sides can decide which
>>       algorithm is being used when they talk about oids.
>>
>>    6. Add a config option to write references in objects using the new
>>       algorithm.
>>
>>    7. After a while, flip the config option on. Hopefully the readers
>>       from steps 1-5 have percolated to the masses by then, and it's not
>>       a horrible flag day.
>>
>> We're basically on step 0 right now. I'm sure I'm missing some
>> subtleties in there, too.
>
> One subtlety is that 7. "not a flag day" may not be a good thing.
>
> There has to be a section of a history that spans the transition,
> set of commits and trees that have pointers to both kinds of object
> names.  The narrower such a section of the history, the more
> pleasant to use the result of the transition would be.
>
> Different projects that can have their own flag days at their own
> pace is a good thing, so the above observation does not invalidate
> your transition plan, though.

I don't think there is any way this can *not* be by repository and 
somehow require a manual operation in order to preserve the 
cryptographic integrity.  In some ways, the transition point and the 
transition table becomes a special kind of tag object.  There may have 
to be more than one in the case of commits in multiple trees.
