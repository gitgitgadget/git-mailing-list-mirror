From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] checkout --to: no auto-detach if the ref is already checked out
Date: Thu, 24 Jul 2014 11:13:14 -0700
Message-ID: <xmqq61imaamd.fsf@gitster.dls.corp.google.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
	<1406115795-24082-4-git-send-email-pclouds@gmail.com>
	<xmqqzjfzdbds.fsf@gitster.dls.corp.google.com>
	<CACsJy8CTYyjqmwGgkKZQFX4YC9-X=TGx9Ex5QfNWRNKFjgpKag@mail.gmail.com>
	<xmqqr41aaey0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 20:13:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XANWC-00027x-CT
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 20:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759723AbaGXSNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 14:13:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62530 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759718AbaGXSNX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 14:13:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5F9072A1F1;
	Thu, 24 Jul 2014 14:13:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MeaRy2gJrvLbifgcCAFpZROklzQ=; b=WD23SJ
	Rmy64omydixjSt8M90DuUvT+agWapM86b0r1BQGImuciX38X3+/0p0rDWA6oqav+
	ZGYESNpRHCBUYYoat+Bhxm43YcKn7AZAEvuChaUJ/ZWc1BBfkVdiOCf+UMCyUzW2
	va2lGbPt43EL7X0+oOuA2/raic2mMgjUxKATs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AOOGvqFwvC+9IHob872i7wXVuwy6Ep/P
	2wcF9zdFhi4gUCrNpX0xsanfatKUXQ2M0HyxFc1iQgg7wOQ84A5AETLAe3mkLu5i
	0mdfWw6ZK/dYEkXD+gUm71kUQjZ/ZfwxrSwzaSV6aYZdfhQxq1cM/sH3gE+PsViM
	mm8ceY3phhU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 552882A1F0;
	Thu, 24 Jul 2014 14:13:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DE0C12A1E5;
	Thu, 24 Jul 2014 14:13:16 -0400 (EDT)
In-Reply-To: <xmqqr41aaey0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 24 Jul 2014 09:39:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2F59868A-135E-11E4-A308-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254172>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Thu, Jul 24, 2014 at 4:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> +     if (strbuf_read_file(&sb, path.buf, 0) <= 0 ||
>>>> +         !skip_prefix(sb.buf, "ref:", &start))
>>>> +             goto done;
>>>>       while (isspace(*start))
>>>>               start++;
>>>>       end = start;
>>>>       while (*end && !isspace(*end))
>>>>               end++;
>>>
>>> Not new in this round of update, and may not even be an issue, but:
>>>
>>>  - Earlier, the code returned early on a negative return value from
>>>    read-file (i.e., an error), but this round it also does so for
>>>    zero.  Intended?
>>
>> Yes. But it does not make any difference. strbuf_read_file returns
>> sb.len, if it's empty, the next skip_prefix would fail anyway.
>
> Yes but changing < 0 to <= 0 is inconsistent with that; I would
> understand if you changed it to <= 4, which would be consistent with
> the reasoning, though.

Just to make sure.  I am not saying changing < 0  to <= 4 is a good
idea.  I think checking for strbuf_read_file() failure with < 0 and
then checking for malformatted input (or detached head perhaps?)
with !skip_prefix(), i.e. testing two logically separate things with
two separate conditions concatenated together with ||, would be the
most natural way to express it.
