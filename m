From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/32] read-cache: split-index mode
Date: Tue, 29 Apr 2014 10:23:47 -0700
Message-ID: <xmqqiopskq1o.fsf@gitster.dls.corp.google.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
	<1398682553-11634-18-git-send-email-pclouds@gmail.com>
	<xmqq1twhnkbz.fsf@gitster.dls.corp.google.com>
	<CACsJy8BEJdA+d5DL94n4o3FRphs9bNPhX9oKK3MmOfTTBY=f9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 19:23:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfBl7-0000ry-CF
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 19:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758383AbaD2RXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 13:23:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33244 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758291AbaD2RXw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 13:23:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AF368165C;
	Tue, 29 Apr 2014 13:23:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7jMvh7Z9v8nQQ7Ah89BcnfY08RA=; b=XRa1TJ
	y3VyALbNYuxNogEFBhxPCHJDKQAp4zoo3DFGqRGRW/C4kzg6VQfa9DBFJ4kXal0y
	NPFoMFqot1UBjYai69GfXqzD2IcMxNyNFXS40nI05NFYZx9BHYCr/xKTIxa/Udvh
	kcDd1U8GF7Q7gpSpPivRzNKv6a34FB8i6smFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DDEprG6B9A+7ap7drAGSQUTmFCJLt+vZ
	flvvUF5gcz460BBoZlP6DRZdS3TLVsfCmUsk8MWG5qIqOMcRt8ACM6948bsMIwjS
	IGIRTv3BhFigpyH0TNb+3aaGZ1LfB5qqzeOXT7U/JuAA7IjBNiDJnrWqxPulBwKR
	TB6SrGU46FI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0165B8165B;
	Tue, 29 Apr 2014 13:23:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8189981654;
	Tue, 29 Apr 2014 13:23:49 -0400 (EDT)
In-Reply-To: <CACsJy8BEJdA+d5DL94n4o3FRphs9bNPhX9oKK3MmOfTTBY=f9Q@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 29 Apr 2014 08:43:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0715110A-CFC3-11E3-BCD5-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247595>

Duy Nguyen <pclouds@gmail.com> writes:

>> I do think it is sensible to keep two arrays of "struct cache_entry"
>> around (one for base and one for incremental changes) inside
>> index_state, and the patch seems to do so via "struct split_index"
>> that does have a copy of saved_cache.  If the write-out codepath
>> walks these two sorted arrays in parallel, shouldn't it be able to
>> figure out which entry is added, deleted and modified without
>> fattening this structure?
>
> So far without that "index" field I would have to resort to hasing
> entries in both arrays to find the shared paths. But ideas are
> welcome.

Hmm, why do you need to hash, when both arrays are sorted?  Wouldn't
it be just the matter of walking these two arrays in parallel,
with one scanning index for each array initialized to the beginning,
comparing the elements pointed by these indices, noting the side
that comes earlier in the sort order and advancing the index on that
side (or if they compare equal then advance both), ...?
