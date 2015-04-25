From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] refs.c: enable large transactions
Date: Fri, 24 Apr 2015 21:23:16 -0700
Message-ID: <xmqqzj5w25vv.fsf@gitster.dls.corp.google.com>
References: <1429738227-2985-1-git-send-email-sbeller@google.com>
	<xmqqzj5y3f0a.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYO9NifvWQ7nWHP6==ZFmrMj47-94rEHOhWooR5Nh7EUw@mail.gmail.com>
	<xmqq8udi2tn8.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYGDOUgzKmQOLAXkYYb-HZJCw3Y=iSLXWHVXcQ0pAiDBw@mail.gmail.com>
	<20150424181236.GK5467@google.com> <20150424201734.GA4747@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 25 06:24:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlrdL-0006Sc-D7
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 06:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbbDYEXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2015 00:23:25 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750731AbbDYEXY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 00:23:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 943604CBFF;
	Sat, 25 Apr 2015 00:23:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4X8iafYWqiTm+XALP088qdP7mo4=; b=hBRsU8
	hyPbxkAZyB14rXYtD2S9qz928r+Gmw064Ex3EGSn9KVyHekuLEhsdcONSS6H/01x
	GsizGyxad/JSP4Hynb82IXcSuU0+8yPRBGcDdI7uTBS/eu2tu8EVlJNyED7mIChH
	gDy7TZjt+YmCLT6XWP466bbv2jfaKNe2Ld/80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wbxu2WBvWs1J7ipr8MKPeFHBukmkjulA
	GtWtL48DftvfNn+QkxYs3J2nHTyFDtZ+bBrWUZFOqE1nqRjdhBPkLcBGPIitAWx3
	n0I8c86zkzF9W2QJVcVkKsDUqHTh2Fo7GHSdctg7XPUkKI0KbRRTfqM9yRlmD47X
	ilPVXPc67VE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CD7A4CBFE;
	Sat, 25 Apr 2015 00:23:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0AF684CBFD;
	Sat, 25 Apr 2015 00:23:17 -0400 (EDT)
In-Reply-To: <20150424201734.GA4747@peff.net> (Jeff King's message of "Fri, 24
	Apr 2015 16:17:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CC74E12C-EB02-11E4-9066-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267768>

Jeff King <peff@peff.net> writes:

> So if anything, I think my inclination would be to make it easier to
> help people (and ourselves) get a backtrace from gdb.
>
> One can get a core for a running process with gcore, or trigger a
> coredump by killing with SIGABRT. But catching it at the exact moment of
> a die() is a bit hard without support from the program. What about
> something like this:
>
> diff --git a/usage.c b/usage.c
> index ed14645..fa92190 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -34,6 +34,8 @@ static NORETURN void usage_builtin(const char *err, va_list params)
>  static NORETURN void die_builtin(const char *err, va_list params)
>  {
>  	vreportf("fatal: ", err, params);
> +	if (git_env_bool("GIT_DIE_ABORT", 0))
> +		abort();
>  	exit(128);
>  }

Two comments.

There probably are more than a few places that calls exit(128)
without using die(), upon seeing that some helper function returned
an error code, because the helper already gave an error message.

The proposals so far, including this one, assume that the bug
reporter will first fail the operation with "normal" invocation
of Git (e.g. without GIT_DIE_ABORT exported) and then retry the
same operation in a different way (e.g. with GIT_DIE_ABORT) to
give us something that would help diagnosis.  Such a user could
just rerun Git under gdb with breakpoint set to die_builtin, no?
