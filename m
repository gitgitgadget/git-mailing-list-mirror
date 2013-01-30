From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/8] Hiding refs
Date: Wed, 30 Jan 2013 10:45:34 -0800
Message-ID: <1359571542-19852-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 19:46:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0cg2-0004fU-On
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 19:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654Ab3A3Spr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 13:45:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33601 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756650Ab3A3Spo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 13:45:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 377CEC3E8;
	Wed, 30 Jan 2013 13:45:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=sTmGgR4RhfdnwlWCHPHgRvo1WKg
	=; b=DzeD+FY3LfhG7uz0+eT5PxV3o0v8HjsFiqaKmyB6yFxRybjNiDtNYRIr+j8
	2G4+y8t0zVffKbNeaNUC/b2MsDv1Az+DfL/7CnrO05QovU18u0xVgzda+4xd6c8r
	5UbMLYhmJ+RL09hpJPw71YacAnZWu4pnHH2FWVGv49d+c1no=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=Mgp0wL1knf5ZZ2xalL1Bz
	Po+u/3M/2Y1N4F1FUrhtZ9OLB1MUEredOkOlObN3dpdg4JErrrGVZ8v/G4/o8tlm
	t+z+c/eDfS+RAavr46U1hPGpVhLFSho5P92lNbyJPC0PQ5eZyn2QFtimxHFP+MT7
	xMbukkO5bZsLOpr1MJExGg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D0CFC3E7;
	Wed, 30 Jan 2013 13:45:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87754C3E4; Wed, 30 Jan 2013
 13:45:43 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.589.ga9b91ac
X-Pobox-Relay-ID: 40832B32-6B0D-11E2-81FE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215054>

The third round.

 - Multi-valued variable transfer.hiderefs lists prefixes of ref
   hierarchies to be hidden from the requests coming over the
   network.

 - A configuration optionally allows uploadpack to accept fetch
   requests for an object at the tip of a hidden ref.

Elsewhere, we discussed "delaying ref advertisement" (aka "expand
refs"), but it is an orthogonal feature and this "hiding refs
completely from advertisement" series does not attempt to address.

Patch #2 (simplify request validation), #4 (clarify the codeflow),
and #5 (use struct ref) are new.  The are all long overdue clean-ups
for these codepaths.

The last patch is an illustration why it wouldn't make sense to
optionally allow pushing into hidden refs, and not meant to be part
of the series proper.

For those who missed it, earlier rounds are at:

    http://thread.gmane.org/gmane.comp.version-control.git/213951
    http://thread.gmane.org/gmane.comp.version-control.git/214888

Junio C Hamano (8):
  upload-pack: share more code
  upload-pack: simplify request validation
  upload/receive-pack: allow hiding ref hierarchies
  parse_fetch_refspec(): clarify the codeflow a bit
  fetch: use struct ref to represent refs to be fetched
  upload-pack: optionally allow fetching from the tips of hidden refs
  fetch: fetch objects by their exact SHA-1 object names
  WIP: receive.allowupdatestohidden

 Documentation/config.txt |  23 +++++++++++
 builtin/fetch-pack.c     |  40 +++++++++++++++----
 builtin/receive-pack.c   |  31 +++++++++++++++
 cache.h                  |   3 +-
 fetch-pack.c             | 101 ++++++++++++++++++++++++++++++++---------------
 fetch-pack.h             |  11 +++---
 refs.c                   |  41 +++++++++++++++++++
 refs.h                   |   3 ++
 remote.c                 |  41 ++++++++++---------
 remote.h                 |   1 +
 t/t5512-ls-remote.sh     |   9 +++++
 t/t5516-fetch-push.sh    |  82 ++++++++++++++++++++++++++++++++++++++
 transport.c              |   9 +----
 upload-pack.c            |  86 ++++++++++++++++++++++++----------------
 14 files changed, 374 insertions(+), 107 deletions(-)

-- 
1.8.1.2.589.ga9b91ac
