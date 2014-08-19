From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/18] Signed push
Date: Tue, 19 Aug 2014 15:06:09 -0700
Message-ID: <1408485987-3590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 00:06:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJrY9-0005Km-UJ
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 00:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbaHSWGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 18:06:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60883 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170AbaHSWGh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 18:06:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B4EE3305D;
	Tue, 19 Aug 2014 18:06:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=PO4wdEy4P7O+Qe7DlMK8vG8Yrkc
	=; b=V8JHhH+GRoQSSDSWa6Dw0KsfC6kX+ht0np02CXfG39IrG+tIZ5248AgVW9w
	1ZWAR1YdSR7gYihzojd4D6R5nkK8Ynt9nYg39u6mmxqKz9vkOjU3VmSeVOhrfx4c
	uBEVPm2gAj5L1X92CfhyDITO7rhhIdhB2hyOa/Ugmthcc9aw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=P1Y5uJ+GdkXqSo/liZnC3yS6z7W8g
	dpY4ulMGnisq6u4VEKeokPFAsolgqujb+DfZ09D201h9G5iHZ316jsBtjexD16r2
	LSHHj+gz0zw45+C1iIEiuZCVU5KTp6fb5HyHgcBEd1e04sQYhnXw3JjbUlpOxtfJ
	f5NCSBE+c9+jOQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7F18D3305C;
	Tue, 19 Aug 2014 18:06:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DE1CF33052;
	Tue, 19 Aug 2014 18:06:28 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-301-g54593e2
X-Pobox-Relay-ID: 11E912C0-27ED-11E4-8F85-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255520>

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

The most interesting part starts at 15/18; everything that precedes
that patch are preparatory clean-ups.

    [PATCH 15/18] the beginning of the signed push

	This step presents the basic idea.  If you remember the
	underlying "git push" protocol exchange, it goes like this:

	- The server advertises the existing refs and where they
	  point at, and the capabilities the server supports;

	- The "git push" client sends update commands (one or more
	  "old-sha1 new-sha1 refname") followed by the pack data;

	- The server unpacks and updates the refname to point at
	  new-sha1.

	We introduce "push-cert" capability, and allow the client to
	sign the "update commands" it will send to the server and
	send this signature using the new "push-cert" command.

	This certificate is exported to the pre/post-receive hooks
	of the server, so that the pre-receive hook can GPG validate
	(and possibly reject a bad push); post-receive hook can log
	the certificate.

    [PATCH 16/18] receive-pack: GPG-validate push certificates

	This step builds a native GPG validation into the server to
	help the pre-receive hook.  The signature is verified
	against the GPG keychain the server uses (it is likely that
	you would want to set and export GNUPGHOME when starting
	your server), and verification result is given to the
	pre/post-receive hook.

    [PATCH 17/18] send-pack: send feature request on push-cert packet
    [PATCH 18/18] signed push: final protocol update

	With the protocol introduced in 15/18, the update commands
	and the push certificate record the same information twice;
	the protocol was kept inefficient to make it easier to
	review the changes.

	These two steps updates the protocol to the final version,
	which does not to send the update commands when a push
	certificate is in use.

If the server's GPG keychain and pre-receive hook are properly set
up, a "git push --signed" over an unauthenticated and unencrypted
communication channel (aka "git daemon") can be made as secure as,
and even more secure than, the authenticated "git push ssh://".

With the signed push certificate, together with the connectivity
check done when the server accepts the packed data, we are assured
that the trusted user vouches for the history leading to the
proposed tips of refs (aka "new-sha1"s), and a man-in-the-middle
would not be able to make the server accept an update altered in
transit.


Junio C Hamano (18):
  receive-pack: do not overallocate command structure
  receive-pack: parse feature request a bit earlier
  receive-pack: do not reuse old_sha1[] to other things
  receive-pack: factor out queueing of command
  send-pack: move REF_STATUS_REJECT_NODELETE logic a bit higher
  send-pack: refactor decision to send update per ref
  send-pack: always send capabilities
  send-pack: factor out capability string generation
  send-pack: rename "new_refs" to "need_pack_data"
  send-pack: refactor inspecting and resetting status and sending commands
  send-pack: clarify that cmds_sent is a boolean
  gpg-interface: move parse_gpg_output() to where it should be
  gpg-interface: move parse_signature() to where it should be
  pack-protocol doc: typofix for PKT-LINE
  the beginning of the signed push
  receive-pack: GPG-validate push certificates
  send-pack: send feature request on push-cert packet
  signed push: final protocol update

 Documentation/git-push.txt                        |   9 +-
 Documentation/git-receive-pack.txt                |  30 +++-
 Documentation/technical/pack-protocol.txt         |  24 ++-
 Documentation/technical/protocol-capabilities.txt |  12 +-
 builtin/push.c                                    |   1 +
 builtin/receive-pack.c                            | 161 +++++++++++++++---
 commit.c                                          |  36 -----
 gpg-interface.c                                   |  57 +++++++
 gpg-interface.h                                   |  18 ++-
 send-pack.c                                       | 188 ++++++++++++++++------
 send-pack.h                                       |   1 +
 t/t5534-push-signed.sh                            |  77 +++++++++
 tag.c                                             |  20 ---
 tag.h                                             |   1 -
 transport.c                                       |   4 +
 transport.h                                       |   5 +
 16 files changed, 502 insertions(+), 142 deletions(-)
 create mode 100755 t/t5534-push-signed.sh

-- 
2.1.0-301-g54593e2
