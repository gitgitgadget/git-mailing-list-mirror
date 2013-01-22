From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Finishing touches to "push" advises
Date: Mon, 21 Jan 2013 21:53:44 -0800
Message-ID: <1358834027-32039-1-git-send-email-gitster@pobox.com>
References: <20130121234002.GE17156@sigill.intra.peff.net>
Cc: Jeff King <peff@peff.net>, Chris Rorvick <chris@rorvick.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 22 06:54:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxWoG-0003Ym-H3
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 06:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904Ab3AVFxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 00:53:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53858 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817Ab3AVFxu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 00:53:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6F5172BF;
	Tue, 22 Jan 2013 00:53:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=kVfd
	Rs3b1H4+e7WWxJY15KE5JXw=; b=qnB+hioXrq3x15di271ZRAaF5156sqIQEX8D
	CEeIZMLCfhojJjviOh29qLW07I0Q7+bf0NxGGKkvJzcIS8C/rbP/A4f2nKgb2EYy
	HtE6huTnyThipm8S21cw0E4E7GrqbPC7OsLic/vkRVzTTImVx+CusTl/xBCbqwpU
	KL5icw8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	b4S5VSIHwUFLgfp2h+G65pH3d9i6+qIbKO7SFfTeJDtP2NU17Z5FxsUCX44/IyaJ
	QPazPm2R0gnEj0XbKjnDXkJJvUHpA5s0PeEMO1Oyg4ZK6+EsKXm3vBmdDYCmNwo8
	Au4Df7mF9E8mZROR260liT5/IdLOEpfBI6B+FqP57ts=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBBD072BE;
	Tue, 22 Jan 2013 00:53:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 458E872BC; Tue, 22 Jan 2013
 00:53:49 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.498.gfdee8be
In-Reply-To: <20130121234002.GE17156@sigill.intra.peff.net>
X-Pobox-Relay-ID: 17C05C1C-6458-11E2-BBCA-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214196>

This builds on Chris Rorvick's earlier effort to forbid unforced
updates to refs/tags/ hierarchy and giving sensible error and advise
messages for that case (we are not rejecting such a push due to fast
forwardness, and suggesting to fetch and integrate before pushing
again does not make sense).

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
  push: further reduce "struct ref" and simplify the logic

 advice.c            |  4 ++++
 advice.h            |  2 ++
 builtin/push.c      | 25 +++++++++++++++++++++++++
 builtin/send-pack.c | 10 ++++++++++
 cache.h             |  6 +++---
 remote.c            | 38 ++++++++++++++++----------------------
 send-pack.c         |  2 ++
 transport-helper.c  | 10 ++++++++++
 transport.c         | 14 +++++++++++++-
 transport.h         |  2 ++
 10 files changed, 87 insertions(+), 26 deletions(-)

-- 
1.8.1.1.498.gfdee8be
