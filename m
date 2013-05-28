From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] difftool --dir-diff: always use identical working tree file
Date: Tue, 28 May 2013 11:57:08 -0700
Message-ID: <7v7gij0w6z.fsf@alter.siamese.dyndns.org>
References: <20130526154429.GK27005@serenity.lan>
	<1369668697-1016-1-git-send-email-nitoyon@gmail.com>
	<7vbo7v0yju.fsf@alter.siamese.dyndns.org>
	<20130528181525.GA17475@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kenichi Saita <nitoyon@gmail.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue May 28 20:57:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhP5B-0003CQ-7P
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 20:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363Ab3E1S5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 14:57:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53304 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753233Ab3E1S5L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 14:57:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E53B0232AC;
	Tue, 28 May 2013 18:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/gfJNgLqManRHVbrBWxXUZ9TO5M=; b=psE8PI
	gJJPU5l0zeHB58z30QkYVs9n7nmQdw7nj8Hnmk/naga33f4IfEtxl/ZyW2DjXYvq
	TuDT/fXsYAIDw8ZtIRetsLUuGTXCTMJGjTtsKcx7iBIx+Ew8UnWKWLf/Fuq9dhI4
	l+Zdbtoy+0ho+ZQxwQMdqtoTklwrHbZz4Nvew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CuZKD83+bFFSui6SZPR3IeDAMOBgdwaX
	ItJVDk9CHaQPDssiVDf18sW+lDuKw2nswFlGI6uHMOJdb7arTjQ/L3BIXN6DZ0zC
	6Gyx21h1hj/UTB1l8HvaDY/0Jh44rBS7KM0q8MTPNSZI2/H9iyY69PD3mb20IvdS
	LbMs0YHZt0I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8414232AB;
	Tue, 28 May 2013 18:57:10 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 857F1232A6;
	Tue, 28 May 2013 18:57:09 +0000 (UTC)
In-Reply-To: <20130528181525.GA17475@serenity.lan> (John Keeping's message of
	"Tue, 28 May 2013 19:15:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6623C8CA-C7C8-11E2-9311-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225680>

John Keeping <john@keeping.me.uk> writes:

> Yeah, the commit message is still quite focused on the end effect of
> copying files back.  But that's not what's being changed here.
>
> In my suggested commit message I tried to make it clear that we're
> changing when we decide to copy a file across to the temporary tree.
> This has the beneficial (side-)effect of changing the set of files we
> consider for copying back into the working tree after the diff tool has
> been run.

I actually think the effect of copying files back _is_ the primary
motivation of this change, and stressing that end effect is a much
better description.  After all, if the working tree files do not
have any difference from the RHS of the comparison, copying from the
working tree and stuffing the $rsha1 to the RHS temporary index and
running "checkout -f" should produce identical temporary directory
for the user to start viewing.

The _only_ difference in behaviour before and after this patch that
matters to the end user is if that path is in @working_tree, which
is returned to @worktree of dir_diff sub to be later copied back,
no?  I would view this change as a mere means, an implementation
detail, to achieve that end of stuffing more paths in the @worktree
array.

Perhaps

	difftool --dir-diff: allow changing any clean working tree file

	The temporary directory prepared by "difftool --dir-diff" to
	show the result of a change can be modified by the user via
	the tree diff program, and we try hard not to lose changes
	to them after tree diff program returns to us.

        However, the set of files to be copied back is computed
	differently between --symlinks and --no-symlinks modes.  The
	former checks all paths that start out as identical to the
	working tree file, while the latter checks paths that
	already had a local modification in the working tree,
	allowing changes made in the tree diff program to paths that
	did not have any local change to be lost.

or something.  This invites a few questions, though.

 - By allowing these files in the temporary directory to be
   modified, aren't we making the user's life harder by forcing them
   to handle "working tree file was already modified, made different
   changes in the temporary directory, now these changes need to be
   consolidated" case?

 - When comparing two revisions, e.g. "--dir-diff HEAD^^ HEAD^",
   that checks out (via $rsha1 to "checkout -f" codepath) a blob
   that does not match what is in the working tree of HEAD to the
   temporary directory, we still allow modifications to the copy in
   the temporary directory, but what can the user do with these
   changes that are _not_ based on HEAD, short of checking out HEAD^
   and apply the difference first?

I still cannot shake this nagging feeling that giving a writable
temporary directory might have been a mistake in the first place.
Perhaps it may be a better design to make the ones that the user
shouldn't touch (or will lead to the above confusion) read-only,
while the ones that match the working tree read-write?
