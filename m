From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [long] worktree setup cases
Date: Wed, 20 Oct 2010 14:00:45 -0700
Message-ID: <7v8w1svate.fsf@alter.siamese.dyndns.org>
References: <20101020085859.GA13135@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Niedier <jrnieder@gmail.com>, git@vger.kernel.org,
	fbriere@fbriere.net, drizzd@aon.at, 575917@bugs.debian.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 23:01:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8fmX-0008L3-OC
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 23:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754994Ab0JTVBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 17:01:03 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43275 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562Ab0JTVBC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 17:01:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E5C5ADC685;
	Wed, 20 Oct 2010 17:01:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H6kTa5e4JydEJWv44yhnOfLSJY8=; b=PEnJl8
	02ZvYPKlmQaODSg9Zk4xfzheVE757Qu+XogoL2XBTaZJKAxx6WcPb9NR3II/1Xjs
	eLTdtphzGix/bZuT/upzZQrSF6sbjC7nvErCYBHN/ExaHaTsqgAXNT9ep7S5SHt0
	vAmrgM+Lm4BG1PPtAzm4fRNlu/ujakpFvgzV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i1ileCCUQU3gBDIHiBl8nDMGfhS1arkm
	gCuwgglNGNCbnxQ+hlDVfilnmj0K3oXwfd9zqv62Azh9tjCtIHnmCKuQxIDmeIDV
	CTOXEAG4AibRN2CJo2VIAXvfL3b3j+thkInOYclz2uEXF3MG/K4apoTtvBIRv/5S
	o3mHoWrv1XA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BAC5DC67C;
	Wed, 20 Oct 2010 17:00:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE673DC675; Wed, 20 Oct
 2010 17:00:46 -0400 (EDT)
In-Reply-To: <20101020085859.GA13135@do> (Nguyen Thai Ngoc Duy's message of
 "Wed\, 20 Oct 2010 15\:59\:00 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 20E3AF74-DC8D-11DF-AB04-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159439>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Assumptions:
>
> 1. When .git is a file and contains a relative path, I assume it is
>    relative to .git file's parent directory.  read_gitfile_gently()
>    function will make the path absolute, but it depends on (maybe
>    wrong) cwd.

Ok.  I agree that a regular file .git that has "gitdir: ../there" in it
should be naming "there" directory next to the directory .git lives in.
It is insane for it to take $(cwd) into account.

> There are a few factors that affect gitdir/worktree/cwd/prefix setup.
> Those are:
>
>  - GIT_DIR (or --git-dir)
>  - GIT_WORK_TREE (or --work-tree)
>  - core.worktree
>  - .git is a file pointing to real .git directory
>  - Bare repo
>
> So there are 2^5 = 32 cases in total.

Hmm, why is core.worktree separate from the second item?  In any case, the
three mechanisms to specify the working tree should only be in effect when
GIT_DIR/--git-dir is used, so the above are not orthogonal, and the total
count should be smaller than 32 cases.

> The following questions must be answered for each case:
>
> 0. What setup function handles that case?
> 1. Is worktree available?
> 2. Where is new cwd? Is it at worktree root?
> 3. Prefix?
> 4. Is (relative) $GIT_DIR accessible from current cwd?
> 5. What if original cwd is outside worktree, or new cwd if it's not at
>    worktree root?

All good questions to ask, except for the last one which I cannot quite
parse.

> Table of Contents
> =================
> 1 Cases
>     1.1 Case 0, 8
>     1.2 Case 1, 4, 5, 9, 12, 13
>         1.2.1 cwd outside worktree
>     1.3 Case 2, 10
>     1.4 Case 3, 6, 7, 11, 14, 15
>         1.4.1 cwd outside worktree
>     1.5 Case 16, 24
>     1.6 Case 17, 20, 21, 25, 28, 29
>         1.6.1 cwd outside worktree
>     1.7 Case 18, 26
>     1.8 Case 19, 22, 23, 27, 30, 31
>
>
> 1 Cases
> ~~~~~~~~
>
> Case#  Bare  .git-file  core.worktree  GIT_DIR  GIT_WORK_TREE
> 0      0     0          0              0        0
> 8      0     1          0              0        0

Ok.

> 1      0     0          0              0        1
> 4      0     0          1              0        0
> 5      0     0          1              0        1
> 9      0     1          0              0        1
> 12     0     1          1              0        0
> 13     0     1          1              0        1

How does it make sense to have GIT_WORK_TREE without GIT_DIR?  Without
GIT_DIR, we will run repository discovery, which means we will always go
up to find a .git dir, and the reason for doing that is because we want to
also work in a subdirectory of a working tree (the very original git never
worked from anywhere other than the root level of the working tree).  By
definition, the root of the working tree is the same as in cases 0/8.

> 2      0     0          0              1        0
> 10     0     1          0              1        0

If you set GIT_DIR, we do no discovery, so git will work only from the
root level of the working tree (or bare repository operation) if you do
not tell us where the working tree is.

> 3      0     0          0              1        1
> 6      0     0          1              1        0
> 7      0     0          1              1        1
> 11     0     1          0              1        1
> 14     0     1          1              1        0
> 15     0     1          1              1        1

Without discovery, we know where the root level of the working tree is,
and we know where the repository is, because you told us.  The answers to
questions 1-5, i.e. semantics observable by the end user, should be the
same as case 0/8 even though the internal codepath to achieve that,
i.e. question 0, may be different.

> 16     1     0          0              0        0
> ...
> 31     1     1          1              1        1

Shouldn't all of these 16 be the same, if the repository is bare?  What is
your definition of bareness?  core.bare?  In any case we should say "you
are using a bare repository, there is no working tree" and cwd shouldn't
change in these cases.  They are all bare and there is no working tree.

Alternatively, you could give precedence to core.worktree and friends, in
which case these can go to the other categories in your description,
ignoring core.bare settings.  For example, 31 explicitly specifies where
the .git directory and the working tree are, which would fall into the
same category as 3,6,7,11,14,15.

Either way is fine.

> 1.1 Case 0, 8
> ==============
>
> The most used case, nothing special is set.
>
> 0. setup_discovered_git_dir()
> 1. work tree is .git dir's parent directory
> 2. cwd is at worktree root, i.e. .git dir's parent dir
> 3. prefix is calculated from original cwd
> 4. git_dir is set to ".git" (#0) or according to .git file, made
>    absolute (#8)
> 5. N/A
>
> TODO: turn git_dir to relative in #8

Ok.

> 1.2 Case 1, 4, 5, 9, 12, 13

As I said already, isn't this a nonsense combination you should error out?

> 1.3 Case 2, 10
> ===============
>
> 0. setup_explicit_git_dir()
> 1. worktree is set at cwd for legacy reason
> 2. cwd is unchanged
> 3. prefix is NULL
> 4. git_dir is set according to GIT_DIR (#2) or according to .git file,
>    made absolute (#10)
>
> TODO: turn git_dir to relative path
>
> Note on #10: setup_git_env() is used to read .git file

Ok.

> 1.4 Case 3, 6, 7, 11, 14, 15
> =============================
>
> Another normal case where worktree is at an unsual case.
>
> 0. setup_explicit_git_dir()
> 1. worktree is set according to GIT_WORK_TREE (#3, #7, #11, #15) or
>    core.worktree (#6, #14)
> 2. cwd is moved to worktree root dir if original cwd is inside
>    worktree
> 3. prefix is calculated if original cwd is inside worktree
> 4. git_dir is set to GIT_DIR (#3, #6, #7) or according to .git file,
>    made absolute (#11, #14, #15)
>
> TODO: if GIT_DIR is relative, it is assumed relative to original cwd,
> so it breaks because cwd now is changed. Right now this does not
> happen because git_dir is turned absolute. Although it's better to be
> relative.
>
> TODO: turn git_dir to relative in #11, #14, #15
>
> FIXME on #11, #14, #15: setup_git_env() is used to read .git file. cwd
> by that time is worktree root, not .git's parent dir anymore.

Ok.

> 1.4.1 cwd outside worktree
> ---------------------------
>
> cwd is left unchanged, prefix is NULL, which is sensible for full tree
> operations. is_inside_work_tree() returns 0, operations that require
> worktree should check and error out.
>
> TODO: File path output however may not be what user expected because
> it will be relative to worktree root, not original cwd.

This is operating out of bounds of the original design criteria; we
probably do not error out now, which is an original bug, but I understand
that you are trying to enhance this to reach into a submodule repository
and its working tree from its superproject.  As long as we can make such
an enhancement in a way that produces sensible and consistent output, that
kind of change would be fine.

I suspect that you would need to pass in "make the path relative to this"
using some means that do not exist in the current structure of the code.

Also I suspect that for the purpose of your enhancement, the first three
lines of this paragraph would not be true.  Think of a case where you are
at the superproject level and running a recursive grep into its submodule
at "nitfol", that has contents recorded at the path "xyzzy/frotz.txt".

If you keep cwd unchanged, the path appears at nitfol/xyzzy/frotz.txt in
the working tree from the end user's point of view, so you need to pass
"nitfol/" as a different kind of "prefix" that needs to be used to modify
the path recorded in the contents tracked by the submodule.  The grep
running in the submodule will read xyzzy/frotz.txt from the index (which
is how it notices which paths are of interest), use the "nitfol/" prefix
to turn it into a path in the working tree, read from that file and report
hits.  This is an example of an operation that clearly require a working
tree, and does not have to error out.

Alternatively, if you move cwd to the top of the working tree of the
submodule, you would still need to pass "nitfol/" prefix, but it needs to
be used only in the output phase.  The grep running in the submodule will
read xyzzy/frotz.txt from the index (which is how it notices which paths
are of interest), read from the file in the working tree (relative to cwd
which now is at the root level of the submodule), and use "nitfol/" as
output prefix when reporting.
