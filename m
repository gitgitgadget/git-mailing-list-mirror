From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v11 00/11] Add interpret-trailers builtin
Date: Fri, 25 Apr 2014 21:06:51 +0200
Message-ID: <20140425185719.28550.27059.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 21:11:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdlXJ-0001F0-V2
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 21:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589AbaDYTHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 15:07:52 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:43406 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753260AbaDYTHo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 15:07:44 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 74C616B;
	Fri, 25 Apr 2014 21:07:40 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247100>

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

It is better to keep builtin/commit.c uncontaminated by any more
hard-wired logic, like what we have for the signed-off-by line.  Any
new things can and should be doable in hooks, and this filter would
help writing these hooks.

And that is why the design goal of the filter is to make it at least
as powerful as the built-in logic we have for signed-off-by lines;
that would allow us to later eject the hard-wired logic for
signed-off-by line from the main codepath, if/when we wanted to.

Alternatively, we could build a library-ish API around this filter
code and replace the hard-wired logic for signed-off-by line with a
call into that API, if/when we wanted to, but that requires (in
addition to the "at least as powerful as the built-in logic") that
the implementation of this stand-alone filter can be cleanly made
into a reusable library, so that is a bit higher bar to cross than
"everything can be doable with hooks" alternative.

2) Current state:

Currently the usage string of this command is:

git interpret-trailers [--trim-empty] [(--trailer <token>[(=|:)<value>])...] [<file>...]

The following features are implemented:

        - the result is printed on stdout
        - the --trailer arguments are interpreted
        - messages read from <file>... (new) or stdin are interpreted
        - the "trailer.<token>.key" options in the config are interpreted
        - the "trailer.<token>.where" options are interpreted
        - the "trailer.<token>.ifExist" options are interpreted
        - the "trailer.<token>.ifMissing" options are interpreted
        - the "trailer.<token>.command" config works
        - $ARG can be used in commands
        - messages can contain a patch (new)
        - there are 34 tests
        - there is some documentation

The following features are planned but not yet implemented:
        - add examples in documentation

Possible improvements:
        - integration with "git commit"
        - support GIT_COMMIT_PROTO env variable in commands

3) Changes since version 10, thanks to Michael and Junio:

* changed the usage string and the interface
* detect a patch in the input and print it if any
* adapt tests and add some related to the above changes
* improved documentation
* squashed patch to add blank lines before trailers into
  other pathes
* added git-interpret-trailers to command-list.txt
* use strcasecmp() instead of strcmp() to compare
  some values from the config file matching a fixed set

This means that only patches 1/11, 2/11, 3/11, 9/11 and 10/11
mostly did not change. I say mostly because there are still
at least a commit message change in 2/11 and
s/strcmp/strcasecmp/ in 3/11.

Christian Couder (11):
  trailer: add data structures and basic functions
  trailer: process trailers from input message and arguments
  trailer: read and process config information
  trailer: process command line trailer arguments
  trailer: parse trailers from file or stdin
  trailer: put all the processing together and print
  trailer: add interpret-trailers command
  trailer: add tests for "git interpret-trailers"
  trailer: execute command from 'trailer.<name>.command'
  trailer: add tests for commands in config file
  Documentation: add documentation for 'git interpret-trailers'

 .gitignore                               |   1 +
 Documentation/git-interpret-trailers.txt | 143 ++++++
 Makefile                                 |   2 +
 builtin.h                                |   1 +
 builtin/interpret-trailers.c             |  44 ++
 command-list.txt                         |   1 +
 git.c                                    |   1 +
 t/t7513-interpret-trailers.sh            | 542 ++++++++++++++++++++++
 trailer.c                                | 750 +++++++++++++++++++++++++++++++
 trailer.h                                |   6 +
 10 files changed, 1491 insertions(+)
 create mode 100644 Documentation/git-interpret-trailers.txt
 create mode 100644 builtin/interpret-trailers.c
 create mode 100755 t/t7513-interpret-trailers.sh
 create mode 100644 trailer.c
 create mode 100644 trailer.h

-- 
1.9.1.636.g20d5f34
