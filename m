From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] teach sha1_name to look in graveyard reflogs
Date: Thu, 19 Jul 2012 15:39:24 -0700
Message-ID: <7vtxx3tlyb.fsf@alter.siamese.dyndns.org>
References: <20120719213225.GA20311@sigill.intra.peff.net>
 <20120719213326.GB20385@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexey Muranov <alexey.muranov@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 20 00:39:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrzNc-0001f7-I9
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 00:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068Ab2GSWj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 18:39:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62198 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683Ab2GSWj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 18:39:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C1F088AE;
	Thu, 19 Jul 2012 18:39:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y+KFkKbuLZGwzpYEK2aroBbJ3xg=; b=QOkagP
	oXTfdZ5EnDBU6LK8qPzRWUu3kAn6obUN8DDmdawJzbKAZvbnCqZwqj//jrYZ45BV
	ufk0CcH89FQuo2eBGYpHN8ZdY4e8CA3pXlmteqtT03ob8Lb5P+CKcPZliLwXxEud
	KnyQfDDlrKksFGYRpxUZ2ntLGHdBquFGpQcsI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DpFaGpmh55HxCR5aYdnRXC7EAMW0C0z5
	KNi8VjVQZ1jSIIF4F4KGzlxJQycigCpnNY8u2B9WPSuVK5ibVE0vBbfaQHvapGiI
	Pav4w1DAJqR4tWtRRy6ZgMFccCL3OsqhR1wjt3S+zL/TXHvNn2J44zGVJVSzaJLv
	vUvNmi1a3QY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A8E088AD;
	Thu, 19 Jul 2012 18:39:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6B8988AC; Thu, 19 Jul 2012
 18:39:25 -0400 (EDT)
In-Reply-To: <20120719213326.GB20385@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 19 Jul 2012 17:33:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97F4F13E-D1F2-11E1-9EC5-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201759>

Jeff King <peff@peff.net> writes:

> The previous commit introduced graveyard reflogs, where the
> reflog for a deleted branch "foo" appears in
> "logs/graveyard/refs/heads/foo~".
>
> This patch teaches dwim_log to search for these logs if the
> ref does not exist, and teaches read_ref_at to fall back to
> them when the literal reflog does not exist.  This allows
> "deleted@{1}" to refer to the final commit of a deleted
> branch (either to view or to re-create the branch).  You can
> also go further back, or refer to the deleted reflog entries
> by time. Accessing deleted@{0} will yield the null sha1.
>
> Similarly, for_each_reflog_ent learns to fallback to
> graveyard refs, which allows the reflog walker to work.
> However, this is slightly less friendly, as the revision
> parser expects the matching ref to exist before it realizes
> that we are interested in the reflog. Therefore you must use
> "git log -g deleted@{1}" insted of "git log -g deleted" to
> walk a deleted reflog.
>
> In both cases, we also tighten up the mode-checking when
> opening the reflogs. dwim_log checks that the entry we found
> is a regular file (not a directory) to avoid D/F confusion
> (e.g., you ask for "foo" but "foo/bar" exists and we find
> the "foo" but it is a directory).
>
> However, read_ref_at and for_each_reflog_ent did not do this
> check, and relied on earlier parts of the code to have
> verified the log they are about to open. This meant that
> even before this patch, a race condition in changing refs
> between dwim_log and the actual read could cause bizarre
> errors (e.g., read_ref_at would open and try to mmap a
> directory). This patch makes it even easier to trigger those
> conditions (because the ref namespace and the fallback
> graveyard namespace can have D/F ambiguity for a certain
> path). To solve this, we check the mode of the file we open
> and treat it as if it did not exist if it is not a regular
> file (this is the same way dwim_log handles it).
>
> Signed-off-by: Jeff King <peff@peff.net>

This may or may not be related, but I vaguely recall that "log -g"
traversal hack had a corner case where the walking stops prematurely
upon seeing a gap (or creation/deletion that has 0{40})?  Do you
recall if we have ever dealt with that?

The patch seems fine from a cursory look.  Thanks.
