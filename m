From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/48] Handling more corner cases in merge-recursive.c
Date: Wed, 03 Aug 2011 17:20:48 -0700
Message-ID: <7v4o1y81sv.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 02:20:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QolgH-0000J1-7m
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 02:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756043Ab1HDAUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 20:20:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59475 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756031Ab1HDAUu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 20:20:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C8CF5D26;
	Wed,  3 Aug 2011 20:20:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=yInKVdrT949p7SA8766KKnwQT7c=; b=F3IihlP5oMZxHD1eeR0t
	uNWaexM97hwqYB84DfvHUhitktuxUdnNF0rDbXhZrlZhD9r2Yt0HNT/6+Uh546DT
	fu0E5eb4RwkOaUvvWbCx9P8rHlvVh7rNrZXbv2eAMG6JCJJTIDmbOwtKd771B76m
	2OR9GHfU/N2qEpnbHrHlyH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=aVpLGRGrK8r8uLYmSCcLiLa81/uqwKOfpafG1UINtJZTfY
	1PYJe7KjZk05DmM44l8mp93BZOn4wKIF94JbDS1lqE8uWMp/+DJK+QYxwZlTGrXI
	u2ELO2IY6xLrnvuaoyAh2Uszmqbt9b2JiQAxPYIGIek/SYAQT/nKicGpTuAvo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0345B5D25;
	Wed,  3 Aug 2011 20:20:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B4CB5D24; Wed,  3 Aug 2011
 20:20:49 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B02ACCC-BE2F-11E0-978C-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178645>

Unfortunately I seem to have found a regression that manifests in the real
life.

When this series is merged to 'next', it mismerges a trivial renamed path.
A sample commit to reproduce is 2d11f21c3, which is a merge between
28b9264dd6 and 5b42477b59.  Check out the former and try to merge in the
latter.

The merge base of these two commits is 2cfe8a68ccb (no criss-cross).

One branch (current one, 28b9264dd6) does not have that path, but it does
have t/t4037-whitespace-status.sh:

    $ git ls-tree 28b9264dd6 t/t4037-whitespace-status.sh
    100755 blob 3c728a3ebf9ce52e5c24c81525d5cb749cfb2957 t/t4037-whitespace-status.sh

What happened to that path on the current branch is this:

    $ git log -m -M --raw --pretty=short 2cfe8a68ccb..28b9264dd6 -- \
      t/t40{37,40}-whitespace-status.sh
    commit af7b41c923677ff9291bab56ec7069922e37453b
    Author: Jeff King <peff@peff.net>

        diff_tree: disable QUICK optimization with diff filter

    :100755 100755 abc4934... 3c728a3... M  t/t4037-whitespace-status.sh

In other words, we had t4037, and we have t4037 but we updated its
contents from abc4934 to 3c728a3.

Running "log -m -M --raw --pretty=short 2cfe8a68ccb..5b42477b59" shows
that the merged branch (5b42477b59) has renamed t4037 to t4040 at
0e098b6d:

    commit 0e098b6d79fbcab763874f2b6fde5aa82144d150
    Author: Johannes Sixt <j6t@kdbg.org>

        Make test case number unique

    :100755 100755 a30b03b... a30b03b... R100 t/t4037-whitespace-status.sh    t/t4040-wh..

This commit is on a side-branch that has not been merged at the merge base
2cfe8a68ccb; its contents a30b03b is older than what 2cfe8a68ccb has, and
was updated by 2cfe8a68ccb to abc4934.

Another merge after this commit updated it at 7d0cf357:

    commit 7d0cf357a31cc8a442342696788d776265482ce9 (from 98b256bd...)
    Merge: 98b256b 2cfe8a6
    Author: Junio C Hamano <gitster@pobox.com>

        Merge branch 'jc/maint-diff-q-filter'

    :100755 100755 a30b03b... abc4934... M  t/t4040-whitespace-status.sh

This abc4934 is the same contents as the merge base had at t4037.

So this is an "our side kept t4037 and updated its contents from abc4934
to 3c728a3, while the other side renamed t4037 to t4040 and kept its
contents as abc4934". We should merge this as structural change "our side
left it untouched, their side renamed, so take the rename without
conflict" and content level change "our side updated but their side left
it untouched, so take our modification without conflict".

In other words, in the result, we should have 3c728a3 at t4040, and that
indeed is what we got in the recorded history:

    $ git ls-tree 2d11f21c3 -- t/t4040-whitespace-status.sh
    100755 blob 3c728a3ebf9ce52e5c24c81525d5cb749cfb2957 t/t4040-whitespace-status.sh

However, the merge retried with this series cleanly resolves the path, but
with wrong contents:

    $ git checkout 28b9264dd6
    $ git merge 5b42477b59
    $ git ls-files -s t/t4040-whitespace-status.sh
    100755 abc49348b196cf0fec232b6f2399356e4fe324d5 0 t/t4040-whitespace-status.sh

Correct answer should be:

    $ git ls-files -s t/t4040-whitespace-status.sh
    100755 3c728a3ebf9ce52e5c24c81525d5cb749cfb2957 0 t/t4040-whitespace-status.sh

I am rewinding today's integration of 'next' to unmerge this topic
now. :-(...
