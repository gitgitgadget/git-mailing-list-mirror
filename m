From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] builtin/interpret-trailers: suppress blank line
Date: Thu, 07 Apr 2016 10:21:31 -0700
Message-ID: <xmqqegah1gis.fsf@gitster.mtv.corp.google.com>
References: <1460042563-32741-1-git-send-email-mst@redhat.com>
	<1460042563-32741-3-git-send-email-mst@redhat.com>
	<xmqqmvp51hhm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 19:21:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoDcg-00006e-Uo
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 19:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757017AbcDGRVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 13:21:35 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64614 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756773AbcDGRVe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 13:21:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2402F52927;
	Thu,  7 Apr 2016 13:21:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y5b2KOyRNwTvpp7yP2n0TYE4/Ow=; b=vYDAmf
	IBk29++F+PNGWPz9vRA3cmM+ffGQQN/xpjUVN+FVKUcFUfhr5KQIURRFE1ME5v76
	9qLXTrToWk21hQgI0FdmUDfeTU7kNW2wWNz3JmMvgQ8XZhA0tJ5XpQiBLqlR1y2l
	1fScLim43zeht5ENDVwZx+5QW8ZHVX4JaBmxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dkWYwqNflu3WbYO2fkrcTthrn/eCks5G
	ueDOZxeIiWR/KvFNcposHZy/yXYYxKp9LPBMxOJRsRIgJV22Fq901E8SMIV9jOid
	6TbkS+7njlR5oKr9YOVRRdQbvcEq1DtPADemEpU94TKjF7/VEkOekV3p1gcRlF4b
	BB6rtGAGxBM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B5FE52926;
	Thu,  7 Apr 2016 13:21:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7579952923;
	Thu,  7 Apr 2016 13:21:32 -0400 (EDT)
In-Reply-To: <xmqqmvp51hhm.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 07 Apr 2016 10:00:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2C433744-FCE5-11E5-90FC-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290931>

Junio C Hamano <gitster@pobox.com> writes:

> "Michael S. Tsirkin" <mst@redhat.com> writes:
>
>> it's sometimes useful to be able to pass output message of
>> git-mailinfo through git-interpret-trailers,
>> but that creates problems since that does not
>> include the subject and an empty line after that,
>> making interpret-trailers add an empty line.
>>
>> Add a flag to bypass adding the blank line.
>
> I think I understand what you are trying to do, but using output
> that comes from 'mailinfo' alone as the input to anything (including
> interpret-trailers) does not make much sense.
>
> If you use the mailinfo output in the way it is expected to be used,
> i.e. take the subject from the "info" that goes to its standard
> output and append the "msg" with a blank between them, and feed the
> result to interpret-trailers, do you still need this step in your
> series?

OK, after reading 3/4 and guessing that you hand "msg" to
interpret-trailers to let it munge its contents, it makes sense to
allow us to tell interpret-trailers that you are feeding only the
body of the message without the title and the blank line before it.

"suppress blank line" is a terrible title for that new feature,
though.  Perhaps "--body-only"?

The difference in behaviour in two modes (i.e. with title and
without title) is that when the input does not have any blank line
in it, the normal mode considers that there is no body (i.e. only
title exists in the input) hence there is no existing trailer lines,
and new trailer lines need to be added after adding blank, while the
new "body only" mode considers that there is only one paragraph in
the body, hence it may be the existing trailer block without any
message (in which case that is the block new trailer lines are to be
added to or existing ones to be removed from), or there is no
trailer block but one paragraph of the message (in which case you
would do the "add blank and append new trailer lines" thing).

I wrote the above down, hoping that it would give you a hint to
better explain what this patch aims to do, so please feel free to
further rephrase (or steal outright from) it when you reroll the
series.

Thanks.
