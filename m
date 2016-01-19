From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git filter-branch not removing commits when it should in 2.7.0
Date: Tue, 19 Jan 2016 13:35:25 -0800
Message-ID: <xmqq7fj59rs2.fsf@gitster.mtv.corp.google.com>
References: <AF975DD2-988F-47A8-BFC3-3BBC27419305@wolfram.com>
	<xmqqbn8h9squ.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, John Fultz <jfultz@wolfram.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 19 22:35:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLdwD-0003Vt-7Z
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 22:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757600AbcASVfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 16:35:34 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58705 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754656AbcASVf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 16:35:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EBE6F3DFEC;
	Tue, 19 Jan 2016 16:35:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/kvWFTmvsqtNrRThRL1QkfAnTkU=; b=jXLGxU
	3ztrTJT7cuIs9XBsx3VSh+LPqcN6AKHgQ9bzLyJQYrrQ5R65VA5x8LN7xz9ybDUo
	f0wme7XqmnWia+huFaT6zKKdF8DSRCw5WhCvKu8FqIJzrfeON6Wmx3CF3IOrfMlu
	v4HrHKfSHVFU+bZJJkch2OHx92RUQf5zKaiPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z4MBh6CQmsfkfbPG05thPp229OjcK+JC
	x6jRgRjaTWe00Blk0enqVq/T218OkDsicBWxFT93AIFnuIYANgngnTJZIJZ/q8U5
	a6/2TJN5jh5REKAcoqihV1ZD+XAOZ13Yhbyex2hbSyflVt56l54hcpuV0YBwIY4w
	zTp1Uq2DYrk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E1EC33DFEB;
	Tue, 19 Jan 2016 16:35:27 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 569563DFEA;
	Tue, 19 Jan 2016 16:35:27 -0500 (EST)
In-Reply-To: <xmqqbn8h9squ.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 19 Jan 2016 13:14:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8E521894-BEF4-11E5-A5FF-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284380>

Junio C Hamano <gitster@pobox.com> writes:

> John Fultz <jfultz@wolfram.com> writes:
>
>> This seems to be a 2.7.0 regression in filter-branch.  The bug is reproducible on Mac/Windows (haven't tried Linux) in the 2.7.0 production releases.
>>
>> Make an empty repo and put an empty commit in the history.  E.g.,
>>
>> echo > foo && git add . && git commit -m "commit 1" && git commit --allow-empty -m "commit 2"
>>
>> Now try to use filter-branch to remove the empty commit.  Both of the following methods leave master unchanged, but both worked in 2.6.4:
>>
>> git filter-branch --prune-empty
>> git filter-branch --commit-filter 'git_commit_non_empty_tree "$@"'
>
> Thanks.
>
> Since there were only 5 changes to git-filter-branch.sh between
> v2.6.0 and v2.7.0, it was fairly easy to pinpoint.
>
> Reverting the following commit from v2.7.0 seems to give the same
> result as v2.6.0 for "--prune-empty" experiment.
>
> commit 348d4f2fc5d3c4f7ba47079b96676b4e2dd831fc
> Author: Jeff King <peff@peff.net>
> Date:   Fri Nov 6 01:24:29 2015 -0500
>
>     filter-branch: skip index read/write when possible
>     
>     If the user specifies an index filter but not a tree filter,
>     filter-branch cleverly avoids checking out the tree
>     entirely. But we don't do the next level of optimization: if
>     you have no index or tree filter, we do not need to read the
>     index at all.
>     
>     This can greatly speed up cases where we are only changing
>     the commit objects (e.g., cementing a graft into place).
>     Here are numbers from the newly-added perf test:
>     
>       Test                  HEAD^              HEAD
>       ---------------------------------------------------------------
>       7000.2: noop filter   13.81(4.95+0.83)   5.43(0.42+0.43) -60.7%
>     
>     Signed-off-by: Jeff King <peff@peff.net>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

OK, is this because git_commit_non_empty_tree() does this to decide
that it should skip the commit:

git_commit_non_empty_tree()
{
        if test $# = 3 && test "$1" = $(git rev-parse "$3^{tree}");
        then
                map "$3"
        else
                git commit-tree "$@"
        fi
}

where its parameters when --prune-empty is in use (or when the
function is used as the commit-filter), $1 is "$tree", $2 and $3 are
"-p" and its sole commit object name $commit (which is read from the
revs file, which is an output from rev-list, so it is known to be
40-hex) and tree after the said patch is computed like so:

        if test -n "$need_index"
        then
                tree=$(git write-tree)
        else
                tree="$commit^{tree}"
        fi

i.e. the helper does textual comparison between "$FOURTY_HEX^{tree}"
and 40-hex from rev-parse "$3^{tree}"?

In other words, would the fix be a one-liner like this?

 git-filter-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 98f1779..86b2ff1 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -404,7 +404,7 @@ while read commit parents; do
 	then
 		tree=$(git write-tree)
 	else
-		tree="$commit^{tree}"
+		tree=$(git rev-parse "$commit^{tree}")
 	fi
 	workdir=$workdir @SHELL_PATH@ -c "$filter_commit" "git commit-tree" \
 		"$tree" $parentstr < ../message > ../map/$commit ||
