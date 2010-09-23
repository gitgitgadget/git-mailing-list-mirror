From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mingw: do not crash on open(NULL, ...)
Date: Thu, 23 Sep 2010 15:50:37 -0700
Message-ID: <7vy6asoz0i.fsf@alter.siamese.dyndns.org>
References: <1285263325-2016-1-git-send-email-kusmabite@gmail.com>
 <AANLkTinJ4kKRsKO6HyqQH4Oy12E1mdqCXxPb2z+59818@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Sep 24 00:50:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oyucx-0007ee-6F
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 00:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406Ab0IWWuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 18:50:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33686 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357Ab0IWWuu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 18:50:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 487D0D8F5B;
	Thu, 23 Sep 2010 18:50:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YyrPxX5ZHwJOTMndZGICePinYKA=; b=sIowvc
	niKYyw7huGxIGpG0Sy/FAXA0s0Yk0eyhHxcaAZYfzSqzw7gWDi6kR0dm3lHwLFc/
	ppjxzrlvzwHw+YzSmGgjJf04joHqJSI+cVc/lFeIDKBK3HJz2zPKs0ABevTJQPIZ
	tEitYZg67o/goBB4xcCjnFdKzQHO6cDDY3YV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pjSoS+bQFDk1HVeTt7ZMEAGd6yKHSyy2
	rVKss8pACab4cid4gJ/aZ1e9fHebOZ/h6BzeISjsg0UQOeiHU4Bd8khfxyY2TBGz
	mpZ+3+NMemfs5RdMhT64MpnnZ41d6hpGQJSqNxdp3ePPsCSmIQxtUBKwdGhXlZrC
	EvOeijLHXE4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D13A8D8F5A;
	Thu, 23 Sep 2010 18:50:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA4C9D8F59; Thu, 23 Sep
 2010 18:50:39 -0400 (EDT)
In-Reply-To: <AANLkTinJ4kKRsKO6HyqQH4Oy12E1mdqCXxPb2z+59818@mail.gmail.com>
 (Erik Faye-Lund's message of "Thu\, 23 Sep 2010 10\:59\:46 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FFE3B72A-C764-11DF-B7CD-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156923>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Thu, Sep 23, 2010 at 10:35 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> Since open() already sets errno correctly for the NULL-case, let's just
>> avoid the problematic strcmp.
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>
> I guess I should add a comment as to why this patch is needed:
>
> This seems to be the culprit for issue 523 in the msysGit issue
> tracker: http://code.google.com/p/msysgit/issues/detail?id=523
>
> fetch_and_setup_pack_index() apparently pass a NULL-pointer to
> parse_pack_index(), which in turn pass it to check_packed_git_idx(),
> which again pass it to open(). This all looks intentional to my
> (http.c-untrained) eye.

Surely, open(NULL) should be rejected by a sane system, and your patch
looks sane to me.

But depending on and exploiting the fact sounds like a horrible hack in
the caller of parse_pack_index(..., NULL) to me.

Shawn may have intentionally done that in 750ef42 (http-fetch: Use
temporary files for pack-*.idx until verified, 2010-04-19), but at least
7b64469 (Allow parse_pack_index on temporary files, 2010-04-19) should
have documented that idx_path is allowed to be NULL under what
circumstance (and for what purpose it is useful to do so) when it
introduced the second parameter to the API.

What were we smoking?
