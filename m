From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] skip_prefix: rewrite so that prefix is scanned once
Date: Mon, 03 Mar 2014 11:05:16 -0800
Message-ID: <xmqqvbvvp0gj.fsf@gitster.dls.corp.google.com>
References: <1393816384-3300-1-git-send-email-siddharth98391@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Siddharth Goel <siddharth98391@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 20:05:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKYB9-0001DG-Uq
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 20:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755378AbaCCTFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 14:05:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37812 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754847AbaCCTFX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 14:05:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D386A70179;
	Mon,  3 Mar 2014 14:05:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X4zHQ583viJ/llbDADUV+vlpn20=; b=u2yN71
	9XsEb7FZiv3jyA0/6YbE+4CTl5B0BbSFEK5LoXwBM/G9mVe36z1yhKaIgWDkMEeb
	G5RahWuksvDw1OR503W3GXxDG07gU69SnAj3azgMkIvjwXE8Hr4losueWrhN1lSx
	dMpmbvdRjQJqCfkhYx34hdVnqLt9lfXtnYfrM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VB6csB4zFwj+x5yUjlVDE7cQuQmcie0m
	6booO+6yg5ewW5esw72IvFdaBWLSoWO9Bb4wy62XE9LJOntHo1LqysgM7ev/4jiE
	vH0/ZFHPd1GHHULAsBWxC3oRORVnrdHVsFHprx9UOlBCfQtYPck35x9x/aXboTB2
	EIewQxszvlQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE78C70175;
	Mon,  3 Mar 2014 14:05:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A868B70171;
	Mon,  3 Mar 2014 14:05:18 -0500 (EST)
In-Reply-To: <1393816384-3300-1-git-send-email-siddharth98391@gmail.com>
	(Siddharth Goel's message of "Mon, 3 Mar 2014 11:13:04 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C2F155BC-A306-11E3-BB63-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243255>

Siddharth Goel <siddharth98391@gmail.com> writes:

> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Siddharth Goel <siddharth98391@gmail.com>
> ---
> Added a space after colon in the subject as compared to previous 
> patch [PATCH v2].
>
> [PATCH v2]: http://thread.gmane.org/gmane.comp.version-control.git/243150

Whenever you see "Change", "Rewrite", etc. in the subject of a patch
that touches existing code, think twice.  The subject line is a
scarce real estate to be wasted on a noiseword that carries no real
information, and we already know a patch that touches existing code
changes or rewrites things.

    Subject: [PATCH v3] skip_prefix: scan prefix only once

perhaps?

>  git-compat-util.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 614a5e9..550dce3 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -357,8 +357,11 @@ extern int suffixcmp(const char *str, const char *suffix);
>  
>  static inline const char *skip_prefix(const char *str, const char *prefix)
>  {
> -	size_t len = strlen(prefix);
> -	return strncmp(str, prefix, len) ? NULL : str + len;
> +	while (*prefix != '\0' && *str == *prefix) {
> +		str++;
> +		prefix++;
> +	}
> +	return (*prefix == '\0' ? str : NULL);

Unlike another patch I saw the other day on the same topic, this
checks *prefix twice for the last round, even though I think this
one is probably slightly easier to read.  I dunno.
