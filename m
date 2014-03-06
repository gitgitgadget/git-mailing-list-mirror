From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 00/11] Add interpret-trailers builtin
Date: Thu, 06 Mar 2014 23:06:18 +0100
Message-ID: <20140306220029.29150.64594.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 07:20:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLo8w-0007yP-8M
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 07:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbaCGGUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 01:20:21 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:57794 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982AbaCGGUV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 01:20:21 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 99D9A39;
	Fri,  7 Mar 2014 07:20:16 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243589>

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

git interpret-trailers [--trim-empty] [(<token>[(=|:)<value>])...]

The following features are implemented:

        - the result is printed on stdout
        - the [<token>[=<value>]>] arguments are interpreted
        - a commit message read from stdin is interpreted
        - the "trailer.<token>.key" options in the config are interpreted
        - the "trailer.<token>.where" options are interpreted
        - the "trailer.<token>.ifExist" options are interpreted
        - the "trailer.<token>.ifMissing" options are interpreted
        - the "trailer.<token>.command" config works
        - $ARG can be used in commands
        - there are some tests
        - there is some documentation

The following features are planned but not yet implemented:
        - add more tests related to commands
        - add examples in documentation
        - integration with "git commit"

Possible improvements:
        - support GIT_COMMIT_PROTO env variable in commands

3) Changes since version 6, thanks to Junio and Ramsey:

* many style fixes
* clearer and nicer setup tests
* trailer.h is included at the beginning of trailer.c


Christian Couder (11):
  Add data structures and basic functions for commit trailers
  trailer: process trailers from stdin and arguments
  trailer: read and process config information
  trailer: process command line trailer arguments
  trailer: parse trailers from stdin
  trailer: put all the processing together and print
  trailer: add interpret-trailers command
  trailer: add tests for "git interpret-trailers"
  trailer: execute command from 'trailer.<name>.command'
  trailer: add tests for commands in config file
  Documentation: add documentation for 'git interpret-trailers'

 .gitignore                               |   1 +
 Documentation/git-interpret-trailers.txt | 123 ++++++
 Makefile                                 |   2 +
 builtin.h                                |   1 +
 builtin/interpret-trailers.c             |  33 ++
 git.c                                    |   1 +
 t/t7513-interpret-trailers.sh            | 261 ++++++++++++
 trailer.c                                | 667 +++++++++++++++++++++++++++++++
 trailer.h                                |   6 +
 9 files changed, 1095 insertions(+)
 create mode 100644 Documentation/git-interpret-trailers.txt
 create mode 100644 builtin/interpret-trailers.c
 create mode 100755 t/t7513-interpret-trailers.sh
 create mode 100644 trailer.c
 create mode 100644 trailer.h

-- 
1.8.5.2.204.gcfe299d.dirty
