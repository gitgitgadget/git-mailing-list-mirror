From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Not going beyond symbolic links
Date: Wed, 06 Aug 2008 23:52:38 -0700
Message-ID: <7vk5etjozt.fsf@gitster.siamese.dyndns.org>
References: <20080721002354.GK10151@machine.or.cz>
 <20080721002508.26773.92277.stgit@localhost>
 <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org>
 <7vej5543v5.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0808041719380.3299@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 07 08:54:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQzNl-0002JK-8j
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 08:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753835AbYHGGwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 02:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753832AbYHGGwz
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 02:52:55 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53988 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbYHGGwy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 02:52:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5FED24E9F8;
	Thu,  7 Aug 2008 02:52:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 637F34E9F6; Thu,  7 Aug 2008 02:52:43 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0808041719380.3299@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Mon, 4 Aug 2008 17:21:03 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 737425F8-644D-11DD-938D-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91560>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 4 Aug 2008, Junio C Hamano wrote:
>> 
>> I started to revisit this issue and patched "git update-index --add"
>> and "git add" so far.  Patches follow.
>
> Patches look good to me, but did you check the performance impact?
>
> The rewritten 'has_symlink_leading_path()' should do ok, but it migth 
> still be a huge performance downside to check all the paths for things 
> like "git add -u".

I couldn't quite measure much meaningful performance impact.

My test repository was the kernel tree at v2.6.27-rc2-20-g685d87f, without
any build products nor editor temporary crufts.

By the way, if anybody wants to reproduce this, be careful with the tests
that run "rm -f .git/index" before adding everything.  After doing so, if
you check the result with "git diff --stat HEAD", you will notice many
missing files --- I almost got a heart attack before inspecting this file:

	$ cat arch/powerpc/.gitignore
        include

Yes, it excludes 261 already tracked files.  Is it intended?  I dunno.

The file is there since 06f2138 ([POWERPC] Add files build to .gitignore,
2006-11-26).  Not that having tracked files in an entirely ignored
directory is a bug, but the .gitignore entry seems to me an Oops waiting
to happen.  There are three commits that affect this directory that is
entirely ignored after that entry is added:

    b5b9309 (remove unnecessary <linux/hdreg.h> includes, 2008-08-05)
    9c4cb82 (powerpc: Remove use of CONFIG_PPC_MERGE, 2008-08-02)
    b8b572e (powerpc: Move include files to arch/powerpc/include/asm, 2008-08-01)

Anyhow, back on topic.  Here are the numbers.

Test #1: With fully up-to-date .git/index, "git add .", best of 5 runs

* v1.6.0-rc2
0.20user 0.20system 0:00.41elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+3622minor)pagefaults 0swaps

* v1.6.0-rc1-73-g725b060 (with patch)
0.22user 0.19system 0:00.41elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+3635minor)pagefaults 0swaps


Test #2: After "rm -f .git/index", "git add .", best of 5 runs

* v1.6.0-rc2
1.81user 0.55system 0:02.51elapsed 93%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+92855minor)pagefaults 0swaps

* v1.6.0-rc1-73-g725b060 (with patch)
1.76user 0.56system 0:02.58elapsed 89%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+92852minor)pagefaults 0swaps


Test #3: same as #2, after dropping cache with "echo 3 > /proc/sys/vm/drop_caches".
(Yes, I have slow disks).

* v1.6.0-rc2
3.43user 2.29system 2:02.45elapsed 4%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (29611major+63244minor)pagefaults 0swaps

* v1.6.0-rc1-73-g725b060 (with patch)
3.55user 2.33system 1:54.77elapsed 5%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (29616major+63236minor)pagefaults 0swaps

Test #4: same as #1, "strace -c -e lstat"

* v1.6.0-rc2
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
100.00    0.000247           0     23993           lstat

* v1.6.0-rc1-73-g725b060 (with patch)
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
100.00    0.000261           0     23993           lstat

Test #5: same as #2, "strace -c -e lstat"

* v1.6.0-rc2
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
100.00    0.000639           0     23993           lstat

* v1.6.0-rc1-73-g725b060 (with patch)
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
100.00    0.000427           0     23993           lstat
