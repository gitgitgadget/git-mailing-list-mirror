From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v14 5/8] bisect: introduce --no-checkout support into
 porcelain.
Date: Tue, 02 Aug 2011 16:16:54 -0700
Message-ID: <7vk4avcsk9.fsf@alter.siamese.dyndns.org>
References: <1312323362-20096-1-git-send-email-jon.seymour@gmail.com>
 <1312323362-20096-6-git-send-email-jon.seymour@gmail.com>
 <7voc07ct9z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 01:17:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoOD0-00043a-UI
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 01:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528Ab1HBXRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 19:17:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37450 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753505Ab1HBXQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 19:16:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10FE63AC5;
	Tue,  2 Aug 2011 19:16:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ImieCiyV6pWbJ83d5CvR50lCXRM=; b=avZN9h
	it59KjEr7WyHYQc15c4S8MrKVBjBdRlo7ynrlctwtLjY2LRiFJR9zicLSth6MpU+
	U3GGDySpiZgkzHZl2YS2sjK3xTds+CEkUdpHzCb5F9Be0StTalO8NdQRiHiOeJgs
	W7xrSjV0894oS+WJaQQ2e6zlnW6jS4iQC63YM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VTjC+UVVedtkMkXIxSttex9HcBW1kKaw
	xg+lPtU0SBFZ8SUs8UYR+G4QsLen8DUREsWZvV69bAqlNCTJ9Io9Xtmk2h+j1ECk
	DfEBxU6n2N2sqPIVOWZozg+kTmcYaPRldsYbXYDWgl9LY79AbQelVGLl3jqjjYTf
	j20Skh+22qU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07B213AC4;
	Tue,  2 Aug 2011 19:16:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 710DC3AC3; Tue,  2 Aug 2011
 19:16:56 -0400 (EDT)
In-Reply-To: <7voc07ct9z.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 02 Aug 2011 16:01:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 83F77AE4-BD5D-11E0-A64E-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178531>

Junio C Hamano <gitster@pobox.com> writes:

> Jon Seymour <jon.seymour@gmail.com> writes:
> ...
>> +		if test "$BISECT_MODE" = "--no-checkout"; then
>> +		    git update-ref --no-deref HEAD "$start_head"
>> +		else
>> +		    git checkout "$start_head" --
>> +		fi
>
> Just a minor worry but I would not be surprised if somebody's "test"
> implementation barfs upon:
>
> 	test "--no-checkout" = "--no-checkout"
>
> mistaking the string with a dash at the beginning as an option unknown to
> it. That is why we often have "z$variable" in our comparison, like so:
>
> 	if test "z$BISECT_MODE" = "z--no-checkout"
>         then
>         	git update-ref --no-deref BISECT_HEAD "$start_head"
> 	else
>         	git checkout "$start_head" --
> 	fi
>
>> -	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES" &&
>> +	git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAMES"
>> +	echo "$BISECT_MODE" > "$GIT_DIR/BISECT_MODE" &&
>
> &&?

Having said that, other than these minor nits, I think this round is
almost ready. I didn't check how it behaves upon "bisect reset",
though. It shouldn't touch the index, HEAD nor the working tree (it
probably is just the matter of "update-ref -d BISECT_HEAD" and nothing
else, but I haven't thought things through thoroughly).

Further polishing we may want to do while it is still in pu/next I can
think of off the top of my head are:

 - In this mode, I can bisect the history even inside a bare repository,
   as the whole point of --no-checkout is that the mode does not require a
   working tree. I however suspect "git bisect" requires working tree. Is
   this something we want to fix?

 - Further, perhaps should we default to this mode inside a bare
   repository?

Christian, do you think of anything else?  Also do you see flaws in our
reasoning that updating only BISECT_HEAD and doing nothing else is a good
way to do this?
