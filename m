From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] add -u: only show pathless 'add -u' warning when
 changes exist outside cwd
Date: Wed, 20 Mar 2013 08:10:01 -0700
Message-ID: <7v620mgl9y.fsf@alter.siamese.dyndns.org>
References: <1362786889-28688-1-git-send-email-gitster@pobox.com>
 <20130319224400.GA19014@google.com> <20130319225050.GE19014@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 16:10:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIKez-0001vH-DC
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 16:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088Ab3CTPKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 11:10:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63346 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756206Ab3CTPKF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 11:10:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F99EA8C1;
	Wed, 20 Mar 2013 11:10:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+GJHyR84ABhegqFesuL1ai5gqHs=; b=AX1c1Y
	oYy2XvXm/2cJxrUznQUzzkKesyHodjgTLs2/dhyAen3laWDQqDKZ2cECDvhBlrVY
	a+cHFGqmoax43gPnasz2QCZ64q97W1JVghQNwQ3WvVPyMtOhwbnEGTm7cGz3fPEx
	4JPb3KFMv6RuQcb8FxTX1jlLLu5ytjLH4uwuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kBUlpOtLTn5rmjmxIr9RXpSJNozATKJu
	xovND3iVaS2bcbeiaWOqqXEPzDHyUfaUDraUKmhhfKbXZqEfDYaEjwWhr94463Pv
	rhiX4EU2HjrivABkoogui5Ttmc88SyaRLwRhHhmUZQEt+Hl9uQHoj60z+Zp/mqjm
	7KhBYI2oX7g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51641A8C0;
	Wed, 20 Mar 2013 11:10:04 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A130BA8BF; Wed, 20 Mar 2013
 11:10:03 -0400 (EDT)
In-Reply-To: <20130319225050.GE19014@google.com> (Jonathan Nieder's message
 of "Tue, 19 Mar 2013 15:50:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3DFA04A6-9170-11E2-ABE3-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218613>

Jonathan Nieder <jrnieder@gmail.com> writes:

> A common workflow in large projects is to chdir into a subdirectory of
> interest and only do work there:
>
> 	cd src
> 	vi foo.c
> 	make test
> 	git add -u
> 	git commit
>
> The upcoming change to 'git add -u' behavior would not affect such a
> workflow: when the only changes present are in the current directory,
> 'git add -u' will add all changes, and whether that happens via an
> implicit "." or implicit ":/" parameter is an unimportant
> implementation detail.
>
> The warning about use of 'git add -u' with no pathspec is annoying
> because it seemingly serves no purpose in this case.  So suppress the
> warning unless there are changes outside the cwd that are not being
> added.
>
> A previous version of this patch ran two I/O-intensive diff-files
> passes: one to find changes outside the cwd, and another to find
> changes to add to the index within the cwd.  This version runs one
> full-tree diff and decides for each change whether to add it or warn
> and suppress it in update_callback.  As a result, even on very large
> repositories "git add -u" will not be significantly slower than the
> future default behavior ("git add -u :/"), and the slowdown relative
> to "git add -u ." should be a useful clue to users of such
> repositories to get into the habit of explicitly passing '.'.

I'll queue this as-is for now, but the point Peff raised on
IMPLICIT_DOT needs to be addressed.

This is a tangent, but I would also suggest at least considering to
measure how big the working tree is relative to the area covered by
the implicit dot [*1*].  If you are running "add -u" in a project
with 30k paths but are working with only a few dozen files, you may
want more encouragement to use an explicit "."  than the command
mysteriously and silently getting slower at Git version boundary.

IOW, an advice message issued only when (1) you are indeed working
in a narrow directory, (2) you did not touch anything outside, and
(3) you did not give an explicit ".".  We would want to keep the
advice in place even after Git 2.0 switches the default to ":/".  In
fact, it would become even more valuable after the transition. And
make it protected under advice.addUAuseexplicitdot or something.

By the way, I am not a big fan of the approach taken in [3/6].  It
may be a lot cleaner to separate the "do we need to warn?" logic
that flips a global (or a field in a callback, if we make some of
these codepaths callable from other places) and the code to issue
the warning, no?


[Footnote]

*1* The former you can get an approximation from active_nr, the
latter you can count after first finding where prefix would insert
to the active_cache with index_name_pos().  I suspect that you also
could add a new read-only API to cache-tree to see if it already
knows how many index entries a given subtree for the prefix covers.
