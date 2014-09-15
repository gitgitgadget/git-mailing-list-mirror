From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 00/23] Signed push
Date: Mon, 15 Sep 2014 15:24:01 -0700
Message-ID: <1410819864-22967-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 00:24:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTehG-0006BF-AX
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755285AbaIOWY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 18:24:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63174 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754823AbaIOWY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 18:24:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C96233B16B;
	Mon, 15 Sep 2014 18:24:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=A8X0q59foEU6eHiq1YItDgYU098
	=; b=ge7m2aw3TSVZOAGA0GtZJq7ZOEvUGPq8Ye6h0g7Gn08uz3tItkCMRSJMXPn
	bxHEpC6J0Q3CI6NHqXE9f0L/IzebfK1Cgi58dk4TVIEcoPXmlzAbG//6y0Kx/phQ
	spDeyNI2ebqCg2pi1f1gtCvVmraE6bee94JhKvi5q2n/Wos0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=IyWaLYFujYWNEuiJ3FliG4EDkXNSA
	dmZt+niqobKLgNvCWVixvBC79f/Vbeuz/Vu54W0FbSfYBizY8LvY8kzJYkzgGYXW
	Wb1H5/BVZ/RJmFFrALlTvxiKZ3eVKB0aqVMNBnOt46v7vWiqmg8EKBqLpF6dIYWE
	FmymEXb07/09H0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BEA0C3B16A;
	Mon, 15 Sep 2014 18:24:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 409D13B169;
	Mon, 15 Sep 2014 18:24:26 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-420-g23b5121
X-Pobox-Relay-ID: 0D37B84A-3D27-11E4-A940-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257087>

The first round is found at $gmane/255520.
The second round is found at $gmane/255701.
The third round is found at $gmane/256464.
The forth round is found at $gmane/256518.

Not much had to have changed since the last round, except for the
hooks used in the test that have been fixed to slurp all its input
in.

A failing test has been added at the end for smart HTTP.  It appears
that somewhere in the callchain "--signed" is forgotten and the
sending end not to send the certificate for some reason.  If
somebody with a fresh set of eyes can look into it, that would be
very much appreciated, as I do not expect I would have sufficient
concentration to dig it quickly for several days at least.

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
  send-pack: refactor inspecting and resetting status and sending
    commands
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
  t5541: test push --signed to smart HTTP server

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
 t/t5534-push-signed.sh                            | 125 ++++++++
 t/t5541-http-push-smart.sh                        |  39 +++
 tag.c                                             |  20 --
 tag.h                                             |   1 -
 transport.c                                       |   5 +
 transport.h                                       |   5 +
 18 files changed, 847 insertions(+), 156 deletions(-)
 create mode 100755 t/t5534-push-signed.sh

-- 
2.1.0-410-gd72dacd
