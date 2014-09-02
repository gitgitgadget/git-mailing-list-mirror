From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 3/3] core: improve header dependencies
Date: Tue, 02 Sep 2014 11:32:02 -0700
Message-ID: <xmqqr3zt27rx.fsf@gitster.dls.corp.google.com>
References: <1409515893-48017-1-git-send-email-davvid@gmail.com>
	<1409515893-48017-2-git-send-email-davvid@gmail.com>
	<1409515893-48017-3-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 20:34:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOsuO-0004K6-3T
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 20:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277AbaIBSeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 14:34:20 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65071 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954AbaIBSeT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 14:34:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1592D36D7F;
	Tue,  2 Sep 2014 14:34:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QiSK2aakUCf3f3U8zU90s8+8OUk=; b=bS4nzo
	mpwBPQ0k0CG2CPSKxvVc51tA1J39hmeR/k+M5c+rY6OQ5oxYM3A1XCw3MPuGNkSM
	UYbVJ2IdqXrwSQxdVu4b6mCc3AFVQl2eEXpYLacaTOV++8TUKRg+VzCToVdHTH/Z
	l3MzwDCYKebYrWGTFigT4L4TfO5C6DGtHwU6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=voSd6p1WpYD6zgJLSEoxHARzEHJZbimA
	ORn5WLb6+Nivm+JPd+3tJiQUtL2IwcZbi/jertKChyaZ9xZdlVxTjznVy6a9IIyz
	OadTqI0Qq6EiTA5FhBUwVk+BoiFFXa/el9v9nHlUDlmt7+Px1hTD0x/QFxOWjWqb
	BSfuF4KsxsU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 093D136D7E;
	Tue,  2 Sep 2014 14:34:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4FBE136C9E;
	Tue,  2 Sep 2014 14:32:04 -0400 (EDT)
In-Reply-To: <1409515893-48017-3-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Sun, 31 Aug 2014 13:11:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6FCDD69A-32CF-11E4-8B41-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256332>

David Aguilar <davvid@gmail.com> writes:

> Remove includes that have already been included by another header.

Hmm, I am not sure if that is a good move, and suspect that it is
incompatible with what your 2/3 attempts to do, at least at the
philosophical level.

I am guessing that your 2/3 wants to see

	gcc $header.h

to be happy.  One benefit from doing such a change is that sources
that want to use declaration made in $header.h have to include that
$header.h without having to worry about what other things the
implementation detail of $header.h needs.  If function F or type T
is declared in header H, you include H and you are done.

That is nice and tidy, but if that is the goal, then after making H
include its own dependency H1 that happen to declare functions F1,
F2 and types T1, T2 (which are necessary for H to be complete as
standalone), if the source that used to include both H and H1
because it uses F and F1 should still explicitly include H1, no?

For example, you dropped "diff.h" from builtin/add.c, but the
implementation of builtin/add.c needs access to diff_options struct,
which is in "diff.h", not whatever happened to include indirectly
that is already included by builtin/add.c.  I do not think it is a
good idea, and more importantly I suspect that it is not consistent
with what you tried to do with your 2/3.

But it is entirely possible I am misunderstanding the real
motivation behind these changes.  The log message justifies why
removal is safe i.e. "have already been included indirectly", and
the title claims it is an improvement, but there is no explanation
why it is an improvement (which would have also explained the
motivation behind it), so it is a bit hard for me to guess.
