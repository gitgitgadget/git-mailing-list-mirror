From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 6/7] refs: add update_refs for multiple simultaneous updates
Date: Thu, 29 Aug 2013 11:32:13 -0700
Message-ID: <xmqqmwo04ac2.fsf@gitster.dls.corp.google.com>
References: <cover.1377784597.git.brad.king@kitware.com>
	<518ba77096664a679e4c7212e4cc4d496c6b38d3.1377784597.git.brad.king@kitware.com>
	<xmqqhae85rbl.fsf@gitster.dls.corp.google.com>
	<521F90EC.6040208@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:32:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF716-0004m9-VU
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756311Ab3H2ScV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:32:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64094 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754741Ab3H2ScQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:32:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3A233D0F5;
	Thu, 29 Aug 2013 18:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WBnced2GVun/F7PsAh6r7EGoXVY=; b=f9y4Dd
	96DXzojVOmMxmj+wbUAkldOFhs8z+hZuuCwc2vUODOMIOjhozhfPsa7SRwZFU6rL
	FHFcttMIwaNxNouEFznveCsUYrg9PEBoRcZblYi3HkBDOuEndtDymQNk/VPWB1JH
	9LLLZk3IrvbV94KEuzki9eVik4hgcyvafkIhg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KNTb8NKp69n7Lf4/yiJjaE1cgqbS2mWv
	U16qQZm3+yZ6ZkfN/bmzyb6fXNZfoBY+HUmUpzPa1Bjnh08OqXSignGfTcA1nVwP
	UHTKl6cEUdmonP/4YOFK8vchEq4qWHqBpeYxbsFWG4vJzOaHNwcMCRJ67h+tiwWQ
	67epr30nSDg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AA8E3D0F4;
	Thu, 29 Aug 2013 18:32:15 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 027AC3D0F2;
	Thu, 29 Aug 2013 18:32:14 +0000 (UTC)
In-Reply-To: <521F90EC.6040208@kitware.com> (Brad King's message of "Thu, 29
	Aug 2013 14:20:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 53BE9570-10D9-11E3-9E2A-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233325>

Brad King <brad.king@kitware.com> writes:

> On 08/29/2013 01:39 PM, Junio C Hamano wrote:
>> Brad King <brad.king@kitware.com> writes:
>>> +	for (i=0; i < n; ++i) {
>> 
>> Style:
>> 
>> 	for (i = 0; i < n; i++) {
>
> Fixed.
>
>> Is it asking for AB-BA deadlock?  If so, is the caller responsible
>> for avoiding it?
>
> Since we don't actually block waiting for locks we won't really
> deadlock.

Ahh, OK.

> For Git's internal API I think we can document this in a comment so
> that update_refs does not have to sort.  Then we can add a new
> ref_update_sort function to sort an array of struct ref_update.
> The user-facing "update-ref --stdin" can then use ref_update_sort.

My immediate reaction was "is there a case where the caller knows
that it already has a sorted collection?".  The single caller you
are envisioning could collect the proposed updates to a string list
and dedup, I think, and the resulting list would then be already
sorted.

But it may not be a bad idea to keep the callers dumb and have this
function always sort, dedup, *and* fail inconsistent request.  Then
your original caller that just collects --stdin input can pass
possibly unsorted, duplicated and/or inconsistent request to the
function and have it do the sanity check.
