From: Henrik Austad <henrik@austad.us>
Subject: Re: git checkout does not warn about tags without corresponding commits
Date: Sat, 3 Jan 2009 12:00:01 +0100
Message-ID: <200901031200.01883.henrik@austad.us>
References: <200901021325.58049.henrik@austad.us> <7v8wptcrhp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xU0XJ9mh17RXblj"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 03 12:01:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJ4GK-0004MO-Rq
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 12:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755895AbZACLA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 06:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753604AbZACLA0
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 06:00:26 -0500
Received: from cassarossa.samfundet.no ([129.241.93.19]:35575 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbZACLAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 06:00:25 -0500
Received: from asterix.samfundet.no
	([2001:700:300:1800::f] helo=asterix.frsk.net ident=Debian-exim)
	by cassarossa.samfundet.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <henrik@austad.us>)
	id 1LJ4Ej-000601-LS; Sat, 03 Jan 2009 12:00:13 +0100
Received: from ti121210a080-2009.bb.online.no ([85.164.71.219] helo=[192.168.1.1])
	by asterix.frsk.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <henrik@austad.us>)
	id 1LJ4Ej-0007iL-Ag; Sat, 03 Jan 2009 12:00:09 +0100
User-Agent: KMail/1.9.10
In-Reply-To: <7v8wptcrhp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104460>

--Boundary-00=_xU0XJ9mh17RXblj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 02 January 2009 22:44:50 Junio C Hamano wrote:
> Henrik Austad <henrik@austad.us> writes:
> > I recently tried to do a checkout of (what I thought was the first) inux
> > kernel in the linux git repo.
> >
> > git checkout -b 2.6.11 v2.6.11
>
> This should have barfed, and indeed I think it is a regression around
> v1.5.5.  v1.5.4 and older git definitely fails to check out a tree object
> like that.

You're right, I bisected it down to commit 
782c2d65c24066a5d83453efb52763bc34c10f81

It introduces quite a large change, adding checkout-builtin.c, which coud be 
the cause I guess.

As of how to fix this (if a fix is desired) I have not yet any clue what so 
ever :-)

I attached the bisect result (sorry if attachements are frowned upon, but my 
email client tends to mutilate text-contents like that).

-- 
 -> henrik

--Boundary-00=_xU0XJ9mh17RXblj
Content-Type: text/plain;
  charset="iso 8859-15";
  name="git_bisect_res.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="git_bisect_res.txt"

782c2d65c24066a5d83453efb52763bc34c10f81 is first bad commit
commit 782c2d65c24066a5d83453efb52763bc34c10f81
Author: Daniel Barkalow <barkalow@iabervon.org>
Date:   Thu Feb 7 11:40:23 2008 -0500

    Build in checkout

    The only differences in behavior should be:

     - git checkout -m with non-trivial merging won't print out
       merge-recursive messages (see the change in t7201-co.sh)

     - git checkout -- paths... will give a sensible error message if
       HEAD is invalid as a commit.

     - some intermediate states which were written to disk in the shell
       version (in particular, index states) are only kept in memory in
       this version, and therefore these can no longer be revealed by
       later write operations becoming impossible.

     - when we change branches, we discard MERGE_MSG, SQUASH_MSG, and
       rr-cache/MERGE_RR, like reset always has.

    I'm not 100% sure I got the merge recursive setup exactly right; the
    base for a non-trivial merge in the shell code doesn't seem
    theoretically justified to me, but I tried to match it anyway, and the
    tests all pass this way.

    Other than these items, the results should be identical to the shell
    version, so far as I can tell.

    [jc: squashed lock-file fix from Dscho in]

    Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

:100644 100644 5cfadfd307d588a427e200576ba97a5227653a13 90c0dd8c43cd66008d29492bdfb6b21a17855a00 M      Makefile
:000000 100644 0000000000000000000000000000000000000000 59a0ef4ec9770af6d031abe959adc587c9538a89 A      builtin-checkout.c
:100644 100644 428160d0e48b2acf1ac54d6d73910fd93151ca22 25d91bbfb21ea3c1ea067b10f7ea033d3563936a M      builtin.h
:040000 040000 098e84f3f9fc152debb0f92eb849127f460391d7 0860a331e5a98a88a143d32f371385e78a0121d8 M      contrib
:100755 000000 5621c69d86062c7c75c0b8c2749d34efc78cafb4 0000000000000000000000000000000000000000 D      git-checkout.sh
:100644 100644 114ea75eef55e2960ff111014a505c3eb678caae fc156863b0bbd7d264864c49c2529e47709abf4d M      git.c
:040000 040000 49b19f06ce0395f99f5b9729a1e51b5fa7fd1875 4165e146453fa357ef5e76a9ad48e683301ae669 M      t


--Boundary-00=_xU0XJ9mh17RXblj--
