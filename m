From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/6] Improved infrastructure for refname normalization
Date: Fri,  9 Sep 2011 13:46:12 +0200
Message-ID: <1315568778-3592-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 13:46:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1zXt-0005nF-Oq
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 13:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933480Ab1IILqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 07:46:42 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:46239 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758767Ab1IILql (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 07:46:41 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R1zTN-0002Qy-OJ; Fri, 09 Sep 2011 13:42:17 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181051>

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
  (multi-level vs. one-level, with vs. without a refspec-like "*",
  normalized or unnormalized).

* Add a function normalize_refname() that can check and optionally
  normalize refnames according to the one true set of rules.

* Add options to "git check-ref-format" to give scripts access to
  these facilities (and to allow them to be tested in the test suite).

* Forbid ".lock" at the end of any refname component, as directories
  with such names can conflict with attempts to create lock files for
  other refnames.


The patches just provide the tools for handling refnames more
consistently.  How do we actually fix the problem of inconsistent
handling of refname normalization?  First we need policy.  I suggest
the following:

Unnormalized refnames should only be accepted at the UI level and
should be normalized before use.  This can be done using code like

    char normalized_refname[strlen(arg) + 1];
    if (normalize_refname(normalized_refname, sizeof(normalized_refname),
                           arg, REFNAME_ALLOW_UNNORMALIZED|other_flags))
        die("invalid refname '%s'", arg);

    /* From now on, use normalized_refname. */

Refnames coming from other sources, such as from a remote repository,
should be checked that they are in the correct *normalized* format,
like so:

    if (check_ref_format(refname, other_flags))
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

Michael Haggerty (6):
  Change bad_ref_char() to return a boolean value
  git check-ref-format: add options --onelevel-ok and --refname-pattern
  Change check_ref_format() to take a flags argument
  Add a library function normalize_refname()
  Do not allow ".lock" at the end of any refname component
  Add a REFNAME_ALLOW_UNNORMALIZED flag to check_ref_format()

 Documentation/git-check-ref-format.txt |   42 ++++++++--
 builtin/check-ref-format.c             |   62 ++++++++--------
 builtin/checkout.c                     |    2 +-
 builtin/fetch-pack.c                   |    2 +-
 builtin/receive-pack.c                 |    3 +-
 builtin/replace.c                      |    2 +-
 builtin/show-ref.c                     |    2 +-
 builtin/tag.c                          |    4 +-
 connect.c                              |    2 +-
 environment.c                          |    2 +-
 fast-import.c                          |    7 +--
 notes-merge.c                          |    5 +-
 pack-refs.c                            |    2 +-
 refs.c                                 |  133 +++++++++++++++++++-------------
 refs.h                                 |   30 ++++++-
 remote.c                               |   55 ++++---------
 sha1_name.c                            |    4 +-
 t/t1402-check-ref-format.sh            |   93 ++++++++++++++++++++--
 transport.c                            |   18 ++---
 walker.c                               |    2 +-
 20 files changed, 294 insertions(+), 178 deletions(-)

-- 
1.7.6.8.gd2879
