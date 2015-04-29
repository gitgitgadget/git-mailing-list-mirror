From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/15] Teach "git merge FETCH_HEAD" octopus merges
Date: Wed, 29 Apr 2015 14:29:18 -0700
Message-ID: <1430342973-30344-1-git-send-email-gitster@pobox.com>
References: <1430025967-24479-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 23:29:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZY5-0006In-1X
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbbD2V3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:29:36 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57303 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750710AbbD2V3f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:29:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B1F2C4DA8C;
	Wed, 29 Apr 2015 17:29:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=6ftH
	rwPiee/uIkeQm8QkByHJASE=; b=R6+dN2j4CdVsqOlkFoacDrLsKhD03bP9FPXb
	UtoCfXzdb+J7DG0rC3+JWVbOTxwZIYUOorbZ83/ckHGHbtCrTaQgmxu39/vOkWrS
	uy4i11CmWaWk5bgKnfk1i4/RaIdlnwlaPHuddPp4Xv+bWGeMYYHYClTKxG+JLybO
	MbviNZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=TbcMDU
	L9eebbl2ERhtIZjNWNuh65tPVBEUkbJ0xJ4rYvFYfQskdDiriTfTh9cd9Tdy5iM3
	tZg0WKq8wkq7jwCdkbXAjJ3/mowHm6W9ovu/byw/Vu79W7CCNjN5U1U2XnLItkko
	szkQQ5bgL3s3Qx4MoI7HW2gg87X6+DemIPLFA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ABC8B4DA8B;
	Wed, 29 Apr 2015 17:29:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C7AC4DA89;
	Wed, 29 Apr 2015 17:29:34 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-300-g052d062
In-Reply-To: <1430025967-24479-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D457C33E-EEB6-11E4-AD67-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268011>

This series is an attempt to make these two operations truly equivalent:

    $ git pull . topic-a topic-b...

    $ git fetch . topic-a topic-b...
    $ git merge FETCH_HEAD

Compared to the previous one ($gmane/267809), there are only a few
minor changes:

 - The first patch is new; it adds tests to illustrate what the
   current code does.  Accordingly, the penultimate patch is the
   same as the previous, but updates the tests that expect failure
   in this step to expect success.

 - One step failed to compile (the offending code was removed in a
   later patch and the endgame did not break the build), which has
   been corrected.

Junio C Hamano (15):
  merge: test the top-level merge driver
  merge: simplify code flow
  t5520: style fixes
  t5520: test pulling an octopus into an unborn branch
  merge: clarify "pulling into void" special case
  merge: do not check argc to determine number of remote heads
  merge: small leakfix and code simplification
  merge: clarify collect_parents() logic
  merge: split reduce_parents() out of collect_parents()
  merge: narrow scope of merge_names
  merge: extract prepare_merge_message() logic out
  merge: make collect_parents() auto-generate the merge message
  merge: decide if we auto-generate the message early in collect_parents()
  merge: handle FETCH_HEAD internally
  merge: deprecate 'git merge <message> HEAD <commit>' syntax

 Documentation/git-merge.txt   |   4 +
 builtin/merge.c               | 248 +++++++++++++++++++++++++++---------------
 git-cvsimport.perl            |   2 +-
 git-pull.sh                   |   3 +-
 t/t3033-merge-toplevel.sh     | 136 +++++++++++++++++++++++
 t/t3402-rebase-merge.sh       |   2 +-
 t/t5520-pull.sh               |  31 +++---
 t/t6020-merge-df.sh           |   2 +-
 t/t6021-merge-criss-cross.sh  |   6 +-
 t/t9402-git-cvsserver-refs.sh |   2 +-
 10 files changed, 324 insertions(+), 112 deletions(-)
 create mode 100755 t/t3033-merge-toplevel.sh

-- 
2.4.0-rc3-300-g052d062
