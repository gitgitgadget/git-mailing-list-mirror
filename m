From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 04/12] refs: implement simple transactions for the
 packed-refs file
Date: Thu, 20 Jun 2013 09:49:51 +0200
Message-ID: <51C2B41F.2050708@alum.mit.edu>
References: <1371628293-28824-1-git-send-email-mhagger@alum.mit.edu> <1371628293-28824-5-git-send-email-mhagger@alum.mit.edu> <7vfvwdzz6k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 09:50:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpZd3-0000Wf-Cf
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 09:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970Ab3FTHt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 03:49:57 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:59401 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754273Ab3FTHt4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jun 2013 03:49:56 -0400
X-AuditID: 1207440e-b7f0f6d0000043b7-51-51c2b42311af
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 6E.F3.17335.324B2C15; Thu, 20 Jun 2013 03:49:55 -0400 (EDT)
Received: from [192.168.69.140] (p57A25408.dip0.t-ipconnect.de [87.162.84.8])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5K7nq9Q032025
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Jun 2013 03:49:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7vfvwdzz6k.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsUixO6iqKu85VCgwe2t6hZdV7qZLBp6rzBb
	zLu7i8niR0sPs8XuaQvYHFg9Lr38zubxrHcPo8fFS8oejyeeYPX4vEkugDWK2yYpsaQsODM9
	T98ugTtj0d+igiXSFXfe3GZuYPwv2sXIySEhYCLRdXkaG4QtJnHh3nogm4tDSOAyo8SeJ7NZ
	IZyzTBIvlz9jBKniFdCWWPprByuIzSKgKrHr0lKwbjYBXYlFPc1MILaoQJjE+2VTWSHqBSVO
	znzCAmKLCKhJTGw7xAIylFmgk1Hi5sKfYEOFBWIkGv7eYILYtpxR4nJbO1g3p4CZRMfEN+wg
	NrOAjsS7vgfMELa8xPa3c5gnMArMQrJkFpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N1i1OTszL
	Sy3SNdbLzSzRS00p3cQICXO+HYzt62UOMQpwMCrx8GpcPhgoxJpYVlyZe4hRkoNJSZR3/aZD
	gUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeFPnAOV4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNL
	UrNTUwtSi2CyMhwcShK8eZuBGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJB0Rpf
	DIxXkBQP0N6DIDfxFhck5gJFIVpPMepyHPix5T2jEEtefl6qlDivL8gOAZCijNI8uBWwpPaK
	URzoY2Fee5AqHmBChJv0CmgJE9CSPavBlpQkIqSkGhj7LZaasO4IOfF8svaEX8ukz7/KF3pp
	odH0+bCEaMA+losz7v2Pa3Uo/8DMFMKw97i00VJnie0sjPON11xu/57eaHH27UGb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228446>

On 06/19/2013 09:18 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Handle simple transactions for the packed-refs file at the
>> packed_ref_cache level via new functions lock_packed_refs(),
>> commit_packed_refs(), and rollback_packed_refs().
>>
>> Only allow the packed ref cache to be modified (via add_packed_ref())
>> while the packed refs file is locked.
>>
>> Change clone to add the new references within a transaction.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  builtin/clone.c |  7 ++++-
>>  refs.c          | 83 ++++++++++++++++++++++++++++++++++++++++++++++-----------
>>  refs.h          | 27 +++++++++++++++++--
>>  3 files changed, 98 insertions(+), 19 deletions(-)
>>
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index 66bff57..b0c000a 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -489,17 +489,22 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
>>  	return local_refs;
>>  }
>>  
>> +static struct lock_file packed_refs_lock;
>> +
>>  static void write_remote_refs(const struct ref *local_refs)
>>  {
>>  	const struct ref *r;
>>  
>> +	lock_packed_refs(&packed_refs_lock, LOCK_DIE_ON_ERROR);
>> +
>>  	for (r = local_refs; r; r = r->next) {
>>  		if (!r->peer_ref)
>>  			continue;
>>  		add_packed_ref(r->peer_ref->name, r->old_sha1);
>>  	}
>>  
>> -	pack_refs(PACK_REFS_ALL);
>> +	if (commit_packed_refs())
>> +		die_errno("unable to overwrite old ref-pack file");
>>  }
> 
> The calling convention used here looks somewhat strange.  You allow
> callers to specify which lock-file structure is used when locking,
> but when you are done, commit_packed_refs() does not take any
> parameter.
> 
> lock_packed_refs() make the singleton in-core packed-ref-cache be
> aware of which lock it is under, so commit_packed_refs() does not
> need to be told (the singleton already knows what lockfile is in
> effect), so I am not saying the code is broken, though.
> 
> Does the caller need to even have an access to this lock_file
> instance?

No it doesn't.  My reasoning was as follows:

lock_file instances can never be freed, because they are added to a
linked list in the atexit handler but never removed.  Therefore they
have to be allocated statically (or allocated dynamically then leaked).

[I just noticed that lock_ref_sha1_basic() leaks a struct lock_file
every time that it is called.]

I wanted to leave the way open to allow other packed refs caches to be
locked.  But since all packed refs caches are allocated dynamically, the
lock_file instance cannot be part of struct packed_ref_cache.  So I
thought that the easiest approach is to rely on the caller, who
presumably can know that only a finite number of locks are in use at
once, to supply a usable lock_file instance.

But currently only the main packed ref cache can be locked, so it would
be possible for lock_packed_refs() to use the static packlock instance
for locking.  I will change it to do so.

If/when we add support for locking other packed ref caches, we can
change the API to use a caller-supplied lock_file.  Or even better,
implement a way to remove a lock_file instance from the atexit list;
then lock_packed_refs() could use dynamically-allocated lock_file
instances without having to leak them.

v3 to come.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
