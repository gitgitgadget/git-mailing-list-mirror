From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 08/14] remote.c: report specific errors from branch_get_upstream
Date: Thu, 21 May 2015 12:25:57 -0700
Message-ID: <xmqqpp5tivga.fsf@gitster.dls.corp.google.com>
References: <20150521044429.GA5857@peff.net> <20150521044532.GH23409@peff.net>
	<xmqq7fs1kcfd.fsf@gitster.dls.corp.google.com>
	<20150521184910.GA3490@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 21 21:26:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvW6X-00039z-RP
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 21:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754484AbbEUT0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 15:26:00 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33078 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702AbbEUTZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 15:25:59 -0400
Received: by igbpi8 with SMTP id pi8so18916270igb.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 12:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=x5XeGNlw0MAXUIMLnk92qn1QkjW5Xt6A4eapSN3sT1I=;
        b=jvT/0QA1y0Nmsb0OvMuBXWKAMgxVXeJtIvkibJRoLUKKSr1INzE9G30vYfLmi+1s0b
         Pi9Dg3PtcrETmtInV3Ouqefi+Nw7RTPwPKdFSd624ixEJ2u0AOKFoQlw+cyull8SRqSe
         mHTMvo/tD5I8PQ8SfSWPj83MSAZvOhfd9vspssUThzbOLqJlrcDX3ztgbFVvma/UHiFV
         j1nzrClRj6agV6jHXMx7RlUtGjc45Aw4FHHwYdYeRv+go5jvZlruV/fyPCZHmMEPtTjr
         L5aEu519IB05m/k2M1OZz3TdgcIsEMr4UK73nKyrnuZB+0r2tnUWlyCfYPfdeYVfw/Em
         PNtw==
X-Received: by 10.107.156.71 with SMTP id f68mr5485720ioe.36.1432236359012;
        Thu, 21 May 2015 12:25:59 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id o15sm1851834igw.11.2015.05.21.12.25.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 12:25:58 -0700 (PDT)
In-Reply-To: <20150521184910.GA3490@peff.net> (Jeff King's message of "Thu, 21
	May 2015 14:49:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269649>

Jeff King <peff@peff.net> writes:

> On Thu, May 21, 2015 at 11:33:58AM -0700, Junio C Hamano wrote:
>
>> > +static const char *error_buf(struct strbuf *err, const char *fmt, ...)
>> >  {
>> > -	if (!branch || !branch->merge || !branch->merge[0])
>> > -		return NULL;
>> > +	if (err) {
>> > +		va_list ap;
>> > +		va_start(ap, fmt);
>> > +		strbuf_vaddf(err, fmt, ap);
>> > +		va_end(ap);
>> > +	}
>> > +	return NULL;
>> > +}
>> 
>> Many of our functions return -1 to signal an error, and that is why
>> it makes sense for our error() helper to return -1 to save code in
>> the caller, but only because the callers of this private helper use
>> a NULL to signal an error, this also returns NULL.  If we were to
>> use the "callers can opt into detailed message by passing strbuf"
>> pattern more widely, we would want a variant of the above that
>> returns -1, too.  And such a helper would do the same thing as
>> above, with only difference from the above is to return -1.
>
> Yeah, this is not really a good general-purpose purpose function in that
> sense. I have often wanted an error() that returns NULL, but avoided
> adding just because it seemed like needless proliferation.
>
> The real reason to include the return value at all in error() is to let
> you turn two-liners into one-liners.

Yeah, our error() returns -1 to save code in the caller.  And the
callers of this private helper all want to return NULL, so this
returns NULL for the same reason.

> We could drop the return value from
> this helper entirely (or make it -1, but of course no callers would use
> it) and write it out long-hand in the callers:
>
>   if (!branch->merge) {
> 	error_buf(err, ...);
> 	return NULL;
>   }
>
> That is really not so bad, as there are only a handful of callers.

That may happen when somebody (perhaps Jonathan?) wants to push the
"let's optionally pass strbuf to format messages into" approach
forward, and most likely be done by adding a similar function to
usage.c next to error_builtin() and friends.  As long as we do not
forget to reimplement this helper in terms of that public function
when it happens, what we have right now after this patch would be
fine.

> Yeah, my goal here was to faithfully keep the same logic, but I had a
> similar head-scratching moment. What would make more sense to me is:
>
>   if (!branch)
> 	return error("HEAD does not point to a branch");
>
>   if (!branch->merge || !branch->merge[0]) {
> 	/*
> 	 * no merge config; is it because the user didn't define any, or
> 	 * because it is not a real branch, and get_branch auto-vivified
> 	 * it?
> 	 */
> 	if (!ref_exists(branch->refname))
> 		return error("no such branch");
> 	return error("no upstream configured for branch");
>   }
>
>   if (!branch->merge[0]->dst)
> 	return error("upstream branch not stored as a remote-tracking branch");
>
>   return branch->merge[0]->dst;
>
> Hopefully the comment there answers your question; it is not that we
> truly care whether the ref exists, but only that we are trying to tell
> the difference between a "real" branch and a struct that is an artifact
> of our internal code.

Well, answering "my" question here on the list wouldn't help future
readers of the code very much ;-)

> Note also that the original may dereference branch->merge[0] even if it
> is NULL. I think that can't actually happen in practice (we only
> allocate branch->merge if we have at least one item to put in it, and
> all of the checks of branch->merge[0] are actually being over-careful).
> But the code I just wrote above does not have that problem.

Perhaps update the patch with this explanation in the log message,
as a separate preparatory step?

Thanks.
