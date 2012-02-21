From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how do you review auto-resolved files
Date: Tue, 21 Feb 2012 13:19:17 -0800
Message-ID: <7vhayjga0a.fsf@alter.siamese.dyndns.org>
References: <ji0vik$e48$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Neal Kreitzinger" <neal@rsss.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 22:19:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzx7N-0005n7-ME
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 22:19:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707Ab2BUVTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 16:19:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46760 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752438Ab2BUVTU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 16:19:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A707B6EF3;
	Tue, 21 Feb 2012 16:19:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=02tCAzZHC1D5ffE3WpnAtaugVyU=; b=jwsIqr
	pTBCji/t66bcLuqpPgDoDuTA0TiYhvzCKWpiYxgf3/tS3J+u8mx513Gj5WE6b5of
	gPEXEqtEQaIGrmCol6Its659UeOwDB4ybQy6BfqZR1fMUie+p8Si00yyPTlQc/5P
	OLkj7gd1fx01MJEfy40qCw9ir01JhlyK4jZlc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c4auVwpeXZdC8FBEgzQRVAI8QuwFuEKI
	AT1rFeI43GSTKIU6/YMUtyaHAt3UkbsBE3lt3Pmcf8DqIH95Qk+hcLLPacoFuDb9
	5lt+JIa5IoWpgZyj222Qd8nmiHpD5kv5uTI+TvZdN+9haqRSL7iliWj23g/wQJwX
	aTKgWdUWz9A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EDC46EF2;
	Tue, 21 Feb 2012 16:19:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3414B6EEE; Tue, 21 Feb 2012
 16:19:19 -0500 (EST)
In-Reply-To: <ji0vik$e48$1@dough.gmane.org> (Neal Kreitzinger's message of
 "Tue, 21 Feb 2012 14:41:57 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B75F91C8-5CD1-11E1-95AE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191186>

"Neal Kreitzinger" <neal@rsss.com> writes:

> When git does a merges (merge/rebase/cherry-pick) it auto-resolves same-file 
> changes that do not conflict on the same line(s).
>
> Technical Question:  What are the recommended commands for reviewing the 
> files that auto-resolved after a "merge"?

Imagine that you are the maintainer of the mainline and are reviewing the
work made on a side branch that you just merged, but pretend that the
contribution came as a patch instead.  How would you assess the damage to
your mainline?

You would use "git show --first-parent $commit" for that.

And then look at what the sideline wanted to do to the old baseline:

	git log -p $commit^..$commit

which would, unless the person who worked on the side branch did a shoddy
job describing his work, explain what the side branch wanted to achieve
and also _how_ it wanted to achieve it.

And then re-read the first "git show" output with that knowledge, together
with the knowledge you have on your mainline codebase, and decide if the
solution used by the side branch is still valid.  If it makes sense, you
are done.  If the advance in your mainline since the side branch forked
invalidated some assumption the side branch made (e.g. a helper function
the side branch used has changed its meaning, a helper function the side
branch changed its meaning gained more callsite on the mainline, etc.),
you have a semantic conflict that you would need to address.

It is unclear what exactly you consider "auto-resolve" in your message, so
I'd refrain from commenting on the "Philosophical" part, at least for now.
