From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] implement pattern matching in ce_path_match
Date: Thu, 15 Jan 2009 18:51:07 -0800
Message-ID: <7vzlhsneuc.fsf@gitster.siamese.dyndns.org>
References: <1231944876-29930-1-git-send-email-drizzd@aon.at>
 <1231944876-29930-2-git-send-email-drizzd@aon.at>
 <1231944876-29930-3-git-send-email-drizzd@aon.at>
 <1231944876-29930-4-git-send-email-drizzd@aon.at>
 <7vljtd20m6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes@familieschneider.info
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Jan 16 03:52:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNep7-0001C2-Pi
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 03:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbZAPCvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 21:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754269AbZAPCvR
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 21:51:17 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37164 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162AbZAPCvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 21:51:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 90FD11CA26;
	Thu, 15 Jan 2009 21:51:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C33661CA2A; Thu,
 15 Jan 2009 21:51:09 -0500 (EST)
In-Reply-To: <7vljtd20m6.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 14 Jan 2009 10:39:29 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8A3CF83C-E378-11DD-A4D9-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105916>

Junio C Hamano <gitster@pobox.com> writes:

> Clemens Buchacher <drizzd@aon.at> writes:
>
>> With this patch ce_path_match uses match_pathspec in order to perform
>> pattern matching.
>
> We have two conflicting definitions of pattern matching in our system.
> I'd make it more explicit which kind of pattern matching you are talking
> about here.
>
> The family of operations based on the diff-tree machinery (e.g. path
> limited revision walking "git log A..B -- dir1/dir2") define the pattern
> matching as "leading path match (exact match is just a special case of
> this)".  Other operations that work on paths in the work tree and the
> index (e.g. grep, ls-files) uses "leading path match, but fall back to
> globbing".
>
> In the longer term we really should unify them by teaching the former to
> fall back to globbing without getting undue performance hit, and this
> patch may be a step in the right direction.  There are optimizations that
> assume the "leading path" semantics to trim the input early and avoid
> opening and descending into a tree object if pathspec patterns cannot
> possibly match (see tree-diff.c::tree_entry_interesting() for an example),
> and we need to teach them to notice a glob wildcard in an earlier part of
> a pathspec and to descend into some trees that they would have skipped
> with the old definition of pathspec.

Actually there was an earlier attempt that resulted in the pathspec
matching tree traverser builtin-grep uses.  Even though it has to work
with trees (when grepping inside a tree-ish) and has optimizations not to
open unnecessary subtrees similar to the one the diff-tree machinery has,
it also knows how to handle globs.  If we were to pick one of existing
implementations for the longer term unification, I think that is probably
the one we should build on top of.
