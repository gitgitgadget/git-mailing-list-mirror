From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH v2] git-add--interactive pathspec and patch additions
Date: Fri, 23 Nov 2007 20:20:43 +0100
Message-ID: <1195845650-85962-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 20:21:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ive5j-0007yW-Nm
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 20:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755595AbXKWTVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 14:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755622AbXKWTVN
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 14:21:13 -0500
Received: from wincent.com ([72.3.236.74]:60674 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754968AbXKWTVM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 14:21:12 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lANJKolv018032;
	Fri, 23 Nov 2007 13:20:52 -0600
X-Mailer: git-send-email 1.5.3.6.886.g6e20-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65910>

This is a revised series based on the feedback and suggestions
received to date. The purpose of the series is to implement these
two user-visible changes:

    1. "git-add --interactive" now takes optional pathspec parameters
       which can be used to limit the scope of an interactive session
    2. We now have "git-add --patch" which takes you straight to the
       "patch" subcommand using the given pathspecs and then exits

The series implements these changes in seven steps that apply on top of
"master"; these patches are rebased/squashed ones which *replace* the
ones sent the other day:

    1. Add -q/--quiet switch to git-ls-files

Needed because run_cmd_pipe() doesn't propagate the child exit status
and system() likes to be chatty on the standard out. Of the possible
workarounds adding this switch seems to be the cleanest and most
portable.

    2. Rename patch_update_file function to patch_update_pathspec

Merely cosmetic.

    3. Add path-limiting to git-add--interactive
    4. Bail if user supplies an invalid pathspec

For consistency with many other Git commands. It also shields us from
errors if the user starts passing funny pathspecs; eg. consider what
happens if the user passes a non-existent file "foo", and that
eventually hits git-diff-files; note how the error message changes
depending on where "foo" appears in the list:

$ git diff-files --numstat --summary --
1       0       git-commit.sh
$ git diff-files --numstat --summary -- .
1       0       git-commit.sh
$ git diff-files --numstat --summary -- . foo
error: Could not access ''
$ git diff-files --numstat --summary -- foo .
error: Could not access 'foo'
$ git diff-files --numstat --summary -- . . foo
1       0       git-commit.sh

    5. Teach builtin-add to pass path arguments to git-add--interactive
    6. Add "--patch" option to git-add--interactive
    7. Teach builtin-add to handle "--patch" option

And that's all. Here's the diff stat:

 Documentation/git-add.txt         |    9 +++++-
 Documentation/git-ls-files.txt    |    7 ++++-
 builtin-add.c                     |   28 ++++++++++++--------
 builtin-ls-files.c                |   12 ++++++++-
 commit.h                          |    2 +-
 git-add--interactive.perl         |   52 +++++++++++++++++++++++++++++++-----
 t/t3020-ls-files-error-unmatch.sh |   12 ++++++++
 7 files changed, 99 insertions(+), 23 deletions(-)
