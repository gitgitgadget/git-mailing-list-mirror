From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 06/16] t3700: sleep for 1 second, to avoid
 interfering with the racy code
Date: Wed, 08 Aug 2012 13:57:34 -0700
Message-ID: <7vmx25rtj5.fsf@alter.siamese.dyndns.org>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-7-git-send-email-t.gummerer@gmail.com>
 <7vsjc023sr.fsf@alter.siamese.dyndns.org> <20120807165947.GD913@tgummerer>
 <7vr4rhrvfm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pcouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 22:57:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzDK4-0006Di-6s
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 22:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030754Ab2HHU5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 16:57:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42293 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759219Ab2HHU5i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 16:57:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F17C9769;
	Wed,  8 Aug 2012 16:57:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eoMd6FzXVwXQStPeGR/FOQ9fUaU=; b=sN/KX1
	/bjH67Ashx2x8tsPgfr3MilUm8papUSx4JlsfhHSOC1dBZ9YGWA2sr2A6etzE1kw
	IfDmsnDf84NkPFABzDQKYnbaw0dpPYKP79K0WewJTafLdQw7JWd26GwK02cxjjJn
	q7KIejBJL20r51ZaRNSYJnlJi58vAqv4R7HZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sZzN0gdyQ+3j5SVo/L8yu+P9YLaseylc
	Nr652DppB8//3+og1ry/HRgr7WkpWuJ5Y9UNZNe7ADbsVJlxJRivep3SDn5ha2Jb
	83i13H5dmqCVhU65pAewlgdjGt6MzfvweNuX09BMHbi4LIUGXdOI7QGgDXvZgooA
	ECcaFZ9qrCI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B9299768;
	Wed,  8 Aug 2012 16:57:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58E3A9765; Wed,  8 Aug 2012
 16:57:36 -0400 (EDT)
In-Reply-To: <7vr4rhrvfm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 08 Aug 2012 13:16:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AEA00258-E19B-11E1-A0BC-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203130>

Junio C Hamano <gitster@pobox.com> writes:

> So whether done with "sleep" or "test-chmtime", avoiding a racily
> clean situation sounds like sweeping a bug in the v5 code in racy
> situation under the rug to me (unless I am misunderstanding what
> you are doing with this change and in your explanation, or the test
> was checking a wrong thing, that is).
>
> Even more confused....

OK, after staring this test for a long time, and going back to
3d1f148 (refresh_index: do not show unmerged path that is outside
pathspec, 2012-02-17), I give up.

Let me ask the same question in a more direct way.  Which part of
this test break with your series?

        test_expect_success 'git add --refresh with pathspec' '
                git reset --hard &&
                echo >foo && echo >bar && echo >baz &&
                git add foo bar baz && H=$(git rev-parse :foo) && git rm -f foo &&
                echo "100644 $H 3	foo" | git update-index --index-info &&
	# "sleep 1 &&" in the update here ...
                test-chmtime -60 bar baz &&
                >expect &&
                git add --refresh bar >actual &&
                test_cmp expect actual &&

                git diff-files --name-only >actual &&
                ! grep bar actual&&
                grep baz actual
        '

We prepare an index with bunch of paths, we make "foo" unmerged, we
smudge bar and baz stat-dirty, so that "diff-files" would report
them, even though their contents match what is recorded in the
index.

Then we say "git add --refresh bar".  As far as I know, the output
from "git add --refresh <pathspec>" is limited to "foo: needs merge"
if and only if "foo" is covered by <pathspec> and "foo" is unmerged.

	Side note: If "--verbose" is given to the same command, we
	also give "Unstaged changes after refreshing the index:"
	followed by "M foo" or "U foo" if "foo" does not match the
	index but not unmerged, or if "foo" is unmerged, again if
	and only if "foo" is covered by <pathspec>.  But that is not
	how we invoke "git add --refresh" in this test.

So if you are getting a test failure from the test_cmp, wouldn't it
mean that your series broke what 3d1f148 did (namely, make sure we
report only on paths that are covered by <pathspec>, in this case
"bar"), as the contents of "bar" in the working tree matches what is
recorded in the index?

If the failure you are seeing is that "bar" appears in the output of
"git diff-files --name-only", it means that "diff-files" noticed
that "bar" is stat-dirty after "git add --refresh bar".  Wouldn't it
mean that the series broke "git add --refresh bar" in such a way
that it does not to refresh what it was told to refresh?

Another test that could fail after the point you added "sleep 1" is
that the output from "git diff-files --name-only" fails to list
"baz" in its output, but with "test-chmtime -60 bar baz", we made
sure that "bar" and "baz" are stat-dirty, and we only refreshed
"bar" and not "baz".  If that is the case, then would it mean that
the series broke "git add --refresh bar" in such a way that it
refreshes something other than what it was told to refresh?

In any case, having to change this test in any way smells like there
is some breakage in the series; it is not immediately obvious to me
that the current test is checking anything wrong as I suspected in
the earlier message.

So,... I dunno.
