From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5 07/35] hold_lock_file_for_append(): release lock on
 errors
Date: Wed, 17 Sep 2014 17:39:48 +0200
Message-ID: <5419AB44.1070109@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu> <1410896036-12750-8-git-send-email-mhagger@alum.mit.edu> <20140916204853.GH29050@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 17:39:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUHKn-0003Qm-9a
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 17:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304AbaIQPjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 11:39:53 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:52459 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754870AbaIQPjw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Sep 2014 11:39:52 -0400
X-AuditID: 1207440c-f79036d000005e77-47-5419ab47c265
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id CB.FB.24183.74BA9145; Wed, 17 Sep 2014 11:39:51 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1C15.dip0.t-ipconnect.de [93.219.28.21])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8HFdmBE020963
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 17 Sep 2014 11:39:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20140916204853.GH29050@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsUixO6iqOu+WjLE4NkCeYuuK91MFg29V5gt
	nsy9y2zx9uYSRosfLT3MFv8m1Fh0dnxldGD32DnrLrvHgk2lHg9fdbF7POvdw+hx8ZKyx+dN
	ch63n21jCWCP4rZJSiwpC85Mz9O3S+DO+PVzBnPBLZ6KLyefsjcwTuHqYuTkkBAwkTjzcCob
	hC0mceHeeiCbi0NI4DKjxIO1n1khnHNMEpf/P2YHqeIV0JZ4+beJGcRmEVCVOP7pDSuIzSag
	K7Gop5kJxBYVCJD40PmAEaJeUOLkzCcsILaIgIbE80/fwDYwC3xklJh7/SRYs7BAsETf9LlQ
	2xYySnz5cQhsA6eAgcS5lqlgm5kF9CR2XP/FCmHLSzRvnc08gVFgFpIls5CUzUJStoCReRWj
	XGJOaa5ubmJmTnFqsm5xcmJeXmqRrqFebmaJXmpK6SZGSDTw7GD8tk7mEKMAB6MSD++GyxIh
	QqyJZcWVuYcYJTmYlER59y+WDBHiS8pPqcxILM6ILyrNSS0+xCjBwawkwiu/BCjHm5JYWZVa
	lA+TkuZgURLnVV2i7ickkJ5YkpqdmlqQWgSTleHgUJLgPbcSqFGwKDU9tSItM6cEIc3EwQky
	nEtKpDg1LyW1KLG0JCMeFK/xxcCIBUnxAO2dDtLOW1yQmAsUhWg9xajLsa7zWz+TEEtefl6q
	lDjv3RVARQIgRRmleXArYKnvFaM40MfCvM9ARvEA0ybcpFdAS5iAlpztEQNZUpKIkJJqYFz0
	433S7EvLAtq3OocaTLjF1nir6Ipp3ryDFVe6eZt/H1mxzsiXNVQjKvTPm+VbbqT8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257224>

On 09/16/2014 10:48 PM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
>> --- a/lockfile.c
>> +++ b/lockfile.c
>> @@ -219,13 +219,13 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
>>  		if (errno != ENOENT) {
>>  			if (flags & LOCK_DIE_ON_ERROR)
>>  				die("cannot open '%s' for copying", path);
>> -			close(fd);
>> +			rollback_lock_file(lk);
>>  			return error("cannot open '%s' for copying", path);
> 
> Makes sense.
> 
> Now that I'm here, I wonder a little at the error convention.  If the
> caller doesn't pass LOCK_DIE_ON_ERROR, are they supposed to be able to
> use unable_to_lock_message?  What errno would they pass in the err
> parameter?  Would callers want handle failure to acquire a lock
> differently from other errors (e.g., by sleeping and trying again),
> and if not, what is the optionally-die behavior in hold_lock_file
> about?

The same applies to hold_lock_file_for_update(), so I'll discuss both at
once:

Most callers do pass LOCK_DIE_ON_ERROR. Of the ones that don't, a couple
appear to want to emit more meaningful error messages. A couple don't
die at all but return an error code to their caller. At least one
(add_to_alternates_file()) calls die_errno().

As it happens, hold_lock_file_for_append() sometimes overwrites errno
before it returns. I will add a patch on top of this series that fixes that.

I don't see any callers that retry, though I've thought about
implementing that in some places. But it's outside of the scope of this
patch series.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
