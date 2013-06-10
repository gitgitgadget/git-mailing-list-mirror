From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] log: --author-date-order
Date: Mon, 10 Jun 2013 00:39:24 -0700
Message-ID: <7vobbel8ib.fsf@alter.siamese.dyndns.org>
References: <1370581872-31580-1-git-send-email-gitster@pobox.com>
	<1370820277-30158-1-git-send-email-gitster@pobox.com>
	<1370820277-30158-5-git-send-email-gitster@pobox.com>
	<20130610055014.GF3621@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Elliott Cable <me@ell.io>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 10 09:39:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulwhe-0000eM-F6
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 09:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667Ab3FJHj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 03:39:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33673 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270Ab3FJHj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 03:39:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FABD24C4A;
	Mon, 10 Jun 2013 07:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hKr/SvSpadvXfL9Cv2SP84TmsCI=; b=MpabWq
	ZFTlTZxn1hWVFc3HZJjYLQV73LnYYm1q/cITfS6fqyL9I6kvZDdNeYe3QZwRofrZ
	8bAkIEgNaxq5L9xZkvrTYi5MgH7YJ8tvqRk6361ipX3XMHqlicnz9mhmhXPhp5bo
	wgeY9jMWegoHf7jv31gUBSUB662s0egGaPoMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qkJRIZrp/GEsZfQY+TNEo1FESJgCxddP
	D2mcX/6Oa0+bQmCl9pmgXJn+PmU73UlpWbS4o9QFvrjJF60jncFBk9urybGpM+cL
	3XKM+iZM0fUi1mcVh4dQXKISNO7cNvfBY76/6D08BI9MciOhGUE3pBybhX5zuF29
	3KN/5OU3TBo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8479924C48;
	Mon, 10 Jun 2013 07:39:27 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5D6224C43;
	Mon, 10 Jun 2013 07:39:25 +0000 (UTC)
In-Reply-To: <20130610055014.GF3621@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 10 Jun 2013 01:50:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E01CFD68-D1A0-11E2-876C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227249>

Jeff King <peff@peff.net> writes:

> I'm not excited about introducing yet another place that parses commit
> objects (mostly not for correctness, but because we have had
> inconsistency in how malformed objects are treated). It is at least
> using split_ident_line which covers the hard bits. I wonder how much
> slower it would be to simply call format_commit_message to do the
> parsing.

The thought certainly crossed my mind, not exactly in that form but
more about splitting the machinery used in pretty.c into a more
reusable form.

The result of my attempt however did not become all that reusable
(admittedly I didn't spend too much brain cycles on it), so I punted
;-).

> The record_author_date function assumes that commit->buffer is valid
> (i.e., not NULL).  We seem to assume that the commits are parsed already
> (for looking at parents, and at the committer date).  

I thought that the latter is warranted, as the function worked on
the output of limit_list(), and by the time limit_list() finishes,
everything relevant must have been parsed already.

But you are right.  The commit->buffer may no longer be there, and
the --author-date-order option needs to read the object again
in this codepath.  That would be in line with what --pretty/format
would do, I guess.

Or we could extend parse_commit() API to take an optional commit
info slab to store not just author date but other non-essential
stuff like people's names, and we arrange that extended API to be
triggered when we know --author-date-order is in effect?
