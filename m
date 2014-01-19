From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 00/16] Add interpret-trailers builtin
Date: Sun, 19 Jan 2014 09:53:38 +0100
Message-ID: <20140119083636.2734.14378.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 19 09:55:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4oA2-0008KQ-Fu
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jan 2014 09:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbaASIyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jan 2014 03:54:47 -0500
Received: from [194.158.98.15] ([194.158.98.15]:49865 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751051AbaASIyq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jan 2014 03:54:46 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 4755842;
	Sun, 19 Jan 2014 09:54:24 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240675>

This patch series implements a new command:

        git interpret-trailers

and an infrastructure to process trailers that can be reused,
for example in "commit.c".

1) Rationale:

This command should help with RFC 822 style headers, called
"trailers", that are found at the end of commit messages.

(Note that these headers do not follow and are not intended to
follow many rules that are in RFC 822. For example they do not
follow the line breaking rules, the encoding rules and probably
many other rules.)

For a long time, these trailers have become a de facto standard
way to add helpful information into commit messages.

Until now git commit has only supported the well known
"Signed-off-by: " trailer, that is used by many projects like
the Linux kernel and Git.

It is better to implement features for these trailers first in a
new command rather than in builtin/commit.c, because this way the
prepare-commit-msg and commit-msg hooks can reuse this command.

2) Current state:

Currently the usage string of this command is:

git interpret-trailers [--trim-empty] [--infile=file] [<token[=value]>...]

The following features are implemented:
        - the result is printed on stdout
        - the [<token[=value]>...] arguments are interpreted
        - a commit message passed using the "--infile=file" option is interpreted
        - (new) if --infile is not used a commit message is read from stdin 
        - the "trailer.<token>.key" options in the config are interpreted
        - the "trailer.<token>.where" options are interpreted
        - the "trailer.<token>.ifExist" options are interpreted
        - the "trailer.<token>.ifMissing" options are interpreted
        - (new) the "trailer.<token>.command" config works
        - (new) GIT_{AUTHOR,COMMITTER}_{NAME,EMAIL} env variables
          can be used in commands 
        - there are a lot of tests

The following features are planned but not yet implemented:
        - some documentation
        - integration with "git commit"

Possible improvements:
        - support GIT_COMMIT_PROTO env variable in commands

3) Notes:

* I used "sed -e 's/ Z$/ /' <<-\EOF" in the tests as suggested by Junio. 

* I added many commits on top of the previous series, but of course they
can be squashed.

Christian Couder (16):
  Add data structures and basic functions for commit trailers
  trailer: process trailers from file and arguments
  trailer: read and process config information
  trailer: process command line trailer arguments
  strbuf: add strbuf_isspace()
  trailer: parse trailers from input file
  trailer: put all the processing together and print
  trailer: add interpret-trailers command
  trailer: add tests for "git interpret-trailers"
  trailer: if no input file is passed, read from stdin
  trailer: add new_trailer_item() function
  strbuf: add strbuf_replace()
  trailer: execute command from 'trailer.<name>.command'
  trailer: add tests for trailer command
  trailer: set author and committer env variables
  trailer: add tests for commands using env variables

 .gitignore                    |   1 +
 Makefile                      |   2 +
 builtin.h                     |   1 +
 builtin/interpret-trailers.c  |  36 +++
 git.c                         |   1 +
 strbuf.c                      |  14 +
 strbuf.h                      |   4 +
 t/t7513-interpret-trailers.sh | 262 +++++++++++++++++
 trailer.c                     | 639 ++++++++++++++++++++++++++++++++++++++++++
 trailer.h                     |   6 +
 10 files changed, 966 insertions(+)
 create mode 100644 builtin/interpret-trailers.c
 create mode 100755 t/t7513-interpret-trailers.sh
 create mode 100644 trailer.c
 create mode 100644 trailer.h

-- 
1.8.5.2.201.gacc5987
