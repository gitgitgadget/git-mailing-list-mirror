From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/6] "git repack -a -d" improvements
Date: Sat, 28 Feb 2009 01:15:05 -0800
Message-ID: <cover.1235812035.git.gitster@pobox.com>
References: <alpine.LFD.2.00.0902191318310.21686@localhost.localdomain>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 10:17:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdLK4-0001wI-Hd
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 10:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754389AbZB1JPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 04:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755721AbZB1JPX
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 04:15:23 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593AbZB1JPU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 04:15:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 552DB9D466
	for <git@vger.kernel.org>; Sat, 28 Feb 2009 04:15:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A61689D465 for
 <git@vger.kernel.org>; Sat, 28 Feb 2009 04:15:17 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc2.99.g9f3bb
In-Reply-To: <alpine.LFD.2.00.0902191318310.21686@localhost.localdomain>
X-Pobox-Relay-ID: 51247B5C-0578-11DE-AD95-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111758>

This is series removes the linear search in "ignore_packed" list when "git
repack -a -d" is run to consolidate many packfiles that are not marked to
be kept with ".keep".  It is oversplit for easier review; in the final
form, I think it should be two patch series, 1/6 and the rest.

The current mechanism is to pass the name of packfiles that are not marked
to be kept with --unpacked= command line option.  This list is used to a
few internal functions to pretend as if the objects found in named packs
exist in loose form and subject to repacking.  This look-up is linear and
found to be very inefficient.

[1/6] is a preparatory and an unrelated bugfix to git-repack script.

[2/6] refactors public interface has_sha1_pack() that takes an optional
"ignore_packed" list.  Most callers pass NULL, so it introduces a new
function has_sha1_kept_pack() and migrate the minority caller to this
interface while losing the argument from the original function and callers
that currently pass NULL.

[3/6] temporarily makes the the extra argument to has_sha1_kept_pack()
function to pass "ignore_packed" list from a list of char* to a pointer to
struct rev_info, solely to make the refactoring done in [4/6] easier to
follow.  Most of the effects of this patch will be removed at the end.

[4/6] identifies three places that use "ignore_packed" list to tell if a
pack is on the list or not, and introduces a helper function to do so.
The helper is conveniently called is_kept_pack(), even though at this
stage the list does not necessarily mean a list of "unkept" packs yet.

[5/6] removes --unpacked=<packfile> parameter, and adds --kept-pack-only
option.  The sole user of --unpacked=<packfile>, git-repack, is updated to
pass this option instead of listing the "unkept" packfiles on the command
line.

[6/6] reverts most of the effects of [3/6] made solely for reviewability
and removes is_kept_pack() helper function, which now is merely a lookup
of a structure member "p->pack_keep".

I think we probably could get rid of --honor-pack-keep mechanism after
this series, but I didn't look very deeply into it.

Junio C Hamano (6):
  git-repack: resist stray environment variable
  has_sha1_pack(): refactor "pretend these packs do not exist"
    interface
  has_sha1_kept_pack(): take "struct rev_info"
  Consolidate ignore_packed logic more
  Simplify is_kept_pack()
  is_kept_pack(): final clean-up

 builtin-count-objects.c |    2 +-
 builtin-fsck.c          |    2 +-
 builtin-pack-objects.c  |   14 ++--------
 builtin-prune-packed.c  |    2 +-
 cache.h                 |    4 +-
 diff.c                  |    2 +-
 git-repack.sh           |    6 ++++-
 revision.c              |   25 +++++++------------
 revision.h              |    6 +---
 sha1_file.c             |   60 ++++++++++++++++++++--------------------------
 10 files changed, 51 insertions(+), 72 deletions(-)
