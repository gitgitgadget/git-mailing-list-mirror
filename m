From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/6] "git push --cas/--lockref" renamed to "--force-with-lease"
Date: Mon, 22 Jul 2013 23:43:14 -0700
Message-ID: <1374561800-938-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 23 08:43:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1WJy-0002QK-Ll
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 08:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128Ab3GWGnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 02:43:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45071 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497Ab3GWGnX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 02:43:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C120E249EC
	for <git@vger.kernel.org>; Tue, 23 Jul 2013 06:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=8EJxb9Q2ipo+d0p2zugVRUyX2Vk
	=; b=sXmsA4yu2y3HkzCzv7DCcA7GgS27rzWzz7Nf1ClGKBWF5ZVDJWhd6ef6NX8
	jReP95/aGon2vB2iBpRf0iXQCHNa02OEEeihF4zRKCcWSZuoWuSoTcOSYkk2BpRa
	50Q2q1/D8zhX6vc4SdNXTW6iSIDmG6vTooW0lJF8kAQ7hZVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=XqnFj1tgvfQ+Cwddgn4tTwWlLiBfp
	U4ELBvXKQaalelmQydPWhJJ4Xhsba4Q030ThxUNYj6a4An3nYhKy9ZCW6Q1u3rwy
	K+f6CIUBE1t5igEfhRphYBzfBQW3cnwiwPGF18MKYXnTOYn4nzp0y5n4xJ/s1q66
	FKidASdBmU8fcs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4D6C249EB
	for <git@vger.kernel.org>; Tue, 23 Jul 2013 06:43:22 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17BAB249E7
	for <git@vger.kernel.org>; Tue, 23 Jul 2013 06:43:22 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.4-985-g5661af8
X-Pobox-Relay-ID: 2ADE5D86-F363-11E2-BFBB-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231021>

This is mostly unchanged since the previous round, except that

 * The option is spelled "--force-with-lease=<ref>:<expect>".
   Nobody liked "cas" as it was too technical, many disliked
   "lockref" because "lock" sounded as if push by others were
   excluded by it while in fact this is to fail us.

   The final name implies that it is related to the "--force" that
   breaks the "must fast-forward" safety, but "with-lease" part
   conveys that there is some reservation with the forcing.  The
   observation you make before you start rebasing (or you ensure
   that everything is expendable and decide to delete) is like
   taking a lease on the ref, and as long as the lease is not
   broken by others, you can push a non-fast-forward history to
   replace what is at the remote.

 * The logic to choose default when the option is not given with an
   explicit expected value is still "the remote-tracking branch for
   the ref being updated", but the documentation warns users against
   relying on that semantics, as it was shown to be fragile during
   the discussion, and hopefully we will come up with a better and
   more robust one to replace it.

The first two preparatory patches are the same since v2.  For the
remainder, other than changes necessary to rename the option, the
documentation part of [PATCH 3/6] has been updated to mark forms
without explicit expect value as experimental.

Junio C Hamano (6):
  cache.h: move remote/connect API out of it
  builtin/push.c: use OPT_BOOL, not OPT_BOOLEAN
  remote.c: add command line option parser for "--force-with-lease"
  push --force-with-lease: implement logic to populate old_sha1_expect[]
  push --force-with-lease: tie it all together
  t5533: test "push --force-with-lease"

 Documentation/git-push.txt |  77 +++++++++++++++---
 builtin/fetch-pack.c       |   2 +
 builtin/push.c             |  19 ++++-
 builtin/receive-pack.c     |   1 +
 builtin/send-pack.c        |  26 +++++++
 cache.h                    |  62 ---------------
 connect.c                  |   1 +
 connect.h                  |  13 ++++
 fetch-pack.c               |   1 +
 fetch-pack.h               |   1 +
 refs.c                     |   8 --
 remote.c                   | 175 +++++++++++++++++++++++++++++++++++++----
 remote.h                   |  83 ++++++++++++++++++++
 send-pack.c                |   2 +
 t/t5533-push-cas.sh        | 189 +++++++++++++++++++++++++++++++++++++++++++++
 transport-helper.c         |   6 ++
 transport.c                |  13 ++++
 transport.h                |   5 ++
 upload-pack.c              |   1 +
 19 files changed, 588 insertions(+), 97 deletions(-)
 create mode 100644 connect.h
 create mode 100755 t/t5533-push-cas.sh

-- 
1.8.3.4-980-g8decd39
