From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/7] safer "push --force" with compare-and-swap
Date: Tue,  9 Jul 2013 12:53:23 -0700
Message-ID: <1373399610-8588-1-git-send-email-gitster@pobox.com>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 09 21:53:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwdyk-0005pz-07
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 21:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048Ab3GITxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 15:53:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41527 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752741Ab3GITxc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 15:53:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 259532F3B2
	for <git@vger.kernel.org>; Tue,  9 Jul 2013 19:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=0lVs
	Sf6PvW1kNpuJGP+SAIWLrM0=; b=EgQqEkJPq9kR04f9DeAixrMizKECgFZDPi7P
	MlYfKOgYNenh7THOvr5VhBjs8jbEcrUpJwFCV0cjv7UnZcXo4Yq7+NOi1v+YKP/1
	VG4PrzABQb/jZie7c6Swk+RuLm2Trhuu/VGoKArcvUH+ZtpuanMnJN/AkPUo2zbx
	5qC+hX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=WFj1PA
	mf16S38qWRdd4QLcAg5EbwPVFQ/Po/BKrt1Y55T34+phRhghdKnkRBtHt4dIjSNp
	e40fNa0N+/BsR67vuS7guRuZ2nZl6bcYZrPBuWmaFl9w69YfWYzwaP8Ppg/awNdA
	Bg0LKzauQWcsnBoUDHsYAYf74fhZRxrTOQKCY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19B4B2F3B1
	for <git@vger.kernel.org>; Tue,  9 Jul 2013 19:53:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C5F52F3B0
	for <git@vger.kernel.org>; Tue,  9 Jul 2013 19:53:31 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-875-g76c723c
In-Reply-To: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 3B421A56-E8D1-11E2-9728-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229987>

When you have to replace an already published branch with its
rebased version, you would have to --force, but then you risk losing
work, if any, that was pushed by somebody else while you are working
on rebasing, as your earlier decision that replacing the old one
with its rebase is OK was based on the assumption that there is
nothing else going on.  Unfortunately, --force is blind, and did not
offer this "... but fail if the tip has moved from what I expect".

And here is a series to remedy it.  It lets you specify what the
expected current values of refs you are attempting to update, and if
you are lazy, the value is taken from your remote tracking branch
for the ref you are attempting to update.

I am not married to the "lockref" name, but I think the semantics
implemented here is what we discussed to do in the earlier
discussion.

cf. http://thread.gmane.org/gmane.comp.version-control.git/229430

This may still be rough at edges, but a basic testset seems to pass.

I haven't bothered to check the smart-http transport; help is
greatly appreciated.

Junio C Hamano (7):
  cache.h: move remote/connect API out of it
  builtin/push.c: use OPT_BOOL, not OPT_BOOLEAN
  push: beginning of compare-and-swap "force/delete safety"
  remote.c: add command line option parser for --lockref
  push --lockref: implement logic to populate old_sha1_expect[]
  t5533: test "push --lockref"
  push: document --lockref

 Documentation/git-push.txt |  26 +++++++
 builtin/fetch-pack.c       |   2 +
 builtin/push.c             |  18 ++++-
 builtin/receive-pack.c     |   1 +
 builtin/send-pack.c        |  26 +++++++
 cache.h                    |  62 ----------------
 connect.c                  |   1 +
 connect.h                  |  13 ++++
 fetch-pack.c               |   1 +
 fetch-pack.h               |   1 +
 refs.c                     |   8 ---
 remote.c                   | 149 +++++++++++++++++++++++++++++++++++++-
 remote.h                   |  83 +++++++++++++++++++++
 send-pack.c                |   2 +
 t/t5533-push-cas.sh        | 176 +++++++++++++++++++++++++++++++++++++++++++++
 transport-helper.c         |   6 ++
 transport.c                |  13 ++++
 transport.h                |   5 ++
 upload-pack.c              |   1 +
 19 files changed, 519 insertions(+), 75 deletions(-)
 create mode 100644 connect.h
 create mode 100755 t/t5533-push-cas.sh

-- 
1.8.3.2-875-g76c723c
