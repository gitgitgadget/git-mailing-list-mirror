From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs.c: add a function to append a reflog entry to a fd
Date: Wed, 19 Nov 2014 17:22:42 -0800
Message-ID: <xmqqzjbm4qe5.fsf@gitster.dls.corp.google.com>
References: <1416444142-28042-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sahlberg@google.com, jrnieder@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 02:22:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrGSQ-0007lh-0Z
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 02:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756246AbaKTBWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 20:22:45 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754910AbaKTBWp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 20:22:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F055209EC;
	Wed, 19 Nov 2014 20:22:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LUanlM6rvfhURVC2ARTpU4x7KjQ=; b=EY6P2R
	xH0svib2AHF8wVanbpnAo7OxBtXDLAAB3pQuyvYO4U+NcOvc4taRKru/uW+W+vIU
	ebWl7RmNXJ8Yh3unirNWQ4c8d5kf/27xvO4KvdmZzVPPoja54VJTcLQR0t4GIgRG
	gUprfWc1+uYa9Leh6/w6CSkIMS1Z8HT7ryVJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jXoLaca3jM0nNLeFaiy65Kw5ytCJHzm0
	PfsvJLTS1fCxspWGwnlF44WyW6Hn02oDs9GNOaWDrqdIp41v8nGl7wql+Zq1gYal
	dLyKO9navv9TfdH+Y7rTssa4Z6ke4rcQJIVE5w7iT0Y7qMXwOkp+/KcFHpDGu3q/
	teFRaOQWAHU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3699A209EB;
	Wed, 19 Nov 2014 20:22:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B3906209EA;
	Wed, 19 Nov 2014 20:22:43 -0500 (EST)
In-Reply-To: <1416444142-28042-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 19 Nov 2014 16:42:22 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BA4C901E-7053-11E4-9466-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Compared to the last send of this patch[1], there was one change in the print
> function. Replaced sprintf by snprintf for security reasons. 

Careful.  I despise people who blindly think strlcpy() and
snprintf() are good solutions for for security.  They are by
themselves not.

Surely, the use of them lets you avoid stomping on pieces of memory
that you did not intend to write to.  I'd call that "protecting
other people's data".

But what about your own data?  If you are thinking that you are
trying to write "this and that", but by mistake (either by your or
by a careless future change) if you did not allocate enough, you
would stop at "this and th".  You may have protected other people's
data, but your result is still broken.  If you gave that to others
without checking that you produced an incomplete piece of data, what
guarantee are you getting that you are not creating a security hole
there (imagine you intended to copy "rm -fr ./tmpdir" and by mistake
you stopped at "rm -fr ./" @~@).

> +	msglen = msg ? strlen(msg) : 0;
> +	maxlen = strlen(committer) + msglen + 100;
> +	logrec = xmalloc(maxlen);
> +	len = snprintf(logrec, maxlen, "%s %s %s\n",
> +		       sha1_to_hex(old_sha1),
> +		       sha1_to_hex(new_sha1),
> +		       committer);
> +	if (msglen)
> +		len += copy_msg(logrec + len - 1, msg) - 1;

In this codepath, you are allocating enough buffer to hold the whole
message; there is no difference between sprintf() and snprintf().
If the difference mattered, you would have chopped the reflog entry
too short, and produced a wrong result, but you then discard the
whole record (the code that follows the above), losing data.

So use of snprintf() is not really buying you much here, not in the
current code certainly, but not as a future-proofing measure,
either.
