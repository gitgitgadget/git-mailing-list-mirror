From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/9] Add interpret-trailers builtin
Date: Tue, 24 Dec 2013 07:37:16 +0100
Message-ID: <20131224061541.19560.17773.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 24 07:38:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VvLdc-0001K7-RD
	for gcvg-git-2@plane.gmane.org; Tue, 24 Dec 2013 07:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967Ab3LXGii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Dec 2013 01:38:38 -0500
Received: from [194.158.98.14] ([194.158.98.14]:50258 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750816Ab3LXGih (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Dec 2013 01:38:37 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 7243044;
	Tue, 24 Dec 2013 07:38:14 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239657>

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
        - the "trailer.<token>.key" options in the config are interpreted
        - the "trailer.<token>.where" options are interpreted
        - the "trailer.<token>.ifExist" options are interpreted
        - the "trailer.<token>.ifMissing" options are interpreted
	- there are a lot of tests

The following features are planned but not yet implemented:
	- making "git interpret-trailers" a filter
        - some documentation
        - the "trailer.<token>.command" config option

3) Notes:

* I chose "trailer.<token>.key" over "trailer.<token>.value" and
"trailer.<token>.trailer", as I think it is clearer.

* I focused on a cleaner and more complete implementation than the
PATCH/RFC I sent previously.

Happy end of year!

Christian Couder (9):
  Add data structures and basic functions for commit trailers
  trailer: process trailers from file and arguments
  trailer: read and process config information
  trailer: process command line trailer arguments
  strbuf: add strbuf_isspace()
  trailer: parse trailers from input file
  trailer: put all the processing together and print
  trailer: add interpret-trailers command
  trailer: add tests for "git interpret-trailers"

 .gitignore                    |   1 +
 Makefile                      |   2 +
 builtin.h                     |   1 +
 builtin/interpret-trailers.c  |  36 +++
 git.c                         |   1 +
 strbuf.c                      |   7 +
 strbuf.h                      |   1 +
 t/t7513-interpret-trailers.sh | 206 ++++++++++++++++
 trailer.c                     | 544 ++++++++++++++++++++++++++++++++++++++++++
 trailer.h                     |   6 +
 10 files changed, 805 insertions(+)
 create mode 100644 builtin/interpret-trailers.c
 create mode 100755 t/t7513-interpret-trailers.sh
 create mode 100644 trailer.c
 create mode 100644 trailer.h

-- 
1.8.4.1.616.g07f5c81
