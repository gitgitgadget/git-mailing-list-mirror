From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 11/25] object_array_remove_duplicates(): rewrite to
 reduce copying
Date: Thu, 30 May 2013 23:14:46 +0200
Message-ID: <51A7C146.6090605@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu> <1369472904-12875-12-git-send-email-mhagger@alum.mit.edu> <7vk3mhwyiq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 30 23:14:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiABU-0004CO-E5
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 23:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758785Ab3E3VOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 17:14:53 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:45519 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758369Ab3E3VOv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 17:14:51 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-0a-51a7c14a05e9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id C2.63.02380.A41C7A15; Thu, 30 May 2013 17:14:50 -0400 (EDT)
Received: from [192.168.69.140] (p57A24A59.dip0.t-ipconnect.de [87.162.74.89])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4ULEkVA028548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 30 May 2013 17:14:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7vk3mhwyiq.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsUixO6iqOt1cHmgQXeTnEXXlW4mi4beK8wW
	8+7uYrL40dLDbHH38ip2B1aPSy+/s3ncfj2f2eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M7Y9G0tS8F66Yqmg7uYGhjfiHYxcnJICJhIfDzVxwZhi0lcuLceyObiEBK4zCjxbvF8
	JgjnHJNEw8FNzCBVvALaEtvbHjOB2CwCqhJTLzxhBbHZBHQlFvU0g8VFBcIk3i+bygpRLyhx
	cuYTFhBbREBNYmLbITCbWaBe4tSay2C2sEC0xOFJq1gglq1glNh1+hbYIE4BM4nvu1czQzTo
	SLzrewBly0tsfzuHeQKjwCwkO2YhKZuFpGwBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1j
	vdzMEr3UlNJNjJAw59vB2L5e5hCjAAejEg/vwZTlgUKsiWXFlbmHGCU5mJREeQP2AYX4kvJT
	KjMSizPii0pzUosPMUpwMCuJ8M5dC5TjTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1I
	LYLJynBwKEnw7jgA1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPitb4YmC8gqR4
	gPYuB2nnLS5IzAWKQrSeYtTlmPFj8jtGIZa8/LxUKXHeMyBFAiBFGaV5cCtgSe0VozjQx8K8
	u0CqeIAJEW7SK6AlTEBLnliDLSlJREhJNTDWLJTZGXTML5DZxea4j8gb8cdTK1NNT1UXbDzl
	U9AmXKF96zlXh6fi5BP3bkVt2SGyUoTv0cPK88K+iz68S0n7pPcmKDnffq8X08MP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226036>

On 05/29/2013 06:18 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> The old version copied one entry to its destination position, then
>> deleted any matching entries from the tail of the array.  This
>> required the tail of the array to be copied multiple times.  It didn't
>> affect the complexity of the algorithm because the whole tail has to
>> be searched through anyway.  But all the copying was unnecessary.
>>
>> Instead, check for the existence of an entry with the same name in the
>> *head* of the list before copying an entry to its final position.
>> This way each entry has to be copied at most one time.
>>
>> Extract a helper function contains_name() to do a bit of the work.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  object.c | 32 +++++++++++++++++++++-----------
>>  object.h |  6 +++++-
>>  2 files changed, 26 insertions(+), 12 deletions(-)
>>
>> diff --git a/object.c b/object.c
>> index fcd4a82..10b5349 100644
>> --- a/object.c
>> +++ b/object.c
>> @@ -294,22 +294,32 @@ void object_array_filter(struct object_array *array,
>>  	array->nr = dst;
>>  }
>>  
>> +/*
>> + * Return true iff array already contains an entry with name.
>> + */
>> +static int contains_name(struct object_array *array, const char *name)
>> +{
>> +	unsigned nr = array->nr, i;
>> +	struct object_array_entry *object = array->objects;
>> +
>> +	for (i = 0; i < nr; i++, object++)
>> +		if (!strcmp(object->name, name))
>> +			return 1;
>> +	return 0;
>> +}
> 
> Because some codepaths (e.g. patch 14/25) stuff NULL in the name
> field, we may want to be more careful with this.
> 
> This is not a new problem, and I think the longer term solution is
> to get rid of object_array_remove_duplicates(), so it is perfectly
> fine to leave this function broken with respect to NULL input as-is.

You make a good point about NULL names, but I agree to leave it for now
since it needs work anyway.

> The only caller of remove-duplicates is bundle.c, which gets many
> starting points and end points from the command line and tries to be
> nice by removing obvious duplicates, e.g.
> 
> 	git bundle create t.bundle master master
> 
> but I think its logic of deduping is wrong.  It runs dwim_ref() on
> the incoming refs after the remove-duplicates call, so
> 
> 	git bundle create t.bundle master heads/mater
> 
> will end up with two copies of refs/heads/master.  To fix it, the
> code must dedup the result of running dwim_ref(), and at that point,
> there is no reason to call object_array_remove_duplicates().

That sounds reasonable.

I poked around this code a bit to understand what is going on, and it
occurred to me that the object_array can include both positive and
negative references, right?  And yet object_array_remove_duplicates()
only considers names, not flags.  So it seems to me that if the deduping
code would see the same reference twice, once positive and once
negative, then it would throw an arbitrary one of them out, which would
be wrong.

But I couldn't provoke this situation, so perhaps setup_revisions()
already specially treats combinations like "master ^master"?  (If that's
true then why? and wouldn't it get confused by "master ^heads/master"?)

I suppose someday I will have to dig into these functions and maybe even
document them.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
