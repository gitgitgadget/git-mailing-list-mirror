From: Johan Herland <johan@herland.net>
Subject: [RFC 00/11] Foreign VCS helper program for CVS repositories
Date: Mon, 27 Jul 2009 03:04:08 +0200
Message-ID: <1248656659-21415-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, barkalow@iabervon.org,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 03:05:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVEeL-0003wO-Di
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 03:05:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbZG0BEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 21:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754701AbZG0BEz
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 21:04:55 -0400
Received: from mx.getmail.no ([84.208.15.66]:46984 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754674AbZG0BEy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jul 2009 21:04:54 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNF00L1L1O37K70@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 27 Jul 2009 03:04:51 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNF004SX1O2UG30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 27 Jul 2009 03:04:51 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.7.27.4819
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124142>

This series is a first draft towards implementing a foreign VCS helper
program for CVS.

It is based on the 'db/foreign-scm' and 'jh/notes' topics in 'pu'. As such,
this patch series should apply cleanly to current 'pu'.

The first 4 patches supply the necessary parts of Daniel Barkalow's
foreign-scm topic that has not yet been merged to 'pu' (i.e. everything
remaining in Daniel's original patch series, except the p4-specific stuff).

The next 2 patches add some functionality to git fast-import, for
facilitating the import of 'notes' objects (this is a _much_ faster way to
generate/import notes than invoking "git notes edit -m MSG" for each note).

Next, there are 3 patches tweaking and expanding the git-vcs API (with
corresponding implementations in the foreign transport code) to adjust for
the CVS helper's needs.

The final 2 patches add the git-vcs-cvs helper program that implements the
fetch/import of objects from a local or remote CVS repository, along with
selftests for verifying its correctness in some simple cases. This is a
first RFC/draft of this helper program, and will hopefully grow along with
the foreign-scm feature itself until it provides a compelling alternative
to "git cvsimport" and "git cvsexportcommit".


Daniel Barkalow (4):
  Add specification of git-vcs-* helper programs
  Use a function to determine whether a remote is valid
  Allow programs to not depend on remotes having urls
  Add a transport implementation using git-vcs-* helpers

Johan Herland (7):
  Refactor path name parsing into new function: get_path_str()
  Add support for mark references as path names
  Preliminary clarifications to git-vcs documentation
  Teach foreign transport code to perform the "capabilities" command
  Introduce a 'marks <filename>' feature to the foreign transport code
  First draft of CVS importer using the foreign-scm machinery
  Add simple test cases of git-vcs-cvs functionality

 Documentation/git-fast-import.txt |    9 +-
 Documentation/git-vcs-cvs.txt     |   85 ++++
 Documentation/git-vcs.txt         |   88 ++++
 Makefile                          |   47 ++
 builtin-fetch.c                   |   19 +-
 builtin-ls-remote.c               |    4 +-
 builtin-push.c                    |   54 ++-
 configure.ac                      |    3 +
 fast-import.c                     |   71 ++--
 git-vcs-cvs.py                    |  697 +++++++++++++++++++++++++++++
 git_vcs_cvs/.gitignore            |    2 +
 git_vcs_cvs/Makefile              |   27 ++
 git_vcs_cvs/changeset.py          |  114 +++++
 git_vcs_cvs/commit_states.py      |   52 +++
 git_vcs_cvs/cvs.py                |  884 +++++++++++++++++++++++++++++++++++++
 git_vcs_cvs/cvs_revision_map.py   |  367 +++++++++++++++
 git_vcs_cvs/cvs_symbol_cache.py   |  283 ++++++++++++
 git_vcs_cvs/git.py                |  588 ++++++++++++++++++++++++
 git_vcs_cvs/setup.py              |   12 +
 git_vcs_cvs/util.py               |  147 ++++++
 remote.c                          |   13 +-
 t/t9800-foreign-vcs-cvs-basic.sh  |  518 ++++++++++++++++++++++
 t/t9801-foreign-vcs-cvs-fetch.sh  |  291 ++++++++++++
 t/test-lib.sh                     |    1 +
 transport-foreign.c               |  271 ++++++++++++
 transport.c                       |    4 +
 transport.h                       |    1 +
 27 files changed, 4588 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/git-vcs-cvs.txt
 create mode 100644 Documentation/git-vcs.txt
 create mode 100755 git-vcs-cvs.py
 create mode 100644 git_vcs_cvs/.gitignore
 create mode 100644 git_vcs_cvs/Makefile
 create mode 100644 git_vcs_cvs/__init__.py
 create mode 100644 git_vcs_cvs/changeset.py
 create mode 100644 git_vcs_cvs/commit_states.py
 create mode 100644 git_vcs_cvs/cvs.py
 create mode 100644 git_vcs_cvs/cvs_revision_map.py
 create mode 100644 git_vcs_cvs/cvs_symbol_cache.py
 create mode 100644 git_vcs_cvs/git.py
 create mode 100644 git_vcs_cvs/setup.py
 create mode 100644 git_vcs_cvs/util.py
 create mode 100755 t/t9800-foreign-vcs-cvs-basic.sh
 create mode 100755 t/t9801-foreign-vcs-cvs-fetch.sh
 create mode 100644 transport-foreign.c


Have fun! :)

...Johan
