From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 0/5] Pretty formats for reflog data
Date: Fri, 16 Oct 2009 16:20:32 +0200
Message-ID: <cover.1255701207.git.trast@student.ethz.ch>
References: <20091016053230.GB10629@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 16 16:25:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MynkM-0008Gh-Ar
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 16:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbZJPOV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 10:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760002AbZJPOV7
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 10:21:59 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:25267 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759992AbZJPOV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 10:21:58 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 16 Oct
 2009 16:21:10 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Fri, 16 Oct
 2009 16:21:10 +0200
X-Mailer: git-send-email 1.6.5.116.g4aaa3
In-Reply-To: <20091016053230.GB10629@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130489>

Next round :-)

I only changed 3/5, as per your comments:

Jeff King wrote:
> On Fri, Oct 16, 2009 at 12:41:46AM +0200, Thomas Rast wrote:
> > +- '%gD': reflog selector, e.g., `refs/stash@{1}`
> > +- '%gd': shortened reflog selector, e.g., `stash@{1}`
> > +- '%gs': reflog subject
> 
> Should we give a note that these do nothing if "-g" was not given?

I tried for some time, but all attempts at interrupting the lists
ended up terminating it again, so that the %g family list would not
line up with the rest of the parameters.  Having the note there would
be nice, but I think keeping the list together optically is more
important.  However, AFAICS it really is the first character that only
works with certain options (%m makes little sense without A...B, but
still expands to >).

Looking at it did make me notice that @{1} is invalid asciidoc and
needs to be spelled @\{1\} though :-)

> A test for '%gd' would be nice. A squashable one is below. I am tempted
> to test all three forms in t6006, since the intent of that script is to
> test all format specifiers. However, those tests would be somewhat
> redundant with your t1411 tests.

I added yours and moved my tests to t6006 too, as indicated in the
other mail.

I also changed the caching, as outlined earlier:

I wrote:
> I had a slightly better idea today: We can just put an extra member
> into the complete_reflogs struct, i.e., a short_ref to go along with
> the ref.  It'll take a bit of auditing to verify that all allocations
> are zeroed, but since the struct is local to the file that shouldn't
> be so hard.

There's in fact only a single allocation (with xcalloc).


Thomas Rast (5):
  Refactor pretty_print_commit arguments into a struct
  reflog-walk: refactor the branch@{num} formatting
  Introduce new pretty formats %g[sdD] for reflog information
  stash list: use new %g formats instead of sed
  stash list: drop the default limit of 10 stashes

 Documentation/pretty-formats.txt |    3 +
 builtin-branch.c                 |    3 +-
 builtin-checkout.c               |    3 +-
 builtin-log.c                    |    3 +-
 builtin-merge.c                  |    7 ++-
 builtin-rev-list.c               |    7 ++-
 builtin-shortlog.c               |    9 +++-
 builtin-show-branch.c            |    4 +-
 commit.h                         |   20 ++++++---
 git-stash.sh                     |    8 +---
 log-tree.c                       |   21 +++++-----
 pretty.c                         |   44 ++++++++++++++------
 reflog-walk.c                    |   83 ++++++++++++++++++++++++++++----------
 reflog-walk.h                    |    8 ++++
 t/t6006-rev-list-format.sh       |   18 ++++++++
 15 files changed, 170 insertions(+), 71 deletions(-)
