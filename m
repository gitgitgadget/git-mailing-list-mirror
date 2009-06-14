From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: Troubles when directory is replaced by symlink
Date: Sun, 14 Jun 2009 16:34:44 +0200
Organization: private
Message-ID: <861vpmkhob.fsf@broadpark.no>
References: <c6c947f60906042243v2e36251dn9a46343cf6b8a2f4@mail.gmail.com>
 <c6c947f60906090118n78d3c40fq11d1390f8776c2c0@mail.gmail.com>
 <20090611114846.GC4409@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 16:36:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFqob-0005vG-C0
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 16:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755385AbZFNOgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 10:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755169AbZFNOf7
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 10:35:59 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:44543 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755051AbZFNOf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 10:35:58 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KL8007VWGJZNZ10@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 14 Jun 2009 16:35:59 +0200 (CEST)
Received: from localhost ([80.203.78.58]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KL8006D5GJWA600@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 14 Jun 2009 16:35:59 +0200 (CEST)
In-reply-to: <20090611114846.GC4409@coredump.intra.peff.net>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121551>


From: Kjetil Barvik <barvik@broadpark.no>
Date: Sun, 14 Jun 2009 15:08:28 +0200
Subject: [PATCH] lstat_cache: guard against full match of length of 'name' parameter

longest_path_match() in symlinks.c does exactly what it's name says,
but in some cases that match can be too long, since the
has_*_leading_path() functions assumes that the match will newer be as
long as the name string given to the function.

fix this by adding an extra if test which checks if the match length
is equal to the 'len' parameter.
---

  OK, this is a first version of a patch for this bug.  I have not added
  a "Signed-off-by:"-tag yet, but I intend to do that when I am more
  shure that this is the real fix for the bug.  Will also add a test
  case in a later version.

  The given instructions(1) to repeat the failure, gave me the following
  4 calls to has_symlink_leading_path() for the failed 'git checkout
  master' command, and I made the following the table:

   'name' parameter       Kjetil      Linus      tested
  -------------------------------------------------------
   "beta/alpha/file"        2           1           2
   "beta/alpha"             2C          0           0
   "alpha/file"             0           0           0
   "beta/alpha/file"        0           1C          0

  The "Kjetil" column is what the h_s_l_p() function returns as of
  commit 92604b46 by me.  The "Linus" column is what the h_s_l_p()
  function returns as of commit c40641b7 by Linus.  The "tested" column
  is what will be returned when the cache is clear'ed each time.  An
  added "C" indicate that the result was cached/taken from the cache.

  My bug is from the incorrect cached value from line 2, and since I
  noticed that it take the symbolic link result, "beta/alpha", which was
  the full length of the 'name' parameter and not the leading part, I
  have based the included patch on this fact.

  The function is named has_symlink_leading_path(), so I guess it is a
  reason for that "leading" part of the name.  So, is this a reasonable
  fix?  Other comments?

  -- kjetil

  1) the following commands:

# make a repo
mkdir repo && cd repo && git init

# content in alpha
mkdir alpha && echo content >alpha/file && git add . && git commit -m one
# and duplicate content inside beta
mkdir beta && cp -R alpha beta && git add . && git commit -m two

# now replace the duplicate with a symlink
git checkout -b branch
rm -rf beta/alpha && git add -u && git commit -m deleted
ln -s ../alpha beta/alpha && git add . && git commit -m symlink

# now checkout master again; alpha/file will be missing, even
# though it wasn't touched at all
git checkout master



 symlinks.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/symlinks.c b/symlinks.c
index 8dcd632..934abc6 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -97,6 +97,10 @@ static int lstat_cache(const char *name, int len,
 			longest_path_match(name, len, cache.path, cache.len,
 					   &previous_slash);
 		match_flags = cache.flags & track_flags & (FL_NOENT|FL_SYMLINK);
+
+		if (!(track_flags & FL_FULLPATH) && match_len == len)
+			match_len = last_slash = previous_slash;
+
 		if (match_flags && match_len == cache.len)
 			return match_flags;
 		/*
-- 
1.6.3.2.277.gd10543
