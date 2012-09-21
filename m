From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/14] Provide free_directory() for reclaiming
 dir_struct memory
Date: Fri, 21 Sep 2012 09:11:25 -0700
Message-ID: <7vfw6b8ifm.fsf@alter.siamese.dyndns.org>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
 <1348170383-15751-1-git-send-email-git@adamspiers.org>
 <1348170383-15751-14-git-send-email-git@adamspiers.org>
 <505C1F69.1050508@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Spiers <git@adamspiers.org>, git list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 21 18:11:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF5pM-0006Bl-Cp
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 18:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096Ab2IUQLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 12:11:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56728 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932Ab2IUQLa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 12:11:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61BC28278;
	Fri, 21 Sep 2012 12:11:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kFhDqsd2Xu+OcWGAWzc5AWA8H2Q=; b=N1gQLZ
	qmQOUhKHsyV4fglh+tL6ZwR5mtEnbSi6OXijWcop/BRQoN51AXd1zvCHdNOBBRKW
	5cw2pZeWQQxEkv1IfUkr8cOAbRJR8Z88/mhrTzeewPw+/QSSGPMA3p60E/T4wOIQ
	5z1kCH2Vywq/pQVxyTWKxb9teGM9MM2jdQzrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cSH4K/J/uw/3sOHZXnAw47QrDWsypS0l
	fAe0cuITfoP+8LVq+nOSVBHvRI6V6dW6UCZgGV+QXGpSqpbJlqMZcQLSdZsuhvNB
	MWv6lFWAFVUhO8OkbWO1iKJtEIfVMTVlbs91GhInriPKGuo8RGScLkz9ssn/9ZL2
	zRiPMRNefuw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DF4F8277;
	Fri, 21 Sep 2012 12:11:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E71E8275; Fri, 21 Sep 2012
 12:11:28 -0400 (EDT)
In-Reply-To: <505C1F69.1050508@alum.mit.edu> (Michael Haggerty's message of
 "Fri, 21 Sep 2012 10:03:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 000B93EA-0407-11E2-B196-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206128>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 09/20/2012 09:46 PM, Adam Spiers wrote:
>> Signed-off-by: Adam Spiers <git@adamspiers.org>
>> ---
>>  Documentation/technical/api-directory-listing.txt |  2 ++
>>  dir.c                                             | 23 +++++++++++++++++++++--
>>  dir.h                                             |  1 +
>>  3 files changed, 24 insertions(+), 2 deletions(-)
>> 
>> diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
>> index 944fc39..e339c18 100644
>> --- a/Documentation/technical/api-directory-listing.txt
>> +++ b/Documentation/technical/api-directory-listing.txt
>> @@ -79,4 +79,6 @@ marked. If you to exclude files, make sure you have loaded index first.
>>  
>>  * Use `dir.entries[]`.
>>  
>> +* Call `free_directory()` when none of the contained elements are no longer in use.
>> +
>>  (JC)
>> [...]
>> diff --git a/dir.h b/dir.h
>> index ebb0367..7da29da 100644
>> --- a/dir.h
>> +++ b/dir.h
>> @@ -128,6 +128,7 @@ extern void add_excludes_from_file(struct dir_struct *, const char *fname);
>>  extern void add_exclude(const char *string, const char *base,
>>  			int baselen, struct exclude_list *el, const char *src, int srcpos);
>>  extern void free_excludes(struct exclude_list *el);
>> +extern void free_directory(struct dir_struct *dir);
>>  extern int file_exists(const char *);
>>  
>>  extern int is_inside_dir(const char *dir);
>
> With I see a function like this, the first question in my head is always
> "does it also free(dir), or does it only free the substructures, leaving
> dir empty but allocated?"  There should be a comment documenting the
> behavior.  I also find it helpful if a function that frees the top-level
> structure has "free" in the name, while a function that only empties the
> top-level structure without freeing it *not* have free in the name
> (e.g., "clear_directory()").  But maybe that's just me.

All good points, including the last one.  Thanks.
