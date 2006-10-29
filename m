X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] gitweb: New improved patchset view
Date: Sun, 29 Oct 2006 10:49:45 -0800
Message-ID: <7v3b972bzq.fsf@assigned-by-dhcp.cox.net>
References: <200610291122.30852.jnareb@gmail.com>
	<200610291850.46321.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 18:50:23 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610291850.46321.jnareb@gmail.com> (Jakub Narebski's message
	of "Sun, 29 Oct 2006 18:50:46 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30438>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeFjN-0007MN-Q3 for gcvg-git@gmane.org; Sun, 29 Oct
 2006 19:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932427AbWJ2St6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 13:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWJ2St6
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 13:49:58 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:44799 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S932427AbWJ2St6
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 13:49:58 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061029184957.KLVE6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Sun, 29
 Oct 2006 13:49:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id gJpq1V00P1kojtg0000000 Sun, 29 Oct 2006
 13:50:02 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> A couple of questions regarding new patchset/diff look for gitweb.
> Currently patch starts with "git diff" header
>
>   diff --git a/file1 b/file2
>
> then we have a couple of extended header lines
>
>   old|new|deleted file|new file mode <mode>
>   copy|rename from|to <path>
>   (dis)?similarity index <percent>
>   index <hash>..<hash> [<mode>]
>
> then we have two-line from-file/to-file header
>
>   --- a/file1
>   +++ b/file2
>
> then patch itself.

Before answering 3 questions, I think we need to ask a bigger
question.  What is the primary target audience of gitweb?

If it is for git-uninitiated, then staying as close to what GNU
diff would give would be a better idea.  I would say we at least
can assume that the user has some familiarity with SCM, and
knows what kind of information is kept track of and is shown as
differences between versions, and what files, directories and
symlinks are, but not how git represents these.  On the other
hand, if the user uses git to track a project (not necessarily
the project the user is looking at with gitweb) and is familiar
with the way git-diff presents these information, deviating from
git-diff output is distractiing.

At least to me /-rw-rw-... part made me feel uneasy for that
reason.

WIth that in mind, I'll think aloud what I would like if I were
not familiar with git:

 * "diff --git a/file b/file" would not use /dev/null but
   ---/+++ does.  If the former is shown as link, it should be
   visible which side is a link and which side is not for
   creation or deletion diff; otherwise you would need a second
   to realize it is not a bug that clicking on a/file on the
   "diff --git" line did not show anything for a creation diff.

 * I think showing object names in "index xxx..yyy mode" line is
   not very useful to humans (they are added for tools).  I do
   agree that we would want some clickable handle in combined
   diff output, but people not familiar with git would not know
   that "index xxx,yyy..zzz" is where you would find the
   parents, so that line needs to be munged anyway.

   Side note: Even though some git people (Luben, for example)
   claim they recognize some abbreviated object names, I suspect
   that are mostly recent commits and not blobs.

 * Mode on the "index" line may be useful, but as you say 100644
   is probably too git specific; however if our audience is
   git-uninitiated, I doubt -rw-r--r-- is much better (it is
   UNIXism, which I personally do not mind).  Spelling them out
   like "regular file", "executable file", or "symbolic link"
   might be more readable.  And spelling them out is more
   technically correct; when git says 100644, it does _not_ mean
   "-rw-r--r--", but it means "regular file, not executable"
   (IOW, we borrowed the octal bits from POSIX but it means
   slightly a different thing).

 * So the above two together suggests that I probably would want
   to see something like:

	diff --git a/file b/file (regular file)

   with a/file and b/file as visible links for one parent diff.
   For combined,

        diff --cc a/file b/file (regular file)

   with perhaps a/file be a pop-up window that has a list of
   links to parent blobs (b/file is a link to the merge result
   blob), or maybe 

        diff --cc a/file (parent1 parent2) b/file (regular file)

   where parent#N is a link to the blob in the parent (a/file is
   not clickable, b/file is the link to the result blob).

 * I think redundant links to blobs in extended headers (rename
   from ... to ...) and ---/+++ lines are Ok, but as other
   redundant links they probably are better kept half-hidden
   (i.e. react to mouse-over like commit titles) to avoid visual
   distraction.

 * I think the filename quoting is better left as-is, since it
   is a way to indicate something funny is going on. 

   One thing I noticed while browsing gitweb/ part is that we
   quote byte values above 128; we might want to change
   quote_c_style_counted() to either use unsigned char to avoid
   this, or explicitly use signed char to keep this across
   platforms (char could be unsigned char).


