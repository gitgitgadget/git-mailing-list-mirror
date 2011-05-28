From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: learn --discard subcommand
Date: Sat, 28 May 2011 11:51:32 -0700
Message-ID: <7vpqn2psjv.fsf@alter.siamese.dyndns.org>
References: <1306551495-26685-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 28 20:51:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQObz-00006r-71
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 20:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755935Ab1E1Svm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2011 14:51:42 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755671Ab1E1Svl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2011 14:51:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7040B495B;
	Sat, 28 May 2011 14:53:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GAi0b3J5Iq9rEoaW87PXgF2Dz6I=; b=qp+I6e
	ZC6nDUX11TLjav7+3la2x113fs7jenmD0InGd3p2ii+SMm0N2PLCoNBc6HPgo9+r
	H/veml9ixfp3aTZrbkJIAOlraqvXvi02BsTDrYjUCmxGVsBYpsIYza9ewTvjPRhd
	su/BS/sPR6jPbWn5aYzjiWY/6CP8ykxvaJ9DE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B4nY8ic9w+oTz4w6JP6AFFaHsaRVBhug
	NT9u9VWryV686xRaDLrdW/xjha764YqzL/tP2rt++N7gbr/fAdMRlNWMeIKYKLP2
	Sjz3RQIdm/17AYXMH320CHwWIf94r6dHzPyKHpWOfN/3cGaIhBT2CICRpQxYHPoH
	oUKdbgHtsFU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3DEE7495A;
	Sat, 28 May 2011 14:53:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1F88F4956; Sat, 28 May 2011
 14:53:41 -0400 (EDT)
In-Reply-To: <1306551495-26685-1-git-send-email-martin.von.zweigbergk@gmail.com> (Martin
 von Zweigbergk's message of "Fri, 27 May 2011 22:58:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0F2F598-895B-11E0-9C85-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174671>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> ... I think Junio then
> hinted that he sometimes wished that he could abort rebase without
> moving to anywhere else at all, which is what this patch implements.

I am not opposed to this particular patch, but thinking about a bigger
picture, I am not sure if we want to solve it this way.

We have multiple "sequence" operations that want to do things in multiple
steps, each of which can stop and give control back to the user, while
leaving some information in the .git directory for it to know where it was
when resuming. I think "am" knows about what "rebase" does (and
vice-versa) so it can detect an attempt to run it while "rebase" is in
still progress and refuse to continue to limit the damage, but if we have
N such "sequence" commands that want to refrain from interfering with each
other, and want to offer an advice to abort the in-progress operation
initiated by other commands, that would mean we would need N * N pieces of
logic to detect other's in-limbo state and offer advices, which would not
scale.

A user who is given back the control from a "sequence" operation may be
confused either (1) immediately after such an event (often some sort of
merge conflict) or (2) much later after first abandoning the working tree
altogether and taking a walk and then coming back to continue working
while forgetting what he was doing. Such a user may want to say "I know I
am in a strange state, give me a state that I can work from, at this point
I do not care about continuing what I was originally doing". The user may
probably not know if "git rebase" was in progress or "git cherry-pick"
was.

"git reset --hard" used to be such a command in simpler times. It removes
MERGE_HEAD unconditionally, so that a confused user can start from scratch
without having to worry about what was in progress. As a devil's advocate,
I am wondering if it is a good idea to simply teach "reset --hard" to also
remove any and all "sequence" cruft (.git/rebase-apply, .git/rebase-merge,
CHERRY_PICK_HEAD; we might have others I do not recall offhand) and be
done with it. It is a large hammer, but it is certainly the easiest to
explain and the simplest to understand way to get out of any troubles.
