From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 2/3] make USE_NSEC work as expected
Date: Fri, 20 Feb 2009 21:42:25 -0800
Message-ID: <7vhc2os5vi.fsf@gitster.siamese.dyndns.org>
References: <cover.1235071656.git.barvik@broadpark.no>
 <24cefa55a62e2c898f9bd75ff7a6fe8e70836cf0.1235071656.git.barvik@broadpark.no>
 <7vab8hfqug.fsf@gitster.siamese.dyndns.org> <86mychifqj.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Sat Feb 21 06:53:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Laknn-000140-Aj
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 06:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbZBUFmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 00:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbZBUFme
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 00:42:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40305 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbZBUFme (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 00:42:34 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B8A72B985;
	Sat, 21 Feb 2009 00:42:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6E8F62B97C; Sat,
 21 Feb 2009 00:42:27 -0500 (EST)
In-Reply-To: <86mychifqj.fsf@broadpark.no> (Kjetil Barvik's message of "Fri,
 20 Feb 2009 11:07:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6E627C8A-FFDA-11DD-9807-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110927>

Kjetil Barvik <barvik@broadpark.no> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> +	ce->ce_ctime.sec = (unsigned int)st->st_ctime;
>>> +	ce->ce_mtime.sec = (unsigned int)st->st_mtime;
>>> +#ifdef USE_NSEC
>>> +	ce->ce_ctime.nsec = (unsigned int)st->st_ctim.tv_nsec;
>>> +	ce->ce_mtime.nsec = (unsigned int)st->st_mtim.tv_nsec;
>>> +#else
>>> +	ce->ce_ctime.nsec = 0;
>>> +	ce->ce_mtime.nsec = 0;
>>> +#endif
>>
>> How does this affect a use case where the same index file used with two 
>> instances of git (one compiled with and another without USE_NSEC)?
>
>   OK, I admit that I was thinking safe here,...

It was not a veiled objection in the guise of a rhetoric question.  I just
wanted to know what happens, when you have "/usr/bin/git" compiled without
NSEC and "/usr/local/bin/git" compiled with NSEC, and tried to use the two
interchangeably.  A NSEC enabled one will leave nsec in the index entry,
and the normal one reads from the index file (truncating the nsec from
both file timestamp and on-disk index entries), and it is unclear what it
does to the racy-git algorithm.  If there is no adverse effect, that is
great.  Otherwise, even though the on-disk format might be compatible, we
need to somehow tell people not to use two gits on the same index file.

>>> diff --git a/unpack-trees.c b/unpack-trees.c
>>> index e547282..44714cc 100644
>>> --- a/unpack-trees.c
>>> +++ b/unpack-trees.c
>>> @@ -380,8 +380,12 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>>>  
>>>  	memset(&o->result, 0, sizeof(o->result));
>>>  	o->result.initialized = 1;
>>> -	if (o->src_index)
>>> -		o->result.timestamp = o->src_index->timestamp;
>>> +	if (o->src_index) {
>>> +		o->result.timestamp.sec = o->src_index->timestamp.sec;
>>> +#ifdef USE_NSEC
>>> +		o->result.timestamp.nsec = o->src_index->timestamp.nsec;
>>> +#endif
>>> +	}
>>
>> Do we need this hunk?
>
>   Since timestamp is now a 'struct cache_time' member, I converted the
>   usage of this if-test to be in line with the USE_NSEC usage.

My question was if it is wrong to leave this as "a->timestamp = b->timestamp"
which now becomes structure assignment.  You would need to move extra 4
(or 8) bytes if you are not using NSEC, but this is not per index entry
but one assignment for the whole index file, so...
