From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: re-validate data we copy from elsewhere.
Date: Sat, 02 Sep 2006 02:42:20 -0700
Message-ID: <7vwt8m1u6b.fsf@assigned-by-dhcp.cox.net>
References: <20060830015122.GE22935@spearce.org>
	<9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
	<20060830031029.GA23967@spearce.org>
	<Pine.LNX.4.64.0608300124550.9796@xanadu.home>
	<7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <44F871BA.3070303@gmail.com>
	<Pine.LNX.4.64.0609011129270.27779@g5.osdl.org>
	<7vveo741tc.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609011721390.27779@g5.osdl.org>
	<7vd5ae3ox2.fsf@assigned-by-dhcp.cox.net>
	<20060902045246.GB25146@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 11:42:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJS18-0001Kl-PV
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 11:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWIBJmU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 05:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbWIBJmU
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 05:42:20 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:62374 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750919AbWIBJmT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 05:42:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060902094219.MFEI20060.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Sat, 2 Sep 2006 05:42:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HMiD1V00K1kojtg0000000
	Sat, 02 Sep 2006 05:42:14 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060902045246.GB25146@spearce.org> (Shawn Pearce's message of
	"Sat, 2 Sep 2006 00:52:46 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26325>

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> It might be worthwhile to disable revalidate reused objects
>> individually and instead scan and checksum the entire .pack file
>> when the number of objects being reused exceeds certain
>> threshold, relative to the number of objects in existing pack,
>> perhaps.
>
> Correct me if I'm wrong but didn't this revalidate check happen
> because the SHA1 of the pack was correct but there was a bad bit
> in the zlib stream?

There are two more or less independent problems and you are
correct to point out that summing the entire .pack does not
catch one class of problem while it does catch the other.

The Linus's theory goes like this:

 (1) A bit in an existing pack was damaged somehow.  It might have
     happened on the mothership machine when it was first created,
     or after it was read and copied to the notebook via rsync.

 (2) A 'repack -a -d' was done in a repository that had that
     damanged pack, it decided to reuse a deflated object from the
     existing, damaged pack, and copied that deflated
     representation into a newly created pack without validating.

 (3) The 'repack -a -d', when finishing the newly created pack,
     computed a checksum over the whole new pack and wrote the
     SHA-1 checksum in it.

Now, sha1_file() has check_packed_git_idx() that makes sure .idx
file is not corrupted; it runs the checksum over the whole .idx
data when it first maps in and makes sure the sum matches what
is recorded at the end.  So if the corruption in (1) happened to
the .idx file, 'repack -a -d' in (2) would have noticed and
refused to use the corresponding .pack.

The problem is that there is however no corresponding "checksum
over the whole file before use" for .pack file during a normal
operation of use_packed_git().  Otherwise we would have caught
the corruption in the existing pack and prevented step (2) from
propagating the error.

The idea proposed by Linus and implemented in the patch in this
thread is to mitigate this by revalidating the individual pieces
we copy in (2).  If we copy out most of what is in the existing
pack, however, it may be cheaper to do the "whole file checksum
before use" instead.

On the other hand, the "alpha particle at the right moment"
theory goes like this:

 (1) write_object() gave the buffer to sha1write_compressed();

 (2) sha1write_compressed() asked zlib to deflate the data and
     received the result in buffer pointed by void *out;

 (3) bit flipped in that buffer, after zlib finished writing
     into it with the CRC;

 (4) sha1write() wrote out the now-corrupt buffer, while
     computing the correct checksum for the end result (which is
     now corrupt).

This breakage will not be caught unless we revalidate everything
we copy out to the new pack.


-- 
VGER BF report: U 0.5
