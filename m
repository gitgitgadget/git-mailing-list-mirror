From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] patch-id: make it stable against hunk reordering
Date: Mon, 31 Mar 2014 10:59:50 -0700
Message-ID: <xmqqk3ba6yg9.fsf@gitster.dls.corp.google.com>
References: <1396202583-2572-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, jrnieder@gmail.com,
	peff@peff.net
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 20:01:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUgV6-0001ky-N9
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 20:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656AbaCaR7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 13:59:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51564 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753045AbaCaR7x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 13:59:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC34F7649F;
	Mon, 31 Mar 2014 13:59:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SOqDQiAjidbP0IJQOd302H69pl8=; b=JWFWLA
	ChUNsFVcuEf9C6Vl4usy1bx5OkiIAHUe0WDK51WP5VcfpGpECI6pUVdA5hv1FRGz
	FyJvSFIjKe9qyJeVmBkrPbOa61EFmVyCZoNSYali+cDNIjyeyVJFN+smqCUtH3B3
	szESZbhOYZcQMABy3ZXz7O7Xvve9XRtNM+WQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yv4Wb04PCBkyKJhWqyicEhzpl5STf2hS
	+UW4XfAN9fTyayt18l3W8itxGcQD6LamGT6s2LC1tQQDZzkUgSaKLozLosgiuB3U
	cVZLQ9TM8c3QQJIzT6BhIaheLnpO/0w/Ucg2hz/ONTDOTNpJmBqo4qBMWuuFX7Fj
	oBBT83Kgu0M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 941387649C;
	Mon, 31 Mar 2014 13:59:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E45737649B;
	Mon, 31 Mar 2014 13:59:51 -0400 (EDT)
In-Reply-To: <1396202583-2572-1-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Sun, 30 Mar 2014 21:09:22 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 41FC1F56-B8FE-11E3-B9F2-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245500>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Patch id changes if users
> 1. reorder file diffs that make up a patch
> or
> 2. split a patch up to multiple diffs that touch the same path
> (keeping hunks within a single diff ordered to make patch valid).
>
> As the result is functionally equivalent, a different patch id is
> surprising to many users.
> In particular, reordering files using diff -O is helpful to make patches
> more readable (e.g. API header diff before implementation diff).
>
> Change patch-id behaviour making it stable against these two kinds
> of patch change:
> 1. calculate SHA1 hash for each hunk separately and sum all hashes
> (using a symmetrical sum) to get patch id
> 2. hash the file-level headers together with each hunk (not just the
> first hunk)
>
> We use a 20byte sum and not xor - since xor would give 0 output
> for patches that have two identical diffs, which isn't all that
> unlikely (e.g. append the same line in two places).
>
> Add a new flag --unstable to get the historical behaviour.
>
> Add --stable which is a nop, for symmetry.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> changes from v2:
> 	several bugfixes
> changes from v1:
> 	hanges from v1: documented motivation for supporting
> 	diff splitting (and not just file reordering).
> 	No code changes.
>
>  builtin/patch-id.c | 72 ++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 56 insertions(+), 16 deletions(-)

Does this have to interact or be consistent with patch-ids.c which
is the real patch-id machinery used to filter like-changes out by
"cherry-pick" and "log --cherry-pick"?

This series opens a very interesting opportunity by making it
possible to introduce the equivalence between two patches that touch
the same file and a single patch that concatenates hunks from these
two patches.

One example I am wondering about is perhaps this could be used to
detect two branches, both sides with many patches cherry-picked from
the same source, but some patches squashed together on one branch
but not on the other.  It would be very nice if you can detect that
two sets of patches are equivalent taken as a whole in such a
situation while rebasing one on top of the other.

Another example is that another mode that gives a set of broken-up
patch-ids for each hunk contained in the input.  Suppose there is a
patch that is only meant to be used on the proprietary fork of an
open source project, and the project releases the open source
portion by cherry-picking topics from the development tree used for
the proprietary "trunk".  The integration service of such a project
used to prepare the open source branch may want to have a
pre-receive hook that says "do not merge any commit to cause this
this hunk appear in the result, no matter what other changes the
patches in the commit may bring in", and broken-down patch-ids
(e.g. "diff HEAD...$commit | patch-id --individual") may be an
ingredient to implement such a hook.  There may be interesting
applications other than such a "broken-down patch-ids" that can be
based on the enhancement you are presenting here.
