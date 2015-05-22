From: Bastien Traverse <bt@esrevart.net>
Subject: [BUG] "git commit --date" format parsing
Date: Fri, 22 May 2015 15:18:53 +0200
Message-ID: <555F2CBD.8050501@esrevart.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 22 15:19:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvmr1-0000RY-As
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 15:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757373AbbEVNTE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 May 2015 09:19:04 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:36651 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757026AbbEVNSz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 09:18:55 -0400
Received: from [IPv6:2001:41d0:fc06:e100:6236:ddff:fe94:4666] (unknown [IPv6:2001:41d0:fc06:e100:6236:ddff:fe94:4666])
	(Authenticated sender: bastien@esrevart.net)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id EAEAD172081
	for <git@vger.kernel.org>; Fri, 22 May 2015 15:18:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269710>

Hi *

Trying to specify a commit (author) date using `--date` option yields
unpredictable results that are incoherent with man git-commit:

$ git --version
git version 2.4.1

$ uname -a
Linux arch-clevo 4.0.4-1-ARCH #1 SMP PREEMPT Mon May 18 06:43:19 CEST
2015 x86_64 GNU/Linux

$ mkdir test && cd test/
$ git init
$ touch test
$ git add test

1. ISO 8601 (strict)

$ git commit --date=3D"2015-05-21T16=E2=88=B631+02:00" -m "Test commit =
to check
date format parsing"
[master (root commit) fed9ae6] Test commit to check date format parsing
 Date: Thu May 21 02:00:00 2015 +0200
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 test

  --> gets the date right but confuses the timezone for the time

2. git-log --date=3Diso8601 format:

$ git commit --amend --date=3D"2015-05-21 16=E2=88=B631 +0200" -m "Test=
 commit to
check date format parsing"
[master d2cdbf2] Test commit to check date format parsing
 Date: Thu May 21 14:37:37 2015 +0200
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 test

  --> gets the date right but uses current time, not specified one

3. date format git uses in output of commit command:

$ git commit --amend --date=3D"Thu May 21 16=E2=88=B631 2015 +0200"
=2E..
Date: Sat May 21 14:40:08 2016 +0200

  --> get the day and month right but not the year, uses current time

4. RFC 2822

$ git commit --amend --date=3D"Thu, 21 May 2015 16=E2=88=B631 +0200"
=2E..
Date: Thu May 21 15:01:03 2015 +0200

  --> gets the date right but uses current time

5. Environment variable with ISO 8601 (strict)

$ GIT_AUTHOR_DATE=3D"2015-05-21T16=E2=88=B631+02:00" git commit --amend
=2E..
Date: Thu May 21 15:04:30 2015 +0200

  --> using the env var we get something better than 1. (not confusing
timezone for time) but still not the specified date.


Seeing the discussions there have been here around date parsing and ISO
8601 [1][2], I suggest only supporting the W3C=E2=80=99s suggested prof=
ile of
ISO 8601 [3] to cut in the complexity.

My use case for using the --date option to git-commit is to reconstruct
the revision history of a set of files that were timestamped with YAML
`date:` metadata, so as to see which files were added after which other=
s
etc.

I was hoping to use a script to parse the YAML datetime metadata in git
commit, but right now the time information would be lost, which is
problematic.

Besides this, documentation for git-commit is currently uncorrect since
it suggests we can use RFC 2822 and ISO 8601 while this seems not to be
the case.

Thanks for your feedback,
Bastien

[1] http://thread.gmane.org/gmane.comp.version-control.git/256109
[2] http://thread.gmane.org/gmane.comp.version-control.git/52414/focus=3D=
52597
[3] http://www.w3.org/TR/NOTE-datetime
