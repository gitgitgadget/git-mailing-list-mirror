From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Let format-patch and rebase ignore trivial merges.
Date: Thu, 17 Dec 2009 14:44:37 -0800
Message-ID: <7vaaxhfcfe.fsf@alter.siamese.dyndns.org>
References: <20091216164553.GA22471@pcpool00.mathematik.uni-freiburg.de>
 <4B29106C.1040501@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Bernhard R. Link" <brlink@debian.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Dec 17 23:44:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLP5c-0001VM-7R
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 23:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177AbZLQWou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 17:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbZLQWou
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 17:44:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47095 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964988AbZLQWot (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 17:44:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C012AA7111;
	Thu, 17 Dec 2009 17:44:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cKzvlwZGrvbgkmXM98FOKRd36GU=; b=YTsxwT
	zQPRFAax0/zl8xoMmEwYPzNtCyGfJ0p9sndk9yHLnR1LT9fYim1nATRC2PKXf//w
	ra6lVPlAaomhbwx9dUcL/4HRvsSnzHZeEsCa8J2hQnDPA2qxBfo+HLZXivqBuP9m
	yS1BS6lDJAc/fody4Tjf7t+78vyxppmqS+fVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=glmljbK1VDTXqYG6Si3OIVZcd7DrYru6
	+ySvsQDIH9lh1XD1GhUvaFLHiG963Wyqloi4M+ydhayf8mROn/SHuhK1grmrU+T5
	D07TQWEXmYL5cC+jSd0D0WE4om2TUJP/LLS1RtQqMCTC0cAj/xIQ1L/866kg+z+o
	DYeCAiTPp3c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9012BA710F;
	Thu, 17 Dec 2009 17:44:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 14AE5A710E; Thu, 17 Dec 2009
 17:44:38 -0500 (EST)
In-Reply-To: <4B29106C.1040501@viscovery.net> (Johannes Sixt's message of
 "Wed\, 16 Dec 2009 17\:53\:00 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C4CF1E24-EB5D-11DE-B3C6-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135385>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Please do not set Mail-Followup-To (and use reply-to-all to keep the Cc list).
>
> Bernhard R. Link schrieb:
>> --prune-tree makes rev-list without paths equivalent to
>> "git rev-list $options -- ." (or .. or ../.. and so on,
>> if you are in some subdirectory).
>> This is the new default for format-patch and rebase
>
> Why do you need a new option when you can just add "-- ." to the rev-list
> invocation?

I agree that --[no-]prune-tree options are unnecessary.  The patch to
builtin-log.c, the second hunk to revision.c, and revision.h would be
sufficient and all others should be dropped.  Instead, the shell script
Porcelains can simply add "-- ." at the end of their rev-list invocations.

That way, we don't have to add anything to the documentation either.

But I wonder if it is an indication of something screwy in the workflow,
if a branch that merges others with "-s ours" is where the patches for
upstream submission is taken from with format-patch, or what is rebased
and internally gets its patches extracted with format-patch.

A branch that merges with "-s ours" is typically done so that others can
pull and build against (and "-s ours" is used to cauterize the history of
a bad side branch), and good bits merged into it would also have come from
a different clean branch that is merged into that branch.  It might make
more sense to format-patch that clean branch when preparing for upstream
submission, than the "aggregated mesh of commits" branch with "-s ours"
fix-ups.

On the other hand, a branch that will be rebased to keep up with others is
by definition private, and I don't see a reason to mark with "-s ours" to
cauterize history of an unrelated side branch that tried to do something
similar to what the branch is trying to achieve in that setting.  You can
instead ignore such a side branch and not merge with it.  So I don't know
how a sane history you are going to rebase ends up containing a "-s ours"
merge to begin with.
