From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP 02/11] notes-merge: use opendir/readdir instead of
 using read_directory()
Date: Wed, 26 Oct 2011 10:37:19 -0700
Message-ID: <7vmxcn3b8w.fsf@alter.siamese.dyndns.org>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
 <1319438176-7304-3-git-send-email-pclouds@gmail.com>
 <7vzkgo3m9b.fsf@alter.siamese.dyndns.org>
 <CACsJy8CocoAiVx_PeaaX1oRZvmzfj9-z9JLJkE5unSRVtpGkNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 26 19:37:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ7Ps-0008W2-0Z
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 19:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933749Ab1JZRhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 13:37:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52298 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932914Ab1JZRhW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 13:37:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72492474C;
	Wed, 26 Oct 2011 13:37:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KQNZ/juDtQsWoUEseH2NBallajM=; b=p6gVEe
	ZzccgbKc3/vmRVq2QUuKpWUCxNX51JaxB4iGLse3DL0I0kgbffAGJ65qCrMaH9LP
	lZ5Dfszfx3NM7D010o9IgDEOewora/aiFN7ikXOiGh5vTdJjvnuVutwpmgMdYajD
	3QuK21Zkogpb7XHZgQZqfZWDQ9zfPyuTEKEqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yW+c8/yS3pdrpcUeE9Ja6w1R4R6IQQDn
	zmsT5w5JZ4ZgGjJEvsvdVQ2Iu1hZ6So+4/oRshPD8q35BArAeC+DykG6aTdGb6lX
	trX6z3KP9CaNrUEVFLB/UR7sMXwTmSS+qe+amJqS9YjvE4p8rDRm06EQPJlKDmgy
	FQzyImcEfWc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6973F474B;
	Wed, 26 Oct 2011 13:37:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F09E2474A; Wed, 26 Oct 2011
 13:37:20 -0400 (EDT)
In-Reply-To: <CACsJy8CocoAiVx_PeaaX1oRZvmzfj9-z9JLJkE5unSRVtpGkNA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 26 Oct 2011 11:08:55 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2858C4CA-FFF9-11E0-A00D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184269>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Current read_directory() treats given path separately from contents
> inside the path. If the given path has ".git", it's ok (but it'll stop
> at .git if during tree recursion). The new read_directory() does not
> make this exception, so when note-merge call
> read_directory(".git/NOTES_MERGE_WORKTREE"), read_directory() sees
> ".git" and stops immediately, assuming it's a gitlink.

When read_directory("where/ever") is called, what kind of paths does it
collect? Do the paths the function collects share "where/ever" as their
common prefix? I thought it collects the paths relative to whatever
top-level directory given to the function, so that "where/ever" could be
anything.

Why does it even have to look at the given path in the first place and
make a decision heavier than "can I opendir() and read from it"?  In other
words, if you see read_directory("some/thing/.git/more/stuff") and find a
substring ".git/" in there, what "magic" gitlink handling does the code
have to do?

I do not think it matters for _this_ particular case, but I can for
example imagine an alternative implementation of a merge that uses
temporary working tree somewhere other than the main working tree, and one
of the natural "temporary" places such a feature in the future may want to
use is inside .git/ somewhere. If you are planning to close the door by
breaking the behaviour of read_directory(".git/some_where") for such
callers with this series, we need to be aware of it, and that is why I am
not satisfied by your explanation.
