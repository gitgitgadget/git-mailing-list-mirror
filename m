From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 14/33] refs: extract a function peel_entry()
Date: Tue, 16 Apr 2013 15:07:43 +0200
Message-ID: <516D4D1F.5010207@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu> <1365944088-10588-15-git-send-email-mhagger@alum.mit.edu> <7v38urwv6o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 15:08:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US5c8-0007D6-LI
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 15:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934590Ab3DPNHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 09:07:49 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:61212 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754832Ab3DPNHr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 09:07:47 -0400
X-AuditID: 1207440f-b7f0e6d000000957-0b-516d4d2264ae
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 07.A7.02391.22D4D615; Tue, 16 Apr 2013 09:07:46 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3GD7hes027352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 16 Apr 2013 09:07:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7v38urwv6o.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsUixO6iqKvkmxtoMGEvu0XXlW4mi4beK8wW
	Kx/fZbb40dLD7MDi0f7+HbPHs949jB4XLyl7fN4kF8ASxW2TlFhSFpyZnqdvl8CdcftII2vB
	QvGKWavPsTcwXhbqYuTkkBAwkTh+4CA7hC0mceHeerYuRi4OIYHLjBK/96+Cco4zScw++JgZ
	pIpXQFviX8M3RhCbRUBVYsbbyywgNpuArsSinmYmEFtUIExi1fplUPWCEidnPgGrERFQk5jY
	dgjI5uBgFoiROHcV7AhhAQeJm+fOQ+1awSjxfecfsF5OATOJC48OgM1kFtCReNf3gBnClpfY
	/nYO8wRGgVlIVsxCUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbomermZJXqpKaWb
	GCEBzb+DsWu9zCFGAQ5GJR7eAPmcQCHWxLLiytxDjJIcTEqivFaeuYFCfEn5KZUZicUZ8UWl
	OanFhxglOJiVRHjPOgLleFMSK6tSi/JhUtIcLErivOpL1P2EBNITS1KzU1MLUotgsjIcHEoS
	vGI+QI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoFiNLwZGK0iKB2jvB2+QvcUF
	iblAUYjWU4zGHLO2PnnNyLHyCpAUYsnLz0uVEue9BlIqAFKaUZoHtwiWyl4xigP9Lcx7HaSK
	B5gG4ea9AlrFBLTqwKpskFUliQgpqQbGxdnNJg1en2Kn8pmwnYli6Er6f8Jh9dQzfxi9T91s
	92J5fyDAwXmOTxDLnak5R9fM3eZT8LyTLS76kpNAgzDPsjtzFLM/5xecXiylHM2f 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221414>

On 04/15/2013 07:38 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>>  	if (read_ref_full(refname, base, 1, &flag))
>>  		return -1;
>>  
>> -	if ((flag & REF_ISPACKED)) {
>> +	/*
>> +	 * If the reference is packed, read its ref_entry from the
>> +	 * cache in the hope that we already know its peeled value.
>> +	 * We only try this optimization on packed references because
>> +	 * (a) forcing the filling of the loose reference cache could
>> +	 * be expensive and (b) loose references anyway usually do not
>> +	 * have REF_KNOWS_PEELED.
>> +	 */
>> +	if (flag & REF_ISPACKED) {
>>  		struct ref_entry *r = get_packed_ref(refname);
> 
> This code makes the reader wonder what happens when a new loose ref
> masks a stale packed ref, but the worry is unfounded because the
> read_ref_full() wouldn't have gave us REF_ISPACKED in the flag in
> such a case.
> 
> But somehow the calling sequence looks like such a mistake waiting
> to happen.  It would be much more clear if a function that returns a
> "struct ref_entry *" is used instead of read_ref_full() above, and
> we checked (r->flag & REF_ISPACKED) in the conditional, without a
> separate get_packed_ref(refname).

As I'm sure you realize, I didn't change the code that you are referring
to; I just added a comment.

But yes, I sympathize with your complaint.  Additionally, the code has
the drawback that get_packed_ref() is called twice: once in
read_ref_full() and again in the if block here.  Unfortunately, this
isn't so easy to fix because read_ref_full() doesn't use the loose
reference cache, so the reference that it returns might not even have a
ref_entry associated with it (specifically, unless the returned flag
value has REF_ISPACKED set).  So there are a couple options:

* Always read loose references through the cache; that way there would
always be a ref_entry in which the return value could be presented.
This would not be a good idea at the moment because the loose reference
cache is populated one directory at a time, and reading a whole
directory of loose references could be expensive.  So before
implementing this, it would be advisable to change the code to populate
the loose reference cache more selectively when single loose references
are needed.  -> This approach would be well beyond the scope of this
patch series.

* Implement a function like read_ref_full() with an additional (struct
ref_entry **entry) argument that is written to *in the case* that the
reference that was returned has a ref_entry associated with it, and NULL
otherwise.  This would have to be an internal function because we don't
want to expose the ref_entry structure outside of refs.c.
read_ref_full() would be implemented on top of the new function.

Either way, I'd rather put this idea on my TODO list for another time.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
