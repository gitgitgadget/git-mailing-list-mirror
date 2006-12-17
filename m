X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-add fails after file type change
Date: Sat, 16 Dec 2006 17:39:06 -0800
Message-ID: <7vk60r7139.fsf@assigned-by-dhcp.cox.net>
References: <458437E0.1050501@midwinter.com> <45843C5A.8020501@gmail.com>
	<45848CF8.4000704@midwinter.com>
	<7vvekb73jh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 17 Dec 2006 01:39:32 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vvekb73jh.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 16 Dec 2006 16:46:10 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34673>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gvkzv-0003TR-Tu for gcvg-git@gmane.org; Sun, 17 Dec
 2006 02:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751627AbWLQBjL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 20:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbWLQBjL
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 20:39:11 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:47673 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751627AbWLQBjK (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 20:39:10 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061217013907.PULN9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Sat, 16
 Dec 2006 20:39:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zdfK1V00E1kojtg0000000; Sat, 16 Dec 2006
 20:39:19 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

When replacing an existing file A with a directory B that has a
file B/C in it in the index, 'update-index --replace --add B/C'
did not properly remove the file to make room for the new
directory.

There was a trivial logic error, most likely a cut & paste one,
dating back to quite early days of git.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

  Junio C Hamano <junkio@cox.net> writes:

  > But I think you helped me to spot a bug ;-).
  >
  >         $ git update-index --replace --add 3/2
  >         $ git ls-files -s
  >         100644 00750edc07d6415dcc07ae0351e9397b0222b7ba 0     1
  >         100644 00750edc07d6415dcc07ae0351e9397b0222b7ba 0     3
  >         100644 fa457baf8abbf5dd3bb4cbfab0c5a4cf0523d7f8 0     3/2
  >
  > The entry '3' should have been removed when we did --replace.
  > This index cannot be written out as a tree:
  >
  >       $ git write-tree
  >         You have both 3 and 3/2
  >         fatal: git-write-tree: error building trees

  And this fixes it.

 read-cache.c     |    2 +-
 t/t0000-basic.sh |    9 +++++++++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index a602010..e856a2e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -517,7 +517,7 @@ static int has_dir_name(const struct cache_entry *ce, int pos, int ok_to_replace
 		pos = cache_name_pos(name, ntohs(create_ce_flags(len, stage)));
 		if (pos >= 0) {
 			retval = -1;
-			if (ok_to_replace)
+			if (!ok_to_replace)
 				break;
 			remove_cache_entry_at(pos);
 			continue;
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 3260d1d..0cd1c41 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -272,4 +272,13 @@ test_expect_success \
 	 wc -l) &&
      test $numparent = 1'
 
+test_expect_success 'update-index D/F conflict' '
+	mv path0 tmp &&
+	mv path2 path0 &&
+	mv tmp path2 &&
+	git update-index --add --replace path2 path0/file2 &&
+	numpath0=$(git ls-files path0 | wc -l) &&
+	test $numpath0 = 1
+'
+
 test_done
