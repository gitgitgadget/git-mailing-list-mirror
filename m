From: Junio C Hamano <junkio@cox.net>
Subject: Re: git clone dies (large git repository)
Date: Sat, 19 Aug 2006 13:46:30 -0700
Message-ID: <7vfyfs313t.fsf@assigned-by-dhcp.cox.net>
References: <op.teh30gmyies9li@rygel.lnxi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 19 22:46:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEXiP-0001Oc-La
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 22:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422779AbWHSUqc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 16:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422780AbWHSUqc
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 16:46:32 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:5878 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1422779AbWHSUqb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Aug 2006 16:46:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060819204630.YOSX27846.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 19 Aug 2006 16:46:30 -0400
To: "Troy Telford" <ttelford@linuxnetworx.com>
In-Reply-To: <op.teh30gmyies9li@rygel.lnxi.com> (Troy Telford's message of
	"Fri, 18 Aug 2006 16:42:06 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25734>

"Troy Telford" <ttelford@linuxnetworx.com> writes:

> I originally had everything as loose objects.  I then ran 'git-repack
> -d' on occasion, so I had a combination of a large pack file, smaller
> pack  files, and loose objects.  Finally, I tried 'git repack -a -d'
> and  consolidated it all into a single 4GB pack file.  It didn't seem
> to make  much difference in the output.
>
> Am I bumping some sort of limitation within git, or have I uncovered a bug?

The former.  Unfortunately this comes from an old design
decision.

Fortunately this design decision is not something irreversible
(see Chapter 1 of Documentation/ManagementStyle in the kernel
repository ;-).

The packfile is a dual-use format.  When used for network
transfer, we only send the .pack file and have the recipient
reconstruct the corresponding .idx file.  When used locally, we
need both .pack and .idx file; .pack contains the meat of the
data, and .idx allows us random access to the objects stored in
the corresponding .pack file.

What is interesting is that .pack format does not have (as far
as I know) inherent size limitation.  However, .idx file has
hardcoded 32-bit offsets into .pack -- hence, in practice, you
cannot use a .pack that is over 4GB locally.

One crude workaround that would work _today_ for your situation
without changing file formats would be to use git-fetch into an
empty repository (and do ref cloning by hand) instead of using
git-clone.  git-fetch gets .pack data over the wire and explode
the objects contained in the stream into individual objects (as
opposed to git-clone gets .pack data, stores it as a .pack and
tries to create corresponding .idx which in your case would bust
the 32-bit limit and fail).

This is from a private note I sent to Linus on Jun 26 2005 when
pack & idx pairs were initially introduced.

 - Design decision.  As before, you have assumption that nothing
   is longer than 2^32 bytes.  I am not unhappy with that
   restriction with individual objects (even their uncompressed
   size limited below 4GB or even 2GB is fine --- after all we
   are talking about a source control system).  I am however
   wondering if we would regret it later to have a packed file
   also limited to 4GB by having object_entry.offset "unsigned
   long" (and fwrite htonl'ed 4 bytes).  I personally do not
   have problem with this, but I can easily see HPA frowning on
   us.  He didn't like it when I said "in GIT world, file sizes
   and offsets are of type 'unsigned long'" some time ago.

I do not have a copy of a response from Linus to this point, but
if I recall things correctly, since then, the plan always has
been (1) to limit the size of individual packfiles to fit within
the idx limit and/or (2) extend the idx format to be able to
express offset over 2^32.  The latter is possible because idx
file is a local matter, used only for local accesses and does
not get set over the wire.

However, even if we revise the .idx file format, we have another
practical problem to solve.  Currently we assume that we can mmap
one packfile as a whole and do a random access into it.  This
needs to be changed so that we (perhaps optionally, only when
dealing with a huge packfile) mmap part of a .pack at a time.

I recall more recently (as opposed to the heated discussion
immediately after packfile was introduced June last year) we had
another discussion about people not being able to mmap huge
packfiles, and partial mmapping was one of the things that were
discussed there.
