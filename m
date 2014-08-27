From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/6] commit: provide a function to find a header in a buffer
Date: Wed, 27 Aug 2014 12:05:06 -0700
Message-ID: <xmqqwq9tda8t.fsf@gitster.dls.corp.google.com>
References: <20140827075503.GA19521@peff.net>
	<20140827075600.GA26384@peff.net>
	<xmqqioldet75.fsf@gitster.dls.corp.google.com>
	<20140827180016.GA6269@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 21:05:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMiXE-0006ak-Hg
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 21:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935722AbaH0TF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 15:05:28 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51102 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933865AbaH0TF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 15:05:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E9069352A1;
	Wed, 27 Aug 2014 15:05:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cR3Sgai+axNVu5sX1Slc92mCFgE=; b=aOdIKi
	q7HTk46O3rkgt+0AXWSvhrDB10HNdJQ2dt2yaXGdPDrXZFnWrywdK0AF+ZI39tUc
	HhIA4KtsgenqUWfkq8U2On7Kv0e7PGuTMmutJ83Wa9DasMA4nF8UsTmAr+qPqHvT
	gdESk2apw8kDZV6523qD/EP7DeWTt7olyQ5mI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WJBy5VccWDUosKZw4ZJ195RF2Q7dQHH0
	zg2W9NKwkpiPsslc2ewiOyrnrd5puCOUeDw8IcL5hJ+8eWQ3GlqxGZ0+0V1Pboem
	79jmOEWthmhyq/niGoRMyBcly6B9kH6zu1J0StmEKU4/fjpl/cqQ2D55Ge48m26q
	zWBWyBPW/ZY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D96E43529F;
	Wed, 27 Aug 2014 15:05:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A5D943528D;
	Wed, 27 Aug 2014 15:05:07 -0400 (EDT)
In-Reply-To: <20140827180016.GA6269@peff.net> (Jeff King's message of "Wed, 27
	Aug 2014 14:00:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0F7F77AA-2E1D-11E4-9427-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256021>

Jeff King <peff@peff.net> writes:

> On Wed, Aug 27, 2014 at 10:30:22AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > +const char *find_commit_header(const char *msg, const char *key, size_t *out_len)
>> [...]
>> 
>> Hmph.  Does this have to worry about continuation lines in the
>> header part e.g. mergetag?  If the original in pretty.c was only
>> about the encoding, it may not have mattered, but now because it is
>> made public, it may matter more.
>
> If you mean parsing past continuation lines, then no, we do not need to
> worry. We go line by line and look for the key at the beginning of a
> line, so we would skip past any continuation lines.
>
> If you mean including continuation lines in the output, I don't think
> that's a good idea here. It would mean the function would have to copy
> the value out (to get rid of the continuation whitespace) rather than
> point directly into the msg buffer.

I meant the counting of out_len.  You do not copy the contents for
the caller for a single line case either, so I wouldn't expect it.

You locate where the stuff begins to make it easier for the caller
to read or copy, and the caller may choose to stop reading from the
location up to out_len bytes, or it may choose to ignore out_len and
stop at the first newline.  For the latter kind of caller, it does
not matter if out_len does not point at the end of the "field"
(i.e. for a continued-line case), but for the former, wouldn't it be
more useful if out_len told where the end of the "field" is?
