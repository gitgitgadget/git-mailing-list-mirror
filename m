From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Wed, 30 Apr 2008 12:29:34 +0200
Message-ID: <48184A0E.3050704@viscovery.net>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <7vabjm78v2.fsf@gitster.siamese.dyndns.org> <20080422095549.GB3752@alea.gnuu.de> <alpine.DEB.1.00.0804221127360.4460@eeepc-johanness> <7vy775ygjm.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804221810180.4460@eeepc-johanness> <7v3ap5a4ny.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804290138170.27457@eeepc-johanness> <7vk5ih8ckp.fsf@gitster.siamese.dyndns.org> <4816CA72.8070405@viscovery.net> <alpine.DEB.1.00.0804291147450.27457@eeepc-johanness> <7vk5ig745b.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804292220120.13650@eeepc-johanness> <7viqy05mhp.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804292355060.17469@eeepc-johanness> <7v63u05khw.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804300016130.17469@eeepc-j
 ohanness> <7v1w4o3zle.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804300938190.17469@eeepc-johanness> <7vr6cn1yzk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?J=F6?= =?ISO-8859-1?Q?rg_Sommer?= 
	<joerg@alea.gnuu.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 12:30:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr9a0-0000a1-TX
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 12:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754824AbYD3K3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 06:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755528AbYD3K3m
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 06:29:42 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:30976 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755269AbYD3K3i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 06:29:38 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jr9Z8-0006Hh-LI; Wed, 30 Apr 2008 12:29:34 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 693A96B7; Wed, 30 Apr 2008 12:29:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vr6cn1yzk.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80822>

Junio C Hamano schrieb:
> In the context of "rebase -i", this may not be a problem, but by forcing
> us to name commits always with original commits, we cannot build (instead
> of rebuild) a history that does not yet exist using the sequencer
> machinery, can we?
> 
> If we want to transplant "^C ^N O" in this history elsewhere:
> 
>       --o---C---N
>                / 
>           B---M
>          /   /
>         O---A
> 
> while inserting a new fix-up commit F on top of B before we merge that
> side branch to rewritten A:
> 
>               --o---C---N'
>                        / 
>               B'--X---M'
>              /       /
>         O---Q-------A'
> 
> Would/Should the machinery somehow figure out that the merge between the
> rewritten A (which is A') and an inserted commit X (which is made on top
> of the rewritten B) corresponds to M in the original history?

No. The 'merge' insn tells the original merge commit. So, rebase would
suggest this todo list:

	pick B
	reset Q
	pick A
	merge M A B
	merge N M C

and you would have to change it to

	pick B
	pick X       <--
	reset Q
	pick A
	merge M A X  <--
	merge N M C

But you could just as well do this:

	edit B       <--
	reset Q
	pick A
	merge M A B
	merge N M C

When the 'edit B' stops, HEAD is at B'. Now you git-am X, then 'rebase
--continue'. Since now HEAD is at X, X is recorded as the rewritten
version of B, and the 'merge M A B' would pick X as the second parent.

-- Hannes
