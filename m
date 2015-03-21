From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/15] update-index: fix a memleak
Date: Fri, 20 Mar 2015 20:40:00 -0700
Message-ID: <xmqqwq2baui7.fsf@gitster.dls.corp.google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
	<1426897692-18322-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 04:40:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZAGv-0006MS-9B
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 04:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbbCUDkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 23:40:04 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54646 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751527AbbCUDkD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 23:40:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A02CC42988;
	Fri, 20 Mar 2015 23:40:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o2bdLfJGSty55DlKxItYhGLJX2Q=; b=BwCyjO
	s1CxloncMCv+IhUp6hP9DjjRhiPrt0skG4Of1HLB1KBgdEjUMKF3YZw33iGuWIuh
	xO6GxngTtu3MWGCVJk/uQ2Wh6jkCGVgBRxsn37RdzdyMopPHc3tbR6mzn7d6kbkj
	XaGmMsUWyXSg2IYTDHWTSvgHBQokpM3q9kHtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MXEBo6r3b65vtXr2Ra8/W6hSIH4SDbPc
	/c/UIO2a8gyveWpYgW7FI//YxaD3P7zHBg5ru80Ki76E+WyGiEkTp+V4sPCC5nLe
	4MW6IX6FWDdGv+up/zU2cLWrpqgUJtsYdMdnlENxgt3DfUa6Q+iF4Lfcn3mzXqyb
	OOQLMxT9918=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9730242987;
	Fri, 20 Mar 2015 23:40:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C273042983;
	Fri, 20 Mar 2015 23:40:01 -0400 (EDT)
In-Reply-To: <1426897692-18322-5-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 20 Mar 2015 17:28:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F4837F4A-CF7B-11E4-9BCD-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266002>

Stefan Beller <sbeller@google.com> writes:

> `old` is not used outside the loop and would get lost
> once we reach the goto.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/update-index.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 5878986..6271b54 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -584,6 +584,7 @@ static int do_reupdate(int ac, const char **av,
>  		path = xstrdup(ce->name);
>  		update_one(path);
>  		free(path);
> +		free(old);

The change looks trivially correct.

A tangent; I wonder if we want to make path a strbuf that is
declared in the function scope, reset (not released) at each
iteration of the loop and released after the loop; keep allocating
and freeing a small piece of string all the time feels somewhat
wasteful.

Also, we might want to add to the "Be careful" comment to describe
why this cannot just be a call to "update_one(ce->name)" that does
not use "path".
