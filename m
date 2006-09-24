From: Junio C Hamano <junkio@cox.net>
Subject: What will happen to git.git in the near future
Date: Sun, 24 Sep 2006 03:37:57 -0700
Message-ID: <7v7iztbldm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Sep 24 12:38:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRRN7-0004z6-2G
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 12:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbWIXKh7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 06:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbWIXKh7
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 06:37:59 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:39121 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751934AbWIXKh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 06:37:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060924103758.XQPE13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Sun, 24 Sep 2006 06:37:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id SAe01V00B1kojtg0000000
	Sun, 24 Sep 2006 06:38:00 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27652>

Here are some random thoughts on the short-term plan.  We are
currently at 1.4.2 release (and "maint" is at 1.4.2.1).

I do not know when the changes are big enough to start the 1.5
series, so tentatively I'll call the next one 1.4.3, the one
that follows 1.4.4, and so on, in the following description.

 - git-resolve is deprecated on "master" and will continue to be
   so until 1.4.3.  We will remove it before 1.4.4 happens.

 - We will deprecate the original merge-recursive written in
   Python by renaming it to merge-recursive-old, and make
   merge-recur to take its place.  1.4.3 will ship that way.
   Sometime in not so distant future we will remove
   merge-recursive-old and merge-recur, perhaps in 1.4.5.

 - We should deprecate git-tar-tree.  However, it has been
   around and advertised for quite some time, so we need to make
   sure people would not get burned too badly.  It might be
   worthwhile to rewrite git-tar-tree as a thin wrapper to
   "git-archive --format=tar" and remove git-upload-tar now (in
   other words, "git-tar-tree --remote" will continue to work,
   but it will talk with "git-upload-archive", not with
   "git-upload-tar" on the other end), release 1.4.3 with it
   with a deprecation warning, and then remove it in 1.4.5.

 - virtual hosting by git-daemon should be ready.  I will push
   it out to "master" before 1.4.3 release.

 - packed-refs still has a few issues before it can hit
   "master". 

   - deleting branches does not really work yet, as there have
     been some discussions on the list.

   - dumb transports are unaware of it.  Trying to fetch a
     ref that is packed would not work.

   I feel this series to be a significant enough change that
   deserve a bit careful handling.  Perhaps in 1.4.4 release.

 - The per-branch configuration to control git-fetch is Ok in
   itself, and we might want to push it out to "master" and
   release 1.4.3 with it in its current form.  But the topic
   might want to learn other tricks to have more comprehensive
   per-branch configuration support.  We will see how it plays
   out.

 - Git.pm lost Git.xs which hopefully would make it a bit easier
   to work for wider audiences.  Hopefully we can push it out to
   "master" soon and see if anybody screams.  Depending on what
   happens, it may be in 1.4.3 release.

 - git-show-ref and git-for-each-ref serve similar purpose (when
   viewed in a bigger picture) but with different interface and
   different set of features.  We should consolidate them into
   one command before they hit in any released version.

 - git-log's support for --committer=, --author= and --grep= is
   Ok by itself, but I feel we should do a bit more to make it
   useful.  Currently we cannot say "written by A and committed
   by B", or "written by C and have word D in the log".  Because
   the boolean logic between match patterns we use internally
   are line oriented, borrowing --and from git-grep is not
   enough ("--committer=A --and --author=B" would mean 'if the
   commit object has a header line that matches "^committer .*A"
   and "^author .*B" at the same time', which is not what we
   want).  We would need a "buffer-wide AND" that can express
   'see if there is a header line that matches "^committer .*A"
   and a header line, which may be different from the
   "committer" one, that matches "^author .*B"'.

   Implementing "buffer-wide AND" will involve updating git-grep
   but as a side effect we will also be able to say "find files
   that have word A and B in them", which would be a useful
   thing.  I'd push the current implementation out to "master"
   soon and release 1.4.3 with it, and defer implementation of
   the buffer-wide AND to a later version.

 - generation of version 3 pack files is 1.4.3 material.

 - new pack object format to express delta base object by the
   offset in the stream will start cooking in "next" soon; I
   just haven't got around to merge it yet.  I feel this to be
   significant enough change that can deserve a bit careful
   handling.  Perhaps in 1.4.4 or 1.4.5 release.

 - windowed mmap() of pack data is an important change (I do not
   mean to pressure Shawn by saying this) and needs to be cooked
   carefully.  I do not expect it to be ready until 1.4.5
   release at the earliest.
