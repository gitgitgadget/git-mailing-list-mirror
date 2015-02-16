From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] cmd_push: pass "flags" pointer to config callback
Date: Sun, 15 Feb 2015 23:05:57 -0800
Message-ID: <xmqqr3tq72ui.fsf@gitster.dls.corp.google.com>
References: <20150216061051.GA29895@peff.net>
	<20150216061325.GB32381@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dave Olszewski <cxreg@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 08:06:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNFks-0000Y3-RE
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 08:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbbBPHGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 02:06:01 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53935 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751801AbbBPHGA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 02:06:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 638F22BB5D;
	Mon, 16 Feb 2015 02:05:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x8X9QnE7Dcxcpf9mFMDVlmrtZGg=; b=M2wzsV
	UFWojKUKwLtP2bcVYbpcugIbM0YUDqkr72UWR0YGWrDIx9Eqp8y3O+kgPvtmGo5b
	OnqpocSC5nZWYo/OrQcoJ1Lmh2KfHyt9tqQLq0HGplwq7ltPXoqUR8NzwESIXGLK
	ZvvQehSm3u6oOVkr5qwBZJDm7+5YDSQ5Njytw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=snLs1NXStJJc4A7jJ6XJkzexi9ALEscL
	M4sY5QX7q8gxBUPkUOchNsURxO3c5LUITEDCVzrlupwnp1gHqsdrqwXeaC+nUikA
	TcbnFrMrWNXF46cbW8ihKaMxrju6XofcBocUpi+aie5hyOPp6TJdGlG5+M+6eigc
	sXTIv6+cS8U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B18D2BB5C;
	Mon, 16 Feb 2015 02:05:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D358C2BB5B;
	Mon, 16 Feb 2015 02:05:58 -0500 (EST)
In-Reply-To: <20150216061325.GB32381@peff.net> (Jeff King's message of "Mon,
	16 Feb 2015 01:13:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 42438EB4-B5AA-11E4-AA44-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263884>

Jeff King <peff@peff.net> writes:

> This will let us manipulate any transport flags which have matching
> config options (there are none yet, but we will add one in
> the next patch).

Nice---this will later lets us do push.atomic if we really wanted
to, right?

> To be honest, the whole do_push is confusing to me. It seems like that
> should just be part of cmd_push.

Yeah, that part of the push callchain always confuses me every time
I look at it.  I think it was a consequence of how transport layer
was wedged into the existing codepath that only handled push that
called send-pack to unify the codepaths that push calls into
different transport backends, and we may have done it differently
and more cleanly if we were designing the push to transport to
backends from scratch.

>  builtin/push.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/push.c b/builtin/push.c
> index f558c2e..c25108f 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -555,7 +555,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  	};
>  
>  	packet_trace_identity("push");
> -	git_config(git_push_config, NULL);
> +	git_config(git_push_config, &flags);
>  	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
>  
>  	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
