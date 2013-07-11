From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/6] Less potent "--force" for "git push"
Date: Thu, 11 Jul 2013 15:26:14 -0700
Message-ID: <1373581580-13651-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 00:27:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxPKF-0002ZM-G9
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 00:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756111Ab3GKW04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 18:26:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63974 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856Ab3GKW0X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 18:26:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77202303CD
	for <git@vger.kernel.org>; Thu, 11 Jul 2013 22:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=vVM6/1mC5k4c2wTzu/Fzzcqu90k
	=; b=PeGKCN/GK1kGAuLeyuNcM3dequvjmsOdDyBo4r1mYaWdBf7IV8VuVXt/Lqd
	4ICwLCZiaBKeg+zdXby61tMOSMt2H44oLKa8SwonoVR3aEQBqxSmZqOKoHDxOLhu
	cZY6y0sfHbLkGtZ8wngu+PWQqiolvk31MC81piXGjtJ/OEnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=i55tv/fl0i610hoI7CeywUuZycfOL
	UnSq0LL5fRfwdRmgXwXcbsRWrnV1pyI/5ddD6KXBcF+QXIYCensG+fc9fmCHZ31y
	S5dyEvvsZ/g78DEo6jcEsdNEkAoMglwqEkw9DjtPuXCHoShAUhpgOt0NSrjNAAgV
	DBX1zMwLdFr59w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F3C3303CC
	for <git@vger.kernel.org>; Thu, 11 Jul 2013 22:26:22 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D242A303CA
	for <git@vger.kernel.org>; Thu, 11 Jul 2013 22:26:21 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-911-g2c4daa5
X-Pobox-Relay-ID: EA13CC02-EA78-11E2-8171-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230142>

So here is a reroll to make "--lockref" a weaker form of "--force"
that by itself makes "git push" bypass the usual "must fast-forward"
check but enforces a different check "the old ref must be at X"
instead, taking ideas from J6t.  This allows "--force" to be again
the big red button to bypass all the safety.

I still am not married to the "lockref" name, and as I said in 3/6,
I think "--force-with-lease" might be a better name for it.

The previous round is found at $gmane/229987.


[PATCH v2 1/6] cache.h: move remote/connect API out of it
[PATCH v2 2/6] builtin/push.c: use OPT_BOOL, not OPT_BOOLEAN

These are the same from v1

[PATCH v2 3/6] remote.c: add command line option parser for "--lockref"

The earlier one dug the system from both ends and met in the middle,
but this UI level change has been moved to the front---the series
now digs from the UI surface to the core.  The documentation has
also been moved to this patch, using the same text as the proposed
log message, as Michael Haggerty suggested.

[PATCH v2 4/6] push --lockref: implement logic to populate old_sha1_expect[]

This is unchanged.

[PATCH v2 5/6] push --lockref: tie it all together

This corresponds to old 3/7, but the semantics has been adjusted to
allow "--force" override it.

[PATCH v2 6/6] t5533: test "push --lockref"

This has been adjusted to the change in 5/6 (earlier "--force" would
not break the "--lockref" safety, but now it does).

Junio C Hamano (6):
  cache.h: move remote/connect API out of it
  builtin/push.c: use OPT_BOOL, not OPT_BOOLEAN
  remote.c: add command line option parser for "--lockref"
  push --lockref: implement logic to populate old_sha1_expect[]
  push --lockref: tie it all together
  t5533: test "push --lockref"

 Documentation/git-push.txt |  68 +++++++++++++---
 builtin/fetch-pack.c       |   2 +
 builtin/push.c             |  18 ++++-
 builtin/receive-pack.c     |   1 +
 builtin/send-pack.c        |  26 +++++++
 cache.h                    |  62 ---------------
 connect.c                  |   1 +
 connect.h                  |  13 ++++
 fetch-pack.c               |   1 +
 fetch-pack.h               |   1 +
 refs.c                     |   8 --
 remote.c                   | 175 +++++++++++++++++++++++++++++++++++++----
 remote.h                   |  83 ++++++++++++++++++++
 send-pack.c                |   2 +
 t/t5533-push-cas.sh        | 189 +++++++++++++++++++++++++++++++++++++++++++++
 transport-helper.c         |   6 ++
 transport.c                |  13 ++++
 transport.h                |   5 ++
 upload-pack.c              |   1 +
 19 files changed, 578 insertions(+), 97 deletions(-)
 create mode 100644 connect.h
 create mode 100755 t/t5533-push-cas.sh

-- 
1.8.3.2-912-g65cf5cf
