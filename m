From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/7] Removing the guesswork of HEAD in "clone"
Date: Tue, 17 Sep 2013 22:14:16 -0700
Message-ID: <1379481263-29903-1-git-send-email-gitster@pobox.com>
Cc: Andreas Krey <a.krey@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 18 07:14:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMA69-0005p5-Ew
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 07:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351Ab3IRFO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 01:14:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43283 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256Ab3IRFO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 01:14:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AE7E3C92F;
	Wed, 18 Sep 2013 05:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id; s=sasl; bh=VkZIxl2YY8x/2Nnio54KI3OAU8A
	=; b=etXTL7rK4Q8hBDtGUBwQcijFIyrJDWS4fY/Wt5wEkiq/YAAmmxTIjq8wa0h
	OGmX8X+ZfbA8fynDVWIMRCQkORwC4UXEnswt6h7nZh7hCguosB8OaMZhB++0s0sF
	WbNtav3bHPrv2IerhlNRiSqxNblyRdCKMEnVI52RS/3vz/cQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id; q=dns; s=sasl; b=rtmvq9SzPLQwfBCxiwFoU
	axQDBptbp5wqSBh5B+vcPAYFpiPn1T9woTIOqf57Uv3PTmIoPiV43mYAtZVhwOzX
	gj6QIm82vqsOILuKkihm6W7kj0mSoLdkOBSKhNM5y0mYS+Ux5sbaKjzZc+Uqu9dg
	PaqXX2kUjuw9IJQANeA2q0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D2223C92E;
	Wed, 18 Sep 2013 05:14:26 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 871233C92C;
	Wed, 18 Sep 2013 05:14:25 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-585-g8d1dcaf
X-Pobox-Relay-ID: 2F9634A8-2021-11E3-BA7B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234950>

This reworks the old idea from 2008 ($gmane/102039) to teach
upload-pack to say where symbolic refs are pointing at in the
initial ref advertisement as a new capability "symref", and allows
"git clone" to take advantage of that knowledge when deciding what
branch to point at with the HEAD of the newly created repository.

Credits for re-igniting the ember with an earlier patch series goes
to Andreas Krey.

 * The test-fix in [PATCH 1/7] is new this round.

 * The main patch to upload-pack.c [PATCH 3/7] has the fix I earlier
   sent.  The capability was called "sym" in the previous one, but
   it spells out "symref" in this round.

 * The patch on the receiving end [PATCH 6/7] now comes with an
   update to a test that was fixed in [PATCH 1/7].

This round seems to pass all the test, and the code is fairly
straight-forward, so it may be ready for at least 'pu' if not
'next'.

The series is to be applied on top of v1.8.4; between there and the
'master', there is some code reorganization to create connect.h out
of cache.h which may cause patch conflict, but it should be trivial
to fix when merging it up (queued as an evil merge near the tip of
the 'pu' branch).


Junio C Hamano (7):
  t5505: fix "set-head --auto with ambiguous HEAD" test
  upload-pack.c: do not pass confusing cb_data to mark_our_ref()
  upload-pack: send symbolic ref information as capability
  upload-pack: send non-HEAD symbolic refs
  connect.c: make parse_feature_value() static
  connect: annotate refs with their symref information in
    get_remote_head()
  clone: test the new HEAD detection logic

 cache.h           |  1 -
 connect.c         | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 t/t5505-remote.sh | 16 +++++---------
 t/t5601-clone.sh  | 11 ++++++++++
 upload-pack.c     | 51 ++++++++++++++++++++++++++++++++++++++------
 5 files changed, 123 insertions(+), 19 deletions(-)

-- 
1.8.4-585-g8d1dcaf
