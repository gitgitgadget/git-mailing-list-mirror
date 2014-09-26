From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 27/39] try_merge_strategy(): use a statically-allocated lock_file object
Date: Fri, 26 Sep 2014 12:00:06 -0700
Message-ID: <xmqqh9zu8ax5.fsf@gitster.dls.corp.google.com>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
	<1411726119-31598-28-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 26 21:00:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXakk-0007WW-3c
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 21:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850AbaIZTAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 15:00:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52614 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753770AbaIZTAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2014 15:00:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 294A33B0AA;
	Fri, 26 Sep 2014 15:00:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wSWq2BS1fcrLP75lcJ1GAjEgZmM=; b=oOwZNB
	IegdksZt2jl0ugaFiUpjiK/qlLIv47C78S0r0JU7B2C9ll6XehxTut4u8MRxBSE0
	QYxoMf8mM9GYemyzQFUqataTxPqiZQqYPjl6yeo+rQt0EN5ZfL5v5oGvBEbConoX
	rkxbsMgBWpbsxgDx/RFZo04GsjfkH3ZYJY0EM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CFuGl09gQQnbNg6l5zGOC7rloNsFsx61
	nApPlGnSOQqCA7uHyn3PkumXJ2uqRRAkohkVW9G4DBwV/9bajD+ujy9LpqPs+dhN
	uUXrjydajk8fdPwDu+IcKSR7rywH/tEOt3l3PreSDM5r/dLmTsbqv/rTufoT/gKx
	du14NAxzM6Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1E7673B0A5;
	Fri, 26 Sep 2014 15:00:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 98FE13B095;
	Fri, 26 Sep 2014 15:00:08 -0400 (EDT)
In-Reply-To: <1411726119-31598-28-git-send-email-mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Fri, 26 Sep 2014 12:08:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 55B66702-45AF-11E4-BF2B-D931C4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257549>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Even the one lockfile object needn't be allocated each time the
> function is called.  Instead, define one statically-allocated
> lock_file object and reuse it for every call.
>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> ...
> -	hold_locked_index(lock, 1);
> +	hold_locked_index(&lock, 1);
>  	refresh_cache(REFRESH_QUIET);
>  	if (active_cache_changed &&
> -	    write_locked_index(&the_index, lock, COMMIT_LOCK))
> +	    write_locked_index(&the_index, &lock, COMMIT_LOCK))

I wondered if the next step would be to lose the "lock" parameter
from {hold,write}_locked_index() and have them work on a
process-global lock, but that would not work well.

The reason why this patch works is because we are only working with
a single destination (i.e. $GIT_INDEX_FILE typically .git/index),
right?

Interesting.
