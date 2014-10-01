From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] fdopen_lock_file(): access a lockfile using stdio
Date: Wed, 01 Oct 2014 14:20:14 -0700
Message-ID: <xmqq8ukzpjw1.fsf@gitster.dls.corp.google.com>
References: <1412162089-3233-1-git-send-email-mhagger@alum.mit.edu>
	<1412162089-3233-2-git-send-email-mhagger@alum.mit.edu>
	<20141001124847.GB10772@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 01 23:20:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZRJv-00087E-W5
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 23:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbaJAVUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 17:20:20 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63319 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786AbaJAVUS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 17:20:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6000E3DAFE;
	Wed,  1 Oct 2014 17:20:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vL1URKSyhkHlTR3lUVsXv8Qzka0=; b=KSqV4/
	l3Zs+l7Dnk96wqyVTu+5xeJTcDbybH4LHrIqLwEK6rgULl8mIs3VvwV9pfQ5nK/d
	GijlVWSSJKotHuwWIc9MhQZ7cxjoxsBKfZCwANYcnGkYSLHtjogg8HFfSB5ZyWCr
	Omgq6sxa79S4EiuEw+9GUIIjHT3E43DZsTAIw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DaNvsU+G1gP6c/N0ka2ffWFvBZrTt/4K
	uj9jU1k9EHTzvoo+UqHJ/JGbRnAIjUlBJilMnb6XMHAdNgXnYS6OX5TKKXSRilOG
	IAkd7J1wQNtaVhlKPhiJ1QaBTBferAoU1x71Qlu1sWIAA3Op+aOIS7g1D5dKI1g8
	9SVp4Rf1Hdk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D531D3DAFC;
	Wed,  1 Oct 2014 17:20:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7B4443DAFB;
	Wed,  1 Oct 2014 17:20:15 -0400 (EDT)
In-Reply-To: <20141001124847.GB10772@peff.net> (Jeff King's message of "Wed, 1
	Oct 2014 08:48:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BCA38F8A-49B0-11E4-9563-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257766>

Jeff King <peff@peff.net> writes:

> On Wed, Oct 01, 2014 at 01:14:47PM +0200, Michael Haggerty wrote:
>
>> ... If using stdio on lockfiles becomes
>> more popular, we might want to add some helper functions to make it a
>> bit more convenient.
>
> I think it makes sense to wait until we see more potential callers crop
> up.

Yup.

>> In close_lock_file(), if ferror() returns an error, then errno is not
>> necessarily still set in a way that reflects the original error. I
>> don't see a way to ensure that errno is set correctly in this
>> situation. But hopefully, callers are monitoring their calls to
>> fwrite()/fprintf() etc and will have noticed write errors on their own
>> already. If anybody can suggest an improvement here, please let me
>> know.
>
> I was careful in the packed-refs stdio caller to check all of my fprintf
> calls (because I was using fclose myself). I wonder if it would be nicer
> to back off from that and just depend on the ferror() call at
> commit-time.

That's a thought (I think the same can be said for "close-time").

>> -static void remove_lock_files(void)
>> +static void remove_lock_files(int skip_fclose)
>>  {
>>  	pid_t me = getpid();
>>  
>>  	while (lock_file_list) {
>> -		if (lock_file_list->owner == me)
>> +		if (lock_file_list->owner == me) {
>> +			/* fclose() is not safe to call in a signal handler */
>> +			if (skip_fclose)
>> +				lock_file_list->fp = NULL;
>
> I wondered when reading the commit message if it should mention this
> signal-handling case (which you brought up in the cover letter). This
> comment is probably enough, though.

No strong opinion either way.

>> +FILE *fdopen_lock_file(struct lock_file *lk, const char *mode)
>> +{
>> +	if (!lk->active)
>> +		die("BUG: fdopen_lock_file() called for unlocked object");
>> +	if (lk->fp)
>> +		die("BUG: fdopen_lock_file() called twice for file '%s'", lk->filename.buf);
>
> I would have expected calling this twice to be a noop (i.e., make the
> function more "give me the associated filehandle, and create one if
> necessary"). But I don't think any current callers should need that, so
> it probably makes sense to play it safe and die("BUG"), at least for
> now.

Interesting.  One could imagine a sane call-chain whose top-level
creates a lockfile, associates a FILE * with it to write into it
itself, then calls set of helpers.  You could pass only FILE * to
such helpers that does nothing other than writing to lk->fp to the
lockfile, but it would be cumbersome if a helper wants to have
access to the lockfile itself and FILE * (i.e. it writes and then
either commits or rolls back; name it foo_finish() or something).

Such a call-chain certainly would want a way to ask "I know this lk
is already associated with a FILE *; give me that".  But that still
does not require "I do not know if this lk already has FILE * or
not, but I want a FILE * associated with it now.  Peek or create."

So I think this is OK.

>> +	if (fp) {
>> +		lk->fp = NULL;
>> +
>> +		/*
>> +		 * Note: no short-circuiting here; we want to fclose()
>> +		 * in any case!
>> +		 */
>> +		err = ferror(fp) | fclose(fp);
>
> Would this be more clear as:
>
> 	err = ferror(fp);
> 	err |= fclose(fp);

No strong opinion either way.

Thanks, both.
