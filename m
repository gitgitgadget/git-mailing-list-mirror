From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 00/23] Signed push
Date: Wed, 17 Sep 2014 15:45:35 -0700
Message-ID: <1410993958-32394-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 00:46:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUNzP-000236-6u
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 00:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756977AbaIQWqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 18:46:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60610 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756521AbaIQWqH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 18:46:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2635039DC6;
	Wed, 17 Sep 2014 18:46:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=NxPVyJDJ98dZzFSLpxuv90pjMCA
	=; b=i3FOkDVgUoyXwnh8UKs9jsF3/WCPPsG5pVJU+ENqcgQCYvvVWnnV2WOz5x+
	JqX5FOXuS6s2XSX9oRRwT8AGT2h0fwlMbF+FQycqF1TeL1VCDAk3YgrIRghaYhfT
	g6C78gxlgECfyiBP2fPB1S/Zb03aBVJ5v5QbEtDMlyJTnxPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=e8GHGw/WNTm7f7ET5de+Dgp70wcq5
	uttKbGgyTjGn8uiZXwDDskPY4eOR1hPjuGhbi/SiFZQSwrN+ir5UeimAukkrQYZU
	DWWwxNu07ou2sQWmFmbvynbRVNfmjzepSu2yXa+0ScGyivWpLO3yyTyYPy/1DEXE
	64IDFzUpSMJ2IQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B3CF39DC5;
	Wed, 17 Sep 2014 18:46:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2E0D539DC2;
	Wed, 17 Sep 2014 18:46:00 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-403-g099cf47
X-Pobox-Relay-ID: 65E5D5A8-3EBC-11E4-8426-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257229>

No changes to the earlier 20 patches in the series since the last
round ($gmane/257087).  The last three patches in the series have
been reworked and reordered to:

 - plug a small leak in replay prevention code;
 - smart HTTP integration and test are in a single patch;
 - handling of a stale nonce in smart HTTP mode was reworked.

I think this round is ready for 'next'.  Those who work on various
reimplementations of Git may want to start thinking about adding
support for the "push-cert" feature in their receive-pack, and those
who use server-side pre-receive/post-receive hooks (Gitolite, I am
looking at you ;-) may want to start planning to take advantage of
it.

Junio C Hamano (23):
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
  signed push: teach smart-HTTP to pass "git push --signed" around
  signed push: allow stale nonce in stateless mode

 Documentation/config.txt                          |  19 ++
 Documentation/git-push.txt                        |   9 +-
 Documentation/git-receive-pack.txt                |  65 +++-
 Documentation/technical/pack-protocol.txt         |  49 ++-
 Documentation/technical/protocol-capabilities.txt |  13 +-
 builtin/push.c                                    |   1 +
 builtin/receive-pack.c                            | 393 +++++++++++++++++++---
 builtin/send-pack.c                               |   4 +
 commit.c                                          |  36 --
 gpg-interface.c                                   |  57 ++++
 gpg-interface.h                                   |  17 +-
 remote-curl.c                                     |  13 +-
 send-pack.c                                       | 201 ++++++++---
 send-pack.h                                       |   2 +
 t/lib-httpd/apache.conf                           |   1 +
 t/t5534-push-signed.sh                            | 127 +++++++
 t/t5541-http-push-smart.sh                        |  41 +++
 t/test-lib.sh                                     |   3 +-
 tag.c                                             |  20 --
 tag.h                                             |   1 -
 transport-helper.c                                |   9 +-
 transport.c                                       |   5 +
 transport.h                                       |   5 +
 23 files changed, 932 insertions(+), 159 deletions(-)
 create mode 100755 t/t5534-push-signed.sh

-- 
2.1.0-403-g099cf47
