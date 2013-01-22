From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Finishing touches to "push" advises
Date: Mon, 21 Jan 2013 22:30:27 -0800
Message-ID: <1358836230-9197-1-git-send-email-gitster@pobox.com>
References: <20130121234002.GE17156@sigill.intra.peff.net>
Cc: Jeff King <peff@peff.net>, Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 22 07:30:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxXNo-00026J-JV
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 07:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003Ab3AVGae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 01:30:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40641 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889Ab3AVGad (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 01:30:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3DDE68EA;
	Tue, 22 Jan 2013 01:30:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Cxk+
	RDBI3ab/AsXmkYr32CPHVy8=; b=qlJhHeXJO+pUstBgOEaBAs+mFKXUrjErvv02
	zNP5CI5AXuNt8k0DkL3vqW5RA4pUxh8l7AIAwIfZMHAHhwuBFrUPloYqmsZ6Zly4
	4PNdwp7JtRoVdZxBZJ8eYB4zePAdTkAl0RdVVoc4iVieCQT/3wRHsMrA/ja0/t8Y
	pOXC87g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	ZBgOa+LYdL7VTNEaGt4FbYRgVZAj4Px+kzSj9mdsqPvKMEQRfbJIiXnYioB+0yqP
	GZXgJ/aWR7Sct/6nQz437q86jVpXT81+MWGqZy6JAWIopD7lReQKZWnOI14V9xYs
	sJ2KUmsEAiKXFxB8LXqwKK7rZLnkOUfE5S0SYjpsVn8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A91C868E8;
	Tue, 22 Jan 2013 01:30:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A38B68E0; Tue, 22 Jan 2013
 01:30:31 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.498.gfdee8be
In-Reply-To: <20130121234002.GE17156@sigill.intra.peff.net>
X-Pobox-Relay-ID: 38B28AB2-645D-11E2-AAA6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214201>

This builds on Chris Rorvick's earlier effort to forbid unforced
updates to refs/tags/ hierarchy and giving sensible error and advise
messages for that case (we are not rejecting such a push due to fast
forwardness, and suggesting to fetch and integrate before pushing
again does not make sense).

The series applies on top of 256b9d7 (push: fix "refs/tags/
hierarchy cannot be updated without --force", 2013-01-16).

The main change is in the second patch.  When we

 * do not have the object at the tip of the remote;
 * the object at the tip of the remote is not a commit; or
 * the object we are pushing is not a commit,

there is no point suggesting to fetch, integrate and push again.

If we do not have the current object at the tip of the remote, we
should tell the user to fetch first and evaluate the situation
before deciding what to do next.

Otherwise, if the current object is not a commit, or if we are
trying to push an object that is not a commit, then the user does
not have to fetch first (we already have the object), but it still
does not make sense to suggest to integrate and re-push.  Just tell
them that such a push requires a force in such a case.

Junio C Hamano (3):
  push: further clean up fields of "struct ref"
  push: introduce REJECT_FETCH_FIRST and REJECT_NEEDS_FORCE
  push: further simplify the logic to assign rejection status

 advice.c            |  4 ++++
 advice.h            |  2 ++
 builtin/push.c      | 25 +++++++++++++++++++++++++
 builtin/send-pack.c | 10 ++++++++++
 cache.h             |  6 +++---
 remote.c            | 42 +++++++++++++++++++-----------------------
 send-pack.c         |  2 ++
 transport-helper.c  | 10 ++++++++++
 transport.c         | 14 +++++++++++++-
 transport.h         |  2 ++
 10 files changed, 90 insertions(+), 27 deletions(-)

-- 
1.8.1.1.498.gfdee8be
