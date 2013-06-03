From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cherry-pick: don't barf when there's nothing to do
Date: Mon, 03 Jun 2013 16:20:27 -0700
Message-ID: <7vtxlebx38.fsf@alter.siamese.dyndns.org>
References: <1369921781-30667-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 01:20:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uje3H-0007JS-4x
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 01:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758943Ab3FCXUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 19:20:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45420 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758747Ab3FCXUa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 19:20:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8479D24FC7;
	Mon,  3 Jun 2013 23:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=LeXEUlt24eiHzD+wndCVQaBWnM0=; b=cZ0noipuy7ljx/NN0pHl
	DwVgpx7TJZj2hTIoFNe2N32t9vkwbhNSM6RRrNczYDRsHhxNN8Aob/vm07HJsdfV
	XihCo7NlaaYGmOlxdn4Ot+HjkjHzSk+f24+kfXpI9aI2WR6CH+d1rHNX19iXTfRo
	NjTROc2q2Bu5WXDagc+wQ1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Rxp/dh/C996r+LKe7c/W9Ckm/hGPEE8pxj98UagYMRb0ib
	xRkxMW7nmZvHx4HGMtJh0hZFfcb3B6ChfTzBtBVvgFoO8a5UBcKDueI3P2t4Uvx2
	GrLZ926bMbBwTFIomP9EChliUvo02kwfNxbo55lChgO3rpP2QtQdh8AR7J+g8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D77824FC5;
	Mon,  3 Jun 2013 23:20:29 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 607C924FB3;
	Mon,  3 Jun 2013 23:20:28 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D8E9F2C-CCA4-11E2-A172-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226305>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> If the user set --ff, it's expected that if theres's nothing to do we
> fast-forward our current HEAD, which is a no-op.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

This is about "git cherry-pick topic..master" which is a misspelt
form of "git cherry-pick master..topic", or alternatively, a script
calling "git cherry-pick ..$branch" that turns out to be giving an
empty set, isn't it?

I suspect that it is perfectly fine to turn this die() into a
warning or an informational feedback (or be silent when --quiet is
given) and make the command exit with success.  If the user asked
for a no-op, the result should be a no-op, but because a no-op is a
strange thing to ask for, and is deserved to be warned about.

But I do not see why we should behave differently between with and
without --ff option.

I also notice this funkiness with "--ff":

	git.git/master$ git checkout master^
        git.git/(ed73fe5...)$ git cherry-pick master^0
        [detached HEAD 32af3ed] Update draft release notes to 1.8.4
	 1 file changed, 53 insertions(+)
	git.git/(32af3ed...)$ git checkout master^
        git.git/(ed73fe5...)$ git cherry-pick --ff master^0
        git.git/(b2edae0...)$

The last cherry-pick shows nothing.  The user can notice that
something useful has happened only because git-prompt script is in
use (and he is experimenting on a detached HEAD), but otherwise
there is no feedback.  I think it should, unless given --quiet, say
something like "fast-forwarded to ..." to avoid user confusion.

>  sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index d8f9d30..b9d4b48 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -749,7 +749,7 @@ static void prepare_revs(struct replay_opts *opts)
>  	if (prepare_revision_walk(opts->revs))
>  		die(_("revision walk setup failed"));
>  
> -	if (!opts->revs->commits)
> +	if (!opts->revs->commits && !opts->allow_ff)
>  		die(_("empty commit set passed"));
>  }
