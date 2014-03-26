From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 00/12] Add interpret-trailers builtin
Date: Wed, 26 Mar 2014 23:15:18 +0100
Message-ID: <20140326215858.11352.89243.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 23:17:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSw8A-0002SH-01
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 23:17:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756161AbaCZWQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 18:16:23 -0400
Received: from [194.158.98.14] ([194.158.98.14]:44037 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754217AbaCZWQV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 18:16:21 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 279E669;
	Wed, 26 Mar 2014 23:15:57 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245245>

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

3) Changes since version 7, thanks to Junio:

* improved handling of empty trailer token
* clearer way to create 'expected' files in tests
* other small test cleanups
* improved commit message
* new way to parse config keys
* strcasecmp() is not used anymore in some config related functions
Some values from the config file are lowercased instead.
To enable that a new patch (3/12) is introduced to rationalize
lowercase related functions. I am not very happy with these
changes.


Christian Couder (12):
  Add data structures and basic functions for commit trailers
  trailer: process trailers from stdin and arguments
  Move lower case functions into wrapper.c
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
 config.c                                 |   6 -
 daemon.c                                 |   8 -
 git-compat-util.h                        |   4 +
 git.c                                    |   1 +
 t/t7513-interpret-trailers.sh            | 407 ++++++++++++++++++
 trailer.c                                | 691 +++++++++++++++++++++++++++++++
 trailer.h                                |   6 +
 wrapper.c                                |  14 +
 13 files changed, 1283 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/git-interpret-trailers.txt
 create mode 100644 builtin/interpret-trailers.c
 create mode 100755 t/t7513-interpret-trailers.sh
 create mode 100644 trailer.c
 create mode 100644 trailer.h

-- 
1.9.0.164.g3aa33cd.dirty
