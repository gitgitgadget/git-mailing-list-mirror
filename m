From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git without morning coffee
Date: Wed, 07 Sep 2011 09:46:57 -0700
Message-ID: <7vehzs47we.fsf@alter.siamese.dyndns.org>
References: <4E6721E3.7000207@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 07 18:47:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1LHn-0002Mv-Vv
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 18:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775Ab1IGQrC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 12:47:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55242 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753760Ab1IGQrA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 12:47:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3283033F0;
	Wed,  7 Sep 2011 12:46:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0VrQ1adVM4QHukU9FNJrSuaV3lg=; b=aMM0UT
	1GXqm28KCMwM3frcqahFd7Qe8+kP1lrL/Rl8uOXAfLxL0YUmhGLqd6d+rxLV1vSd
	ZWA8Hkgd3z4kb21JvoueDM/UxkVPo1SvAbX+dG/hK12uJqtVLJqZcADRfzp5umKm
	IdOpoc3adv+UncZw3YRLkBdNNm3C80YF8irg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aeswEk/YgOahnI9ANtXxCY7M52UhM1CO
	y5FBu7tjDv+P/JXlcWUC2OLLaQJQe5XsQols0T7tXWZvGPiUi5997Ix8z8MimvwX
	mPtvsRfDk9RCySdqnKcnsdOgfWgcHdQh3eQrmnXQh9DA9r/JbvUjULhRxYRdB++1
	IJ9bJrrvQFU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B0C233EF;
	Wed,  7 Sep 2011 12:46:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 83C1333EB; Wed,  7 Sep 2011
 12:46:58 -0400 (EDT)
In-Reply-To: <4E6721E3.7000207@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed, 07 Sep 2011 09:48:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 00968C46-D971-11E0-9A29-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180868>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> git merge ":/Merge branch 'jk/generation-numbers' into pu"
> fatal: ':/Merge branch 'jk/generation-numbers' into pu' does not point
> to a commit
> # Huh?

Interesting.

> git merge $(git rev-parse ":/Merge branch 'jk/generation-numbers' into pu")
> error: addinfo_cache failed for path 't/t7810-grep.sh'
> Performing inexact rename detection: 100% (91476/91476), done.
> error: addinfo_cache failed for path 't/t7810-grep.sh'

Smells like another case where merge-recursive is looking at the work tree
when it shouldn't inside an inner merge or something.

> I mean, I'm merging a commit from origin/pu to origin/next when the
> latter is basically contained in the former (except for some merge
> commits).

This falls into the "side note" category, but these days 'next' and 'pu'
do not share any history beyond the tip of 'master'. Every time I update
the 'pu' branch, it is rebuilt directly on top of 'master' from scratch by
merging the topics in 'next' (and at this point I make sure its tree
matches that of 'next') and then merging remaining topics on top of the
result. A topic often goes through multiple iterations of fix-ups while in
'next', and these fix-ups result in multiple incremental merges of the
same topic into 'next'; I do not want to see an incorrect merge when such
a topic is merged in a single-step into 'master', and it is one way to
ensure the health of the merge fixup machinery (including the rerere
database) to attempt from-scratch-the-whole-topic-at-once merges and
verify the result.

The merge you attempted will have a lot of "the history leading to the
current commit added/modified in a certain way and the history being
merged did the same modification independently" kind of conflicts that
should resolve to no-op.
