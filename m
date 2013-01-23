From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/3] Finishing touches to "push" advises
Date: Wed, 23 Jan 2013 13:55:27 -0800
Message-ID: <1358978130-12216-1-git-send-email-gitster@pobox.com>
References: <20130121234002.GE17156@sigill.intra.peff.net>
Cc: Jeff King <peff@peff.net>, Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 22:55:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty8IV-0002g4-2V
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 22:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033Ab3AWVze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 16:55:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42276 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143Ab3AWVzd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 16:55:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F986B7CD;
	Wed, 23 Jan 2013 16:55:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ug+F
	+usXlA0YA0fhqeoNWWGtY40=; b=EQaGEvu8+xYXJovWSUcRezuf10rLaNbr33QR
	YINqClszwvhXajI1hgdod01OwdmwHJ4XnN+FnIffWes91p3nsSy0UPkS5drkciEk
	XIqvXc29fdfyZbuOWq1/iWbUciXircjBAsPyR8QOT6M3IlmpbuBqLlgVqqxI1o6G
	0zg6NxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	JcfO7/f+2oJ6QjNSxl+4up8e5LZhjTia1Q1R4apE6T9besnG5CS26zXZ7uENgqja
	QLWJPHNOicBycCVrwp+G85rQAq8eJql/OElVsYW8t1AWqDnVBjYL6wWjvGVICY/c
	CS8Czbo3ArrvddJMU7SITI+tYACaMw4OQnhMXEo3qYo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65326B7CC;
	Wed, 23 Jan 2013 16:55:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6A24B7CA; Wed, 23 Jan 2013
 16:55:31 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.g0318d2b
In-Reply-To: <20130121234002.GE17156@sigill.intra.peff.net>
X-Pobox-Relay-ID: 9BA14744-65A7-11E2-99F8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214368>

This builds on Chris Rorvick's earlier effort to forbid unforced
updates to refs/tags/ hierarchy and giving sensible error and advise
messages for that case (we are not rejecting such a push due to fast
forwardness, and suggesting to fetch and integrate before pushing
again does not make sense).

The series applies on top of 256b9d7 (push: fix "refs/tags/
hierarchy cannot be updated without --force", 2013-01-16).

This fourth round swaps the order of clean-up patches and now the
bottom two are clean-up patches.  The main change is in the third
one.

When the object at the tip of the remote is not a committish, or the
object we are pushing is not a committish, the existing code already
rejects such a push on the client end, but we used the same error
and advice messages as the ones used when rejecting a push that does
not fast-forward, i.e. pull from there and integrate before pushing
again.  Introduce a new rejection reason NEEDS_FORCE and explain why
the push was rejected, stressing the fact that --force is required
when non committish objects are involved, so that the user can (1)
notice a possibly mistyped source object name or destination ref
name, when the user is trying to push an ordinary commit, or (2)
learn that "--force" is an appropriate thing to use when the user is
sure that s/he wants to push a non-committish (which is unusual).

Unlike the third round, we do not say "fetch first, inspect the
situation to decide what to do", when we do not have the object
sitting at the tip of the remote.  Most likely, it is a commit
somebody who has been working on the same branch pushed that we
haven't fetched yet, so suggesting to pull is often sufficient and
appropriate, and in a more uncommon case in which the unknown object
is not a committish, the suggested pull will fail without making
permanent damage anywhere.  Next atttempt to push without changing
anything (e.g. "reset --hard") will then trigger the NEEDS_FORCE
"Your push involves non-commit objects" case.


Junio C Hamano (3):
  push: further clean up fields of "struct ref"
  push: further simplify the logic to assign rejection reason
  push: introduce REJECT_FETCH_FIRST and REJECT_NEEDS_FORCE

 Documentation/config.txt | 12 +++++++++++-
 advice.c                 |  4 ++++
 advice.h                 |  2 ++
 builtin/push.c           | 29 +++++++++++++++++++++++++++++
 builtin/send-pack.c      | 10 ++++++++++
 cache.h                  |  6 +++---
 remote.c                 | 42 +++++++++++++++++++-----------------------
 send-pack.c              |  2 ++
 transport-helper.c       | 10 ++++++++++
 transport.c              | 14 +++++++++++++-
 transport.h              |  2 ++
 11 files changed, 105 insertions(+), 28 deletions(-)

-- 
1.8.1.1.517.g0318d2b
