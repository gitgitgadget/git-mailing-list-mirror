From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Add git-grep threads param
Date: Tue, 03 Nov 2015 09:22:09 -0800
Message-ID: <xmqqvb9jc81q.fsf@gitster.mtv.corp.google.com>
References: <1445980944-24000-1-git-send-email-vleschuk@accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Victor Leschuk <vleschuk@accesssoftek.com>,
	"torvalds\@linux-foundation.org" <torvalds@linux-foundation.org>,
	"john\@keeping.me.uk" <john@keeping.me.uk>
To: Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 18:22:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtfHp-0001UM-Mh
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 18:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461AbbKCRWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 12:22:15 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57712 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754645AbbKCRWM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 12:22:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 56327289EE;
	Tue,  3 Nov 2015 12:22:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NKYdmI4whjE87AYZZ37UucGBJxk=; b=bycEVA
	XCfKnl1vStRHifobrai3+TSd3+mfWE/mga8UvHK4a3HLyjGmRBErIenkVtlAJxTo
	e0Wpvg/MM4EV36nQWY3EYZtBVQoEgOgsx8ErZ2ekYqi7Jx380y92SbXOJgQ9Zv5B
	lX8SM8GG9cn0w4YqWDXqlgC0xD+2CIGSXSnaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ohYZl7mlHM2KurOWd8qVtgzGD4+57aG7
	4a8x8mDqpvuo54Th4w/jz0BYWcDxL8JnU4EuAXYTk+ob+mGWWzkRZPgkehbHkh+m
	Sb88GfLhri8f4+WfbF5sUMPB/SYnQuDemzct2t3KzM4RV8OBfbjbLoAdT4wCqwcV
	4ufXVo9kPUI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4B5A4289ED;
	Tue,  3 Nov 2015 12:22:11 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C2540289EC;
	Tue,  3 Nov 2015 12:22:10 -0500 (EST)
In-Reply-To: <1445980944-24000-1-git-send-email-vleschuk@accesssoftek.com>
	(Victor Leschuk's message of "Wed, 28 Oct 2015 00:22:24 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6AA8AF52-824F-11E5-978F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280803>

Victor Leschuk <vleschuk@gmail.com> writes:

> Make number of git-grep worker threads a configuration parameter.
> According to several tests on systems with different number of CPU cores
> the hard-coded number of 8 threads is not optimal for all systems:
> tuning this parameter can significantly speed up grep performance.
>
> Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
> ---
>  Documentation/config.txt               |  4 +++
>  Documentation/git-grep.txt             |  9 ++++++
>  builtin/grep.c                         | 56 ++++++++++++++++++++++++----------
>  contrib/completion/git-completion.bash |  1 +
>  4 files changed, 54 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 391a0c3..1dd2a61 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1447,6 +1447,10 @@ grep.extendedRegexp::
>  	option is ignored when the 'grep.patternType' option is set to a value
>  	other than 'default'.
>  
> +grep.threads::
> +	Number of grep worker threads, use it to tune up performance on
> +	multicore machines. Default value is 8. Set to 0 to disable threading.
> +

I am not enthused by this "Set to 0 to disable".  As Zero is
magical, it would be more useful if 1 meant that threading is not
used (i.e. there is only 1 worker), and 0 meant that we would
automatically pick some reasonable parallelism for you (and we
promise that the our choice would not be outrageously wrong), or
something like that.

Of course, we can do grep.threads=auto to make it even more
explicit, but I'd imagine that the in-core code to parse the option
and config to the num_threads variable would need one "int" value to
represent that "auto", and 0 would be a natural choice for that.

Thanks.
