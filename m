From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use child_process_init() to initialize struct child_process variables
Date: Mon, 03 Nov 2014 15:42:31 -0800
Message-ID: <xmqq389zrguw.fsf@gitster.dls.corp.google.com>
References: <54500212.7040603@web.de> <20141029172109.GA32234@peff.net>
	<xmqqlhnyy9e2.fsf@gitster.dls.corp.google.com>
	<20141030213523.GA21017@peff.net>
	<FEC7DC4C920D4F97B5F165B10BC564D2@PhilipOakley>
	<xmqqvbmzsyfy.fsf@gitster.dls.corp.google.com>
	<20141101033327.GA8307@peff.net>
	<F44397C122BB4E63B89EC9BE26007B2E@PhilipOakley>
	<xmqqmw88rvh3.fsf@gitster.dls.corp.google.com>
	<20141103220408.GA12462@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 04 00:42:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlRGh-0000LG-Cg
	for gcvg-git-2@plane.gmane.org; Tue, 04 Nov 2014 00:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbaKCXmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 18:42:35 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750925AbaKCXmf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 18:42:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F0C891BF63;
	Mon,  3 Nov 2014 18:42:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xy67rAYVVHYa/SD+4Y/+GOMcObc=; b=lGGTjG
	AsKlKfDDKuLpvzYUrwyPQRKJezLyVoqt0xlDxPw3LCrKw/HdY4E/8J41G9ugimvZ
	e+viFGq+Mb0aPj5ThUqNauptfGL3ErT5cyUhc8H5DPGkjnbrCcA7tBywLYtXdI68
	8WhlyYMvQ3c12kv6L7C8Jbj9JM0wwgqJWkJjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wieDVGsVXZ4prCZ/fp2Xh74DIPrwn9gS
	pXl6SCyziTgwKSEbbMRsWPJ8NAlFd4OV2m1JCm3t3j3BLNl0JnCh1E1bkDDa0XOj
	7k/E3q4u/EpRf+IG9dd7PJWh1vq1La/Zdep2ScItMaZ5fnxUPgDheSpyjI9y5k/b
	OHWnLTd3xHk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E68EC1BF62;
	Mon,  3 Nov 2014 18:42:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4DE371BF61;
	Mon,  3 Nov 2014 18:42:33 -0500 (EST)
In-Reply-To: <20141103220408.GA12462@peff.net> (Jeff King's message of "Mon, 3
	Nov 2014 17:04:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 152975B8-63B3-11E4-91F4-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I peeked at libgit2 and I think it does not support bundles at all yet,
> so that is safe. Grepping for "bundle" in dulwich turns up no hits,
> either.
>
> Looks like JGit does support them. I did a very brief test, and it seems
> to silently ignore a HEAD ref that has the NUL (I guess maybe it just
> rejects it as a malformed refname).
>
> We could make JGit happier either by:
>
>   1. Only including the symref magic in ambiguous cases, so that regular
>      ones Just Work as usual.
>
>   2. Including two lines, like:
>
>         $sha1 HEAD\0symref=refs/heads/master
> 	$sha1 HEAD
>
>      which JGit does the right thing with (and git.git seems to, as
>      well).

Sounds sensible, even though it looks ugly X-<.
