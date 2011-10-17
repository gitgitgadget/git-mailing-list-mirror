From: mhagger@alum.mit.edu
Subject: [PATCH v4 0/7] Provide API to invalidate refs cache
Date: Mon, 17 Oct 2011 04:38:04 +0200
Message-ID: <1318819091-7066-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 04:39:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFd6V-00026B-4D
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 04:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225Ab1JQCio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 22:38:44 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:45398 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab1JQCin (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 22:38:43 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BECB73.dip.t-dialin.net [84.190.203.115])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9H2cN3S013403;
	Mon, 17 Oct 2011 04:38:24 +0200
X-Mailer: git-send-email 1.7.7.rc2
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183757>

From: Michael Haggerty <mhagger@alum.mit.edu>

These patches are re-rolled onto the current master and incorporate
Junio's suggestion to rename "struct cached_refs" to "ref_cache".

This patch series provides an API for external code to invalidate the
ref cache that is used internally to refs.c.  It also allows code
*within* refs.c to invalidate only the packed or only the loose refs
for a module/submodule.

IMPORTANT:

I won't myself have time to figure out who, outside of refs.c, has to
*call* invalidate_ref_cache().  The candidates that I know off the top
of my head are git-clone, git-submodule [1], and git-pack-refs.  It
would be great if experts in those areas would insert calls to
invalidate_ref_cache() where needed.

Even better would be if the meddlesome code were changed to use the
refs API.  I'd be happy to help expanding the refs API if needed to
accommodate your needs.

This is why the API for invalidating only packed or loose refs is
private.  After code outside refs.c is changed to use the refs API, it
will get the optimal behavior for free (and at that time
invalidate_ref_cache() can be removed again).

[1] http://marc.info/?l=git&m=131827641227965&w=2
    In this mailing list thread, Heiko Voigt stated that git-submodule
    does not modify any references, so it should not have to use the
    API.

Michael Haggerty (7):
  invalidate_ref_cache(): rename function from invalidate_cached_refs()
  invalidate_ref_cache(): take the submodule as parameter
  invalidate_ref_cache(): expose this function in the refs API
  clear_ref_cache(): rename parameter
  clear_ref_cache(): extract two new functions
  write_ref_sha1(): only invalidate the loose ref cache
  clear_ref_cache(): inline function

 refs.c |   59 +++++++++++++++++++++++++++++++----------------------------
 refs.h |    8 ++++++++
 2 files changed, 39 insertions(+), 28 deletions(-)

-- 
1.7.7.rc2
