From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] http: Add Accept-Language header if possible
Date: Sun, 13 Jul 2014 09:57:12 -0700
Message-ID: <xmqqoawt19jr.fsf@gitster.dls.corp.google.com>
References: <1405097573-19239-1-git-send-email-eungjun.yi@navercorp.com>
	<CAPig+cRwJhyZ=R_HGs9JKUFLuJxoS=abrD9+HuoWDiA5oJrtjw@mail.gmail.com>
	<CAFT+Tg8pJrdoD4M1uy6A=PPJaSrq_QcRUQdxdrA-T5sJiZ7j1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>
To: semtlenori@gmail.com
X-From: git-owner@vger.kernel.org Sun Jul 13 18:57:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6N5Z-0003dU-Il
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 18:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbaGMQ5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 12:57:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53068 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753968AbaGMQ5V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 12:57:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3643025D18;
	Sun, 13 Jul 2014 12:57:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lv1ZXsIqfAppdKMuYkS8luMNnzI=; b=icf67B
	l6C6CFxlHM07SugAEdXT7KIruU8TmSzWXGJoDLa0kpGqeTloqw0Ms9DaUhW89M4p
	f1HUKfbRJyvz9mYJWqTi1fQ3NhKD8M7bVAPpzolG+BL8sDtpS/ExnueCen+gZsLn
	TNYY7qnqjaQ51m/kJtKjswCLFPQJYve+S+LMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jexZL4z6RZRHTuFY2ksDEDnKYqjzhAhO
	t5Wa8ijfAYWRQ6QjR9Fu6S/GeBt13H6073795D5rXvm6FCwPKU1hiFjXvwhDqtc8
	lb1zi0oZMRZBtOm87HIZfTGYKyaROyj++Vuss+cXP/imrS0FmolMRdn6cXvsDECA
	8h7tGGdQUuA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2BC6325D13;
	Sun, 13 Jul 2014 12:57:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7078225D09;
	Sun, 13 Jul 2014 12:56:56 -0400 (EDT)
In-Reply-To: <CAFT+Tg8pJrdoD4M1uy6A=PPJaSrq_QcRUQdxdrA-T5sJiZ7j1Q@mail.gmail.com>
	(EungJun Yi's message of "Sun, 13 Jul 2014 18:51:57 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B29631D2-0AAE-11E4-A7A1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253449>

"Yi, EungJun" <semtlenori@gmail.com> writes:

> I think it is possible like this:
>
>     num_langs += 1; /* for '*' */
>     decimal_places = 1 + (num_langs > 10) + (num_langs > 100);
>     snprintf(q_format, sizeof(q_format), "; q=%%.%df", decimal_places);
>     for (q_precision = 1.0; decimal_places-- > 0;) q_precision /= 10;
>
> Does this one look better than before? I'm not sure which one is better.
>
> ps. The last line can be simpler by using pow() but I'm not sure it is
> okay to include math.h.

If you do not want floating point (and I think we tend to avoid it
when we do not need it), you can realize that in your use of "0.1"
and "0.01" and "0.001" there is nothing fundamentally floating-point;
you can measure how many digits below the two-byte string zero-dot
you would want upfront (by counting num_langs), and show an integer
counter zero-padded to the left to that width.

That would avoid having to even worry about a possible funny case
where subtracting 0.01 ten times from 0.1 may not yield zero (or the
result of subtracting nine times may not reach 0.01) due to rounding
errors accumulating, which was the first thing that came to my mind
when I saw your loop.
