From: Junio C Hamano <junkio@cox.net>
Subject: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 11:46:48 -0700
Message-ID: <7vd5su7e5j.fsf@assigned-by-dhcp.cox.net>
References: <20050416131528.GB19908@elte.hu>
	<Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
	<7vmzry7ev5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 20:43:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMsGJ-0003lL-2u
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 20:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbVDPSrA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 14:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbVDPSrA
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 14:47:00 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:48542 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262728AbVDPSqz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 14:46:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050416184649.CXAA9923.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Apr 2005 14:46:49 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vmzry7ev5.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 16 Apr 2005 11:31:26 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

JCH> I have been cooking this idea before I dove into the merge stuff
JCH> and did not have time to implement it myself (Hint Hint), but I
JCH> think something along the following lines would work nicely:

It should be fairly obvious from the context what I meant to
say, but in case somebody gets confused by my inaccurate
description of small details (or, before somebody nitpicks ;-),
I'd add some clarifications and corrections.

JCH>  * Run diff-tree between neighboring commits [*1*] to find out
JCH>    the set of blobs that are "related".  Extract those related
JCH>    blobs and run "diff" [*2*] between them to see if it produces
JCH>    a patch smaller than the whole thing when compressed.  If
JCH>    diff+patch is a win, then we do not have to transmit the blob
JCH>    that we could reproduce by sending the diff.  Note that fact.

I talked only about blobs here, but I really mean all types:
commits, trees and blobs here.  Nothing prevents us from
extracting the raw data for trees and commits and run diff
between them.  We can use cat-file to do that today.

What we do not have is the reverse of "$ cat-file type >rawdata"
(i.e. "$ write-file type <rawdata"), but that is trivial to
write.  The raw data for related tree objects should delta well.
I do not think it is worth the effort to attempt delta for
commit objects.  Anything that git-archive-tar decides not to
send in diff+patch form, be it blob or tree or commit, should be
noted here, not just blob as my previous message incorrectly
implies.

JCH> Given the above, the operation of git-archive-patch is also
JCH> quite obvious.  Extract the "diff package" tarball into the
JCH> objects/ directory that has (at least) the full Bn, uncompress
JCH> the patch file part, and run patch on it. 

Of course after you ran patch to reproduce the raw data for the
blob or tree, we need the reverse of cat-file to register such
data under object/ hierarchy.

