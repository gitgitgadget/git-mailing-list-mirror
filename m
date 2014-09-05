From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 00/22] Signed push
Date: Fri,  5 Sep 2014 13:54:48 -0700
Message-ID: <1409950510-10209-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 22:55:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ0XU-0005R5-TW
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 22:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbaIEUzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 16:55:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64752 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237AbaIEUzS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 16:55:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 22C693661C;
	Fri,  5 Sep 2014 16:55:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=RUJT8C1g4FNNnZqfwodMnbdsBk0
	=; b=MyBbtumPc17CiaC7gYap5ngz8wm58dChdPXYMCa2/U9pv617Gf4ILor4SlW
	rBg1s+BC7NIZEqEEYHPRijmDE8cR8u0luPg10ebZZHM+05AMvpL0BIjx/Vo5i7KF
	Du6WKB2DEM+NYZuIuj05ZCgEAIfULVAoaFBqD/2WvOpM+ANQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=gudiwgWfUqDQuR9owIgjFGEOp7tKO
	TJ5GbhgdXsc4GvxqgN7VkMsv+Dy+Iv7Bfk3Zng9J1DCIgh5mkaKpXxifMhP1nlQ/
	AgK0OV9J4Fd7TyrycnU8zn6Gj9CinQOYLABxXHMpxwuiqaVI1rm44aaNlLGAQPrx
	eDoP+tvIjWmSi8=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 178B33661B;
	Fri,  5 Sep 2014 16:55:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8B58936618;
	Fri,  5 Sep 2014 16:55:11 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-404-gcacb207
X-Pobox-Relay-ID: ED70EF6C-353E-11E4-B5C9-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256518>

The first round is found at $gmane/255520.
The second round is found at $gmane/255701.
The third round is found at $gmane/256464.

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

In addition to typofixes in the log messages and comments in the
earlier parts of the series since the last round, notable changes
and additions in this round include the following:

 - The logic to generate "nonce" was revamped, based on HMAC-SHA1-80
   modeled after RFC 2104, suggested in $gmane/256491 [*1*].

 - Tentative "--push-cert/--no-push-cert" command line options to
   control if "receive-pack" expects/accepts a signed push is gone,
   as it is hard to arrange what goes on its command line.  It is
   now controled by receive.certnonceseed configuration variable.
   If you supply an HMAC secret to be used for generating nonce, you
   accept "git push --signed".  If you don't, you don't.

 - The last patch is new to help "stateless RPC" codepath to
   participate in the "nonce" dance.

I didn't feel bold enough to add smart-http tests to the last
patch.  Contributions are very much welcomed ;-)


[Reference]

*1* http://thread.gmane.org/gmane.comp.version-control.git/255520/focus=256491


Junio C Hamano (22):
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
  signed push: allow stale nonce in stateless mode

 Documentation/config.txt                          |   6 +
 Documentation/git-push.txt                        |   9 +-
 Documentation/git-receive-pack.txt                |  63 +++-
 Documentation/technical/pack-protocol.txt         |  49 ++-
 Documentation/technical/protocol-capabilities.txt |  13 +-
 builtin/push.c                                    |   1 +
 builtin/receive-pack.c                            | 354 +++++++++++++++++++---
 commit.c                                          |  36 ---
 gpg-interface.c                                   |  57 ++++
 gpg-interface.h                                   |  17 +-
 send-pack.c                                       | 201 +++++++++---
 send-pack.h                                       |   2 +
 t/t5534-push-signed.sh                            | 116 +++++++
 tag.c                                             |  20 --
 tag.h                                             |   1 -
 transport.c                                       |   5 +
 transport.h                                       |   5 +
 17 files changed, 799 insertions(+), 156 deletions(-)
 create mode 100755 t/t5534-push-signed.sh

-- 
2.1.0-399-g2df620b
