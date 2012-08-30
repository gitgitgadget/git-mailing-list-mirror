From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] "merge-base" updates
Date: Thu, 30 Aug 2012 16:13:04 -0700
Message-ID: <1346368388-23576-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 01:13:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7DvQ-00075a-US
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 01:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685Ab2H3XNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 19:13:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40747 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541Ab2H3XNL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 19:13:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22EAB8CE5
	for <git@vger.kernel.org>; Thu, 30 Aug 2012 19:13:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=xTYwjdlgALB94JZ/bTdyTgz88w8
	=; b=VpMzjtN1cP6pgEoKhgyidr0jL+S+DTkcAr/nQWqrAabMemH5xaArD1fm+BT
	RHHIM8/OsqKkWHsB378zJF2PIVe0auSc8oo7WAla0kl/9K+c10Dss8AabkvckgK1
	sg+5WIdDGzbsg4S1eoqZIp5im72oMgFE29wYiWo9TduNu+PE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=XcyWn2QXg1NnlttoF+8JsIXlipv+R
	9TNNs6i2h+f/92iayRmrdY2HNQfV3s+Xnx+SMU+ki78I+1efh7G6VTtWiH8U8Dav
	6Ppor7l/zPnFIGdywZ8omhBEpMtdI1Hn+hrZ5RjrmmsDl1+pLXuy2hbjZqQDnbQk
	12T5i5HlKFgWCg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 119D88CE4
	for <git@vger.kernel.org>; Thu, 30 Aug 2012 19:13:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 685FF8CE3 for
 <git@vger.kernel.org>; Thu, 30 Aug 2012 19:13:09 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.293.g6aeebca
X-Pobox-Relay-ID: 43653314-F2F8-11E1-9951-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204574>

This replaces the topmost commit from the earlier series that tried
to optimize N*(N-1) loop with N traversals.  With this, running the
following script in the kernel repository:

-- >8 --
#!/bin/sh

git rev-list --committer=torvalds@linux-foundation.org \
    --max-parents=2 --min-parents=2 --parents v3.5..v3.6-rc2 >RL

cmd='
	while read result parent1 parent2
	do
		$GIT merge-base $parent1 $parent2
	done <RL
'

GIT="rungit master" time sh -c "$cmd" >:stock
GIT=../git.git/git time sh -c "$cmd" >:optim
cmp :stock :optim
-- 8< --

shows a slight but measurable boost in the performance of
merge-base itself.

42.45user 3.79system 0:46.62elapsed 99%CPU (0avgtext+0avgdata 408176maxresident)k
0inputs+24outputs (0major+2708085minor)pagefaults 0swaps
39.99user 3.42system 0:43.27elapsed 100%CPU (0avgtext+0avgdata 408192maxresident)k
0inputs+24outputs (0major+2179604minor)pagefaults 0swaps

Junio C Hamano (4):
  merge_bases_many(): split out the logic to paint history
  merge-base: "--is-ancestor A B"
  in_merge_bases(): use paint_down_to_common()
  get_merge_bases_many(): walk from many tips in parallel

 builtin/merge-base.c |  21 ++++++++
 commit.c             | 143 +++++++++++++++++++++++++++++++++------------------
 2 files changed, 114 insertions(+), 50 deletions(-)

-- 
1.7.12.293.g6aeebca
