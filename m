From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-log --cherry-pick gives different results when using tag or tag^{}
Date: Wed, 15 Jan 2014 11:57:39 -0800
Message-ID: <xmqq1u092f2k.fsf@gitster.dls.corp.google.com>
References: <52CFF27C.1090108@gmail.com>
	<20140115094945.GD14335@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francis Moreau <francis.moro@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 15 20:57:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3Wb1-0007XH-8l
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 20:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbaAOT5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 14:57:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42116 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbaAOT5p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 14:57:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95C0E62F04;
	Wed, 15 Jan 2014 14:57:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YuEPYlrMapRUZOH6RcpOsUNkzg4=; b=UA602e
	WvMc93KGChtqoCKUYzwWOn9WKFRG2o9GNC6lKGSFmdP3BdQaAW/KM/VqF/LJPt/L
	a+tdUbxjMQv2oknEAJcZdFMwWi38P0n9gML6N/Jbt25ez71J5wjVYU/nHLMoaKNu
	kaHX6aAA2+WEdlj0fbg0+w7msovbNMIMW5wwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y290QPemphRGZEcajzBpi1blayUZRxhP
	f1C59YCPOkU0aqq60seH5oN6cavKGOicUbxpMJ2WEQ3q6hUZfSb2ws0LYzdNEkYF
	xsqxeXJeSoEjg7wwrfyJgEsOXdr+3HQZ1ABoFw27CgIXNBfSVWhv2AhE7OmHhRuJ
	ktpZZLA+qWs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 832BC62F03;
	Wed, 15 Jan 2014 14:57:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CACE562F02;
	Wed, 15 Jan 2014 14:57:41 -0500 (EST)
In-Reply-To: <20140115094945.GD14335@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 15 Jan 2014 04:49:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4AFCD358-7E1F-11E3-986A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240475>

Jeff King <peff@peff.net> writes:

> [+cc Junio, as the bug blames to him]
> ...
> I think what is happening is that we used to apply the SYMMETRIC_LEFT
> flag directly to the commit. Now we apply it to the tag, and it does not
> seem to get propagated. The patch below fixes it for me, but I have no
> idea if we actually need to be setting the other flags, or just
> SYMMETRIC_LEFT. I also wonder if the non-symmetric two-dot case needs to
> access any pointed-to commit and propagate flags in a similar way.

Thanks.

Where do we pass down other flags from tags to commits?  For
example, if we do this:

	$ git log ^v1.8.5 master

we mark v1.8.5 tag as UNINTERESTING, and throw that tag (not commit
v1.8.5^0) into revs->pending.objects[].  We do the same for 'master',
which is a commit.

Later, in prepare_revision_walk(), we call handle_commit() on them,
and unwrap the tag v1.8.5 to get v1.8.5^0, and then handles that
commit object with flags obtained from the tag object.  This code
only cares about UNINTERESTING and manually propagates it.

Perhaps that code needs to propagate at least SYMMETRIC_LEFT down to
the commit object as well, no?  With your patch, the topmost level
of tag object and the eventual commit object are marked with the
flag, but if we were dealing with a tag that points at another tag
that in turn points at a commit, the intermediate tag will not be
marked with SYMMETRIC_LEFT (nor UNINTERESTING for that matter),
which may not affect the final outcome, but it somewhat feels wrong.

How about doing it this way instead (totally untested, though)?

 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index a68fde6..def070e 100644
--- a/revision.c
+++ b/revision.c
@@ -276,6 +276,7 @@ static struct commit *handle_commit(struct rev_info *revs,
 				return NULL;
 			die("bad object %s", sha1_to_hex(tag->tagged->sha1));
 		}
+		object->flags |= flags;
 	}
 
 	/*
@@ -287,7 +288,6 @@ static struct commit *handle_commit(struct rev_info *revs,
 		if (parse_commit(commit) < 0)
 			die("unable to parse commit %s", name);
 		if (flags & UNINTERESTING) {
-			commit->object.flags |= UNINTERESTING;
 			mark_parents_uninteresting(commit);
 			revs->limited = 1;
 		}
