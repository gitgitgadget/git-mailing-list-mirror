From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 00/13] Native and foreign helpers
Date: Wed, 5 Aug 2009 01:01:49 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908050052390.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 07:01:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYYdS-00075U-6q
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 07:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbZHEFBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 01:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753547AbZHEFBu
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 01:01:50 -0400
Received: from iabervon.org ([66.92.72.58]:36984 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751923AbZHEFBt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 01:01:49 -0400
Received: (qmail 18246 invoked by uid 1000); 5 Aug 2009 05:01:49 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2009 05:01:49 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series has three parts:

 01 - 03: Use an external program to fetch with curl. This improves
          performance of scripts that call a lot of simple git
          programs on systems where libcurl has a lot of dependencies
          substantially, and introduces a standard format for external
          helpers. Since the push side of http support is still
          invoked from a custom helper program by the core transport
          code, http support cannot yet be made a completely separate
          package, but this is a step in that direction. Since the
          previous version, this section has a few type fixes and in
          more consistent about its use of strbufs.

 04 - 10: Allow the external helper to import data from a foreign
          system. This system may not use URLs at all, or may not use
          them in a way that distinguishes the usage from git's
          usage. The core code has to be able to deal with only
          getting the values of refs after they have been imported,
          not when they are simply listed, and deciding based on a
          flag and the name whether to import them. The helper code
          may (to this point) avoid doing anything to require the
          local system to be git, rather than any other gfi-supporting
          system (although there is no support for limiting the
          generated history to things a particular system can
          represent). This series has changed substantially since
          previous versions, centered around sharing code with the
          native helper methods, supporting code for the cvs and p4
          helpers as they have evolved, and various fixes. Johan
          Herland wrote the bulk of the last patch, including
          specifying the command; I removed some portions of his patch
          that were made unnecessary by changes to this series (and
          rebasing it on the previous series).

 11 - 13: Draft external helper for cvs. The first two patches are
          directly by Johan Herland, and are included unchanged. The
          final patch is the changes needed for the difference in API
          between the original "vcs helper" series and the current
          04-10. In order to get this part to work, the "jh/notes"
          branch in pu is required, although the patches apply without
          it.

As a separate series, I will be sending a new version of my p4 helper,
in addition to handling for an "export" command which is not yet
nailed down, since it is only supported by one helper and is not
agnostic as to the source system (like the import command can be).

Daniel Barkalow (10):
  Add support for external programs for handling native fetches
  Use an external program to implement fetching with curl
  Use a function to determine whether a remote is valid
  Allow fetch to modify refs
  Allow programs to not depend on remotes having urls
  Add a config option for remotes to specify a foreign vcs
  Add support for "import" helper command
  Allow helpers to report in "list" command that the ref is unchanged
  Changes for new vcs-helper series

Johan Herland (3):
  Allow helpers to request marks for fast-import
  First draft of CVS importer using the foreign-scm machinery
  Add simple test cases of git-vcs-cvs functionality

Linus Torvalds (1):
  git-http-fetch: not a builtin

 Documentation/config.txt             |    4 +
 Documentation/git-remote-helpers.txt |   91 ++++
 Documentation/git-vcs-cvs.txt        |   85 ++++
 Makefile                             |   62 +++-
 builtin-clone.c                      |    6 +-
 builtin-fetch.c                      |   19 +-
 builtin-ls-remote.c                  |    4 +-
 builtin-push.c                       |   54 ++-
 configure.ac                         |    3 +
 git-remote-cvs.py                    |  696 ++++++++++++++++++++++++++
 git.c                                |    3 -
 git_vcs_cvs/.gitignore               |    2 +
 git_vcs_cvs/Makefile                 |   27 +
 git_vcs_cvs/changeset.py             |  114 +++++
 git_vcs_cvs/commit_states.py         |   52 ++
 git_vcs_cvs/cvs.py                   |  884 ++++++++++++++++++++++++++++++++++
 git_vcs_cvs/cvs_revision_map.py      |  367 ++++++++++++++
 git_vcs_cvs/cvs_symbol_cache.py      |  283 +++++++++++
 git_vcs_cvs/git.py                   |  591 +++++++++++++++++++++++
 git_vcs_cvs/setup.py                 |   12 +
 git_vcs_cvs/util.py                  |  147 ++++++
 builtin-http-fetch.c => http-fetch.c |    5 +-
 remote-curl.c                        |  139 ++++++
 remote.c                             |   15 +-
 remote.h                             |    2 +
 t/t9800-foreign-vcs-cvs-basic.sh     |  520 ++++++++++++++++++++
 t/t9801-foreign-vcs-cvs-fetch.sh     |  291 +++++++++++
 t/test-lib.sh                        |    1 +
 transport-helper.c                   |  246 ++++++++++
 transport.c                          |  157 +------
 transport.h                          |   44 ++-
 31 files changed, 4741 insertions(+), 185 deletions(-)
 create mode 100644 Documentation/git-remote-helpers.txt
 create mode 100644 Documentation/git-vcs-cvs.txt
 create mode 100755 git-remote-cvs.py
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
 rename builtin-http-fetch.c => http-fetch.c (95%)
 create mode 100644 remote-curl.c
 create mode 100755 t/t9800-foreign-vcs-cvs-basic.sh
 create mode 100755 t/t9801-foreign-vcs-cvs-fetch.sh
 create mode 100644 transport-helper.c
