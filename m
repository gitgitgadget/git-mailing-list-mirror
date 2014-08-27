From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/6] commit: provide a function to find a header in a buffer
Date: Wed, 27 Aug 2014 12:26:56 -0700
Message-ID: <xmqqsikhd98f.fsf@gitster.dls.corp.google.com>
References: <20140827075503.GA19521@peff.net>
	<20140827075600.GA26384@peff.net>
	<xmqqioldet75.fsf@gitster.dls.corp.google.com>
	<20140827180016.GA6269@peff.net>
	<xmqqwq9tda8t.fsf@gitster.dls.corp.google.com>
	<20140827191414.GA7561@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 21:27:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMisD-0007So-Hl
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 21:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935844AbaH0T1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 15:27:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52909 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935842AbaH0T1G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 15:27:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF9A0357A6;
	Wed, 27 Aug 2014 15:27:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g7jTgv4k1jsZl2yo+tn8CntSI2U=; b=yJ/FkH
	/sVzVRlq1ZMIc1FqV5W/WRzLAVW6iJsPit/KNZA2sJMytk5JndB8r7EF+uB1+W3o
	WecW64OWUfqiky7Ibrky0SjI26qmJ8dLmah1l4zBfJWM6AjUY8ZoTbimDc4eAM5v
	XYER53wRTg/4Pj6MIDHiC1j75U57oPsPpR5JU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T/kjyZ8/K2HGd4jwHKXWenqgOfNtPmD3
	SOluwv7OZa/I1DA8Mkh09TBiwa4qmFVuGXvJTslCDoy/egbOGWhQYK+VmR7eZAf8
	O4b/RlZ2M0EyrRsNmKe7uwStutfDysmWG81aeWRMe7qXTThwUxhdTFJSrCXfWFNm
	zHlPyI6BJJA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D083F357A5;
	Wed, 27 Aug 2014 15:27:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BE3D33579B;
	Wed, 27 Aug 2014 15:26:57 -0400 (EDT)
In-Reply-To: <20140827191414.GA7561@peff.net> (Jeff King's message of "Wed, 27
	Aug 2014 15:14:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1C60F48C-2E20-11E4-9087-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256026>

Jeff King <peff@peff.net> writes:

> I think they are a direct tradeoff. If you include only the first line,
> then callers who want multiple lines have to keep parsing.  If you
> include multiple lines, then callers who care only about the first line
> will have to re-find the newline rather than just using "out_len"
> directly.

Fair enough.

> I suppose you could argue that people who are only expecting one line
> (e.g., "encoding") should just assume that out_len ends at the first
> line. For correctly-formatted commits, that works the same under either
> scheme. For a broken commit where "encoding" _is_ multi-line, one case
> would ignore the continued bits and the other case would return an
> unexpected encoding value with newlines in it. The choice probably
> doesn't matter much in practice.

True.

> Mostly I just punted on it with a comment since I did not plan to add
> any multi-line callers, and I figured we could sort it out then. If you
> feel strongly, it should be pretty easy to check for continuation and
> extend out_len if necessary.

I agree that we do not want to worry too much about the minority
multi-line callers.

I don't mind returning -1 in out_len and have the callers check.
That way will allow callers to easily diagnose this

	tree $T
        author $GIT_AUTHOR_IDENT
	committer $GIT_COMMITTER_IDENT
	encoding encoding
         unexpected continuation line

	log message

as an error; they would just make sure that out_len is not the "this
is continued; you need to parse the rest yourself" value.

Otherwise, the callers need to check value[out_len+1] to see if it
is an SP (value[out_len] must be '\n') to catch the error, I would
think.
