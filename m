From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: add --verify-signatures
Date: Thu, 10 Dec 2015 11:53:45 -0800
Message-ID: <xmqqy4d2gjw6.fsf@gitster.mtv.corp.google.com>
References: <20151210130228.GA22641@netblarch.tu-darmstadt.de>
	<xmqq37vai0ev.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 20:53:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a77Hl-0004WP-Fw
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 20:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbbLJTxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 14:53:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63257 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751273AbbLJTxr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 14:53:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC36333C2D;
	Thu, 10 Dec 2015 14:53:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qfUbeVjOIyUHZjXCeV+zG1Z98cs=; b=Sk7uRq
	qlO/kCVs6ee234YisBdUhKLaDmtsKmoWqY6ilzehdx/B+QwS/HkPFCnsmTaEFYWx
	xYnuw4+YglMqL1uIYU3cRyxngNo2M1pspa9EAXGePVCheKxGuaruFAVBOw08BXs+
	io1GFfMZeJDNaRVzO8zfyEHTvgH0KqyblZRL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xkOGV2oDauNv4b3iPBOwjtQWtqNtY7LS
	/k3TG3Nz62H5EySQZ3ZRiExfnd5a+EQVggJwepz9eFqNNNbeqeitpitjdLhAVCSa
	tIlF2Teql4LUILZssj5IaX4j0+RbiHvwj9SIeCtn2o8TIlKJ60/rAr8T4UGNSvlA
	nFBQbUeq6gY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A261A33C2C;
	Thu, 10 Dec 2015 14:53:46 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 23A1333C2B;
	Thu, 10 Dec 2015 14:53:46 -0500 (EST)
In-Reply-To: <xmqq37vai0ev.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 10 Dec 2015 11:11:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B93101A2-9F77-11E5-95C8-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282228>

Junio C Hamano <gitster@pobox.com> writes:

> Alexander 'z33ky' Hirsch <1zeeky@gmail.com> writes:
>
>> +	if test -n "$rebase_root"
>> +	then
>> +		foreign_revisions="$orig_head..$onto"
>> +	else
>> +		foreign_revisions="$orig_head..${restrict_revision-$upstream}"
>> +	fi
>> +
>> +	for cmt in $(git rev-list --reverse "$foreign_revisions")
>> +	do
>> +		if ! git log -1 --pretty=format:'%G?%n%GS' "$cmt" |
>
> I do not think this matches what the corresponding option in "git
> merge" does, where the only tips of the histories being merged are
> checked.

Having said that, I somehow doubt that verify-signatures is a
feature that is desirable in a workflow around "pull --rebase" in
the larger picture.  If you step back a bit, in a "merge" based
workflow, you are the keeper of the sanity, cleanliness, and all the
good things in the authoritative history when doing a "git pull".
That is why you would want to validate what gets merged from another
place and in that context having --verify-signatures may make sense
(and it might even make more sense if the code did so for all new
commits, not just the tip, but that is a separate topic).  If the
validation fails, you would tell the owner of that side branch you
just attempted to pull from to get her act together before asking to
be pulled again.  There is a clear path to make further progress
after the validation fails.

In a workflow that is built around "pull --rebase", you are _given_
the authoritative history with all the good things from another
place and then you rebuild your own work on top of it.  The sanity
and cleanliness of what you built on top is given, and rejecting it
at that point would not help you make further progress in any way,
as that is a published history that is shared and more authoritative
than what you have.

Hence, while I 100% agree with Brian's "it is not there because
nobody bothered to add the corresponding option on the rebase side",
I do not necessarily think "nobody bothered" is the same as "they
were too lazy"--perhaps some people thought about doing it, and then
decided not to, because the option made no sense when they stepped
back to look at the larger picture.
