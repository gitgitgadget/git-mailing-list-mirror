From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v13 00/11] Add interpret-trailers builtin
Date: Sat, 16 Aug 2014 18:06:10 +0200
Message-ID: <20140816153440.18221.29179.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 18:31:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIgsf-0005Tz-UO
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 18:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbaHPQaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2014 12:30:39 -0400
Received: from gleek.ethostream.com ([66.195.129.15]:57358 "EHLO
	barracuda.ethostream.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbaHPQac (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2014 12:30:32 -0400
X-ASG-Debug-ID: 1408205475-016a7707b5114cef0001-QuoKaX
Received: from relay.ethostream.com (www1.ethostream.com [66.195.129.11]) by barracuda.ethostream.com with ESMTP id K1FqDBO7hkEJyyUy; Sat, 16 Aug 2014 11:11:15 -0500 (CDT)
X-Barracuda-Envelope-From: chriscool@tuxfamily.org
X-Barracuda-Apparent-Source-IP: 66.195.129.11
Received: from ethoserver.ezone.net (unknown [10.230.15.218])
	by relay.ethostream.com (Postfix) with ESMTPA id 6DFA48909A0;
	Sat, 16 Aug 2014 11:11:15 -0500 (CDT)
Received: from [127.0.1.1] (unknown [10.0.7.4])
	by ethoserver.ezone.net (Postfix) with ESMTP id 1F0FBC5488F;
	Sat, 16 Aug 2014 11:11:15 -0500 (CDT)
X-ASG-Orig-Subj: [PATCH v13 00/11] Add interpret-trailers builtin
X-Mailer: git-mail-commits v0.5.2
X-Barracuda-Connect: www1.ethostream.com[66.195.129.11]
X-Barracuda-Start-Time: 1408205475
X-Barracuda-URL: http://66.195.129.15:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at ethostream.com
X-Barracuda-Spam-Score: 3.38
X-Barracuda-Spam-Status: No, SCORE=3.38 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.0 tests=FH_DATE_PAST_20XX
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.138343
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	3.38 FH_DATE_PAST_20XX      The date is grossly in the future.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255332>

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
	- the "trailer.separators" option in the config is interpreted (new)
	- the "trailer.where" option is interpreted (new)
	- the "trailer.ifexists" option is interpreted (new)
	- the "trailer.ifmissing" option is interpreted (new)
        - the "trailer.<token>.key" options are interpreted
        - the "trailer.<token>.where" options are interpreted
        - the "trailer.<token>.ifexist" options are interpreted
        - the "trailer.<token>.ifmissing" options are interpreted
        - the "trailer.<token>.command" config works
        - $ARG can be used in commands
        - messages can contain a patch
        - lines in messages starting with a comment char are ignored
        - there are 49 tests
        - there is some documentation
        - there are examples in the documentation

3) Changes since version 12, thanks to Jakub, Michael, Johan and Junio:

* "end" and "start" values for "trailer.<token>.where" have been
  implemented
* "end" has been made the default value for "where", but this default
  value can be changed using the new "trailer.where" config
  variable
* "addIfDifferentNeighbor" is now the default value for "ifexists",
  but this default can be changed using the new "trailer.ifexists"
  config variable
* the new "trailer.ifmissing" can be used to change the default value
  for "ifmissing" (which is "add")
* by default the only separator is ':', this can be changed by using
  the new "trailer.separators" config variable
* only the configured separators (or just ':' by default) are used for
  both input parsing and output printing; the only exception is that
  '=' is always accepted as separator when parsing
  "--trailer '<token><sep><value>'" command line arguments, for
  compatibility with other git commands
* 14 tests have been added

Only patches 7/11, 9/11 and 10/11 have not been changed since v12.

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
 Documentation/git-interpret-trailers.txt | 308 +++++++++++
 Makefile                                 |   2 +
 builtin.h                                |   1 +
 builtin/interpret-trailers.c             |  44 ++
 command-list.txt                         |   1 +
 git.c                                    |   1 +
 t/t7513-interpret-trailers.sh            | 850 +++++++++++++++++++++++++++++++
 trailer.c                                | 830 ++++++++++++++++++++++++++++++
 trailer.h                                |   6 +
 10 files changed, 2044 insertions(+)
 create mode 100644 Documentation/git-interpret-trailers.txt
 create mode 100644 builtin/interpret-trailers.c
 create mode 100755 t/t7513-interpret-trailers.sh
 create mode 100644 trailer.c
 create mode 100644 trailer.h

-- 
2.0.1.674.ga7f57b7
