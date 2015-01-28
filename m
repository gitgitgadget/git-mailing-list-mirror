From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] read_and_strip_branch: fix typo'd address-of operator
Date: Wed, 28 Jan 2015 12:42:26 -0800
Message-ID: <xmqq1tmehc25.fsf@gitster.dls.corp.google.com>
References: <20150128175314.GA13362@peff.net> <20150128175735.GA8172@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 28 21:42:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGZRb-0006KP-Jo
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 21:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761329AbbA1Umb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 15:42:31 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54867 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759688AbbA1Um2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 15:42:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 14DE733DB3;
	Wed, 28 Jan 2015 15:42:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uYIE/3pj2C2GxHAuWAC9rZwoPwU=; b=O97Ci1
	/Vi9ObszR5N6rAecDoBd8FoR7Qh4M4d7aUuE8IPrpF/xRzOrosK4LJODDb95IBPd
	iB13/xSOyrN1JYoN0Qi9LyYP+lRjmZkvzPCJT4FuPg/ib8tfu2gGXCYhLVBtXRI4
	878rldjJsxnjaQWl/dpATViNPoKS3Sx+hhOP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rBV02OVMv8gC+sszHEotcySruoEufsR/
	M3ZZcCLLr4X0ddhtYqtXKnpTOZHgqNqVX0I/vKoyZ82v0OmxELciZ6U6kmRaCMqw
	FXFg33N+q7FlPwZN71QpIvcAXhELTsDBoUUX/i1m8ayeqooXxIlwYG1Mwj8H3cXH
	6QdQqeaIzFQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 084DE33DB0;
	Wed, 28 Jan 2015 15:42:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8090033DAF;
	Wed, 28 Jan 2015 15:42:27 -0500 (EST)
In-Reply-To: <20150128175735.GA8172@peff.net> (Jeff King's message of "Wed, 28
	Jan 2015 12:57:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2BEEC1FE-A72E-11E4-B91A-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263115>

Jeff King <peff@peff.net> writes:

> When we are chomping newlines from the end of a strbuf, we
> must check "sb.len != 0" before accessing "sb.buf[sb.len - 1]".
> However, this code mistakenly checks "&sb.len", which is
> always true (it is a part of an auto struct, so the address
> is always non-zero). This could lead to us accessing memory
> outside the strbuf when we read an empty file.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This dates back to 8b87cfd (wt-status: move strbuf into
> read_and_strip_branch(), 2013-03-16), so it is not a bug that needs
> addressed during the -rc period.
>
> This is the most minimal fix, but I kind of wonder if it should just be
> using strbuf_rtrim (or even strbuf_trim) in the first place.

Yeah.  Or strbuf_chomp(), which does not exist ;-)

It is tempting to apply this directly to maint and merge up
immediately, as there is no way this 1-byte change will break things
(of course that is not necessarily true for random 1-byte changes,
though).

It sometimes gets really hard to resist that temptation during the
pre-release freeze period.

>  wt-status.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index b54eac5..29666d0 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1140,7 +1140,7 @@ static char *read_and_strip_branch(const char *path)
>  	if (strbuf_read_file(&sb, git_path("%s", path), 0) <= 0)
>  		goto got_nothing;
>  
> -	while (&sb.len && sb.buf[sb.len - 1] == '\n')
> +	while (sb.len && sb.buf[sb.len - 1] == '\n')
>  		strbuf_setlen(&sb, sb.len - 1);
>  	if (!sb.len)
>  		goto got_nothing;
