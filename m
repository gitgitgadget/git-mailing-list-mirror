From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-fetch: default globally to --no-tags
Date: Wed, 19 Nov 2014 12:22:36 -0800
Message-ID: <xmqqa93nrldf.fsf@gitster.dls.corp.google.com>
References: <20141119030523.GO22361@norris-Latitude-E6410>
	<xmqqr3wzrpur.fsf@gitster.dls.corp.google.com>
	<20141119185708.GA9908@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Brian Norris <computersforpeace@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 21:22:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrBm1-0002jV-8X
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 21:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654AbaKSUWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 15:22:41 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756547AbaKSUWj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 15:22:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 566B51F35E;
	Wed, 19 Nov 2014 15:22:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=deT9ANCn5fufZXj5EBpUKdurl1c=; b=qXRYz3
	tTsWlxWbTlTw4+yW55CvJNWRYDsslpcOr9FRuSDPe605133zkq6OH/KBO6Z9Vth7
	czo1szEjeUdf/SBlGcbURJxOfhKxDypSm12Y4A1QaKaNVq7V5H6nyEbUsKljx+tt
	UqMQ+WOHpTuNmems+PQPqRsZfL3BmL4roCXic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OYbD22JJ/5oGpo+DhaFlOR1HDIrLX7ZZ
	BczLqYOael9eOra4U7cOioBsjt+YeGIHp9hR/wcy3Eo3wdQeT5eB/61A6Cy4H6kT
	tZJ93GsvCv1+18LdcFAw94iPnv4tL1qDBdMIRfAwIMgVJGHC1dy7kbMbekhR5BB5
	5r2/6L3NX4I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4AC641F35D;
	Wed, 19 Nov 2014 15:22:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B8E7A1F35C;
	Wed, 19 Nov 2014 15:22:37 -0500 (EST)
In-Reply-To: <20141119185708.GA9908@peff.net> (Jeff King's message of "Wed, 19
	Nov 2014 13:57:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CDDC1B24-7029-11E4-8365-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Nov 19, 2014 at 10:45:48AM -0800, Junio C Hamano wrote:
>
>> ... tags are meant to be used for globally shared
>> anchoring points and the whole machinery (e.g. "fetch" that
>> auto-follows tags, "clone" that gives refs/tags*:refs/tags/*
>> refspec) is geared towards supporting that use pattern, which will
>> be broken by moving tags to per-remote namespace.
>> 
>> I can see "git tag --local foo" that creates refs/local-tags/foo
>> and also adding a mechanism to propagate local-tags/ hierarchy just
>> like heads/ hierarchy is propagated per-remote as a solution to that
>> problem that does not break the "release tags" use case, though.
>
> I am not sure I agree here that the discussions in [2] were not handling
> this case. Here you are arguing for the tag-writer to distinguish
> between two separate namespaces: global and local.
>
> But I think the proposals in [2] were about pushing that logic into the
> lookup phase. That is, pulling in all of the remote's tags as
> "refs/remotes/origin/tags/*", and then at lookup time checking multiple
> locations for tags (and preferring your local "refs/tags" to what is
> pulled from a remote).

With a separate local-tags hierarchy, the look-up part still has to
be enhanced.  After doing "git tag v2.0" and "git tag -l snapshot00",
you would want to be able to say "git log snapshot00..v2.0" and have
these found.

If you don't allow a private local-tags hierarchy, then those who
make releases are burdened to be very careful not to contaminate
their public repository --- "git tag snapshot00" cannot be used by
them lightly just to mark their private state, if their day
typically is concluded with "git push --follow-tags", as that will
push out the "tags" that are meant to be private.

Aside from the mantra that it is a good thing to reduce the workload
for people closer to the center of the project (hence likely to be
bottleneck to slow down others) and a separate local-tags hierarchy
is a way to achieve that, a separate local-tags hierarchy also helps
people who do not make releases by letting them easily differenciate
the global tags they get from the project and the tags they and
other project participants create as private markers (their own will
be found in refs/local-tags, others' in refs/remotes/$pal/local-tags).

> ...
> But the superproject is pulling them both together; if it uses
> refs/tags, the global namespaces will clash. Instead, it would be more
> convenitn to have refs/remotes/project1/tags and so on.

Yeah, but isn't it an orthogonal issue?  refs/tags/project{1,2}/*
would be what I would recommend to use for "global" stuff whose
purpose is to give people a shared world view.
