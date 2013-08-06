From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/16] line-range: teach -L/RE/ to search relative to anchor point
Date: Tue, 06 Aug 2013 14:44:12 -0700
Message-ID: <7vwqnyebpv.fsf@alter.siamese.dyndns.org>
References: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
	<1375797589-65308-9-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 23:47:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6p68-0001HJ-Ah
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 23:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756877Ab3HFVrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 17:47:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60719 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756734Ab3HFVoP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 17:44:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F10CE3780A;
	Tue,  6 Aug 2013 21:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4fGS6UWvnYvTh3An8JtAuIVTnSE=; b=ZCRtze
	05NDZnDOewqqqgFeZcDCstErealcuktuNykgny50sdtbiqauEFK4DQcFlcStuHsr
	idI75TR3XeCyvxDTw4NZL7o3D+Q43MadPS4v9u2mZyW8+laua9Sm0VFjGiskXrfG
	3lMFIEhybPJtd5j0eEGAl3eZwvDs6prRqvaUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=svmlWtF7CVLN2h+G4gqFsm2t/lhrKq/X
	4pDAFWfNfw58hlgWgRgwCJ5d3/G8izybG/yIsRBOqO7zIw9RbiTwdkU8wiUuH9We
	9EBGIFkTeYuuLa9uemrDtCE78JuHAlNYpeM0cWKArftUVxCBVnAbls7ywiPHhVbk
	SJNAoD4zWu0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E38C837809;
	Tue,  6 Aug 2013 21:44:14 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2CB5537808;
	Tue,  6 Aug 2013 21:44:14 +0000 (UTC)
In-Reply-To: <1375797589-65308-9-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Tue, 6 Aug 2013 09:59:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56351978-FEE1-11E2-A521-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231790>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Range specification -L/RE/ for blame/log unconditionally begins
> searching at line one. Mailing list discussion [1] suggests that, in the
> presence of multiple -L options, -L/RE/ should search relative to the
> endpoint of the previous -L range, if any.
>
> Teach the parsing machinery underlying blame's and log's -L options to
> accept a start point for -L/RE/ searches. Follow-up patches will upgrade
> blame and log to take advantage of this ability.
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/229755/focus=229966
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  builtin/blame.c |  2 +-
>  line-log.c      |  2 +-
>  line-range.c    | 30 ++++++++++++++++++++++++++----
>  line-range.h    |  5 ++++-
>  4 files changed, 32 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 2f4d9e2..7b084d8 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2479,7 +2479,7 @@ parse_done:
>  	for (range_i = 0; range_i < range_list.nr; ++range_i) {
>  		long bottom, top;
>  		if (parse_range_arg(range_list.items[range_i].string,
> -				    nth_line_cb, &sb, lno,
> +				    nth_line_cb, &sb, lno, 1,
>  				    &bottom, &top, sb.path))
>  			usage(blame_usage);
>  		if (lno < top || ((lno || bottom) && lno < bottom))
> diff --git a/line-log.c b/line-log.c
> index bdadf35..38f827b 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -591,7 +591,7 @@ parse_lines(struct commit *commit, const char *prefix, struct string_list *args)
>  		cb_data.line_ends = ends;
>  
>  		if (parse_range_arg(range_part, nth_line, &cb_data,
> -				    lines, &begin, &end,
> +				    lines, 1, &begin, &end,

This one feeds "1" to anchor, which in turn is given to parse_loc as
"-1" and then (after bypassing the <end> part support) its sign
flipped once again to become "begin=1" in parse_loc().  Then we run
regexp search starting from (1-based) 1st line, retaining the
"always scan from the beginning" behaviour in this step in the
series.

OK, looks sensible.
