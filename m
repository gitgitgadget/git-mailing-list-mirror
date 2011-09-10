From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/7] Improved infrastructure for refname normalization
Date: Sat, 10 Sep 2011 08:50:36 +0200
Message-ID: <1315637443-14012-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 10 08:51:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2HPd-0001xv-R5
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 08:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757670Ab1IJGvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Sep 2011 02:51:10 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:33357 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755905Ab1IJGvI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2011 02:51:08 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEAB10.dip.t-dialin.net [84.190.171.16])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8A6ol8q024666;
	Sat, 10 Sep 2011 08:50:48 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181143>

Patch series re-roll:

The main difference is that I incorporated feedback from Junio that it
should be made more difficult to use unnormalized references.  The
mechanism that I selected is a bit different than discussed in the
mailing list; I changed normalize_refname() to accept unnormalized
refnames *only* if the dst argument is non-NULL.  I changed
check_ref_format() to reject unnormalized refnames but implemented a
transitional function check_ref_format_unsafe() that has the old
behavior and changed callers to use the _unsafe function to avoid
changing their behavior.


As a prerequisite to storing references caches hierarchically (itself
needed for performance reasons), here is a patch series to help us get
refname normalization under control.

The problem is that some UI accepts unnormalized reference names (like
"/foo/bar" or "foo///bar" instead of "foo/bar") and passes them on to
library routines without normalizing them.  The library, on the other
hand, assumes that the refnames are normalized.  Sometimes (mostly in
the case of loose references) unnormalized refnames happen to work,
but in other cases (like packed references or when looking up refnames
in the cache) they silently fail.  Given that refnames are sometimes
treated as path names, there is a chance that some security-relevant
bugs are lurking in this area, if not in git proper then in scripts
that interact with git.

This patch series adds the following tools for dealing with refnames
and their normalization (without actually doing much to fix the
problem; see below):

* Fix check_ref_format() to make it easier and reliable to specify
  which types of refnames are allowed in a particular situation
  (multi-level vs. one-level, with vs. without a refspec-like "*").
  This function only accepts normalized refnames.

* Add a function normalize_refname() that accepts unnormalized
  refnames, checks the format, and outputs a normalized version.

* Add a function check_ref_format_unsafe() that has the old behavior.
  Change callers to use this function until they can be fixed.

* Add options to "git check-ref-format" to give scripts access to
  these facilities (and to allow them to be tested in the test suite).

* Forbid ".lock" at the end of any refname component, as directories
  with such names can conflict with attempts to create lock files for
  other refnames.


I suggest the following policy for handling unnormalized refnames more
consistently:

Unnormalized refnames should only be accepted at the UI level and
should be normalized before use.  This can be done using code like

    int len = strlen(arg);
    char *normalized_refname = xmalloc(len);
    if (normalize_refname(normalized_refname, len, arg, flags))
        die("invalid refname '%s'", arg);

    /* From now on, use normalized_refname. */

Refnames coming from other sources, such as from a remote repository,
should be checked that they are in the correct *normalized* format,
like so:

    if (check_ref_format(refname, flags))
        die("invalid refname '%s'", refname);

Refnames from the local repository (e.g., from the packed references
file) should also be checked that they are in the correct normalized
format, though this policy could be debated if there are performance
concerns.

Refnames probably do not need to be checked at the entrance to the
refs.{c,h} library functions because callers are responsible for not
passing invalid or unnormalized refnames in.  However, some assert()s
would probably be justified, especially during the transition while we
are fixing broken callers.

If there is agreement about this policy, I would be happy to write it
up (presumably in Documentation/technical/api-ref.txt, maybe also
incorporating the content from
Documentation/technical/api-ref-iteration.txt).

I do not yet have enough global overview of the code to know which
callers need fixing, but once these tools are in place the callers can
be fixed incrementally.

Michael Haggerty (7):
  t1402: add some more tests
  Change bad_ref_char() to return a boolean value
  git check-ref-format: add options --allow-onelevel and
    --refspec-pattern
  Change check_ref_format() to take a flags argument
  Add a library function normalize_refname()
  Do not allow ".lock" at the end of any refname component
  Add tools to avoid the use of unnormalized refnames.

 Documentation/git-check-ref-format.txt |   44 ++++++++--
 builtin/check-ref-format.c             |   76 +++++++++---------
 builtin/checkout.c                     |    2 +-
 builtin/fetch-pack.c                   |    2 +-
 builtin/receive-pack.c                 |    2 +-
 builtin/replace.c                      |    2 +-
 builtin/show-ref.c                     |    2 +-
 builtin/tag.c                          |    4 +-
 connect.c                              |    2 +-
 environment.c                          |    2 +-
 fast-import.c                          |    7 +--
 notes-merge.c                          |    5 +-
 pack-refs.c                            |    2 +-
 refs.c                                 |  139 +++++++++++++++++++------------
 refs.h                                 |   46 +++++++++-
 remote.c                               |   54 ++++---------
 sha1_name.c                            |    4 +-
 t/t1402-check-ref-format.sh            |   96 ++++++++++++++++++++--
 transport.c                            |   17 +---
 walker.c                               |    2 +-
 20 files changed, 325 insertions(+), 185 deletions(-)

-- 
1.7.6.8.gd2879
