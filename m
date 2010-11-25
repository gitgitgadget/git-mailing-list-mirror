From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 00/18] WIP implement cherry-pick/revert --continue
Date: Thu, 25 Nov 2010 22:20:31 +0100
Message-ID: <20101125210138.5188.13115.chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 06:54:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrGG-0006Rm-PM
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 06:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075Ab0KZFyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 00:54:15 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:47046 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990Ab0KZFyP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 00:54:15 -0500
Received: from localhost6.localdomain6 (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 26740A60F5;
	Fri, 26 Nov 2010 06:54:04 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162183>

This a a work in progress to show where this is going and to discuss it.

There are many things missing among other:

 * no documentation
 * missing tests, especially for "revert"
 * when cherry-pick fails the error message does not advertise --continue
 * resolving a failing cherry-pick is not handled
 * commit messages could be improved a lot
 * ...

Many patches in this series are replacing calls to "die()" by
"return error()", because the TODO and DONE files are written
only when cherry-pick fails. This is efficient but perhaps it
would be simpler and safer to write them before each cherry-pick
just in case it fails, so that the "die()" calls don't need to
be removed.

Christian Couder (17):
  advice: add error_resolve_conflict() function
  revert: change many die() calls into "return error()" calls
  usage: implement error_errno() the same way as die_errno()
  revert: don't die when write_message() fails
  commit: move reverse_commit_list() into commit.{h,c}
  revert: remove "commit" global variable
  revert: put option information in an option struct
  revert: refactor code into a new pick_commits() function
  revert: make pick_commits() return an error on --ff incompatible
    option
  revert: make read_and_refresh_cache() and prepare_revs() return
    errors
  revert: add get_todo_content() and create_todo_file()
  revert: write TODO and DONE files in case of failure
  revert: add option parsing for option --continue
  revert: move global variable "me" into "struct args_info"
  revert: add NONE action and make parse_args() manage it
  revert: add remaining instructions in todo file
  revert: implement --continue processing

Stephan Beyer (1):
  revert: implement parsing TODO and DONE files

 advice.c                            |   25 +-
 advice.h                            |    1 +
 builtin/revert.c                    |  692 ++++++++++++++++++++++++++++-------
 commit.c                            |   11 +
 commit.h                            |    2 +
 git-compat-util.h                   |    1 +
 merge-recursive.c                   |   11 -
 t/t3508-cherry-pick-many-commits.sh |  101 +++++
 usage.c                             |   28 ++-
 9 files changed, 717 insertions(+), 155 deletions(-)

-- 
1.7.3.2.504.g59d466
