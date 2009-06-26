From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: Troubles when directory is replaced by symlink
Date: Fri, 26 Jun 2009 15:14:25 +0200
Organization: private
Message-ID: <868wjf9lxq.fsf@broadpark.no>
References: <c6c947f60906042243v2e36251dn9a46343cf6b8a2f4@mail.gmail.com>
 <c6c947f60906090118n78d3c40fq11d1390f8776c2c0@mail.gmail.com>
 <20090611114846.GC4409@coredump.intra.peff.net> <861vpmkhob.fsf@broadpark.no>
 <885649360906241507r6ac78495s802f8b7758bcabf9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Alexander Gladysh <agladysh@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 15:16:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKBHz-0007sN-27
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 15:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754055AbZFZNQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 09:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753948AbZFZNQG
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 09:16:06 -0400
Received: from bgo1smout1.broadpark.no ([217.13.4.94]:58372 "EHLO
	bgo1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840AbZFZNQF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 09:16:05 -0400
Received: from bgo1sminn1.broadpark.no ([217.13.4.93])
 by bgo1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KLU008NLKUEHKC0@bgo1smout1.broadpark.no> for
 git@vger.kernel.org; Fri, 26 Jun 2009 15:15:50 +0200 (CEST)
Received: from localhost ([80.203.78.118]) by bgo1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KLU00D0IKUBE330@bgo1sminn1.broadpark.no> for
 git@vger.kernel.org; Fri, 26 Jun 2009 15:15:50 +0200 (CEST)
In-reply-to: <885649360906241507r6ac78495s802f8b7758bcabf9@mail.gmail.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122297>


From: Kjetil Barvik <barvik@broadpark.no>
Date: Fri, 26 Jun 2009 14:51:02 +0200
Subject: [PATCH] lstat_cache: guard against full match of length of 'name' parameter

longest_path_match() in symlinks.c does exactly what it's name says,
but in some cases that match can be too long, since the
has_*_leading_path() functions assumes that the match will newer be as
long as the name string given to the function.

Fix this by adding an extra if test which checks if the match length
is equal to the 'len' parameter.  Also, add a test-case to catch this

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---

* James Pickens <jepicken@gmail.com> writes:
> On Sun, Jun 14, 2009, Kjetil Barvik<barvik@broadpark.no> wrote:
>> From: Kjetil Barvik <barvik@broadpark.no>
>> Date: Sun, 14 Jun 2009 15:08:28 +0200
>> Subject: [PATCH] lstat_cache: guard against full match of length of 'name' parameter
>
> My project ran into this bug today, and I can confirm that this patch
> fixes it.  I think it's an important bug; it hasn't been mentioned yet,
> but this can result in lost work if the user had modified, but not added,
> one of the files that Git wrongly deleted.
>
> So, what's the status of this patch?

  OK, here is a more final patch with a test case.  

  -- kjetil


 symlinks.c                  |    2 ++
 t/t2007-checkout-symlink.sh |   31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/symlinks.c b/symlinks.c
index 8dcd632..66a0e16 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -96,6 +96,8 @@ static int lstat_cache(const char *name, int len,
 		match_len = last_slash =
 			longest_path_match(name, len, cache.path, cache.len,
 					   &previous_slash);
+		if (!(track_flags & FL_FULLPATH) && match_len == len)
+			match_len = last_slash = previous_slash;
 		match_flags = cache.flags & track_flags & (FL_NOENT|FL_SYMLINK);
 		if (match_flags && match_len == cache.len)
 			return match_flags;
diff --git a/t/t2007-checkout-symlink.sh b/t/t2007-checkout-symlink.sh
index 20f3343..08e3c32 100755
--- a/t/t2007-checkout-symlink.sh
+++ b/t/t2007-checkout-symlink.sh
@@ -53,4 +53,35 @@ test_expect_success 'switch from dir to symlink' '
 
 '
 
+test_expect_success 'setup of new directories and a branch' '
+
+	git checkout master &&
+
+	mkdir alpha &&
+	echo content >alpha/file &&
+	git add . &&
+	git commit -m one &&
+
+	mkdir beta &&
+	cp -R alpha beta &&
+	git add . &&
+	git commit -m two &&
+
+	git checkout -b branch &&
+	rm -rf beta/alpha &&
+	git add -u &&
+	git commit -m deleted &&
+	ln -s ../alpha beta/alpha &&
+	git add . &&
+	git commit -m symlink
+
+'
+
+test_expect_success 'checkout of master - alpha/file and beta/alpha/file should exist' '
+
+	git checkout master &&
+	ls alpha/file beta/alpha/file
+
+'
+
 test_done
-- 
1.6.3.2.277.gd10543
