From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] revert: Implement --abort processing
Date: Wed, 01 Jun 2011 10:38:10 -0700
Message-ID: <7vfwnth2pp.fsf@alter.siamese.dyndns.org>
References: <1306944446-11031-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 19:38:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRpNG-000463-Tc
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 19:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759377Ab1FARiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 13:38:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62060 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759354Ab1FARiY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 13:38:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B6B334481;
	Wed,  1 Jun 2011 13:40:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VWCaGG9l5moeVDJIuKm75dCxx1E=; b=wuBH4M
	y2902hRFbm+dD6KQ2hOH4Om131miY858b2k61/7AWJUNevEjKqAAdIxrphvVLP4h
	0xyUFmSc76RoSO9A6j2qRBgb1g6+hJjvi+OJpvDc09OjoIU75nL+Lo5EJ7zf2hVl
	HBAimZJPcG7+PQPeHPWOkIK7qu+/pFCfGebDM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fpz9L3w6Dqv5HD3Qq+StDDu4YytG+nVW
	tZpnyHTxG6QAbpvf5YW1jVJyzUxZFqhz9aZBdQMrMb6JPJGkolc/+fFbvf81JbJy
	Klec6cadoLHf43mnAcbriYQ+u3iRUrc14iqObxHw5qm/oEQj9VLCrP+AHpgHgdvb
	J2INKUyZFrE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6687D447E;
	Wed,  1 Jun 2011 13:40:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CE6CD4475; Wed,  1 Jun 2011
 13:40:20 -0400 (EDT)
In-Reply-To: <1306944446-11031-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Wed, 1 Jun 2011 16:07:26 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3CAF5048-8C76-11E0-B805-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174886>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> To abort, perform a "rerere clear" and "reset --hard" to the ref
> specified by the HEAD file introduced earlier in the series.

What is the scenario this new feature targets? Is it to recover from this?

    % git revert $that_single_faulty_commit
    ... oops conflicted, let's try if I can resolve ...
    % edit $conflicted_files
    ... yuck, I managed to resolve two paths but not other three ...
    ... let's give up for now ...

In that scenario, a recovery may involve "git reset --hard", but clearing
the rerere record for what you have already resolved may or may not be.  I
would imagine that the above "give up _for now_" would be concluded with:

    % git add $files_i_managed_to_resolve_this_round
    % git rerere
    $ git reset --hard

Even if you dropped the unconditional "rerere clear" from the patch, I am
not sure what this new feature buys us. Some people would want the rerere
cache cleared, some others don't. "revert --abort" will forever be to
aborting revert and restoring some but not all the parts of the operation
the user wants to be undone, as you cannot satisfy everybody.  So I am a
bit puzzled why you thought this was even a good idea to begin with.

"reset --hard" has established semantics people already understand what it
does. I would rather see us let them use that, without confusing them with
"what are the differences between the two?" unnecessarily.
