From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [ANNOUNCE] Git 1.7.9.3
Date: Tue, 6 Mar 2012 15:50:37 +0100
Message-ID: <87y5rd4wci.fsf@thomas.inf.ethz.ch>
References: <7vliney6k7.fsf@alter.siamese.dyndns.org>
	<A518E7E7-25D5-429C-A1C1-35F94EC8F043@bjhargrave.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	<trast@student.ethz.ch>
To: BJ Hargrave <bj@bjhargrave.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 15:50:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4viw-0001i3-7x
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 15:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030801Ab2CFOul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 09:50:41 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:32403 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030789Ab2CFOul (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 09:50:41 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Mar
 2012 15:50:38 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Mar
 2012 15:50:38 +0100
In-Reply-To: <A518E7E7-25D5-429C-A1C1-35F94EC8F043@bjhargrave.com> (BJ
	Hargrave's message of "Tue, 6 Mar 2012 09:35:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192355>

BJ Hargrave <bj@bjhargrave.com> writes:

> ok 6 - empty bundle file is rejected
> not ok - 7 ridiculously long subject in boundary
> #	
> #		: >file4 &&
> #		test_tick &&
> #		git add file4 &&
> #		printf "%01200d
> #	" 0 | git commit -F - &&
> #		test_commit fifth &&
> #		git bundle create long-subject-bundle.bdl HEAD^..HEAD &&
> #		git bundle list-heads long-subject-bundle.bdl >heads &&
> #		test -s heads &&
> #		git fetch long-subject-bundle.bdl &&
> #		sed -n "/^-/{p;q}" long-subject-bundle.bdl >boundary &&
> #		grep "^-$_x40 " boundary

I can reproduce this.  The failure (to be seen from -v, which would have
been really nice to have in the original mail):

  sed: 1: "/^-/{p;q}": extra characters at the end of q command

This can be fixed with the change below, which then gets us into the
next one

  grep: Regular expression too big

Sheesh, Apple, are you kidding me?!  So we also need to change the grep
expression.

----- 8< -----
Subject: [PATCH] t5704: fix nonportable sed/grep usages

OS X's sed and grep would complain with (respectively)

  sed: 1: "/^-/{p;q}": extra characters at the end of q command
  grep: Regular expression too big

For sed, use an explicit ; to terminate the q command.

For grep, spell the "40 hex digits" explicitly in the regex, instead
of being lazy with the shell pattern $_x40.
---
 t/t5704-bundle.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
index a51c8b0..9e43731 100755
--- a/t/t5704-bundle.sh
+++ b/t/t5704-bundle.sh
@@ -54,8 +54,8 @@ test_expect_success 'ridiculously long subject in boundary' '
 	git bundle list-heads long-subject-bundle.bdl >heads &&
 	test -s heads &&
 	git fetch long-subject-bundle.bdl &&
-	sed -n "/^-/{p;q}" long-subject-bundle.bdl >boundary &&
-	grep "^-$_x40 " boundary
+	sed -n "/^-/{p;q;}" long-subject-bundle.bdl >boundary &&
+	grep "^-[0-9a-f]\\{40\\} " boundary
 '
 
 test_done
-- 
1.7.6.557.gcee4



-- 
Thomas Rast
trast@{inf,student}.ethz.ch
