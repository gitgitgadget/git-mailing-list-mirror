From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why does send-pack call pack-objects for all remote refs?
Date: Mon, 07 Dec 2015 14:41:00 -0800
Message-ID: <xmqqvb89lw5f.fsf@gitster.mtv.corp.google.com>
References: <4766c8518c2a46afb88fc0a2dd9a1688@EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Daniel Koverman <dkoverman@predictiveTechnologies.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 23:41:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a64T3-00081O-3W
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 23:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756614AbbLGWlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 17:41:07 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756605AbbLGWlE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 17:41:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9814532D4E;
	Mon,  7 Dec 2015 17:41:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gC96OBkqL85tokeGS+cO5MFvYaE=; b=M5KAxS
	8VxImUHWGGaHRL1vSWBtqKuZDsdodhXwjrji1AbGJTtp+Jr3l3c2JSfEWITiVnOo
	u3ZYv45gRHkRcmisGf/EJpc65XlcRHvMjx/FXR+j/SNc/Dm7BubmTKCZ4AmodTz6
	TdKmOIazPw7OyKCR/6PsEMrJxnXaAovLZHHV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EESkPPB4OE7iEYf5Sf6P+cFdNMqhhkno
	VgVzEF5eYcu0oBZnpLCWpOKOYHBGXDqwsonYxPT4PA2jbuJXPBfFQq3Ih6sseqtg
	pmzKXTB7vvnmB4+hiMCCRW3wqDhWITzlvVUSxrlA6PxVvdxYFlRzNWFDQ7GJWlar
	GBgOW3CgmY8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8EBC332D4D;
	Mon,  7 Dec 2015 17:41:02 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E6F0632D4A;
	Mon,  7 Dec 2015 17:41:01 -0500 (EST)
In-Reply-To: <4766c8518c2a46afb88fc0a2dd9a1688@EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com>
	(Daniel Koverman's message of "Mon, 7 Dec 2015 21:02:22 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 97C10238-9D33-11E5-A8AF-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282133>

Daniel Koverman <dkoverman@predictiveTechnologies.com> writes:

> I have a repository which has ~2000 branches on the remote, and it
> takes ~8 seconds to push a change to one ref. The majority of this
> time is spent in pack-object. I wrote a hack so that only the ref
> being updated would be packed (the normal behavior is to pack for
> every ref on the remote).

I am having a hard time understanding what you are trying to say, as
nobody's pack-objects "packs for a ref" or "packs a ref", so my
response has to be based on my best guess---I think you are talking
about feeding the object names of the tips of all remote refs as
the bottoms of the revision range to pack-objects.

When you are pushing your 'topic' branch to update the 'topic'
branch at the remote, it is true that we compute

	git rev-list --objects $your_topic --not $all_of_the_remote_refs

to produce a packfile.  And by tweaking this to

	git rev-list --objects $your_topic --not $their_topic

you will cut down the processing time of 'rev-list', especially if
you have insane number of refs at the remote end.

There is a price you would pay for doing so, though.  An obvious one
is what if the 'topic' branch does not exist yet at the remote.
Without the "--not ..." part, you would end up sending the entire
history behind $your_topic, and the way you prevent that from
happening is to give what are known to exist at the remote end.
Even when there already is 'topic' at the remote, the contents at
the paths that are different between your 'topic' and the 'topic' as
exists at the remote may already exist on some other branches that
are already at the remote (e.g. you may have merged some branches
that are common between your repository and the remote, and the only
object missing from the remote that your repository has to send may
be a merge commit and the top-level tree object), but limiting the
bottoms of the revision range only to "--not $their_topic" would rob
this obvious optimization opportunity from you.

There has to be some way to limit the list of remote-refs that are
used as bottoms of the revision range.  For example, if you know
that the remote has all the tags, and that everything in the v1.0
tag is contained in the v2.0 tag, then a single "--not v2.0" should
give the same result as "--not v1.0 v2.0" that lists both.  But the
computation that is needed to figure out which tags and branches are
not worth listing as bottoms would need to look at all of them at
least once anyway, so a naive implementation of such would end up
spending the same cycles, I would suspect.

Also it was unclear if you are working with a shallow repository.
The performance trade-off made between the packsize and the cycles
is somewhat different between a normal and a shallow repository,
e.g. 2dacf26d (pack-objects: use --objects-edge-aggressive for
shallow repos, 2014-12-24) might be a good starting point to think
about this issue.
