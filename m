From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 19/29] refs: don't dereference on rename
Date: Fri, 29 Apr 2016 01:53:07 -0700
Message-ID: <xmqqvb3023v0.fsf@gitster.mtv.corp.google.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	<27f8b223e42dcf1cf3c010833e0aff7baa4559c2.1461768690.git.mhagger@alum.mit.edu>
	<xmqqy47y98zx.fsf@gitster.mtv.corp.google.com>
	<57230F71.2020401@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 29 10:53:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw4Ap-00061T-53
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 10:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbcD2IxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 04:53:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752066AbcD2IxK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 04:53:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A87D13584;
	Fri, 29 Apr 2016 04:53:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4gLt3yRKJkHjBGtwyfHVfpjkWV4=; b=Frs4y6
	QC4pw5NR+hhCxXyFlLOPuPlSXgq7gkdU7585zbWhziLWydu0VWtQ0NmNpoxcLYay
	09Y7OdzZTmk0BuO0Mc009OfeB3eFdylq6Bv5cSB1PLp0NELcc0OLjAT6VeIMY4ZK
	InkWWXVVODvTo9vC2wd8rMQQcnWAxsDHqC/LU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nwHncwX6ohuiraBoKTwcDF0m+bwwdSlC
	B0dn3qtVlhQyLuJCHl3nT94dd8MLRVk7ARiWjxj4OXStR8WdFTgzvFqjhJj1dU2S
	6dCNv94zU8XGjHf+GVpNpAoqTT0X7SjxD7xnbWyZfBsJKlX8oikqDvEofH3NN3a/
	q4g1+RUxPzQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4101D13582;
	Fri, 29 Apr 2016 04:53:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A6D9D13581;
	Fri, 29 Apr 2016 04:53:08 -0400 (EDT)
In-Reply-To: <57230F71.2020401@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 29 Apr 2016 09:38:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CBAB4D22-0DE7-11E6-950B-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292981>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> Could you explain s/sha1/NULL/ here in the proposed log message?
>
> Good question.
>
> Passing sha1 to delete_ref() doesn't add any safety, because the same
> sha1 was just read a moment before, and it is not used for anything
> else.

"... and it is guaranteed that no other process in the meantime
wanted to update the ref we are trying to delete because it wants to
see the ref with its updated value." is something I expected to see
at the end.

> So the check only protects us from a concurrent update to
> newrefname between the call to read_ref_full() and the call to
> delete_ref(). But such a race is indistinguishable from the case that a
> modification to newrefname happens just before the call to
> read_ref_full(), which would have the same outcome as the new code.

In other words, when a transaction that contains a deletion of a ref
races with another one that updates the ref, the latter transaction
may come after the former one, but the ref may not survive in the
end result and can be left deleted?

Puzzled...
