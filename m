From: Junio C Hamano <junkio@cox.net>
Subject: Re: Change set based shallow clone
Date: Mon, 11 Sep 2006 11:54:40 -0700
Message-ID: <7v8xkqgrnz.fsf@assigned-by-dhcp.cox.net>
References: <20060910190332.17667.qmail@science.horizon.com>
	<Pine.LNX.4.64.0609101254590.27779@g5.osdl.org>
	<17668.38032.20688.991295@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609101949580.27779@g5.osdl.org>
	<Pine.LNX.4.64.0609102002300.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, linux@horizon.com,
	jonsmirl@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 11 20:54:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMqun-0001HL-CB
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 20:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWIKSxu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 14:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWIKSxu
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 14:53:50 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:44934 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S964932AbWIKSxu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Sep 2006 14:53:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060911185349.WAQC2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Mon, 11 Sep 2006 14:53:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id M6tf1V00G1kojtg0000000
	Mon, 11 Sep 2006 14:53:40 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609102002300.27779@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 10 Sep 2006 20:18:49 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26856>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 10 Sep 2006, Linus Torvalds wrote:
>> 
>> If we did the same pack-file approach that we do for objects, the problem 
>> ends up being that _updating_ things is really hard. What we could do (and 
>> might work) is that a "git repack" would create a "packed representation 
>> of the heads too".
>
> To clarify: I'm _not_ suggesting actually using the "pack-file" 
> representation itself for the references.
>
> I'm saying that we could have something like a
>
> 	.git/refs-packed
>
> file, which could be (for example) just a plain linear text-file, of the 
> form
>
> 	19ed368b17abfb9ad5c7467ea74fd8a045d96b43	refs/heads/html
> 	60a6bf5f53635005f4f68d8b8a33172309193623	refs/heads/maint
> 	2d32e76f893b2ac432201ce7596c8bab691691e6	refs/heads/man
>...
> 	9165ec17fde255a1770886189359897dbb541012	refs/tags/v0.99.7c
> 	02b2acff8bafb6d73c6513469cdda0c6c18c4138	refs/tags/v0.99.7d
> 	...
>
> ie it would contain just a linear file with the "<hex></tab><refname>"
> format.

This depends on how expensive it is to read a file backwards,
but it might make sense to have a single append-only file.

${GIT_DIR}/refs-packed file would be a sequence of records, each
record is of form:

	type SP timestamp LF payload LF length LF

where length and timestamp are ASCII integers, the former is the
length of this record and you would use to compute the file
offset you give lseek() to seek back to the beginning of this
record.  The latter is the creation time of this record.  The
type of the record is either full or incremental (perhaps 'F'
and 'I').

A full record describes in the above "object-name refname" tuple
format.  An incremental record has entries only for the subset
of refs, with 0{40} object name denoting deletion of a ref as in
your suggestion.

A few nice things about this representation:

 - It gives reflog for free (we need to add 'author' and
   'reason' encoded after timestamp, though); it also gives
   reflog to tags which I sometimes miss.

 - Garbage collection is straightforward, although it requires
   locking the whole refs.

 - You can now have 'foo' and 'foo/a', 'foo/b', branches at the
   same time.  It is natural to organize a topic branch 'foo'
   which consists of a merge of subtopics 'foo/a', 'foo/b', ...,
   but this cannot be expressed with the current directory-file
   based scheme.

Some minor details:

 - After every N (I do not think we would need to make this
   configurable, but we need to decide on a sane value) updates,
   we would want to write a full record so that we do not have
   to traverse too long a chain.

 - An incremental record could be delta since the last full,
   instead of delta since the last record, as the above
   introduction hints.  If we start from A, B, and C, and then A
   and B are modified in turn, we might have:

	Full: A B C
        Incr: A'
        Incr: B'

   but we could have instead:

	Full: A B C
        Incr: A'
        Incr: A' B'

   For this to make sense, the record header needs to record a
   back-pointer to the last full record before the current
   incremental record.  With that, we would need to read at most
   two records to find out the current status.

Locking between writers and readers can become problematic.  The
reader would read the last line to find the record length, seek
that much back to find the beginning of the "then-latest"
record, but when there is a simultanous writer, there is no
guarantee that what at the last line of the file _is_ the length
of the last record.  The writer may be in the middle of
appending something.  We may be able to work it around by:

 - Add hash of the record at the end;

 - The reader assumes that there is usually no collision, reads
   the hash and the length, seeks back and reads the record and
   validate the hash -- if the hash does not match, it is likely
   that it detected the writer-reader collision so it should
   wait until the file grows and stops growing and then retry.

But writer-writer contention obviously needs a file lock.  Maybe
we can use flock/lockf/fcntl(F_SETLKW)?  If we are going to do
that then protecting the reader-writer side with the same
mechanism may be simpler and cleaner.

> NOTE! It's important that whatever sceme used gets locking right. The 
> above suggestion gets it right simply because it doesn't really _change_ 
> anything. Any new or modified ref ends up using the old code, and using a 
> ".lock" file and renaming it automatically does the same thing it ever 
> did.

The above changes things quite a bit, so locking aspect of it
needs to be thought through thouroughly.
