From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] diff-no-index: correctly diagnose error return from diff_opt_parse()
Date: Mon, 31 Mar 2014 11:47:17 -0700
Message-ID: <xmqqy4zq5hoq.fsf@gitster.dls.corp.google.com>
References: <CA+55aFxYBDXs8mGQ3weR2PSOdMgOzMXPT=uWstL4c4BKnykkdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 20:47:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUhF4-00055o-32
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 20:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183AbaCaSr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 14:47:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62552 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752275AbaCaSrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 14:47:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37A6A78E5E;
	Mon, 31 Mar 2014 14:47:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rfaBANAL8latE5T5XFkReMVU1tc=; b=aaAfzC
	6L6D0p0BXJQbDOutxgcC2UZ70LfGbEKX4f/n/8JyF81H8RKQij7V0WZhePlYwUqh
	OiA8j9ATsU+/8l8JxdX3XANYlDvV7Qae8uLAWIHuMb9881syf4U5HptTQwtw5nY0
	GMQDxGvbTLLnUE5se4Xb/GtiJ3t/OgeDu+bFs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hEQ3nSQ8LhdrcMfMFtjOBcXviEPaXGxN
	wjElzO28TG6+fVpIPE7JpS84AVUZ4yshNkSD+ZY7UEObC5ZCPb3wlPv5YxMOwJZE
	jJxjmn0gd8A/n8B5QcEwQO0jPVO12Q61rzlT7FS7vc/12q4t1Qkxpcu1+kjKF52Z
	MOvGqMlJjAE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F93B78E5D;
	Mon, 31 Mar 2014 14:47:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D90078E5B;
	Mon, 31 Mar 2014 14:47:24 -0400 (EDT)
In-Reply-To: <CA+55aFxYBDXs8mGQ3weR2PSOdMgOzMXPT=uWstL4c4BKnykkdA@mail.gmail.com>
	(Linus Torvalds's message of "Mon, 31 Mar 2014 11:05:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E62C755C-B904-11E3-8EF3-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245508>

diff_opt_parse() returns the number of options parsed, or often
returns error() which is defined to return -1.  Yes, return value of
0 is "I did not process that option at all", which should cause the
caller to say that, but negative return should not be forgotten.

This bug the caused it to infinitely show the same error message
because the returned value was used to decrement the loop control
variable, e.g.

        $ git diff --no-index --color=words a b
        error: option `color' expects "always", "auto", or "never"
        error: option `color' expects "always", "auto", or "never"
        ...

Instead, make it act like so:

        $ git diff --no-index --color=words a b
        error: option `color' expects "always", "auto", or "never"
        fatal: invalid diff option/value: --color=words

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The other callchain to this function comes from rev-list.c, and
   the caller does handle it correctly.

 diff-no-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 00a8eef..ecf9293 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -244,7 +244,7 @@ void diff_no_index(struct rev_info *revs,
 			i++;
 		else {
 			j = diff_opt_parse(&revs->diffopt, argv + i, argc - i);
-			if (!j)
+			if (j <= 0)
 				die("invalid diff option/value: %s", argv[i]);
 			i += j;
 		}
-- 
1.9.1-513-gce53123
