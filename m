From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: fix adding new files on i-t-a entries
Date: Wed, 24 Jun 2015 10:05:32 -0700
Message-ID: <xmqqzj3p9gv7.fsf@gitster.dls.corp.google.com>
References: <CACfKtTAvH7FH2AkC5hUNFEQ620gF401SNYaULLy62iE8S55-7A@mail.gmail.com>
	<1435062855-26274-1-git-send-email-pclouds@gmail.com>
	<xmqqoak6e5dx.fsf@gitster.dls.corp.google.com>
	<CACsJy8Ap4uNi3gXV8Y+S18xtLaZ1R6DscEf7wJKjt59ZLOAJ5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>, phiggins@google.com,
	snoksrud@gmail.com
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 19:06:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7o7o-0002kJ-0N
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 19:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbbFXRFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 13:05:37 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38471 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbbFXRFf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 13:05:35 -0400
Received: by igin14 with SMTP id n14so38247193igi.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 10:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=oH4EZ+d8ujg6LA3jwY0tMm+fkR6WmMG6qXhweymxVyk=;
        b=nAYSnrL1YrKdZTQ0Up0i/XW95WAXOUAdnFoZFh2En8P7TqGrOiGrU0FSXutPfvg79k
         6ng+a0xU0Zh35ghwsdw1owyf+TJIkz3kKVz3YQ8B9EUF7j5UlYDsMwNJRFPnFR1Ueskq
         6JuknOTZkJKAGNcto6oEZnaNMFwFnMJ2kN0fKkOTSDFtInADuDjqKHyjWc+0P/WkTYpB
         KL/+VLMfnzIXt617ZC8xe4uwAJPIJwRlHEjJCNyeV+i1fjyZOh1Tj0KHOo7iGrKoX1RZ
         cmnGQXVN42hWaIQ08GSi8HMbGh0l0l322on5IfV/fKNHDPGdmGU5QOYVs1oboShdrEI1
         5i7A==
X-Received: by 10.50.108.102 with SMTP id hj6mr1061525igb.39.1435165534875;
        Wed, 24 Jun 2015 10:05:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1c05:dbc5:2f2f:d033])
        by mx.google.com with ESMTPSA id y124sm17663594iod.13.2015.06.24.10.05.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Jun 2015 10:05:33 -0700 (PDT)
In-Reply-To: <CACsJy8Ap4uNi3gXV8Y+S18xtLaZ1R6DscEf7wJKjt59ZLOAJ5Q@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 24 Jun 2015 17:11:37 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272566>

Duy Nguyen <pclouds@gmail.com> writes:

> Take checkout for example, when you do "git checkout -- foo" where foo
> is i-t-a, the file foo on disk will be emptied because the SHA-1 in
> the i-t-a entry is an empty blob, mostly to help "git diff". I think
> it should behave as if foo is not i-t-a: checkout should error out
> about not matching pathspec, or at least not destroy "foo" on disk. To
> me, when "ce" is an i-t-a entry, only i-t-a flag and ce_name are
> valid, the rest of "ce" should never be accessed.
>
> blame.c's situation is close to check_preimage() where it may read
> zero from ce_mode. It may be ok for check_preimage() to take zero as
> mode, but I think this is like fixed size buffer vs strbuf again. It
> works now, but if the code is reorganized or refactored, then it may
> or may not work. Better be safe than sorry and avoid reading something
> we should not read in the first place.

All of the above say there _are_ some codepaths that want to treat
the existence of a path in the index not as <exists, does not exist>
boolean but as <exists, i-t-a, does not exist> tristate.  I do not
think we disagree on that.

But that is different from saying that it is always OK to treat
i-t-a entries the same way as "does not exist" non-entries.

Internal "diff-index --cached" is used for another reason you did
not mention (and scripted Porcelains literally use that externally
for the same reason).  When we start a mergy operation, we say it is
OK if the working tree has local changes relative to the index, but
we require the index does not have any modifications since the HEAD
was read.

	Side note: some codepaths insist that "diff-index --cached"
        and "diff-files" are both clean, so d95d728a is harmless;
        the former may say "clean" on i-t-a entries more than
        before, but the latter will still catch the difference
        between the index and the working tree and stop the caller
        from going forward.

With d95d728a (diff-lib.c: adjust position of i-t-a entries in diff,
2015-03-16)'s world view, an empty output from "diff-index --cached"
no longer means that.  Entries added with any "git add -N" are not
reported, so we would go ahead to record the merge result on top of
that "half-dirty" index.

	Side note: a merge based on unpack-trees has an extra layer
	of safety that unpack_trees() does not ignore i-t-a entry as
	"not exist (yet)" and notices that the path does exist in
	the index but not in HEAD.  But that just shows that some
	parts of the world do need to consider that having an i-t-a
	in the index makes it different from HEAD.

If the mergy operation goes without any conflict, the next thing we
do typically is to write the index out as a tree (to record in a new
commit, etc.) and we are OK only in that particular case, because
i-t-a entries are ignored.  But what would happen when the mergy
operation conflicts?  I haven't thought about that fully, but I
doubt it is a safe thing to do in general.

But that is just one example that there are also other codepaths
that do not want to be fooled into thinking that i-t-a entries do
not exist in the index at all.

All we learned from the above discussion is that unconditionally
declaring that adding i-t-a entries to the index without doing
anything else should keep the index compare the same to HEAD.

If d95d728a were only about what wt_status.c sees (and gets reported
in "git status" output), which was what the change wanted to address
anyway, we didn't have to have this discussion.  Without realizing
that two kinds of callers want different view out of "diff-index
--cached" and "diff-files", we broke half the world by changing the
world order unconditionally for everybody, I am afraid.

Perhaps a good and safe way forward to resurrect what d95d728a
wanted to do is to first add an option to tell run_diff_index() and
run_diff_files() which behaviour the caller wants to see, add that
only to the caller in wt-status.c?  Then incrementally pass that
option from more callsites that we are absolutely certain that want
this different worldview with respect to i-t-a?
