From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs.c: add a function to append a reflog entry to a fd
Date: Wed, 19 Nov 2014 17:34:44 -0800
Message-ID: <xmqqvbma4pu3.fsf@gitster.dls.corp.google.com>
References: <1416444142-28042-1-git-send-email-sbeller@google.com>
	<xmqqzjbm4qe5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sahlberg@google.com, jrnieder@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 02:38:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrGhC-0004LH-Ny
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 02:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929AbaKTBes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 20:34:48 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58485 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754550AbaKTBer (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 20:34:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 73F6720BDC;
	Wed, 19 Nov 2014 20:34:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XtBMPlRcelHzbTkG5vMCXuI0pNo=; b=b6erUP
	DmT4vEkGSggt3ztcg7LZwMN7IZxnYRYRphfLqnSnxAYxF6vVUC16jatjR05SKCLr
	2R3lybyQK8FpXW3oXmWiBox3JSMilIYb/dG75QZmMruiOc7UqbqnbpwcsS5Dey9I
	B8+yUezRKqCkH9aF+v/cRPOjjxp9tQWAdNPWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k49zbl8wzhBE+05E//WxO8OPPanQlvNo
	oEEjQmHnxnnI/tNKmVeU4m6ytOZ+QBOqukMUa+JfcPD/aGpw+IPjTE4FJf2iDpsA
	kjS9e3VNnrygrMbhyHMcIXyXkUgsKJ//XKxsWcsgqc2yfYa+Q4YPQK0W66J0WfUT
	2O9SzSxQjk4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6ADE620BDB;
	Wed, 19 Nov 2014 20:34:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA01120BDA;
	Wed, 19 Nov 2014 20:34:45 -0500 (EST)
In-Reply-To: <xmqqzjbm4qe5.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 19 Nov 2014 17:22:42 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 68BC8766-7055-11E4-8DEB-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> Compared to the last send of this patch[1], there was one change in the print
>> function. Replaced sprintf by snprintf for security reasons. 
>
> Careful.  I despise people who blindly think strlcpy() and
> snprintf() are good solutions for for security.  They are by
> themselves not.
> ...
> So use of snprintf() is not really buying you much here, not in the
> current code certainly, but not as a future-proofing measure,
> either.

Don't get me wrong.  I am not saying that using snprintf() here is
bad per-se.  There should be no difference.

But I do not want to see people getting in the habit of thinking "I
now use snprintf/strlcpy instead of sprintf/strcpy, and made my code
more secure."  Often they are not doing that.

The only case snprintf/strlcpy is useful is when your data does not
matter in its detail.  E.g. when you are preparing human-readble
data whose first part is sufficient to convey the information you
want to convey, you would be perfectly happy if the result is
truncated. In such a case, counting to allocate enough to hold
everything and running sprintf() only to chop the result later is
not necessary --- it still is not wrong, though --- and allocating
enough to satisify the eventual chop length and using snprintf()
is easier way to achieve the same result.

But I do not think this codepath falls into such an "I am willing to
lose data" case.
