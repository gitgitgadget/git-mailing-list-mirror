From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v12 00/11] Add interpret-trailers builtin
Date: Sun, 25 May 2014 07:32:11 +0200
Message-ID: <20140525051254.5329.66539.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun May 25 07:46:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WoRGd-0005Qh-O5
	for gcvg-git-2@plane.gmane.org; Sun, 25 May 2014 07:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbaEYFqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2014 01:46:11 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:63889 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946AbaEYFqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2014 01:46:09 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 2081859;
	Sun, 25 May 2014 07:46:05 +0200 (CEST)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250075>

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
        - messages read from <file>... or stdin are interpreted
        - the "trailer.<token>.key" options in the config are interpreted
        - the "trailer.<token>.where" options are interpreted
        - the "trailer.<token>.ifExist" options are interpreted
        - the "trailer.<token>.ifMissing" options are interpreted
        - the "trailer.<token>.command" config works
        - $ARG can be used in commands
        - messages can contain a patch
        - lines in messages starting with a comment char are ignored (new)
        - there are 35 tests
        - there is some documentation
        - there are examples in the documentation (new)

Possible improvements:
        - integration with "git commit"
        - support GIT_COMMIT_PROTO env variable in commands

3) Changes since version 11, thanks to Michael, Jonathan and Junio:

* the patch to ignore comments in messages has been squashed into
  the original series (5/11 and 8/11)
* the comment char config variable is used to ignore comments in
  messages (as suggested by Michael) (5/11)
* the patch that add examples in the documentation has been
  squashed into the original (11/11)
* one of the examples has been split into 2 examples (as suggested
  by Junio) (11/11)
* there is no special case for # when printing the trailers, (as
  suggested by Junio); so we always use ': ' as separator, except
  when trailer.<token>.key ends with a non alphanumeric character;
  in that case we add no separator as we suppose that the key
  already contains a separator (6/11, 8/11 and 10/11)
* documentation has been improved to be clearer, and more
  explicit, especially about how the key config variable is
  used (11/11)

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
 Documentation/git-interpret-trailers.txt | 264 +++++++++++
 Makefile                                 |   2 +
 builtin.h                                |   1 +
 builtin/interpret-trailers.c             |  44 ++
 command-list.txt                         |   1 +
 git.c                                    |   1 +
 t/t7513-interpret-trailers.sh            | 568 +++++++++++++++++++++++
 trailer.c                                | 755 +++++++++++++++++++++++++++++++
 trailer.h                                |   6 +
 10 files changed, 1643 insertions(+)
 create mode 100644 Documentation/git-interpret-trailers.txt
 create mode 100644 builtin/interpret-trailers.c
 create mode 100755 t/t7513-interpret-trailers.sh
 create mode 100644 trailer.c
 create mode 100644 trailer.h

-- 
1.9.rc0.17.g651113e
