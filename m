From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] git-p4: fix Git LFS pointer parsing
Date: Wed, 20 Apr 2016 11:30:24 -0700
Message-ID: <xmqq8u08w2tb.fsf@gitster.mtv.corp.google.com>
References: <1461139809-6573-1-git-send-email-larsxschneider@gmail.com>
	<1461139809-6573-3-git-send-email-larsxschneider@gmail.com>
	<CAHGBnuOjb+zmzwJeY-hbU4MYKpOMCQSRtDC4hS4zvCD5DQzv3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: larsxschneider@gmail.com, Git Mailing List <git@vger.kernel.org>,
	luke@diamand.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 20:30:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aswtU-0007a5-TW
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 20:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbcDTSa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 14:30:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64436 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750808AbcDTSa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 14:30:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A26A14B48;
	Wed, 20 Apr 2016 14:30:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H7FiX14PwmG/i8zaveoaeVlt0GI=; b=WM1le8
	5iUIDaYkE6ufojk6p4PSV7nipn7mYXy68z6WHXkhqpP5sUp/n6RHiFNh6EOEAj9L
	l6lD8Y81FLqNC5TRIZDghN17U1yMG+Cqgiw4dBEbgcDRIyVCfi9aeussPUYzlEuS
	l/8y23HXyJnwHLr30SzduaomdKjruGlkGO/Ns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XuJlTAguZVWBzetnz8N+mgE46G8GFw5P
	9rAHqnPcze9FwqJ1Y3JrYbz5Q31O1Wu/AerVpwVKgDoUCweJndawEwVbMEs7ElTH
	yeUAtqL2PubXtO5y67JqBFgDPw2UEbs7dSCwql2ZQEuEZFRel8nScHFMGbOu6nmN
	lm78p4e3KIA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 81A8914B47;
	Wed, 20 Apr 2016 14:30:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E128114B46;
	Wed, 20 Apr 2016 14:30:25 -0400 (EDT)
In-Reply-To: <CAHGBnuOjb+zmzwJeY-hbU4MYKpOMCQSRtDC4hS4zvCD5DQzv3w@mail.gmail.com>
	(Sebastian Schuberth's message of "Wed, 20 Apr 2016 10:59:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F35A6D08-0725-11E6-8F8C-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292053>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Why do we need to remove the preamble at all, if present? If all we
> want is the oid, we should simply only look at the line that starts
> with that keyword, which would skip any preamble. Which is what you
> already do here. However, I'd probably use .splitlines() instead of
> .split('\n') and .startswith('oid ') (note the trailing space) instead
> of .startswith('oid') to ensure "oid" is a separate word.
>
> But then again, I wonder why there's so much split() logic involved in
> extracting the oid. Couldn't we replace all of that with a regexp like
>
> oid = re.search(r"^oid \w+:(\w+)", pointerFile, re.MULTILINE).group(1)

Yup, all of that is a very useful suggestion.  If we know how the
piece of information we want is identified in the output,
specifically looking for it would future-proof the code better, as
it will not be affected by future change that adds unexpected cruft
to the output we are reading from.
