From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] Allow help.htmlpath to be a URL prefix
Date: Thu, 28 Jun 2012 14:24:33 -0700
Message-ID: <7vvcib3zam.fsf@alter.siamese.dyndns.org>
References: <8d3c71d21710c66e4d5560cec958552b69a22338.1340866684.git.chris@arachsys.com>
 <cebaecfaa217a20794e8278b4db3ce5b8d667834.1340866684.git.chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 23:24:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkMCf-0001KV-D3
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 23:24:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367Ab2F1VYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jun 2012 17:24:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44137 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995Ab2F1VYg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2012 17:24:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 563E2885F;
	Thu, 28 Jun 2012 17:24:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TWTQHNgD+CMij13yw5kI8EYUg7E=; b=P3R7qK
	2dyVfiBbbJ49VenPC/pTzUgOPKixiL40Ip0WXcm15BSrUHx8smNhGSPETvWvt3i5
	JS//BuzGrs0ktYR3tEpTgdYjIEdsyZWAQ7y55a8q2EbOk3e/++w/2C82NFCqLhws
	i3XriZMs7kz2pg05pOifccny3B9FC9Ob+PsRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uezg+dIO+NvVRZc7WN0k+nhdazBXEOin
	vX96elBvCKzHdkxnTjA3l3EmYfuGEwqB1fI24IgEvvS4+nf98NoUWneuJZ/4qkIR
	8etghUd9JY8NAmlFW5o8QvY1huyySufzFeNsGCxIjXyoFVU1aBaGM64UQEFUOcxW
	LLmDJXl3XKk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CAB8885E;
	Thu, 28 Jun 2012 17:24:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3665885D; Thu, 28 Jun 2012
 17:24:34 -0400 (EDT)
In-Reply-To: <cebaecfaa217a20794e8278b4db3ce5b8d667834.1340866684.git.chris@arachsys.com>
 (Chris Webb's message of "Thu, 28 Jun 2012 07:58:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A8644FA6-C167-11E1-A9D0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200796>

Chris Webb <chris@arachsys.com> writes:

> Setting this to a URL prefix instead of a path to a local directory allows
> git-help --web to work even when HTML docs aren't locally installed, by
> pointing the browser at a copy accessible on the web. For example,
>
>     [help]
>       format = html
>       htmlpath = http://git-scm.com/docs
>
> will use the publicly available documentation on the git homepage.
>
> Signed-off-by: Chris Webb <chris@arachsys.com>
> ---
>  builtin/help.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/help.c b/builtin/help.c
> index b467db2..92f2349 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -399,9 +399,11 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
>  		html_path = system_path(GIT_HTML_PATH);
>  
>  	/* Check that we have a git documentation directory. */
> -	if (stat(mkpath("%s/git.html", html_path), &st)
> -	    || !S_ISREG(st.st_mode))
> -		die(_("'%s': not a documentation directory."), html_path);
> +	if (!strstr(html_path, "://")) {
> +		if (stat(mkpath("%s/git.html", html_path), &st)
> +				|| !S_ISREG(st.st_mode))
> +			die("'%s': not a documentation directory.", html_path);
> +	}
>  
>  	strbuf_init(page_path, 0);
>  	strbuf_addf(page_path, "%s/%s.html", html_path, page);

Sounds sensible and looks reasonable.  Thanks.

I do not think [PATCH 3/3] is a positive change at all, though.
