From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] fast-{import,export}: use get_sha1_hex() directly
Date: Tue, 07 May 2013 16:19:09 -0700
Message-ID: <7vli7qidjm.fsf@alter.siamese.dyndns.org>
References: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
	<1367793534-8401-2-git-send-email-felipe.contreras@gmail.com>
	<7v38tyn9cq.fsf@alter.siamese.dyndns.org>
	<CAMP44s0AipiEVhHrDS0-dB9jCoCqHYDd_s5gcGzqyuh0A+qehg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 08 01:19:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZrAP-0004X0-MI
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 01:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104Ab3EGXTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 19:19:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52910 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755923Ab3EGXTN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 19:19:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB73E1CE85;
	Tue,  7 May 2013 23:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e7iiH54DBGlaPZhTR1LUzbKoKnE=; b=uAZEvl
	kGwdwSYH2Y4DD7WZamf/kUD4zdiccfHZBRBWqkHnZoB9cAaVbhy4Zg9JyVvkNXYE
	oghMc/fl8tw3SVUhPYGu0d6o1pu2lty1deTZ2G1kUka/s6sfDFyW2TwuiJTrCfLI
	ipWHmN8GvXUj06O3usmuoIm67W6MwwOP/DPHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lxunR6rk2ZrsdqqJF5Yr74UO4O65XmoB
	hPITytve/5Q5Z49ZFc9shtS71GRBz9zkpTT8QcDPxJgAJFMDhfZY9g7eiRk8lz48
	K2aGXXnRsZPeneKZZGC+iAsMd8CuT6SW3JSM1GzYrSrB0HqA2MTJIcXeIRkjn5S7
	HSVjPR/NUfM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F8891CE84;
	Tue,  7 May 2013 23:19:11 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F96B1CE81;
	Tue,  7 May 2013 23:19:11 +0000 (UTC)
In-Reply-To: <CAMP44s0AipiEVhHrDS0-dB9jCoCqHYDd_s5gcGzqyuh0A+qehg@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 7 May 2013 17:13:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8642ADF4-B76C-11E2-9CC5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223628>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Turns out most of the get_sha1() calls were correct; this does the trick:
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 18fdfb3..d1d68e9 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -623,7 +623,7 @@ static void import_marks(char *input_file)
>
>                 mark = strtoumax(line + 1, &mark_end, 10);
>                 if (!mark || mark_end == line + 1
> -                       || *mark_end != ' ' || get_sha1(mark_end + 1, sha1))
> +                       || *mark_end != ' ' || get_sha1_hex(mark_end + 1, sha1))
>                         die("corrupt mark line: %s", line);
>
>                 if (last_idnum < mark)
> diff --git a/fast-import.c b/fast-import.c
> index 5f539d7..3f32149 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1822,7 +1822,7 @@ static void read_marks(void)
>                 *end = 0;
>                 mark = strtoumax(line + 1, &end, 10);
>                 if (!mark || end == line + 1
> -                       || *end != ' ' || get_sha1(end + 1, sha1))
> +                       || *end != ' ' || get_sha1_hex(end + 1, sha1))

This is where --import-marks is handled, and we should be seeing

	:markid SHA-1

one per each line (according to Documentation/git-fast-import.txt).
So this one should be get_sha1_hex().

The other one in fast-export.c would be the same.

The other ones in the original patch were reading from the
fast-import stream and shouldn't have insisted on 40-hex.

Will replace the body of the change with only these two hunks and
requeue.  Thanks.
