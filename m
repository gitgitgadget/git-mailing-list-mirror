From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 0/4] --word-regex sanity checking and such
Date: Wed, 15 Dec 2010 16:13:24 +0100
Message-ID: <cover.1292424926.git.trast@student.ethz.ch>
References: <561247.22837.qm@web110707.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Matthijs Kooijman <matthijs@stdin.nl>, <git@vger.kernel.org>
To: Scott Johnson <scottj75074@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:13:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSt3F-00060n-ML
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754723Ab0LOPNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 10:13:31 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:7134 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053Ab0LOPNb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:13:31 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 15 Dec
 2010 16:13:21 +0100
Received: from localhost.localdomain (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 15 Dec
 2010 16:13:29 +0100
X-Mailer: git-send-email 1.7.3.3.807.g6ee1f
In-Reply-To: <561247.22837.qm@web110707.mail.gq1.yahoo.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163782>

[Forgot the list and Matthijs on the first sending.  Sorry for the
spam!]

Scott Johnson wrote [trimmed and wraps fixed up]:
> Here's the default `git diff --word-diff`:
>         [-<li class="yws-maps"><em></em><a-]{+<li><em></em><a+} href="#">yws-maps</a></li>
>         [-<li class="ydn-delicious"><em></em><a-]{+<li><em></em><a+} href="#">ydn-delicious</a></li>
> 
> Which is correct, but less than ideal because it highlights much more than the 
> actual changes.
> 
> So I create a .gitattributes file with one line:
> *.html diff=html
> 
> And rerun `git diff --word-diff`:
>         <li[-class="yws-maps"-]><em></em><a href="#">yws-maps</a></li>
>         <li><em></em><a href="#">ydn-delicious</a></li>
> 
> Yikes! What happened to the second line of changes? The removed code is not 
> displayed at all.

Michael J Gruber wrote:
> Yep, I just found out myself experimenting with a wordRegex for csv.
> Seems like quite a "Gimme rope" feature...
> 
> So, it's the regex.

Well. Yes. No. Maybe.

Thanks for bringing this to my attention.  I currently have enough
more serious work to avoid that this actually motivated me to hack up
a sanity check.  It's just far too error prone as it is now.

But I cannot reproduce the problem!  I put Scott's two offending lines
(taken from his "straight" diff) into t4034/html/{pre,post}, and I
think the output is valid.  Also, the word regex for html has long
included the |[^[:space:]] safeguard (actually they all do except for
bibtex, which is even more lenient on what it matches).  So you either
found an example that depends on more context (which would be *really*
bad) or there is another source of bad regexes.  Anyway, the safeguard
should easily catch the latter case.

This did unearth a bug in the ruby regex, though, so it's been worth
the trouble.

Various small issues with this patch series:

* [4/4] I stole the html test from Scott's mail, and some of the rest
  from various Wikibooks sources on "Hello World" in each language,
  usually extended by a bit of code that tests the world-splitting
  power.  I hope this is ok with Scott and the Copyright overlords.
  There are only so many ways to spell "Hello World", and only so many
  languages I know myself.

* [4/4] Many patterns do not split 1+2, probably because they stick +2
  together as a signed integer literal, even though I think they
  should.  I ran out of time to investigate however.

* [3/4] was actually detected with the help of [4/4], but putting it
  after would require heavy special casing.

* [2/4] It's a weird idiosyncrasy of the word-diff code that the exit
  status of git-diff does not depend on whether word-diff found any
  differences, and in fact the shown hunks do not either.  So the
  tests are "test_must_fail" regardless of word regex, because the
  input files differ at a byte level.  Maybe at least hunks without
  word differences should be suppressed?


Thomas Rast (4):
  diff.c: pass struct diff_words into find_word_boundaries
  diff.c: implement a sanity check for word regexes
  userdiff: fix typo in ruby word regex
  t4034: bulk verify builtin word regex sanity

 Documentation/config.txt |    8 ++++
 diff.c                   |  104 +++++++++++++++++++++++++++++++++++++++++----
 diff.h                   |    1 +
 t/t4034-diff-words.sh    |   85 +++++++++++++++++++++++++++++++++++++-
 t/t4034/bibtex/expect    |   15 +++++++
 t/t4034/bibtex/post      |   10 ++++
 t/t4034/bibtex/pre       |    9 ++++
 t/t4034/cpp/expect       |   10 ++++
 t/t4034/cpp/post         |    5 ++
 t/t4034/cpp/pre          |    4 ++
 t/t4034/csharp/expect    |   12 +++++
 t/t4034/csharp/post      |    8 ++++
 t/t4034/csharp/pre       |    8 ++++
 t/t4034/fortran/expect   |   12 +++++
 t/t4034/fortran/post     |    7 +++
 t/t4034/fortran/pre      |    7 +++
 t/t4034/html/expect      |    7 +++
 t/t4034/html/post        |    2 +
 t/t4034/html/pre         |    2 +
 t/t4034/java/expect      |   11 +++++
 t/t4034/java/post        |    6 +++
 t/t4034/java/pre         |    6 +++
 t/t4034/objc/expect      |   11 +++++
 t/t4034/objc/post        |    7 +++
 t/t4034/objc/pre         |    7 +++
 t/t4034/pascal/expect    |   12 +++++
 t/t4034/pascal/post      |    7 +++
 t/t4034/pascal/pre       |    7 +++
 t/t4034/php/expect       |    7 +++
 t/t4034/php/post         |    2 +
 t/t4034/php/pre          |    2 +
 t/t4034/python/expect    |    8 ++++
 t/t4034/python/post      |    3 +
 t/t4034/python/pre       |    3 +
 t/t4034/ruby/expect      |    7 +++
 t/t4034/ruby/post        |    2 +
 t/t4034/ruby/pre         |    2 +
 t/t4034/tex/expect       |    9 ++++
 t/t4034/tex/post         |    4 ++
 t/t4034/tex/pre          |    4 ++
 userdiff.c               |    2 +-
 41 files changed, 433 insertions(+), 12 deletions(-)
 create mode 100644 t/t4034/bibtex/expect
 create mode 100644 t/t4034/bibtex/post
 create mode 100644 t/t4034/bibtex/pre
 create mode 100644 t/t4034/cpp/expect
 create mode 100644 t/t4034/cpp/post
 create mode 100644 t/t4034/cpp/pre
 create mode 100644 t/t4034/csharp/expect
 create mode 100644 t/t4034/csharp/post
 create mode 100644 t/t4034/csharp/pre
 create mode 100644 t/t4034/fortran/expect
 create mode 100644 t/t4034/fortran/post
 create mode 100644 t/t4034/fortran/pre
 create mode 100644 t/t4034/html/expect
 create mode 100644 t/t4034/html/post
 create mode 100644 t/t4034/html/pre
 create mode 100644 t/t4034/java/expect
 create mode 100644 t/t4034/java/post
 create mode 100644 t/t4034/java/pre
 create mode 100644 t/t4034/objc/expect
 create mode 100644 t/t4034/objc/post
 create mode 100644 t/t4034/objc/pre
 create mode 100644 t/t4034/pascal/expect
 create mode 100644 t/t4034/pascal/post
 create mode 100644 t/t4034/pascal/pre
 create mode 100644 t/t4034/php/expect
 create mode 100644 t/t4034/php/post
 create mode 100644 t/t4034/php/pre
 create mode 100644 t/t4034/python/expect
 create mode 100644 t/t4034/python/post
 create mode 100644 t/t4034/python/pre
 create mode 100644 t/t4034/ruby/expect
 create mode 100644 t/t4034/ruby/post
 create mode 100644 t/t4034/ruby/pre
 create mode 100644 t/t4034/tex/expect
 create mode 100644 t/t4034/tex/post
 create mode 100644 t/t4034/tex/pre

-- 
1.7.3.3.807.g6ee1f
