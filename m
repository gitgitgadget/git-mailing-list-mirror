From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RESEND] [PATCH] Endianness bug in index cache logic
Date: Sun, 27 Dec 2009 10:24:00 -0800
Message-ID: <7veimgxolb.fsf@alter.siamese.dyndns.org>
References: <20091204202928.GW17192@gradx.cs.jhu.edu>
 <20091227061121.GP14941@gradx.cs.jhu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nathaniel W Filardo <nwf@cs.jhu.edu>
X-From: git-owner@vger.kernel.org Sun Dec 27 19:24:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOxn0-0003Jh-Cs
	for gcvg-git-2@lo.gmane.org; Sun, 27 Dec 2009 19:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbZL0SYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2009 13:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbZL0SYM
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 13:24:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53095 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbZL0SYL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2009 13:24:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BE81EAA5C3;
	Sun, 27 Dec 2009 13:24:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6dqJICB8V79LE3FIuZOyZRzWgVE=; b=Z89JqR
	loYb4bn6YUGxgnJyL5Fn6tibVxHvMQ3PIStCtEdslVx04aIytSpnX/Ubly29eZmK
	RKtkV6r1yN2TR0BwJKjWpiwv7CCbF76gZiJLFnvU4C1sQ7Jn1kVqMLcC1+mk0eRQ
	szhCsEepxJCjSzTorN6z1IPzG5r2S39ROgz6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qPPghBXHHy9P2XgmXrlovhE2kFQuki1V
	hdv/wFC9Sl0wI8Q/DMqPLD1oq2zRTfWuCQWEWIEFo1zUGKskyYm6wdz+yfAtHb8I
	LzpWjA2w8coyqUgXCtgIQxQnNUIeKsJTrm4JGfmRyXiZlbTrnZrp7zJUNSjsY1PS
	AE8gIQ6z6Gs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9C9FEAA5C1;
	Sun, 27 Dec 2009 13:24:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id ADA24AA5BB; Sun, 27 Dec 2009
 13:24:02 -0500 (EST)
In-Reply-To: <20091227061121.GP14941@gradx.cs.jhu.edu> (Nathaniel W.
 Filardo's message of "Sun\, 27 Dec 2009 01\:11\:21 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 04148D1C-F315-11DE-93B5-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135709>

Nathaniel W Filardo <nwf@cs.jhu.edu> writes:

> I got some free time and tracked it down.  The following one-line delta
> fixes this issue for me; AIUI on sparc64 "unsigned long" is 8 bits and in
> the wrong endianness for the memcpy trick to work as written?  I could be
> sligntly off in my assessment of the problem, tho'.
>
> index 1bbaf1c..9033dd3 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1322,7 +1322,7 @@ int read_index_from(struct index_state *istate, const char *path)
>                  * extension name (4-byte) and section length
>                  * in 4-byte network byte order.
>                  */
> -               unsigned long extsize;
> +               uint32_t extsize;
>                 memcpy(&extsize, (char *)mmap + src_offset + 4, 4);
>                 extsize = ntohl(extsize);
>                 if (read_index_extension(istate,

Good catch.

The original is broken on big endian 64-bit platforms, and your sparc64
indeed is one.  The code expects to see a signature (4-byte) at src_offset
followed by length (4-byte int in network byte order) and it is trying to
read read the latter in extsize.

Thanks for the fix.  The bug dates back to late April 2006, and I am kind
of surprised that nobody reported this since then (perhaps nobody runs git
on big endian 64-bit boxes?).
