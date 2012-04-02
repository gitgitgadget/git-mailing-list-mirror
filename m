From: Martin Fick <mfick@codeaurora.org>
Subject: Re: [PATCH 3/3] revision: insert unsorted, then sort in prepare_revision_walk()
Date: Mon, 2 Apr 2012 10:24:49 -0600
Organization: CAF
Message-ID: <201204021024.49706.mfick@codeaurora.org>
References: <201203291818.49933.mfick@codeaurora.org> <20120330094052.GB12298@sigill.intra.peff.net> <4F7780F5.3060306@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: =?utf-8?q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Shawn Pearce <sop@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 18:25:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEk3t-0007M8-Dx
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 18:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732Ab2DBQYv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Apr 2012 12:24:51 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:41980 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047Ab2DBQYu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Apr 2012 12:24:50 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6668"; a="175797554"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 02 Apr 2012 09:24:50 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 6604310004AA;
	Mon,  2 Apr 2012 09:24:50 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-37-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <4F7780F5.3060306@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194530>

On Saturday, March 31, 2012 04:11:01 pm Ren=C3=A9 Scharfe wrote:
> Speed up prepare_revision_walk() by adding commits
> without sorting to the commit_list and at the end sort
> the list in one go.  Thanks to mergesort() working
> behind the scenes, this is a lot faster for large
> numbers of commits than the current insert sort.

This speeds up my git push test on my repo with ~100K refs=20
case from out ~43s to about ~10s.  Not bad, thanks!

The rest of the 10s do not seem to be spent with high CPU on=20
either the pushing or the receiving side (only a very small=20
100% burst on both sides near the end of the operation).  I=20
also ran iotop on the receiving side and could not find any=20
activity (of course, the repo is likely cached).  iftop does=20
show a decent amount of traffic during this time, so perhaps=20
we are finally approaching the protocol limit? =20

But, I have my doubts on that to be honest.  The reason is=20
because I am able to hack Gerrit to receive this push much=20
faster (around 3.5s) by reusing a cached RevWalk.  Without=20
the cached RevWalk, Gerrit (using jgit) is about the same as=20
your new patch ~10s.  I am not saying that git is spending=20
its time in the same place (but it may be) as jgit, but with=20
jgit, the time I was able to save with the cached RevWalk=20
was the time spent loading and parsing the RevCommits.  This=20
could be the same thing that git is doing?  And while it may=20
not be I/O (disk) bound so to speak since the packs are=20
likely cached, it may still be memory bound on that I/O?  If=20
it is memory bound, and not I/O(disk) or CPU bound, I guess=20
it makes sense that git and jgit would perform about the=20
same (10s)?

Thanks again for your patch,

-Martin

--=20
Employee of Qualcomm Innovation Center, Inc. which is a=20
member of Code Aurora Forum
