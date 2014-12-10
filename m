From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf
Date: Wed, 10 Dec 2014 11:00:18 -0800
Message-ID: <xmqqfvcngwjh.fsf@gitster.dls.corp.google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
	<20141117233525.GC4336@google.com>
	<CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
	<20141118004841.GE4336@google.com>
	<CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
	<20141203050217.GJ6527@google.com> <20141203051344.GM6527@google.com>
	<xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
	<20141203210031.GA6631@peff.net> <20141203213858.GC6527@google.com>
	<20141204075920.GA27142@peff.net> <54887CB7.4000603@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Dec 10 20:00:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XymUw-0002ER-QO
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 20:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932875AbaLJTAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 14:00:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53840 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932501AbaLJTAV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 14:00:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CE6BF235D6;
	Wed, 10 Dec 2014 14:00:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uVHghIhshvBoOtG9p77F4ni4tPM=; b=FMBPQ3
	w5ufQ2cCEHujkvFc8OyDmiNyU6ayDxKgIolAoHG7XzWqNH7XpHwNUDRTAWgf99/k
	A+euaJtS/jjyrDomq1nOofpL/vucgO+phL2IGKKf2Kh8ZbyQSi3JcRyA36iG1c2L
	GP2pHjspGkjoFDeM9agrROL+6kwcTDGpumKPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ho7i5SISNXPAXNPsFatRAWGbaiwriiKh
	GuWM/T568u3FKSyEtP5YSxKxvG8FS/t3YoyQCls8HJWuKKUX2GLjf/9k7oPmJUmP
	dj+VVx1TNhhJy8N19sA8LatOkAmAT/3+En0+h4jgWS8qPGYeHmM0ayTSTwHTKcLk
	eWAsjyX8qwU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C547B235D5;
	Wed, 10 Dec 2014 14:00:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 51D5B235D0;
	Wed, 10 Dec 2014 14:00:19 -0500 (EST)
In-Reply-To: <54887CB7.4000603@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 10 Dec 2014 18:02:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C901AFEE-809E-11E4-911F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261238>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> What if we go in the direction not of less infrastructure, but a little
> bit more? Like
>
> 	struct result {
> 		int code;
> 		struct strbuf msg;
> 	};
>
> 	int report_errors(struct result *result)
> 	{
> 		int code = result->code;
> 		if (code) {
> 			error(result->msg.buf);
> 		}
> 		result->code = 0;
> 		strbuf_release(result->msg);
> 		return code; /* or alternatively (code ? -1 : 0) */
> 	}
>
> 	int report_warnings(struct result *result)
> 	{
> 		...
> 	}
>
> 	int report_with_prefix(struct result *result, const char *fmt, ...)
> 	{
> 		...
> 	}
>
> Then a caller could look pretty much like before:
>
> 	struct result result = RESULT_INIT;
>
> 	if (some_func(fd, &result))
> 		return report_errors(&result);
>
> Other callers might not even bother to check the return value of the
> function, relying instead on result.code via process_error():
>
> 	char *ptr = some_func(fd, &result);
> 	if (report_errors(&result))
> 		return -1;
>
> If the result code is considered superfluous, we could use naked strbufs
> and use msg.len as the indicator that there was an error.

Two potential issues are:

 - Callers that ignore errors need to actively ignore errors with
   strbuf_release(&result.msg);

 - Callers have to remember that once the report_errors() function
   is called on a "struct result", the struct loses its information.

Neither is insurmountable, but the latter might turn out to be
cumbersome to work around in some codepaths.

Other than that, I think it is OK.

Another alternative may be to have the reporting storage on the side
of the callee, and have callers that are interested in errors to
supply a place to store a pointer to it, i.e.

	int some_func(..., struct result **errors) {
        	static struct result mine;

		clear_result(&mine);
		... do its thing ...
                if (... error detected ...) {
                        mine.code = E_SOMEFUNC;
                        strbuf_addstr(&mine.msg, "some_func: foobared");
		}

		if (errors)
			*errors = &mine;
                return mine.code;
	}

And a caller would do this instead:

	struct result *result = NULL;

        if (some_func(fd, &result))
		return report_errors(result);

where report_errors() and friends will only peek but not clear the
result reporting storage.  The clear_result() helper would trivially
be:

	void clear_result(struct result *result) {
		result->code = 0;
                strbuf_release(&result->msg);
	}
