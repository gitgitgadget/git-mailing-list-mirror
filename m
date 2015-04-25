From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] ref_transaction_commit(): only keep one lockfile open at a time
Date: Fri, 24 Apr 2015 23:57:56 -0700
Message-ID: <xmqqiock1yq3.fsf@gitster.dls.corp.google.com>
References: <1429875349-29736-1-git-send-email-mhagger@alum.mit.edu>
	<1429875349-29736-6-git-send-email-mhagger@alum.mit.edu>
	<553B2F5C.3010007@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Apr 25 08:58:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ylu2Q-0002hL-RR
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 08:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbbDYG6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2015 02:58:00 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63870 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754652AbbDYG57 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 02:57:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4082E3EA8B;
	Sat, 25 Apr 2015 02:57:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kh2oDz7gLDcIxZALF3CPeIByWbY=; b=dMSLP1
	GYcTp6WBznEHXJM/q+U++7iXv7kUC010JL7dTJk0V4TBZywlU6u2ZHmfn9LoKPAg
	lAI4ta9w7ZHt5mdFV7Ew15uP2uNhBzso6Ve0ZFFeeM1cH283Nm/LCR6WpHnxBDOX
	hTFEhYeL41mwwywLn+tw49u38K71HVBMewOBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UlkidE4JZrFuhqAi1OInenJiffDRLNpH
	Gyt7LsbSIOJsoN98XJirFTsq2xeK6QrPLYT81GJZT5CgyMn6lUUqw0Rt/OzfMnic
	ugbXrD3wF1rvA0u4P/k5fNld4ZD59l4riM4HUCHoGQLipQ6yjCOwoE9gBu4ntjbs
	mk9jwEXJnnY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 396C03EA89;
	Sat, 25 Apr 2015 02:57:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B225E3EA86;
	Sat, 25 Apr 2015 02:57:57 -0400 (EDT)
In-Reply-To: <553B2F5C.3010007@alum.mit.edu> (Michael Haggerty's message of
	"Sat, 25 Apr 2015 08:08:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6793C44C-EB18-11E4-BCFE-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267779>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Given that "git push --atomic" is one of the main new features of 2.4.0,
> it would be unfortunate for the release to contain this bug, plus the
> bug that atomic pushes can fail due to file descriptor exhaustion.
>
> Is this problem important enough to justify delaying the release to get
> the fix in?

I am not too worried about "push --atomic", as we can just add a few
words to Release Notes and documentation saying "this is still an
experimental broken code that is unusable; don't use the feature in
production".

I however am more worried about the other one "update-ref --stdin";
the change will be pure regression for those who want to do many
updates and do not care if the update is atomic, no?

Unfortuntely it is pretty late in the game, and even though in
principle I know that the only sensible way forward is to revert the
original breakage, I find it very tempting to patch it up with your
series.
