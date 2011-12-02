From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/6] Bulk check-in
Date: Thu,  1 Dec 2011 16:40:43 -0800
Message-ID: <1322786449-25753-1-git-send-email-gitster@pobox.com>
References: <1322699263-14475-6-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 01:40:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWHBS-0006tS-Kl
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 01:40:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756079Ab1LBAkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 19:40:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49964 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755770Ab1LBAkw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 19:40:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC7806B0F
	for <git@vger.kernel.org>; Thu,  1 Dec 2011 19:40:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=aGO4
	U5dOewKIpO7FpSO7t5qicxI=; b=o+kcFHHS57PqSYmt47BqzlBaernwHLLB0PSA
	RqnUMANHAo2IJFO1ar8zLEFhgjp+7lfWBWeOb5FJjdzu6QRcuyBLnHppfXY+/AOi
	aghMnj9VqkWu5DPQhncz7OXgP6/wJDzR9nQfN4Md9NCzrqxVeQkpY7reYkU6yiYm
	1NH8S0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=qs0Xaw
	Ij2U32EnTiV5FMHZjLlYwKDU5ukoz1ONwlO4R9wVxExuSdJRczllVovAISFHkLqn
	Cu0eJxbbv33XYt58Q1FmwCXVPOypuc0tv/Fm8HzPJYAYrqkvMcTMaBigtKHsoMlS
	e97z5bUait+OrSlP/WINFXpWqLR8XxZ2w1Ws4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3BA46B0E
	for <git@vger.kernel.org>; Thu,  1 Dec 2011 19:40:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 273106B0B for
 <git@vger.kernel.org>; Thu,  1 Dec 2011 19:40:51 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc4.177.g4d64
In-Reply-To: <1322699263-14475-6-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 48DCA472-1C7E-11E1-A293-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186201>

I would declare that the earlier parts of the v2 that are about factoring
out various API pieces from existing code are basically completed, so they
are not part of this iteration.

The bulk-checkin patch from v2 has been tweaked a bit (deflate_to_pack()
initializes "already_hashed_to" pointer to 0, instead of the current file
position "seekback"), and then the rest of the series builds on top of it
to add a new in-pack encoding that I am tentatively calling "chunked".

The basic idea is to represent a large/huge blob as a concatenation of
smaller blobs. An entry in a pack in "chunked" representation records a
list of object names of the component blob objects.  The object name given
to such a blob is computed exactly the same way as before. In other words,
the name of a object does not depend on its representation; we hash "blob
<size> NUL" and the whole large blob contents to come up with its name. It
is *not* the hash of the component blob object names.

As can be seen in the log message of the "support chunked-object encoding"
patch, many pieces are still missing from this series and filling them
will be a long and tortuous journey. But we need to start somewhere.

I specifically excluded any heuristics to split large objects into chunks
in a self-synchronising way so that a small edit near the beginning of a
large blob results in a handful of new component blobs followed by the
same component blobs as used to represent the same blob before such an
edit, and I do not plan to work on that part myself. My impression from
listening Avery's plug for "bup" is that it is a solved problem; it should
be reasonably straightforward to lift the logic and plug it into the
framework presented here (once the codebase gets solid enough, that is).

After this series, the next step for me is likely to teach the streaming
interface about "chunked" objects, and then pack-objects to take notice
and reuse "chunked" representation when sending things out (which means
that sending a "chunked" encoded blob would involve sending the component
blobs it uses, among other things), but I expect that it will extend well
into next year.

Junio C Hamano (6):
  bulk-checkin: replace fast-import based implementation
  varint-in-pack: refactor varint encoding/decoding
  new representation types in the packstream
  bulk-checkin: allow the same data to be multiply hashed
  bulk-checkin: support chunked-object encoding
  chunked-object: fallback checkout codepaths

 Makefile               |    3 +
 builtin/add.c          |    5 +
 builtin/pack-objects.c |   34 ++---
 bulk-checkin.c         |  415 ++++++++++++++++++++++++++++++++++++++++++++++++
 bulk-checkin.h         |   17 ++
 cache.h                |   13 ++-
 config.c               |    9 +
 environment.c          |    2 +
 pack-write.c           |   50 +++++-
 pack.h                 |    2 +
 sha1_file.c            |  150 +++++++++---------
 split-chunk.c          |   28 ++++
 t/t1050-large.sh       |  135 +++++++++++++++-
 zlib.c                 |    9 +-
 14 files changed, 760 insertions(+), 112 deletions(-)
 create mode 100644 bulk-checkin.c
 create mode 100644 bulk-checkin.h
 create mode 100644 split-chunk.c

-- 
1.7.8.rc4.177.g4d64
