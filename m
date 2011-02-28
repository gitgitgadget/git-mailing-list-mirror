From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] Using index-pack in place of verify-pack
Date: Mon, 28 Feb 2011 01:49:38 -0800
Message-ID: <1298886583-30965-1-git-send-email-gitster@pobox.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 28 10:49:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptzjn-0000oe-Im
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 10:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198Ab1B1Jtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 04:49:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab1B1Jtu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 04:49:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4A118353E;
	Mon, 28 Feb 2011 04:51:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=L1EyYQBwIhAYiFIy4pwodVH7dU0
	=; b=PhIeZVE2fr0tRmdI9DG8fkrE+Vm4j58MeSyJso79sV4sh/rRehb6dGRNZhk
	P5LxZu03ueSeLwbBWOBF+xQ+Jhu28YZEmcaVDK+HkAdm2gV1GTBznBvRdHoWTtda
	CJjKGouP+VGL4jYPsVndpLjzzBY5g6Pi7QzqywP5iZPc/Wo4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=km5B2G1yjjmIZp6zktexv
	v6rMjz5Vz6AIRwZQL8VDUg6rD7xy5scQyBsoAqrpEQwQ6IADnEup+3TuysAVuHaT
	zfgJKYXSsCoOb28cB2tsVF3QxnXR0CQQNrXVv+BR7Ye1YQw53qK+0D1Q/8PLre3C
	hlHgk57+fLCt12W46EQrAk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 37ABE353D;
	Mon, 28 Feb 2011 04:51:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 88BA5353C; Mon, 28 Feb 2011
 04:51:02 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.249.g4aa72
X-Pobox-Relay-ID: 42451C3A-4320-11E0-A696-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168086>

The verify-pack command walks objects in a pack for contents verification
in a very naive way, namely, in the object name order.  It is inefficient
compared to the way index-pack does, which verifies contents of the
objects in the order delta-chain is applied.  As the result, the former
command would end up reconstituting the same intermediate object in a
delta chain number of times while the latter would recreate an object only
once.

This series, which is still a WIP, is to teach index-pack "--verify"
option, in order to eventually replace verify-pack with it.

The basic idea, which comes from Shawn Pearce, is to run index-pack on a
packfile being verified, and compare the resulting .idx file with the
existing one, and make sure they match.

Junio C Hamano (5):
  index-pack: group the delta-base array entries also by type
  write_idx_file: introduce a struct to hold idx customization options
  index-pack: --verify
  write_idx_file: need_large_offset() helper function
  index-pack --verify: read anomalous offsets from v2 idx file

 builtin/index-pack.c   |  178 ++++++++++++++++++++++++++++++++++++++----------
 builtin/pack-objects.c |   20 +++---
 csum-file.c            |   46 ++++++++++++-
 csum-file.h            |    2 +
 fast-import.c          |   10 ++-
 pack-write.c           |   82 ++++++++++++++++------
 pack.h                 |   23 +++++-
 t/t5302-pack-index.sh  |   18 +++++
 8 files changed, 301 insertions(+), 78 deletions(-)
