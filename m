From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: add color
Date: Tue, 08 Oct 2013 08:16:38 -0700
Message-ID: <xmqqob6zn67d.fsf@gitster.dls.corp.google.com>
References: <1381241929-23378-1-git-send-email-christopherarges@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris J Arges <christopherarges@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 08 17:16:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTZ1j-00051P-Jo
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 17:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230Ab3JHPQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 11:16:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37738 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752452Ab3JHPQn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Oct 2013 11:16:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41493481C0;
	Tue,  8 Oct 2013 15:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GuUCoAZN7eXXkfaBaDs7wXqDhCk=; b=Wl0SIY
	QioxDb5+p1H7/TpUDP00EfcB/BppnXRXHe6ygd8NLMgL1raJ4brC4JGPQctV45aZ
	PVznQQIDjwxDCxishc6ZGIdrJZmSZz1S3gk6e6Rlpg/jpEv7JX+uC92OjjWDHEy2
	oAvrJuE3FaJYUlSiu+njX2w3rHUstFdIh4Ryo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lvCHXIwbgPlyWcxkEqBxW1HTjA7ElO5b
	zaVZNP/egf2iF7mgK5OFmfvOsUp/lMWbkS16GHRy2sXTGdcnqpciRWVvfMPH99mV
	2jNjWcmAIbK39x7RdK7w+fhZ2JXu6vWu3rysakst+0TcSMCNkrW+Jd+aFZUBF8wq
	+GHFuRXsKdA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E9C1481BF;
	Tue,  8 Oct 2013 15:16:42 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 850F3481B4;
	Tue,  8 Oct 2013 15:16:40 +0000 (UTC)
In-Reply-To: <1381241929-23378-1-git-send-email-christopherarges@gmail.com>
	(Chris J. Arges's message of "Tue, 8 Oct 2013 09:18:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A1FB1552-302C-11E3-A5D7-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235780>

Chris J Arges <christopherarges@gmail.com> writes:

> Add colorized text for git blame when color.interactive is enabled.

It does not make any sense to tie this to color.interactive at all,
at least to me.  The "check color.blame and if absent fall back to
color.ui", which is the usual pattern, would be more appropriate.

> +static char blame_colors[][COLOR_MAXLEN] = {
> +	GIT_COLOR_RESET,
> +	GIT_COLOR_NORMAL,	/* PLAIN */
> +	GIT_COLOR_YELLOW,	/* COMMIT */
> +	GIT_COLOR_BOLD,		/* NAME */
> +	GIT_COLOR_CYAN,		/* LINE */
> +	GIT_COLOR_GREEN,	/* TIME */
> +};

Unlike "git grep", where some pieces of a single line are more
interesting (i.e. the exact text matching the pattern given) than
others (i.e. other text on the same line), and "git diff", where
some lines have different meanings from others (i.e. hunk header,
deleted lines, added lines, context lines), the output from "git
blame" is already columnar and it is obvious to the reader of the
output that everything on the leftmost part of all lines is commit
object name, without distraction of extra colours; I do not see much
point in painting the output into vertical stripes of colours.

It may make more sense to assign one colour to each blame origin
(i.e. <commit, path> pair), to make it clear that first five lines
came from the same origin that is different from the two lines that
follow, etc., showing horizontal stripes of colours. If we were to
go that route, I suspect that it would be too distracting to paint
the whole line (like "git diff" does for added or deleted
lines). Perhaps paint only the commit object name part in different
colors to show which lines form a group that came from the same
origin?  The way "git show-branch" paints its output might give an
inspiration.
