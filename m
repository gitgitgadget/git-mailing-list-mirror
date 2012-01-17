From: mhagger@alum.mit.edu
Subject: [PATCH 0/4] Remove a user of extra_refs in clone
Date: Tue, 17 Jan 2012 06:50:30 +0100
Message-ID: <1326779434-20106-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 06:50:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rn1wd-0005w5-Es
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 06:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825Ab2AQFuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 00:50:51 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50010 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725Ab2AQFuu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 00:50:50 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEDA74.dip.t-dialin.net [84.190.218.116])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q0H5oam2006829;
	Tue, 17 Jan 2012 06:50:37 +0100
X-Mailer: git-send-email 1.7.8.3
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188685>

From: Michael Haggerty <mhagger@alum.mit.edu>

When cloning, write_remote_refs() creates local packed refs from the
refs read from the remote repository.  It does this by creating extra
refs for the references then calling pack_refs() to bake the extra
refs into the packed-refs file, then calling clear_extra_refs().

This is silly and relies on the kludgy extra_refs mechanism, which I
want to get rid of.  Instead, add a function call add_packed_ref() to
the refs API, and use it to create packed refs (in the memory cache)
directly.  Then call pack_refs() as before to write the packed-refs
file.

Because the new add_packed_ref() function allows references (perhaps
many of them) to be added to an existing ref_array, it would be
inefficient to re-sort the list after every addition.  So instead,
append new entries to the end of the ref_array and note that the array
is unsorted.  Then, before the ref_array is used, check if it is
unsorted and sort it if necessary.

A side effect of this change is that the new packed references are
left in the in-memory packed reference cache after the return from
write_remote_refs() (whereas previously, the refs were stored as
temporary extra refs that were purged before return from the
function).  I can't see any place in the following code where this
would make a difference, but there is quite a bit of code there so it
is hard to audit.  Confirmation that this is OK would be welcome.

Michael Haggerty (4):
  pack_refs(): remove redundant check
  ref_array: keep track of whether references are sorted
  add_packed_ref(): new function in the refs API.
  write_remote_refs(): create packed (rather than extra) refs

 builtin/clone.c |    3 +--
 pack-refs.c     |    3 +--
 refs.c          |   39 ++++++++++++++++++++++++++++++++-------
 refs.h          |    6 ++++++
 4 files changed, 40 insertions(+), 11 deletions(-)

-- 
1.7.8.3
