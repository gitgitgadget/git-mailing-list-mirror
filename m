From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/6] "ls-files -i" not honoring directory wide ignore
Date: Tue,  5 Jun 2012 22:45:13 -0700
Message-ID: <1338961519-30970-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 07:46:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sc94M-0002JF-89
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 07:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753694Ab2FFFpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 01:45:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45555 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753871Ab2FFFpY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 01:45:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 380E05FE9
	for <git@vger.kernel.org>; Wed,  6 Jun 2012 01:45:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=6MA03RPdFnQMytRmxYv+goEtnkc
	=; b=qWLzRAh2l+sXPtDBmRPGj1GpjoNhaWSEkH3KywfSfCzH9euitI3b7/8UUDx
	IjEl0anobLxECTPAiITy2xEGZ0DaJyaiG/LyycyvibxHWI3KUNEP2gn8UwSV73P0
	Fu8x+F9XlD4RT3OrkAVCXt5WO9uRyamIss86uFwjVbJBKCHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=X8dIyKAGEfCAWDURGXskMEsp82UZL
	gMcILslxQMQVhoHPrSyyEYdwylnLPhblNZwxcKXDd7QJRCQq4kzxqd0qPvzj79Sd
	MzJ7P+XUy6WPUJcRRaCznH7Wf/pWcyateB7A3n0LpNKhSSvYS81h6jGDLYg7AXfi
	C99THl17KlAoIA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EE765FE8
	for <git@vger.kernel.org>; Wed,  6 Jun 2012 01:45:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD70E5FE7 for
 <git@vger.kernel.org>; Wed,  6 Jun 2012 01:45:20 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc1.37.g09843ac
X-Pobox-Relay-ID: CD9C061C-AF9A-11E1-83D2-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199303>

"git ls-files --exclude=t -i" does not list anything, even though it
ought to report all the paths that are tracked in the t/ directory.

This is because the command used excluded() API incorrectly. The API
is designed to be called by callers that walk the tree structure
from the top level, checking each and every level as it descends,
and stop descending into a directory that is known to be ignored,
but the caller just passed a full path of a tracked file without
checking its higher level components and asked "Is this ignored?".

This series introduces a new path_excluded() API to be used for such
callers based on the excluded() API.  Also converted to use this new
API are two other callers of the excluded(), namely "git checkout"
and "git add -n --ignore-missing", that shared the same issue.

The third patch is more or less an "Oops, the earlier one was not
ideal" fix-up patch, but as the earlier parts of the series is
already in "next", I'll leave it as-is for now.  It probably is
necessary to squash it into the earlier patches post 1.7.11 after
the "next" branch is rewound.

Junio C Hamano (6):
  ls-files -i: pay attention to exclusion of leading paths
  ls-files -i: micro-optimize path_excluded()
  path_excluded(): update API to less cache-entry centric
  builtin/add.c: use path_excluded()
  unpack-trees.c: use path_excluded() in check_ok_to_remove()
  dir.c: make excluded() file scope static

 builtin/add.c      |  6 +++++-
 builtin/ls-files.c | 23 +++++++++++++++------
 dir.c              | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 dir.h              | 18 +++++++++++++++-
 unpack-trees.c     | 11 +++++++++-
 unpack-trees.h     |  1 +
 6 files changed, 109 insertions(+), 10 deletions(-)

-- 
1.7.11.rc1.37.g09843ac
