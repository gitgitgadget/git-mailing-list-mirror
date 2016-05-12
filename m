From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] submodule groups
Date: Thu, 12 May 2016 08:58:24 -0700
Message-ID: <xmqqoa8bgten.fsf@gitster.mtv.corp.google.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
	<xmqq37pnj04f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de, git@vger.kernel.org,
	pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 12 17:58:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0t0S-0004PO-Rq
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 17:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbcELP63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 11:58:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59837 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751912AbcELP62 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 11:58:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 50BC0188EB;
	Thu, 12 May 2016 11:58:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=od9J0HfmJGN+xg45g4IUkNX4svE=; b=KlT0lA
	0uf4AfEmWPYrCjdJKoQ/iQ7xmKw0Bh+ViMBqn5OC+dVGs88uk+H+SF91tKGcf7ee
	+Ij3UUqnv1y8/co/7LxdEkcnlbhHNjeTDKuvjU7D9pbM9B2ofehXHwJz3nLuGlJv
	cym5EczsmFPX8XnaYCI/eYgpw9x7KiWxXEotM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SSrum9jfQrDAQWKrOp+qTHjbwogqCCY3
	fe0wJym2wZbi4hRCRrDdFFR/bGQL66M8fQs6mX9Q+c5fWMBHOofdN3vvqti7b8HD
	hqukz3IIXIrZfW1hG92d3gghcByaEJ7SMlofNsz4jYEtMFoVniM77ovr7pEwXI6c
	zy0iUGVW1m0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 47CE6188EA;
	Thu, 12 May 2016 11:58:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C05BF188E9;
	Thu, 12 May 2016 11:58:26 -0400 (EDT)
In-Reply-To: <xmqq37pnj04f.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 11 May 2016 22:50:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5D033E20-185A-11E6-894D-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294410>

Junio C Hamano <gitster@pobox.com> writes:

> The reason why I suspect that this may not work well with submodule
> labels is because submodule labels (or any attribute we give via
> .gitmodules to a submodule) are keyed by a submodule name, which is
> the primary unchanging key (so that people can "mv" a submodule in
> the context of the toplevel superproject without losing track of
> submodule identity), not by paths to submodules, while the "group"
> thing I want is merely a short-hand for pathspec elements and wants
> to be keyed by paths.
>
> But there may be somebody more clever than I who can come up with a
> way to unify these two similar concepts without confusing end users.

Thinking about this even more, if there is no requirement that
labels must be tied to submodule names, we just can scrap the idea
of "submodule labels" to group things and instead just use "path
labels", i.e. write the full path to the submodule and assign it a
label in .gitattributes and use it in place of where we used *label
in the patch series.  After all, an easy way to choose some among
many submodules logically is a subset of an easy way to choose some
among many paths.

The only reason why we added the submodule label to .gitmodules is
because we viewed it as submodule-specific thing and the "keyed by
name, not path" came as a consequence, not because any real "we must
key it by name because..." reason, I would think.

I know this is a huge departure from the design presented both at
the conceptual level and also at the implementation level, and that
is one of the reasons why I do not particularly want to like it, but
on the other hand, I am not bold enough to say that I will have a
good answer when later somebody asks "Why can we group only
submodules with labels, but not random group of paths (e.g. 'these
directories are about documentation')?"  And then, if we add path
labels to allow expressing groups of paths later, the follow-up
question would be "When should I use submodule labels and when
should I use path labels?  I can use path labels to group submodules
and say 'git submodule update -- :(group=docs)' can't I?".

And that makes me pause and step back from the "submodule labels"
idea.
