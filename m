From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] pre-commit.sample: don't use [...] around a tr range
Date: Mon, 21 Sep 2009 13:00:34 +0200
Message-ID: <87ocp4imul.fsf@meyering.net>
References: <871vm0k6jm.fsf@meyering.net>
	<81b0412b0909210243h58633509r7b427c69f62928fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 13:00:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpgdT-0007xl-5s
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 13:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbZIULAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 07:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752618AbZIULAj
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 07:00:39 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:60321 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752231AbZIULAj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 07:00:39 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 3E7C0818174
	for <git@vger.kernel.org>; Mon, 21 Sep 2009 13:00:37 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 57541818078
	for <git@vger.kernel.org>; Mon, 21 Sep 2009 13:00:35 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id C513B28886; Mon, 21 Sep 2009 13:00:34 +0200 (CEST)
In-Reply-To: <81b0412b0909210243h58633509r7b427c69f62928fe@mail.gmail.com>
	(Alex Riesen's message of "Mon, 21 Sep 2009 11:43:44 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128874>

Alex Riesen wrote:
> On Mon, Sep 21, 2009 at 11:09, Jim Meyering <jim@meyering.net> wrote:
>> However, if the use of [] is deliberate, because git still
>> cares about portability to ancient SYSV versions of tr that
>> require that notation, then let me know and I'll undo that part
>> of the change and add a comment to that effect.
>
> We have (had?) people trying to support Git on HP-UX and SunOS.
> Do these count?

I had my doubts, but have just confirmed that Solaris 10's
/usr/bin/tr is still doing it the SYSV way:

    $ echo foo | LC_ALL=C /usr/bin/tr a-z A-Z
    foo

There, you have to use /usr/xpg4/bin/tr to get the expected behavior:

    $ echo foo | LC_ALL=C /usr/xpg4/bin/tr a-z A-Z
    FOO

So you're right.  Thanks!
Here's an updated patch:

>From 4048a5b393fa5f35dfe8157e98a6ea475b0efb2d Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Mon, 21 Sep 2009 10:58:02 +0200
Subject: [PATCH] pre-commit.sample: add comment re tr portability; fix grammar

Add a comment explaining why square brackets around a tr range
are not only ok, but actually required in this case.
Correct spelling and grammar.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 templates/hooks--pre-commit.sample |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index b11ad6a..128c8cc 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -14,15 +14,18 @@ allownonascii=$(git config hooks.allownonascii)
 # them from being added to the repository. We exploit the fact that the
 # printable range starts at the space character and ends with tilde.
 if [ "$allownonascii" != "true" ] &&
+	# Note that the use of brackets around a tr range is ok here, (it's
+	# even required, for portability to Solaris 10's /usr/bin/tr), since
+	# the square bracket bytes happen to fall in the designated range.
 	test "$(git diff --cached --name-only --diff-filter=A -z |
 	  LC_ALL=C tr -d '[ -~]\0')"
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
