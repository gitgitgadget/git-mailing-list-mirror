From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] checkout --to: no auto-detach if the ref is already checked out
Date: Thu, 24 Jul 2014 09:39:51 -0700
Message-ID: <xmqqr41aaey0.fsf@gitster.dls.corp.google.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
	<1406115795-24082-4-git-send-email-pclouds@gmail.com>
	<xmqqzjfzdbds.fsf@gitster.dls.corp.google.com>
	<CACsJy8CTYyjqmwGgkKZQFX4YC9-X=TGx9Ex5QfNWRNKFjgpKag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 18:40:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAM3x-0007Hr-8w
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 18:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759447AbaGXQkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 12:40:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52362 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185AbaGXQkF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 12:40:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3019F2A366;
	Thu, 24 Jul 2014 12:40:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yxaVX8T8u/FVCbHCLUzW9TSGKWM=; b=c4c42S
	hjYv9lIoZvg5x/yfAGkxKNsAr/IoDrDnwvXdQDo9ZuRafVT7IWgpBIUPTr1go/ki
	4LcU7b3iXwWqfNj5Pk+KJQ6iZYMu/XpHEULjK1fub0bxJicJbX6x6kQSsSH+x7xo
	fxzOh+C+lYmwDJajCVR1aQ6gp2qfxRlvYW/RE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Oop6NInGOto7dtyUJkGvNGQxcy0WUIR9
	YxjYUYAgo7paHHWADRZHo7kWUDkse/D7Yg1o0bXU4IYrGvMkIFOZWHKPsdwXblwG
	gMssWNNYkdc9bURJdROKT54Hdj2DlhKmj/kIZxo27e5QwkZOo+Kx/aOBVqFtV37s
	vSBB29LbvaQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 12C2E2A365;
	Thu, 24 Jul 2014 12:40:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 51B1B2A346;
	Thu, 24 Jul 2014 12:39:53 -0400 (EDT)
In-Reply-To: <CACsJy8CTYyjqmwGgkKZQFX4YC9-X=TGx9Ex5QfNWRNKFjgpKag@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 24 Jul 2014 17:09:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 234CD62E-1351-11E4-99B1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254167>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Jul 24, 2014 at 4:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> +     if (strbuf_read_file(&sb, path.buf, 0) <= 0 ||
>>> +         !skip_prefix(sb.buf, "ref:", &start))
>>> +             goto done;
>>>       while (isspace(*start))
>>>               start++;
>>>       end = start;
>>>       while (*end && !isspace(*end))
>>>               end++;
>>
>> Not new in this round of update, and may not even be an issue, but:
>>
>>  - Earlier, the code returned early on a negative return value from
>>    read-file (i.e., an error), but this round it also does so for
>>    zero.  Intended?
>
> Yes. But it does not make any difference. strbuf_read_file returns
> sb.len, if it's empty, the next skip_prefix would fail anyway.

Yes but changing < 0 to <= 0 is inconsistent with that; I would
understand if you changed it to <= 4, which would be consistent with
the reasoning, though.

>> The code in the patch, which is something in between, does not make
>> much sense to me.
>
> I think more about "echo abc > $this_file" where the echo command may
> output '\r\n' on Windows (wild guess though, I don't use Windows
> much). I think I'm going with _rtrim.

To expect 'echo' into the file is to expect and encourage that
people muck with the internal implementation details by hand, which
we do not generally do for things inside .git [*1*].

If we consider the contents of $this_file not an implementation
detail but a part of the published API (i.e. "writing this string
into the file is a valid way to make Git do this"), rtrim would at
least be consistent with how the existing code deals with symrefs,
so I wouldn't say "does not make much sense" if you are going in
that direction ;-)


[Footnote]

*1* ... except for .git/config, to which we say "It's a simple text
file; don't be afraied to edit it away!".
