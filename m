From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/19] Signed push
Date: Fri, 22 Aug 2014 13:30:05 -0700
Message-ID: <1408739424-31429-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 22:30:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKvU5-00077S-8E
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 22:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbaHVUaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 16:30:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63976 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbaHVUaf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 16:30:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 792A033116;
	Fri, 22 Aug 2014 16:30:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=9ZYZHEkSTwe1XKvBIyfTtejjx4M
	=; b=tCi0qE1pbOkMFtepVOBrN0ctqUEh4reXS09Gq+EM1bd3JYdXLXWy6xE8KUS
	UJULODqnpt0HVdheDa4dNG18T2EjS42ZFgDo2bJ+bz4mbQLbRnxS4Y/0BlmI5aO0
	1050JBtmZx4YEROEmKqL9LWE6z2O0DeQk8M7uPisYZ3dTksU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=gzSLCF4tJUwRi6oWhdsRDUD/7b4+Q
	02qe81OisiAUw6t6SQg6lDZzCcigEeC4eaTKZjVsYDnfXV9fWWrFCvMvis7o1N9O
	71QMGsJ3z3N2fFTIVk01/xf6kzMgzU/s9ORGMKdh7XRHEunki8mfSsEigx/euip6
	XF8G4Y8snSTNP0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6FEC133115;
	Fri, 22 Aug 2014 16:30:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6C5263310F;
	Fri, 22 Aug 2014 16:30:26 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-304-g950f846
X-Pobox-Relay-ID: 2673E558-2A3B-11E4-9CF9-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255701>

The first round is found at $gmane/255520

While signed tags and commits assert that the objects thusly signed
came from you, who signed these objects, there is not a good way to
assert that you wanted to have a particular object at the tip of a
particular branch.  My signing v2.0.1 tag only means I want to call
the version v2.0.1, and it does not mean I want to push it out to my
'master' branch---it is likely that I only want it in 'maint', so
the signature on the object alone is insufficient.

The only assurance to you that 'maint' points at what I wanted to
place there comes from your trust on the hosting site and my
authentication with it, which cannot easily audited later.

This series introduces a cryptographic assurance for ref updates
done by "git push" by introducing a mechanism that allows you to
sign a "push certificate" (for the lack of better name) every time
you push.  Think of it as working on an axis orthogonal to the
traditional "signed tags".

Notable changes from the first iteration are:

 - "push --signed" against a receiver that does not support push
   certificates used to downgrade to an unsigned push with a
   warning; this round makes it die.

 - The push-cert capability the receiver sends now with a value,
   <nonce>; the certificate must include this value on the "nonce"
   header to prevent a valid push certificate that was used to push
   elsewhere from being replayed to push to an unrelated repository.

And several typofixes here and there.

Junio C Hamano (19):
  receive-pack: do not overallocate command structure
  receive-pack: parse feature request a bit earlier
  receive-pack: do not reuse old_sha1[] for other things
  receive-pack: factor out queueing of command
  send-pack: move REF_STATUS_REJECT_NODELETE logic a bit higher
  send-pack: refactor decision to send update per ref
  send-pack: always send capabilities
  send-pack: factor out capability string generation
  send-pack: rename "new_refs" to "need_pack_data"
  send-pack: refactor inspecting and resetting status and sending
    commands
  send-pack: clarify that cmds_sent is a boolean
  gpg-interface: move parse_gpg_output() to where it should be
  gpg-interface: move parse_signature() to where it should be
  pack-protocol doc: typofix for PKT-LINE
  the beginning of the signed push
  receive-pack: GPG-validate push certificates
  send-pack: send feature request on push-cert packet
  signed push: signed push: remove duplicated protocol info
  signed push: fortify against replay attacks

 Documentation/git-push.txt                        |   9 +-
 Documentation/git-receive-pack.txt                |  41 ++++-
 Documentation/technical/pack-protocol.txt         |  25 ++-
 Documentation/technical/protocol-capabilities.txt |  13 +-
 builtin/push.c                                    |   1 +
 builtin/receive-pack.c                            | 199 ++++++++++++++++++----
 commit.c                                          |  36 ----
 gpg-interface.c                                   |  57 +++++++
 gpg-interface.h                                   |  18 +-
 send-pack.c                                       | 197 ++++++++++++++++-----
 send-pack.h                                       |   1 +
 t/t5534-push-signed.sh                            |  82 +++++++++
 tag.c                                             |  20 ---
 tag.h                                             |   1 -
 transport.c                                       |   4 +
 transport.h                                       |   5 +
 16 files changed, 564 insertions(+), 145 deletions(-)
 create mode 100755 t/t5534-push-signed.sh

-- 
2.1.0-304-g950f846
