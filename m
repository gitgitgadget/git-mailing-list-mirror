From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] (BROKEN) get_merge_bases_many(): walk from many tips
 in parallel
Date: Tue, 28 Aug 2012 14:35:03 -0700
Message-ID: <7v8vcyzomw.fsf@alter.siamese.dyndns.org>
References: <1346109123-12357-1-git-send-email-gitster@pobox.com>
 <1346109123-12357-6-git-send-email-gitster@pobox.com>
 <7vipc3q041.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 28 23:35:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6TRR-0006EO-Ck
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 23:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376Ab2H1VfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 17:35:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47790 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753163Ab2H1VfH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 17:35:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C11DC9711;
	Tue, 28 Aug 2012 17:35:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lVarkvfypdqJZ2VCuNFqDZZdqKs=; b=NKii/w
	JLLJikMXAnpx4we2eVKZ2W60NI6EQN8BTqzwIyk9KfTNVaG8S2mPUnlqQud4wl9L
	AqlQ/Y3qvkGAzrwdOze0kOs/yqSZpnuKnjy8HtIDejJnef/ywAYX02g82uFc8R7i
	dYL1kO8zFt7v8EbB/AqJTqyS9huqXV8vJMTuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i3i6m8/o7SaPQyNr743fl3FTJ4bIdsXp
	l/OJpGzz50sYmWorfK+gnJXbZNDMkszsO+pL3Y8RQHYyhfQzAWQLk/Lf96tKRbh5
	ZWf7MrRdkreVnR0xFb52MZ/HMi/9v53lEwk1LzefOGcPFIeQzN4ZdP/g4FOr15oC
	l4VZUOto3cM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACB3A9710;
	Tue, 28 Aug 2012 17:35:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27CCB970B; Tue, 28 Aug 2012
 17:35:05 -0400 (EDT)
In-Reply-To: <7vipc3q041.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 27 Aug 2012 18:25:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B4656E6-F158-11E1-AF39-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204454>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>  	for (i = 0; i < cnt; i++) {
>> -		if (rslt[i])
>> +		/*
>> +		 * Is rslt[i] an ancestor of any of the others?
>> +		 * then it is not interesting to us.
>> +		 */
>> +		for (j = 0; j < i; j++)
>> +			others[j] = rslt[j];
>> +		for (j = 1 + 1; j < cnt; j++)
>
> s/1 + 1/i + 1/;
>
> With that, all tests seem to pass ;-)

"git merge-base" itself seems to have more room for improvement.
Trying to recompute bases for recent 200 merges in the kernel
history with the attached script does not show any improvement with
or without the series on top of recent "master".  Correctnesswise it
seems to be OK, though---I get byte-for-byte identical output.

-- >8 --
#!/bin/sh

git rev-list --committer=torvalds@linux-foundation.org \
    --max-parents=2 --min-parents=2 --parents v3.5..v3.6-rc2 >RL

cmd='
	while read result parent1 parent2
	do
		$GIT merge-base $parent1 $parent2
	done <RL
'

GIT="rungit master" time sh -c "$cmd" >:stock
GIT=../git.git/git time sh -c "$cmd" >:optim
cmp :stock :optim
-- 8< --
