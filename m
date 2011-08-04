From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/6] git-check-attr should work for relative paths
Date: Thu,  4 Aug 2011 06:47:42 +0200
Message-ID: <1312433268-11385-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:48:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoprB-0000n2-Na
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998Ab1HDEsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:48:01 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39749 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab1HDEsA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:48:00 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744ltPV029942;
	Thu, 4 Aug 2011 06:47:56 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178693>

This is a reroll of the earlier RFC.  It must be applied on top of
"Add --all option to git-check-attr" v3.

This re-roll differs in the following ways from the RFC:

* Adjusted for changes between the "--all" patch series v2 -> v3.

* Fixed some C problems found by Junio.


Currently, git-check-attr gets confused if it is passed certain types
of unnormalized paths or is invoked from a non-top-level directory.
For example, using the test repo created by t0003-attributes.sh,
inquiring about a path that starts with "./" causes git-check-attr to
emit a spurious warning:

    $ git check-attr test ./f
    [attr]notest !test
     not allowed: ./.gitattributes:1
    ./f: test: f
    $ git check-attr test ./a/i
    [attr]notest !test
     not allowed: ./.gitattributes:1
    ./a/i: test: a/i

In these cases it seems to find the right values, even including the
application of macros from the top-level .gitattributes file.  (My
guess is that it is loading the top-level .gitattributes file
twice--once as a top-level file, and once believing that it is in a
subdirectory.)

Invoking git-check-attr from a subdirectory using a relative path
gives incorrect answers; for example:

    $ (cd a; git check-attr test i )
    i: test: unspecified

(On the other hand, if invoked using the full path of a file, it
"works":

    $ (cd a; git check-attr test a/i )
    a/i: test: a/i

.)  I think that this behavior is confusing and inconsistent with
other git commands.  It is also inconsistent with the behavior of
.gitignore, which works from subdirectories.

The patches in this series add tests demonstrating the problem,
propose a possible solution, and add a couple of subcommands to
test-path-utils.

The changes to test-path-utils helped me figure out how the
corresponding functions work (comments? we don't need no stinkin'
comments) but they are not used anywhere.  Take 'em or leave 'em.


Michael Haggerty (6):
  git-check-attr: test that no output is written to stderr
  git-check-attr: Demonstrate problems with unnormalized paths
  git-check-attr: Demonstrate problems with relative paths
  git-check-attr: Normalize paths
  test-path-utils: Add subcommand "absolute_path"
  test-path-utils: Add subcommand "prefix_path"

 builtin/check-attr.c  |   20 ++++++++++++--------
 t/t0003-attributes.sh |   29 ++++++++++++++++++++++++++---
 test-path-utils.c     |   22 ++++++++++++++++++++++
 3 files changed, 60 insertions(+), 11 deletions(-)

-- 
1.7.6.8.gd2879
