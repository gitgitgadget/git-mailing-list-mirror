From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v10 00/12] Add interpret-trailers builtin
Date: Sun, 06 Apr 2014 19:01:51 +0200
Message-ID: <20140406163214.15116.91484.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Mon Apr 07 20:44:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXEWb-0003NX-Ty
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 20:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997AbaDGSoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 14:44:00 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:56225 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755577AbaDGSn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 14:43:58 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 5B5805A;
	Mon,  7 Apr 2014 20:43:55 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245874>

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
        - there are 31 tests (4 more than in version 9)
        - there is some documentation

The following features are planned but not yet implemented:
        - add examples in documentation

Possible improvements:
        - integration with "git commit"
        - support GIT_COMMIT_PROTO env variable in commands

3) Changes since version 9, thanks to Jonathan and Junio:

* added 1 test with empty trailers in patch 10/12
* fixed bugs when there was no 'key' in the config in patch
  4/12 and added 2 related tests in patch 10/12
* fixed bug when command failed in patch 9/12 and added 1
  related test in patch 10/12
* added patch 12/12 which add one blank line before the
  trailers if there is not one already

This means code changes only in patches 4/12, 9/12, 10/12
and 12/12.


Christian Couder (12):
  trailer: add data structures and basic functions
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
  trailer: add blank line before the trailers if needed

 .gitignore                               |   1 +
 Documentation/git-interpret-trailers.txt | 123 ++++++
 Makefile                                 |   2 +
 builtin.h                                |   1 +
 builtin/interpret-trailers.c             |  33 ++
 git.c                                    |   1 +
 t/t7513-interpret-trailers.sh            | 477 +++++++++++++++++++++
 trailer.c                                | 709 +++++++++++++++++++++++++++++++
 trailer.h                                |   6 +
 9 files changed, 1353 insertions(+)
 create mode 100644 Documentation/git-interpret-trailers.txt
 create mode 100644 builtin/interpret-trailers.c
 create mode 100755 t/t7513-interpret-trailers.sh
 create mode 100644 trailer.c
 create mode 100644 trailer.h

-- 
1.9.0.163.g8ca203c
