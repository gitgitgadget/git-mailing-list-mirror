From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Optimizing "ls-files -k"
Date: Thu, 15 Aug 2013 14:28:07 -0700
Message-ID: <1376602090-19142-1-git-send-email-gitster@pobox.com>
References: <7v8v02rb2g.fsf@alter.siamese.dyndns.org>
Cc: Petr Baudis <pasky@ucw.cz>, Josh Triplett <josh@joshtriplett.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 15 23:28:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA55e-0000ba-Lt
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 23:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336Ab3HOV2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 17:28:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45829 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134Ab3HOV2N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 17:28:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7D18397CD;
	Thu, 15 Aug 2013 21:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=1xX+
	N0kUOfwNrwI0ohPqoAG0lvE=; b=smmGBcFWKV2o281R5D1DOOzc9h11J+gitSaa
	Ud66fwTCutDdR3aTrOijhwjE39OHyItEaYNOR2dYmHVhWodDHUPolLM/tpZLot8W
	qZgZVI1IIlYKFFC238QUScelTUkimctKOEZDaVtEEwIYpWq2rqnpIiJRSb2dubGU
	6YJHAs0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	jKrgD4CGX6KRgcRSXvgxQj6LWLjU+DQ1TX9ckVBqvlk8Ioz0RR1+ZHk7KHNMjrN9
	CbuvwpJwjs9g9xxOpGPzohv4yAgES0KPoY16hfY/AM2TjVfgb5cfav90IDCrER4x
	FdvTXhhPPmVOUYHTgWDIU/pTyJbgh/E3o8eC6U9cV5A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DDE1397CC;
	Thu, 15 Aug 2013 21:28:12 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6B92397CA;
	Thu, 15 Aug 2013 21:28:11 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc3-232-ga8053f8
In-Reply-To: <7v8v02rb2g.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 965899E6-05F1-11E3-B3DB-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232370>

"ls-files -o" and "ls-files -k" both traverse the working tree down
to find either all untracked paths or those that will be "killed"
(removed from the working tree to make room) when the paths recorded
in the index are checked out.

It is necessary to traverse the working tree fully when enumerating
all the "other" paths, but when we are only interested in "killed"
paths, we can take advantage of the fact that paths that do not
overlap with entries in the index can never be killed.

The first one is an independent clean-up.  No public API in the
working tree traversal takes alternate in-core index, so there is no
reason to explicitly use the_index and index_* functions from the
in-core index API.

The second one is rerolled from the "something like this" patch I
sent earlier, but corrects the "we see a directory, it is not in the
index, but a file in it is" case.

And the third one adds a testcase that illustrates why the earlier
"something like this" patch is not sufficient.

These are designed to apply on top of v1.8.3, and needs a bit of
conflict resolution for the upcoming v1.8.4 codebase; I'll queue
them in 'pu' for now.

Note that t3010, especially after merged to 'pu', will use many
different ways to create a test file.  Some redirect "date" into it,
some redirect ":" into it, some "touch" it, and some just redirect
with no command.

	date >file1
	: >file2
	touch file3
	>file4

We should consolidate them all to just do ">file4" after making sure
the contents do not matter (we kind of know it already, as "date"
will output string that is not repeatable).  Use of "touch" for
anything other than updating the timestamp is especially bad, as it
is misleading.

Junio C Hamano (3):
  dir.c: use the cache_* macro to access the current index
  ls-files -k: a directory only can be killed if the index has a non-directory
  t3010: update to demonstrate "ls-files -k" optimization pitfalls

 builtin/ls-files.c                  |  2 ++
 dir.c                               | 40 +++++++++++++++++++++++++++++--------
 dir.h                               |  3 ++-
 t/t3010-ls-files-killed-modified.sh | 12 ++++++++---
 4 files changed, 45 insertions(+), 12 deletions(-)

-- 
1.8.4-rc3-232-ga8053f8
