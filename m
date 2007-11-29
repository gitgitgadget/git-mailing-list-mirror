From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fix a pathological case in git detecting proper renames
Date: Thu, 29 Nov 2007 15:03:06 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711291442300.8458@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0711291050440.1711@blarg.am.freescale.net> <alpine.LFD.0.9999.0711290934260.8458@woody.linux-foundation.org> <28BD703B-24D3-41D6-8360-240A884B1305@kernel.crashing.org> <alpine.LFD.0.9999.0711291122050.8458@woody.linux-foundation.org>
 <41CB0B7D-5AC1-4703-BA99-21622A410F93@kernel.crashing.org> <alpine.LFD.0.9999.0711291303000.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Kumar Gala <galak@kernel.crashing.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 00:05:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxsQe-0007OL-Qj
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 00:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933858AbXK2XDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 18:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758842AbXK2XDp
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 18:03:45 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59581 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934193AbXK2XDn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Nov 2007 18:03:43 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lATN36A7019819
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Nov 2007 15:03:07 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lATN36dq011922;
	Thu, 29 Nov 2007 15:03:06 -0800
In-Reply-To: <alpine.LFD.0.9999.0711291303000.8458@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.426 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_46
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66569>



On Thu, 29 Nov 2007, Linus Torvalds wrote:
> 
> It's worth noting a few gotchas:
> 
>  - this scoring is currently only done for the "exact match" case. 
> 
>    In particular, in Kumar's example, even after this patch, the inexact
>    match case is still done as a copy+delete rather than as two renames:
> 
> 	 delete mode 100644 board/cds/mpc8555cds/u-boot.lds
> 	 copy board/{cds => freescale}/mpc8541cds/u-boot.lds (97%)
> 	 rename board/{cds/mpc8541cds => freescale/mpc8555cds}/u-boot.lds (97%)
> 
>    because apparently the "cds/mpc8541cds/u-boot.lds" copy looked 
>    a bit more similar to both end results. That said, I *suspect* we just 
>    have the exact same issue there - the similarity analysis just gave 
>    identical (or at least very _close_ to identical) similarity points, 
>    and we do not have any logic to prefer multiple renames over a 
>    copy/delete there.
> 
>    That is a separate patch.

Side note: just in case people were expecting me to actually _ship_ that 
separate patch that handles the fuzzy matches too.. I wasn't planning on 
doing that patch. The way the fuzzy rename detection is currently done, 
that's actually quite painful.

For the fuzzy rename detection, we generate the full score matrix, and 
sort it by the score, up front. So all the scoring - and more importantly, 
all the sorting - has actually been done before we actually start looking 
at *any* renames at all, so we cannot easily do the same thing I did for 
the exact renames, namely to take into account _earlier_ renames in the 
scoring. Because those earlier renames have simply not been done when the 
score is calculated.

This would probably become easier to do with the linear-time hash-based 
similarity engine (the stuff Jeff King was working on), but the way the 
code is currently structured - with no incremental rename detection at 
all, and with all the scoring in one global table - it's pretty painful.

			Linus
