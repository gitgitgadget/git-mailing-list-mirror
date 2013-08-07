From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] work around "transport-take-over" hack
Date: Wed,  7 Aug 2013 16:30:37 -0700
Message-ID: <1375918242-4655-1-git-send-email-gitster@pobox.com>
Cc: Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 08 01:30:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7DBq-00056F-HQ
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 01:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933275Ab3HGXaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 19:30:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59660 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752651Ab3HGXaq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 19:30:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30A0D37F90;
	Wed,  7 Aug 2013 23:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=X+LizkQye7vNcw9Kq/cDCF8ZvIs
	=; b=LTrDLA6QomftiX82/ixqZX8QBuLU7z6QoCg7s6feOiIwrvaKjqNGvKMxJ8H
	7MoSxx2vyD+ZwenjYk8jJiZpYtA94jhWDPjBppcU3MT03mLRTp2zAF9XiOneVmRh
	lnjSw/tn0o5Zz/HpCXYS0shsyUpJdUxSLNC8lf0Vs34hXHKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=pAxS5pQQDUf5Yn1yRqHIx
	YUmV6//uUWAmN2wleCRov3HWtNPxAzPAT/6T7ks9hSJrcrKPqVqF+6CcpcufgjO1
	OkmQwEMzmr8/HvPP/hVgVA9wjIXaSIlC79QTwJWVQiFoDIJTixP1hSQIye2UFMWB
	yPqD6wRSxNa8vF3lvzIGVY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 274C737F8F;
	Wed,  7 Aug 2013 23:30:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6725237F8E;
	Wed,  7 Aug 2013 23:30:44 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc1-210-gf6d87e2
X-Pobox-Relay-ID: 617F3DB2-FFB9-11E2-882D-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231847>

"git fetch" sometimes needs to make a real request to the transport
after a single "fetch_refs" request, in order to follow tags that
the other end should have sent as part of the primary transfer with
"follow-tags" request.

However, a transport that defines "connect" has a gross hack that
destroys its internal state to render it unusable after processing a
single request, breaking this.

This is my attempt to work it around.  I am not too proud of it, but
after trying two other approaches to fix it closer to the real cause
(i.e. the implementation of Git-aware transport helper) and seeing
that both of them ended up being even less appealing and not worth
posting, I think this is probably the best fix to the issue.

Junio C Hamano (5):
  t5802: add test for connect helper
  fetch: rename file-scope global "transport" to "gtransport"
  fetch: refactor code that prepares a transport
  fetch: refactor code that fetches leftover tags
  fetch: work around "transport-take-over" hack

 builtin/fetch.c           | 85 ++++++++++++++++++++++++++++++-----------------
 t/t5802-connect-helper.sh | 72 +++++++++++++++++++++++++++++++++++++++
 transport.c               |  2 ++
 transport.h               |  6 ++++
 4 files changed, 134 insertions(+), 31 deletions(-)
 create mode 100755 t/t5802-connect-helper.sh

-- 
1.8.4-rc1-210-gf6d87e2
