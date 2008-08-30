From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/12] Towards a better merge resolution support
Date: Fri, 29 Aug 2008 17:42:31 -0700
Message-ID: <1220056963-2352-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 02:43:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZEZL-00073m-5U
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 02:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbYH3Ams (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 20:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbYH3Ams
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 20:42:48 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42363 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbYH3Amr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 20:42:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 20BC76DC02
	for <git@vger.kernel.org>; Fri, 29 Aug 2008 20:42:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 63F716DC01 for <git@vger.kernel.org>; Fri, 29 Aug 2008 20:42:45
 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.149.ga4c44
X-Pobox-Relay-ID: 90388CF6-762C-11DD-A57B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94339>

This consists of two loosely related topics on improving conflicted merge
resolution support.

The early part of the series is what you already saw.  In addition to
recording a conflicted merge in the RCS merge style we have traditionally
used, this allows you to optionally use "diff3 -m" style.  The difference
is that the latter format shows the part from the common ancestor that
corresponds to the parts both sides modified to cause the conflict, in
addition to the changes done on each side.  This can be chosen by setting
a configuration variable.  Rerere mechanism is updated to understand this
new format as well, and conflicts from either formats interoperate well,
because rerere mechanism only records and uses the changes made on each
side, not what was in the common ancestor.

The last four patches are to "git checkout" that checks things out of the
index.  When resolving conflicts, sometimes you would screw up the state
of the working tree so badly that you would wish to redo the merge from
the beginning for one file, without having to redo the whole merge.  Some
other times, you already know changes made on one side already solves
everything the other side attempted to do, and would want to take the
change from that side as a whole.  New options supported by "git checkout"
when checking out from the index for these purposes are:

 * git checkout -m -- path

   This recreates the merge using information staged in stages 1/2/3;
 
 * git checkout --ours -- path

   This writes 'our' version (stage #2) out for the path to the working
   tree;

 * git checkout --theirs -- path

   This writes 'their' version (stage #3) out for the path to the working
   tree;

None of these operations mark the path resolved.  They are to help you
prepare the working tree into a shape suitable as the resolution, and you
will still conclude it with "git add path".

Junio C Hamano (12):
  xdl_fill_merge_buffer(): separate out a too deeply nested function
  xdiff-merge: optionally show conflicts in "diff3 -m" style
  xmerge.c: minimum readability fixups
  xmerge.c: "diff3 -m" style clips merge reduction level to EAGER or
    less
  rerere.c: use symbolic constants to keep track of parsing states
  rerere: understand "diff3 -m" style conflicts with the original
  merge.conflictstyle: choose between "merge" and "diff3 -m" styles
  git-merge-recursive: learn to honor merge.conflictstyle
  checkout: do not check out unmerged higher stages randomly
  checkout: allow ignoring unmerged paths when checking out of the
    index
  checkout --ours/--theirs
  checkout -m: recreate merge when checking out of unmerged index

 Documentation/config.txt  |    8 ++
 builtin-checkout.c        |  206 +++++++++++++++++++++++++++++++++++----
 builtin-merge-file.c      |   17 +++-
 builtin-merge-recursive.c |    2 +-
 ll-merge.c                |   16 +++-
 rerere.c                  |   29 ++++--
 t/t6023-merge-file.sh     |   44 +++++++++
 t/t7201-co.sh             |  133 +++++++++++++++++++++++++
 xdiff-interface.c         |   20 ++++
 xdiff-interface.h         |    2 +
 xdiff/xdiff.h             |    6 +
 xdiff/xmerge.c            |  237 +++++++++++++++++++++++++++++++--------------
 12 files changed, 612 insertions(+), 108 deletions(-)
