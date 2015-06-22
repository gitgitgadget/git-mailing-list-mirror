From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 12/19] initial_ref_transaction_commit(): check for duplicate refs
Date: Mon, 22 Jun 2015 14:06:02 -0700
Message-ID: <xmqqtwtzfo79.fsf@gitster.dls.corp.google.com>
References: <cover.1434980615.git.mhagger@alum.mit.edu>
	<63ae59139a3a7b5c85f6d44864eade79a93965fb.1434980615.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 22 23:06:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z78ux-0008V5-CK
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 23:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbbFVVGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 17:06:07 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37280 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbbFVVGF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 17:06:05 -0400
Received: by igblr2 with SMTP id lr2so62366139igb.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 14:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=WjsqhhpW7cArtr7P9D+BcZnZJdUm4VvSwqbh2TUqFHw=;
        b=UuEaBZMUEW9hXBeSC9Zcwhp/2WDpoSkXNrautBwh51OSEz/d0cN8OJ+3wg4JjIS5J6
         GQp9ZLXdmYmpyDlyRtEW9EcI9hR7Ujc+ca3ruop5XZJ7G/G1VVTfBhwvw6rKBASxrtnE
         Cb24AK0Pv5M7A3ZtnWaJvBqz8NVieKtl8YPdwi2xd5qnhQfDbbUIYpl3rpWKaGPvGrkc
         bhYkjEPPmxQFJuTOOjzrHdFAoIq+p9OTdpznkE6luBnBqt5+QuFmMVneanuNR5QgZ0h4
         OgytGUEvEIR6LM7d5rZ8JzH6+pJi8/PAqCU7o21Fu1TdRrat//uivDCfHlE4Q+3D4cQH
         F9xA==
X-Received: by 10.50.64.147 with SMTP id o19mr23480645igs.33.1435007164720;
        Mon, 22 Jun 2015 14:06:04 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0be:ae3d:b206:8e25])
        by mx.google.com with ESMTPSA id x4sm13554080iod.26.2015.06.22.14.06.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jun 2015 14:06:04 -0700 (PDT)
In-Reply-To: <63ae59139a3a7b5c85f6d44864eade79a93965fb.1434980615.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 22 Jun 2015 16:03:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272416>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Error out if the ref_transaction includes more than one update for any
> refname.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

This somehow feels like "ehh, I now know better and this function
should have been like this from the beginning" to me.

But that is OK.

Is the initial creation logic too fragile to deserve its own
function to force callers to think about it, by the way?

What I am wondering is if we could turn the safety logic that appear
here (i.e. no existing refs must be assumed by the set of updates,
etc.)  into an optimization cue and implement this as a special case
helper to ref_transaction_commit(), i.e.

	ref_transaction_commit(...)
        {
		if (updates are all initial creation &&
                    no existing refs in repository)
			return initial_ref_transaction_commit(...);
		/* otherwise we do the usual thing */
		...
	}

and have "clone" call ref_transaction_commit() as usual.
