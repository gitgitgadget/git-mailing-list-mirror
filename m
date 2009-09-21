From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] pre-commit.sample: don't use [...] around a tr range
Date: Mon, 21 Sep 2009 16:10:21 +0200
Message-ID: <87tyywgzhu.fsf@meyering.net>
References: <871vm0k6jm.fsf@meyering.net>
	<81b0412b0909210243h58633509r7b427c69f62928fe@mail.gmail.com>
	<87ocp4imul.fsf@meyering.net> <20090921134427.GA20567@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 21 16:10:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpjbA-0007la-5W
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 16:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756203AbZIUOK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 10:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756060AbZIUOK0
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 10:10:26 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:34157 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756048AbZIUOKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 10:10:25 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D76A48181C1
	for <git@vger.kernel.org>; Mon, 21 Sep 2009 16:10:24 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E1A0A818190
	for <git@vger.kernel.org>; Mon, 21 Sep 2009 16:10:21 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id C092A5559A; Mon, 21 Sep 2009 16:10:21 +0200 (CEST)
In-Reply-To: <20090921134427.GA20567@sigio.peff.net> (Jeff King's message of
	"Mon, 21 Sep 2009 09:44:27 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128888>

Jeff King wrote:

> On Mon, Sep 21, 2009 at 01:00:34PM +0200, Jim Meyering wrote:
>
>> > We have (had?) people trying to support Git on HP-UX and SunOS.
>> > Do these count?
>>
>> I had my doubts, but have just confirmed that Solaris 10's
>> /usr/bin/tr is still doing it the SYSV way:
>>
>>     $ echo foo | LC_ALL=C /usr/bin/tr a-z A-Z
>>     foo
>>
>> There, you have to use /usr/xpg4/bin/tr to get the expected behavior:
>>
>>     $ echo foo | LC_ALL=C /usr/xpg4/bin/tr a-z A-Z
>>     FOO
>>
>> So you're right.  Thanks!
>
> See:
>
>   http://article.gmane.org/gmane.comp.version-control.git/76991
>
>> +	# Note that the use of brackets around a tr range is ok here, (it's
>> +	# even required, for portability to Solaris 10's /usr/bin/tr), since
>> +	# the square bracket bytes happen to fall in the designated range.
>>  	test "$(git diff --cached --name-only --diff-filter=A -z |
>>  	  LC_ALL=C tr -d '[ -~]\0')"
>
> Does this work on non-bracket systems?

Yes, since [] happen to fall in the range.

> I would think that enumerating
> the sequence would be the most portable thing.

Enumerating is more portable, at the expense of
readability and maintainability.
In case you want to go that route, here's one more:

(note that this, like the original range, treats TAB as nonportable)

>From 40a368a7bcf0ac6524bbe36ba3bfdaa0711897b8 Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Mon, 21 Sep 2009 10:58:02 +0200
Subject: [PATCH] pre-commit.sample: use tr more portability; fix grammar

Avoid tr's M-N range notation altogether.
Instead, enumerate ascii bytes 32..126.
Correct spelling and grammar.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 templates/hooks--pre-commit.sample |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index b11ad6a..896eb9e 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -10,19 +10,26 @@
 # If you want to allow non-ascii filenames set this variable to true.
 allownonascii=$(git config hooks.allownonascii)

+printables=' !"#$%&'\''()*+,-./0123456789:;<=>?@'
+printables="$printables"'ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`'
+printables="$printables"'abcdefghijklmnopqrstuvwxyz{|}~'
+
 # Cross platform projects tend to avoid non-ascii filenames; prevent
 # them from being added to the repository. We exploit the fact that the
 # printable range starts at the space character and ends with tilde.
 if [ "$allownonascii" != "true" ] &&
-	test "$(git diff --cached --name-only --diff-filter=A -z |
-	  LC_ALL=C tr -d '[ -~]\0')"
+	# Filter out printable ascii bytes, and NUL.
+	# If anything remains, you lose.
+        rem=$(git diff --cached --name-only --diff-filter=A -z |
+	      LC_ALL=C tr -d "$printables"'\0')
+	test -n "$rem"
 then
-	echo "Error: Attempt to add a non-ascii filename."
+	echo "Error: Attempt to add a non-ascii file name."
 	echo
-	echo "This can cause problems if you want to work together"
-	echo "with people on other platforms than you."
+	echo "This can cause problems if you want to work"
+	echo "with people on other platforms."
 	echo
-	echo "To be portable it is adviseable to rename the file ..."
+	echo "To be portable it is advisable to rename the file ..."
 	echo
 	echo "If you know what you are doing you can disable this"
 	echo "check using:"
--
1.6.5.rc1.214.g13c5a
