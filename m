From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 00/21] Signed push
Date: Thu,  4 Sep 2014 13:04:36 -0700
Message-ID: <1409861097-19151-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 22:05:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPdHp-0000jh-Lc
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 22:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371AbaIDUFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 16:05:11 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61337 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755304AbaIDUFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 16:05:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E99ED3812B;
	Thu,  4 Sep 2014 16:05:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=Rn9A4eM660d5rm+KmzU10TyvqTU
	=; b=EpXdQTYRm3Ii5CEd6hcX2/Q7ICOLDsEd0UiPLyBJS0IcDmly4rihkf3shq3
	PSbSRAiIhY1uyw8xZuswzCgsBH42ZSbhV2DVoR39ld7KubkTOpWJ8wdXcx5+a+Rv
	oF3ZtuIVVvVCsCliKmWMuVgY45uqfXDThLCVd3u4LULPNveY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=a+3w9OT010z2yZRD3SKC8Q3rYpoKx
	7143dEI0rO0gr4i5myNt+TNY/hnwJjS+vNcQSqt6a61wuO/WK1AfUKMmd41tlNhy
	s4bKvDUXWIhMpdmgCGcBfHHTEpje/eAm5SW/OsrnD3CU+5HylCHBR1MB0OJFb+fe
	b0ApvhGSGBHzGU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 451AD38128;
	Thu,  4 Sep 2014 16:05:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6A3313811C;
	Thu,  4 Sep 2014 16:04:59 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-399-g1364b4d
X-Pobox-Relay-ID: BFA7B582-346E-11E4-B525-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256464>

The first round is found at $gmane/255520.
The second round is found at $gmane/255701.

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

The second round exportedt GIT_PUSH_CERT, pointing at an empty blob,
even when there was not any signed push going on, which has been
corrected in this version.

The last step of adding "nonce" still needs further thinking and
tweaking (the issue is that inherently smart-http is not as secure
as the native from replay-ability point of view; it needs to loosen
"has any of our ref changed since I started talking with this 'git
push'" check in receive-pack without this series already), but I
think everything else is in pretty good shape.

Junio C Hamano (21):
  receive-pack: do not overallocate command structure
  receive-pack: parse feature request a bit earlier
  receive-pack: do not reuse old_sha1[] for other things
  receive-pack: factor out queueing of command
  send-pack: move REF_STATUS_REJECT_NODELETE logic a bit higher
  send-pack: refactor decision to send update per ref
  send-pack: always send capabilities
  send-pack: factor out capability string generation
  receive-pack: factor out capability string generation
  send-pack: rename "new_refs" to "need_pack_data"
  send-pack: refactor inspecting and resetting status and sending commands
  send-pack: clarify that cmds_sent is a boolean
  gpg-interface: move parse_gpg_output() to where it should be
  gpg-interface: move parse_signature() to where it should be
  pack-protocol doc: typofix for PKT-LINE
  push: the beginning of "git push --signed"
  receive-pack: GPG-validate push certificates
  send-pack: send feature request on push-cert packet
  signed push: remove duplicated protocol info
  signed push: add "pushee" header to push certificate
  signed push: fortify against replay attacks

 Documentation/config.txt                          |   5 +
 Documentation/git-push.txt                        |   9 +-
 Documentation/git-receive-pack.txt                |  41 +++-
 Documentation/technical/pack-protocol.txt         |  49 ++++-
 Documentation/technical/protocol-capabilities.txt |  13 +-
 builtin/push.c                                    |   1 +
 builtin/receive-pack.c                            | 219 ++++++++++++++++++----
 commit.c                                          |  36 ----
 gpg-interface.c                                   |  57 ++++++
 gpg-interface.h                                   |  18 +-
 send-pack.c                                       | 202 +++++++++++++++-----
 send-pack.h                                       |   2 +
 t/t5534-push-signed.sh                            |  96 ++++++++++
 tag.c                                             |  20 --
 tag.h                                             |   1 -
 transport.c                                       |   5 +
 transport.h                                       |   5 +
 17 files changed, 630 insertions(+), 149 deletions(-)
 create mode 100755 t/t5534-push-signed.sh

-- 
2.1.0-399-g1364b4d
