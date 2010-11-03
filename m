From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Use git_open_noatime when accessing pack data
Date: Wed, 03 Nov 2010 10:07:06 -0700
Message-ID: <7v8w1axrnp.fsf@alter.siamese.dyndns.org>
References: <1288652061-19614-1-git-send-email-spearce@spearce.org>
 <1288652061-19614-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 03 18:07:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDgo4-0000Ta-CA
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 18:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073Ab0KCRHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 13:07:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756059Ab0KCRHM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 13:07:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FBF81D6B;
	Wed,  3 Nov 2010 13:07:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mrNuSFQYabNi5nUtxmGkA/KXlkg=; b=NXG7s3
	ByFWLGWFOO15njJULpr492j3ULD+q1OQiKqt5FhyW8TK+Y5LETQlP6m8kxP2JBH/
	C1IxNqB+1TNgBbGVs1fgZvAbeIAhTJFTC1J8bIYcqOc5cqzGztjYnUVRTMwfmWyq
	/6l/4hXZvNASWVOUMA+aqZ5kHY4VBrGSMmuQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TShJj+B0JmpIUUhRC3qWWUM2H6Wk159G
	wJhdk8xZ3iEeEqMu2eKHi9gYa02Op5R/Ve9YD0CwpZ6hOqKj+LE816oFAEBsNLe4
	Y9s6y8JrmSZMTOyIZeeb2bey8IpRayPOZ/jKCIJLqYDwSGwiagYZHBOs8A1Z7A1L
	xAzha4IhKFk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C46E1D66;
	Wed,  3 Nov 2010 13:07:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E1D91D62; Wed,  3 Nov
 2010 13:07:07 -0400 (EDT)
In-Reply-To: <1288652061-19614-2-git-send-email-spearce@spearce.org> (Shawn
 O. Pearce's message of "Mon\,  1 Nov 2010 15\:54\:20 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CB7CA6C2-E76C-11DF-B92C-B51D107BB6B6-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160628>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> This utility function avoids an unnecessary update of the access time
> for a loose object file.  Just as the atime isn't useful on a loose
> object, its not useful on the pack or the corresonding idx file.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

Hearing the name "git-open-noatime", one would naturally assume that it is
a way to open files without burdening the filesystem with inode metadata
update traffic, as that was the original reason why we open loose objects
without atime update.  We historically anticipated to have very many of
the loose objects lying around, and this optimization made sense.

As any sane repository would have far fewer packfiles than loose objects,
one would think that, while it may not hurt, using git-open-noatime to
open packfiles is just a misguided performance measure.  Not.

This patch (and the next patch) adds "we unuse pack windows to retry
opening if we have too many files already open" logic, which is a lot more
important side effect, especially when this function is used for packfiles
(because they tend to stay open for a long time, unlike loose object files
that are opened, read/mapped, and then immediately closed) than what the
name of this function says it does.

Even though I think the issue you are solving is worth addressing, I do
not think I like the structure of the API resulting from these two
patches.  Most of the callers, except for the ones in check-packed-git-idx
and open-packed-git-1, do not care about "keeping one packfile" interface,
so I would prefer to see a two-patch series along the lines of ...

 (1) introduce "int git_open_ro(const char *)" to replace the current
     git_open_noatime().  The point is that the function no longer is
     about avoiding from smudging the inode metadata.  Instead, it becomes
     the preferred way for us to get a read-only fd.

 (2) call your git_open_noatime() implementation git_open_rowpf() or
     something.  Make git_open_ro() a thin wrapper of this function that
     passes NULL for its packed_git parameter.  Two callers that care
     about protecting a pack they are operating on will call this function
     directly.

We can of course do without s/git_open_noatime/git_open_ro/; and it will
make the patch much smaller.  The rename is purely a clarification of the
API and is optional.  It may make it easier to explain the name of the new
function, though.

By the way, I think I still owe you a patch to selectively pack-ref only
old ones.
