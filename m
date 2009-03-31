From: Jeff King <peff@peff.net>
Subject: Re: bsd group semantics
Date: Tue, 31 Mar 2009 16:36:00 -0400
Message-ID: <20090331203600.GA24340@coredump.intra.peff.net>
References: <20090331112637.GA1910@coredump.intra.peff.net> <7vvdpp6623.fsf@gitster.siamese.dyndns.org> <20090331160842.GA9019@coredump.intra.peff.net> <7veiwd61k1.fsf@gitster.siamese.dyndns.org> <20090331184604.GA10701@coredump.intra.peff.net> <7vy6ul4exy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 22:38:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lokit-0004Rq-0c
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 22:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226AbZCaUgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 16:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754446AbZCaUgO
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 16:36:14 -0400
Received: from peff.net ([208.65.91.99]:41562 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397AbZCaUgN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 16:36:13 -0400
Received: (qmail 13044 invoked by uid 107); 31 Mar 2009 20:36:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 31 Mar 2009 16:36:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2009 16:36:00 -0400
Content-Disposition: inline
In-Reply-To: <7vy6ul4exy.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115313>

On Tue, Mar 31, 2009 at 01:26:01PM -0700, Junio C Hamano wrote:

> For now, I'd suggest teaching the test not to care about g+s bit.
> After all, they are about giving correct mode bits to files and
> directories.  Correct mode bits for group do not mean anything if you make
> them owned by a wrong group, but that is not something we have tested so
> far, and can be a separate test anyway.

Makes sense. How about this?

-- >8 --
Subject: [PATCH] t1301: loosen test for forced modes

One of the aspects of the test checked explicitly for the
g+s bit to be set on created directories. However, this is
only the means to an end (the "end" being having the correct
group set). And in fact, on systems where
DIR_HAS_BSD_GROUP_SEMANTICS is set, we do not even need to
use this "means" at all, causing the test to fail.

This patch removes that part of the test. In an ideal world
it would be replaced by a test to check that the group was
properly assigned, but that is difficult to automate because
it requires the user running the test suite be a member of
multiple groups.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1301-shared-repo.sh |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 11ef302..9b18507 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -147,9 +147,6 @@ test_expect_success 'forced modes' '
 	# Everything must be unaccessible to others
 	test -z "$(sed -n -e "/^.......---/d" actual)" &&
 
-	# All directories must have 2770
-	test -z "$(sed -n -e "/^drwxrws---/d" -e "/^d/p" actual)" &&
-
 	# post-update hook must be 0770
 	test -z "$(sed -n -e "/post-update/{
 		/^-rwxrwx---/d
-- 
1.6.2.1.591.geb450
