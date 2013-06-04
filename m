From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] rev-list: add --authorship-order alternative ordering
Date: Tue, 04 Jun 2013 14:20:04 -0700
Message-ID: <7vobbl60aj.fsf@alter.siamese.dyndns.org>
References: <1370369299-20744-1-git-send-email-me@ell.io>
	<1370369299-20744-2-git-send-email-me@ell.io>
	<7vip1t7koi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: elliottcable <me@ell.io>
X-From: git-owner@vger.kernel.org Tue Jun 04 23:20:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjyeK-0000dq-NG
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 23:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904Ab3FDVUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 17:20:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44686 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272Ab3FDVUH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 17:20:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C014425DA2;
	Tue,  4 Jun 2013 21:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FI++4t5XOzN5ENS3W3GA4VVZjvI=; b=gC5GB3
	3EES+v/UESQigacrjizRQdffGFKDU5kwXjDpAyZ5W3Ur9mFUGPLxENAauuzv17TH
	ztdqIR5FUYb2zW+3EHuUe5ePl/C4afMHiYFPu0OvEfycp4IdRjLqRei8MniMX3oe
	lo9Bv3ayozswY4SqUXkMbIeSCCG8/3L6LFsy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hw03mAhECGgYkalwXjTBAptaFegFRNG2
	mMy//3HnlHl+l7T1T+oZvYasRhTqCkO8paNX/yVW+1g3L3TabIRu0dKmnTymN3xU
	kyu4rqRkaZiR7vh2MO0avRzIUZGQJw+4Tm3AJP2fPVl7rhypahAzhKYR3gT6nm1C
	AkCO27PS7zA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B370425DA0;
	Tue,  4 Jun 2013 21:20:06 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 15D9F25D9D;
	Tue,  4 Jun 2013 21:20:05 +0000 (UTC)
In-Reply-To: <7vip1t7koi.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 04 Jun 2013 12:14:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 870D261E-CD5C-11E2-BDFF-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226409>

Junio C Hamano <gitster@pobox.com> writes:

>> @@ -301,7 +328,8 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
>>  			pptr = &commit_list_insert(new_parent, pptr)->next;
>>  		}
>>  	}
>> -	item->date = parse_commit_date(bufptr, tail);
>> +	item->date = parse_commit_committer_date(bufptr, tail);
>> +	item->author_date = parse_commit_author_date(bufptr, tail);
>> ...
>> diff --git a/commit.h b/commit.h
>> index 67bd509..de07525 100644
>> --- a/commit.h
>> +++ b/commit.h
>> @@ -17,6 +17,7 @@ struct commit {
>>  	void *util;
>>  	unsigned int indegree;
>>  	unsigned long date;
>> +	unsigned long author_date;
>
> While walking we keep many of them in-core, and 8-byte each for each
> commit objects add up.  We do not want to make "struct commit" any
> larger than it already is.

Having said that, I do not see a reasonable alternative
implementation than adding an author-date field to struct commit
without major restructuring if we were to add this feature.

So please do not take this part of the response as a "patch rejected
because we do not want to add anything to this structure".  We'll
think of something down the road, but as an independent topic after
this gets in (or doesn't).
