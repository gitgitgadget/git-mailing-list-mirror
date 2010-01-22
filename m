From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-mv: Fix error with multiple sources.
Date: Thu, 21 Jan 2010 21:57:05 -0800
Message-ID: <7v8wbqbs26.fsf@alter.siamese.dyndns.org>
References: <718290.769818367-sendEmail@darysmbp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	"Johannes Sixt" <j6t@kdbg.org>
To: "David Rydh" <dary@math.berkeley.edu>
X-From: git-owner@vger.kernel.org Fri Jan 22 06:57:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYCWF-0008M7-Ep
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 06:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305Ab0AVF5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 00:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266Ab0AVF5Q
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 00:57:16 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46937 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845Ab0AVF5P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 00:57:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DA2493966;
	Fri, 22 Jan 2010 00:57:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7OVSONGBFuN3SB6r3C87/CaicXI=; b=BzxB1o
	+MzcRTZF13J0K9ChDL/pDrDsoMbm5xh9/ZmCJtNnlXZ8EuLyc/o7Bblnm2InKHuU
	1Yf5W6lOM924F9H55qqMk/SnM6hsmzODMnVpWWoEbX2H3tcXMVZchkhXqyu5OGs3
	swtXPG/nqt/DIp5Rm4yydFe064iFmC9m6e5UM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XHU7AEeTXVLQa5Lt/L2gYl0T2ip6uTic
	yA4/BbJmhcy7Wp66mrtCo0Y5uKAeHZNaAgr8ezdXlwIg9PuA16Nz6bk583otb1Rq
	TlQPkF1zhKSFj2Xgd0wmk8suCODQTjgywGuyASPrCfQGKoTAhDwY85rivXS5BkhI
	jz3wTyoNnB4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 583D693965;
	Fri, 22 Jan 2010 00:57:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C28993964; Fri, 22 Jan
 2010 00:57:06 -0500 (EST)
In-Reply-To: <718290.769818367-sendEmail@darysmbp> (David Rydh's message of
 "Thu\, 21 Jan 2010 12\:39\:41 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FAD6BF08-071A-11DF-B860-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137740>

"David Rydh" <dary@math.berkeley.edu> writes:

> Commit b8f26269 (fix directory separator treatment on Windows,
> 30-06-2009) introduced a bug on Mac OS X. The problem is that
> basename() may return a pointer to internal static storage space that
> will be overwritten by subsequent calls:
>
>> git mv dir/a.txt dir/b.txt other/
>
>   Checking rename of 'dir/a.txt' to 'other/b.txt'
>   Checking rename of 'dir/b.txt' to 'other/b.txt'

Good spotting.  basename(3)/dirname(3) are tricky functions to use
correctly.  In addition to the "static storage" implementation and its
associated problem you encountered, they can also be implemented to modify
the given string in place, and can even return a pointer _into_ the given
string, which means that if you do:

	duped = strdup(string);
        duped = basename(duped);
        ... use duped ...
	free(duped);

you may be burned quite badly.  The other call site of basename(3) is in
diff.c and it looks safe.

> diff --git a/setup.c b/setup.c
> index 710e2f3..80cf535 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -132,8 +132,8 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
>  		return NULL;
>  
>  	if (!entry) {
> -		static const char *spec[2];
> -		spec[0] = prefix;
> +		const char **spec = xmalloc(sizeof(char *) * 2);
> +		spec[0] = xstrdup(prefix);
>  		spec[1] = NULL;
>  		return spec;
>  	}

I don't understand this change.  Because elements of returned pathspec
from this function are often simply the pathspec argument itself (which in
turn is often argv[] of the calling program), and other times allocated by
this function, the callers are never going to free() them.
