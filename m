From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] streaming: simplify attaching a filter
Date: Tue, 18 Feb 2014 16:02:20 -0800
Message-ID: <xmqq8ut8as1f.fsf@gitster.dls.corp.google.com>
References: <cover.1392565571.git.john@keeping.me.uk>
	<0120f99a7cccc118782cda63f478d7d3f528ee3f.1392565571.git.john@keeping.me.uk>
	<xmqqd2ikasbe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Feb 19 01:02:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFucP-0000B9-9W
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 01:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbaBSACY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 19:02:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64033 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbaBSACX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 19:02:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19C3D6E647;
	Tue, 18 Feb 2014 19:02:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uW9flLmqcIIHzQpW33ElqD8QzKA=; b=HHcYoa
	G38u7hwEY70IT/LA67gHe1VkkxnQcdSLcBPbm++3U6OzqZLwfsHhl8Y4ocLgaR6k
	WymortwUWOgCmgVcFfoQZQ9VeA7OzWqV0kFHzOdSnIwYhmjOY+xQ1p/4zMQvpljN
	gS7MgxMY7o+I9p+QfzNAqgF8uHVrASrt+rE7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TRD1hn5Lz6Ht73RIJhL0CnFZJm+rZkRJ
	7aszvotWZNrxqWOJy+jzFaOu7zHY3ad7NTK1ge0SLBTbYqMeZvCKciElFf6uImzq
	DYlDAQAMXbnc+cGI8ZzV+gbTGTJwspPdhqNRU7N6TqyhdkDuCgN4UUJah6iLbA/9
	zAudGN3EYf0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E77F46E646;
	Tue, 18 Feb 2014 19:02:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FD486E644;
	Tue, 18 Feb 2014 19:02:21 -0500 (EST)
In-Reply-To: <xmqqd2ikasbe.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 18 Feb 2014 15:56:21 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1B21DC74-98F9-11E3-AF0B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242376>

Junio C Hamano <gitster@pobox.com> writes:

> John Keeping <john@keeping.me.uk> writes:
>
>> We are guaranteed that 'nst' is non-null because it is allocated with
>> xmalloc(), and in fact we rely on this three lines later by
>> unconditionally dereferencing it.
>
> The intent of the original code is for attach_stream_filter() to
> detect an error condition and return NULL, in which case it closes
> the istream it allocated and signal error to the caller, I think,
> and falling thru to use st->anything and return st when that happens
> is *not* a guarantee that a-s-f will not detect an error ever, but
> rather is a bug in the error codepath.

In other words, something like this instead.

-- >8 --
Subject: [PATCH] open_istream(): do not dereference NULL in the error case

When stream-filter cannot be attached, it is expected to return NULL,
and we should close the stream we opened and signal an error by
returning NULL ourselves from this function.

However, we attempted to dereference that NULL pointer between the
point we detected the error and returned from the function.

Brought-to-attention-by: John Keeping <john@keeping.me.uk>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 streaming.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/streaming.c b/streaming.c
index d7c9f32..2ff036a 100644
--- a/streaming.c
+++ b/streaming.c
@@ -152,8 +152,10 @@ struct git_istream *open_istream(const unsigned char *sha1,
 	if (filter) {
 		/* Add "&& !is_null_stream_filter(filter)" for performance */
 		struct git_istream *nst = attach_stream_filter(st, filter);
-		if (!nst)
+		if (!nst) {
 			close_istream(st);
+			return NULL;
+		}
 		st = nst;
 	}
 
-- 
1.9.0-279-gdc9e3eb
