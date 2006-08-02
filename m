From: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/10] LLP - the Legacy Linux Port.
Date: Wed, 2 Aug 2006 02:03:09 +0100
Message-ID: <00a101c6b5cf$6bea1b00$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 02 03:03:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G858U-0006w4-SC
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 03:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWHBBC4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 21:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWHBBC4
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 21:02:56 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:30729 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S1750892AbWHBBCz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 21:02:55 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-35.mail.demon.net with smtp (Exim 4.42)
	id 1G858L-000C1I-If
	for git@vger.kernel.org; Wed, 02 Aug 2006 01:02:54 +0000
To: <git@vger.kernel.org>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24619>

Hi all,

For the last few weeks, I have been considering making an active
contribution to the git project (rather than just lurking on the list).
However, I've been putting it off because I need to upgrade my
laptop. My current laptop is somewhat old (7/8 years) and not a very
good development machine. (234MHz mobile Pentium, 64MB RAM, 3GB disk)
In my current configuration, I triple-boot win95, winNT4 and Mandrake
Linux 7.0 (2.2.14-15mdk, Tue Jan 4 22:24:20 CET 2000). As you can
imagine, disk space is always a problem and the dev tools are all
quite out of date. I need win95 to access the internet, since neither
winNT nor Linux can drive the win-modem.

Having said that, I've been trying to upgrade my laptop since before
Christmas ...  So, just for a laugh, and to start to get to know the
code, I instigated the LLP (Legacy Linux Port!). I'm happy to say
that, despite the OS and dev tools being six years old, I have the
core of git (mostly) running.

At first, I did not intend to send patches to the project, since this
was just a bit of fun and a learning experience while waiting for my
new laptop. On reflection, however, most of the patches actually have
little to do with the legacy aspects of the tools/OS and are equally
relevant to more up-to-date setups. Naturally, some of the patches
are a direct result of old tools, and are included simply to document
the complete solution. (someone else may find it useful).

First, some version numbers for my tools:

  - gcc 2.95.2
  - glibc 2.1
  - perl 5.005_03
  - Tcl/Tk 8.0

and my config.mak file:

-- >8 --
MOZILLA_SHA1=1
NO_OPENSSL=1
NO_CURL=1
NO_EXPAT=1
NO_STRLCPY=1
NO_IPV6=1
NO_PYTHON=1
NO_C99_FORMAT=1
ALL_CFLAGS+= -Werror
-- 8< --

As I don't have python installed, this implies no recursive merge.
Also, since I don't have asciidoc, I downloaded the documentation
tar-balls; so thank you for providing them! (If memory serves, asciidoc
is written in python ...).

I started by downloading the version 1.4.1 tarball: git-1_4_1_tar.gz

The first problem I had, was that the zlib headers were not installed.
In order to solve this, I built and installed zlib-1.1.4 from source.
(I had an old Linux From Scratch CD handy). I note that the INSTALL
file did not mention any minimum version numbers, so I can confirm
that version 1.1.4 seems to work fine.

Compiling and building was not too difficult, see the patches (#4-9)
for the details. When running the test suite, however, many of the
tests failed due to the perl scripts failing to "compile".

Indeed, this was the biggest problem and required "downgrading" some
of the perl scripts to work with perl 5.5. I only fixed those scripts
called from the tests or that I called directly. Again, INSTALL does
not mention a minimum version number for perl, but I note that
git-relink.perl has a "use 5.006;". (see patch #10)

Whilst fixing the perl scripts, I noted a problem with git-clone and
with the annotate test script itself. (see patches #1,2). After fixing
these problems, I had a git which passed all the tests.

Installing git, I then noted a problem with the templates install.
(see patch #3 for the fix).

With a working git, I now created a git repository with the original
contents of the git tar-ball. I was now able to re-implement the
changes using git and to produce the patches in this series.

Unfortunately, gitk does not work with Tcl/Tk 8.0. The first problem
was a syntax error caused by the 'ne' operator. I did a global
search/replace of ' ne ' with ' != ' to overcome this problem.
The next problem was caused by invalid command name "encoding" on
line 5557. I deleted the call to encoding, replacing it with an empty
string, just to get past this. It then failed with 'invalid command
name "panedwindow"' (at line 429). At this point, I gave up!

I would have liked to get gitk working, but my Tcl/Tk is a bit rusty.
Again INSTALL does not mention a minimum version for Tcl/Tk, but it
is obviously greater than 8.0!

The patch series is as follows:

[PATCH 1/10] Ensure git-clone exits with error if perl script fails.
[PATCH 2/10] Fix annotate test script; notice when git-annotate fails.
[PATCH 3/10] Fix installation of templates on ancient systems.
[PATCH 4/10] New tests and en-passant modifications to mktag.
[PATCH 5/10] Add NO_C99_FORMAT to support older compilers.
[PATCH 6/10] Fix header breakage with _XOPEN_SOURCE.
[PATCH 7/10] Fix header breakage due to redefining PATH_MAX.
[PATCH 8/10] Fix some minor warnings to allow -Werror.
[PATCH 9/10] Remove cmd_usage() routine and re-organize the help/usage code.
[PATCH 10/10] Fix perl scripts to work with version 5.005_03.

I hope you will consider applying patches 1-9, but patch 10 is only
included for completeness.

Note that patch #5 could be much simpler; I felt the need to provide
a general solution to the problem. However, the simpler solution is
to eliminate the use of the C99 printf size specifiers; it's not
that difficult.

Also, since I have to go via win95 and outlook, the mbox files
produced by git-format-patch have been sent as attachments.
(I renamed them to p0001.txt, p0002.txt, etc. also)

Some other random notes:

  - Since I can't access the internet from Linux, I am unable to
    clone the actual git repository; so the commit/tree IDs in the
    patches bear no relation to commit IDs in the official repo.
  - I don't quite understand the classification scheme used to
    name the tests, so you may want to re-name the new test in
    patch #4 (t3800-mktag.sh) to something more appropriate.
  - I don't know of any established location for html documentation,
    but I used, essentially,  $(prefix)/doc/git-1.4.1/html
  - For some git commands that have more than one "pattern" of
    invocation (e.g. git-am, git-branch) the man pages were correctly
    formatted, each pattern on a separate line, whereas the html page
    shows them all on one line.

I hope you find this useful.

Ramsay
