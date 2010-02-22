From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2010, #05; Sun, 21)
Date: Mon, 22 Feb 2010 12:21:33 -0800
Message-ID: <7viq9paunm.fsf@alter.siamese.dyndns.org>
References: <7vtytacebd.fsf@alter.siamese.dyndns.org>
 <20100222105203.GB16531@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 21:21:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njemr-0005SP-Og
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 21:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363Ab0BVUVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 15:21:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308Ab0BVUVm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 15:21:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EA1B9C27E;
	Mon, 22 Feb 2010 15:21:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uc9TjB0L4C0+SkVSjLhXioRrpsA=; b=X81dKA
	otQg6xv2jeG7KEd576r6rjJaYBBBiM/+Q6PuUqqWHq6F8TcoUx2WYHn9XPCGx24b
	pqjdw92x8D6KnyuXuWTzdacQ8JxGsvrqqjCXZSecykS/sCJIzNa/nAJQOpWTSX/I
	eRz2D9GqgTpjEoZuX9gI4gsQvqPL38GjVE/oU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rSz7TB18Au5R9Zc/nSE1dpG5BFAUu96U
	HdwHyoE8X29tOTyj0Ic/5q+NS5i10zkxtxwJQRCwWISPLyzzwxrcJ2CeiNt69f3U
	9URSJa91PEHK5PJNR/Nz6kz52pBgSRPu/pRRuZPdiqopjVrmUgyj3DwtXPvf5xPu
	vRpW67YI0p0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 64CC69C27A;
	Mon, 22 Feb 2010 15:21:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 98B4E9C279; Mon, 22 Feb
 2010 15:21:35 -0500 (EST)
In-Reply-To: <20100222105203.GB16531@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 22 Feb 2010 05\:52\:03 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E1681DEE-1FEF-11DF-B08C-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140709>

Jeff King <peff@peff.net> writes:

> On Sun, Feb 21, 2010 at 04:19:18PM -0800, Junio C Hamano wrote:
>
>> * cp/add-u-pathspec (2010-02-09) 2 commits
>>  - test for add with non-existent pathspec
>>  - git add -u: die on unmatched pathspec
>> 
>> I am a bit torn on this one.  Traditionally we never complained on
>> unmatched pathspec when talking about tracked files.  If we were to go
>
> True, though most of those pathspecs for tracked files are when viewing
> diffs. It seems more inconsistent here because "git add foo" complains
> but "git add -u foo" does not. So I think this one is definitely worth
> fixing.

One problem is that it would be adding a new inconsistency.

"git diff" does not complain but "git add -u" will complain if we make
this change, but "add -u" is about updating the path that "git diff"
reports as different.

That is why you would need to make "git diff" and friends _also_ complain,
if we want to add a new consistency between "add" and "add -u" without
breaking the existing consistency between "diff" and "add -u".  I do not
have a problem with making "diff" also complain for an unmatched pathspec
as a longer term direction, but we need to be careful (e.g. How should
this interact with "git log -- pathspec"?)

In any case, teaching "diff-files" about unmatched pathspec warning would
necessitate infrastructure change...

>> this route, I think we should probably enhance the "run_diff_files" and
>> friends in such a way that they mark matched pathspecs, in a way similar
>> to match_pathspec() in dir.c does, and report unmatched ones based on
>> that result, instead of adding an extra pass to scan the index.  The same
>> goes for pathspec_matches() in builtin-grep.c

Once we have an infrastructure for "diff-files" to notice an unmatching
pathspec, "add -u" will notice it, too, without any extra code.

Making "add -u" complain before fixing "diff-files" will have another
issue.  It will expose a bigger inconsistency that you omitted from my
message ;-) The pathspec "git add" without "-u" takes are processed by
pathspec match logic of "ls-files" family, but "git add -u" uses pathspec
match logic of "diff" family.  They have different semantics.

You can say "git add 'frotz/*.c'" but not "git add -u 'frotz/*.c'"; that
also needs to be fixed.

Making "add -u" alone complain using a separate throw-away logic that we
are sure we will have to discard when we make things consistent throughout
the system did not sound very attractive to me.  And that is why I was
unhappy about the solution.
