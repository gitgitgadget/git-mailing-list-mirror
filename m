From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] copy.c: make copy_fd preserve meaningful errno
Date: Tue, 18 Nov 2014 08:32:28 -0800
Message-ID: <xmqqtx1wwjtv.fsf@gitster.dls.corp.google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
	<20141117233525.GC4336@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 17:32:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqlhz-0000ax-CH
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 17:32:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbaKRQcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 11:32:46 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63498 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932259AbaKRQcc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 11:32:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 04D391EC6F;
	Tue, 18 Nov 2014 11:32:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oFz4B1FXxd4cjDivOmvpla/zVz0=; b=p8X/eo
	8uhB8Ps9AoNum+cuo+9FZ/3Cp+WXDHw+wy+7WAVBI1/QacyYJmrBAweeNjKf6pdo
	VARDGQF34h8LnBmjT3yrCnhILz4OYkFEuxbRnMLknHYfeeenL45TIw94Lmzk2UGY
	5CjI8ZYJXB7Ziz3tfn1Pfhka/FLyrAncS7MQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tbNJyi1IR1FH4HxbvQKixqRo5cRFK4f6
	heizwTbW5HyijCLHRlcJp2WuXcOn2s7NQS3lyPA7o6DDv41Wgi8np/jy97UHgXh0
	nzkLRnfFmTp32DzSXPIodfZ20XPDENlDejsvJ+1TeK7ljBjDFDWD8ljsDOsLlmgI
	fCDk7WEVhCc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ED4041EC6E;
	Tue, 18 Nov 2014 11:32:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7729B1EC6D;
	Tue, 18 Nov 2014 11:32:32 -0500 (EST)
In-Reply-To: <20141117233525.GC4336@google.com> (Jonathan Nieder's message of
	"Mon, 17 Nov 2014 15:35:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7EDDE514-6F40-11E4-9038-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Do any callers care about errno?  Does the function's API
> documentation say it will make errno meaningful on error, so people
> making changes to copy_fd in the future know to maintain that
> property?
>
> *searches*
>
> Looks like callers are:
>
>  convert.c::filter_buffer_or_fd, which doesn't care
>
>  copy.c::copy_file, which also doesn't care
>
>  lockfile.c::hold_lock_file_for_append, which started caring
>  in order to propagate errno in v2.2.0-rc0~53^2~2 (restore errno
>  before returning, 2014-10-01).  But no callers of that function
>  care yet.
>
> So this is about fixing a bug-waiting-to-happen in
> hold_lock_file_for_append.  That would be enough to motivate the
> change.

OK.  Perhaps convert.c wants to be fixed?

>> +			int save_errno = errno;
>> +			error("copy-fd: read returned %s", strerror(errno));
>> +			errno = save_errno;
>> +			return -1;
>
> Any caller is presumably going to turn around and print strerror(errno)
> again, producing repetitive output.
>
> Can we do better?  E.g., if the signature were
>
> 	int copy_fd(int ifd, int ofd, struct strbuf *err);
>
> then we could write the error message to the err strbuf for the
> caller to print.

The problem you are solving is "because the caller may want to do
its own error message, stop the callee from emitting the error
message unconditionally", but if we are addressing "the caller may
want to...", I think we should find a single solution that addresses
other kind fo things the caller may want to do.

For example, two callers may want to phrase the same error condition
differently, e.g. depending on what the user asked to do.  We'd want
something better than the ERRORMSG trick used in unpack-trees.c,
which does not scale, and I think passing some data that represents
"here is how the caller wants the errors to be handled and
presented" is probably a part of the solution, but strbuf *err is
not that.

In short I am not a very big fan of passing around strbuf *err to
low level helper API functions myself.

But the approach does not make things much worse than it currently
is, other than code churns to pass an extra pointer around.
