From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Un-pessimize "diff-index $commit -- $pathspec"
Date: Mon, 29 Aug 2011 14:33:20 -0700
Message-ID: <1314653603-7533-1-git-send-email-gitster@pobox.com>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 23:33:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy9Sa-00085Q-2c
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 23:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895Ab1H2Vd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 17:33:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39594 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754524Ab1H2Vd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 17:33:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B53C647C3;
	Mon, 29 Aug 2011 17:33:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=DNuf
	4TPoZrdUfwytIVon5YiGq4g=; b=DhHiYIWYsK78wXvegMWpljxV6R7eShLt8F3v
	HRFV8lDkV5J5vv2FFVJob2mxxo122jqYjgkAz2u1IFYazw0fo5xUIroBg7YocALk
	wKxL0DF6IIiSOUEEsCNfya10bdQN8z3EgIDKbqs/HRH5+pjZJjcZd0DaqCaigkaU
	sZXarPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	oMzOu+cwHGCHzSEMqAOfEudpfCmyO97glntPr/qwcRyY0YTjiXgM+5/yCf2VMadD
	u+CEo93Ct2J5tjSs2hbe7AHrBG4VQbHTpukfwiIj+C4uz20Qymu00FD/qUN/3SIh
	F3kuLf5VgX8KcdJLcjcH1+Bi04jQFZSko7TcOMOvJqc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA9D947C2;
	Mon, 29 Aug 2011 17:33:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D9D547BF; Mon, 29 Aug 2011
 17:33:25 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.70.g82660
In-Reply-To: <7vty9054qr.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 86F2D9E4-D286-11E0-9A4C-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180358>

"git diff A B -- $pathspec" to compare two tree-ishes knew how to apply
pathspec to avoid opening trees that fall outside the area of interest,
but "git diff A -- $pathspec" used unpack_trees() machinery that was meant
for full-tree merges, and ended up reading the whole tree only to discard
potentially major part of the work it does.

Before and after applying this series, looking for changes in the kernel
repository with a fairly narrow pathspec gets a moderate speeds up.

  (without patch)
  $ /usr/bin/time git diff --raw v2.6.27 -- net/ipv6 >/dev/null
  0.48user 0.05system 0:00.53elapsed 100%CPU (0avgtext+0avgdata 163296maxresident)k
  0inputs+952outputs (0major+11163minor)pagefaults 0swaps

  (with patch)
  $ /usr/bin/time git diff --raw v2.6.27 -- net/ipv6 >/dev/null
  0.01user 0.00system 0:00.02elapsed 104%CPU (0avgtext+0avgdata 43856maxresident)k
  0inputs+24outputs (0major+3688minor)pagefaults 0swaps

Junio C Hamano (3):
  tree-walk: allow pruning with pathspec
  unpack-trees: allow pruning with pathspec
  diff-index: pass pathspec down to unpack-trees machinery

 diff-lib.c     |    1 +
 tree-walk.c    |   39 +++++++++++++++++++++++++++++++++------
 tree-walk.h    |    1 +
 unpack-trees.c |    2 ++
 unpack-trees.h |    1 +
 5 files changed, 38 insertions(+), 6 deletions(-)

-- 
1.7.7.rc0.70.g82660
