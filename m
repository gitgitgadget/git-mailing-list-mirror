From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 07:59:25 +0200
Organization: Organization?!?
Message-ID: <85zm1tue6a.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site> <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org> <vpq4pk1vf7q.fsf@bauges.imag.fr>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0.999?= =?ISO-8859-1?Q?.0707181004330.=04?=
	=?ISO-8859-1?Q?27353@woody.linu?= =?ISO-8859-1?Q?x-foundation.org?=
	=?ISO-8859-1?Q?>?= <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0.999?= =?ISO-8859-1?Q?.070718=041710271.?=
	=?ISO-8859-1?Q?27353@woody.linu?= =?ISO-8859-1?Q?x-foundation.org?=
	=?ISO-8859-1?Q?>?= <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 07:59:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBP3I-0002UR-Dd
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 07:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbXGSF7n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 01:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754970AbXGSF7n
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 01:59:43 -0400
Received: from main.gmane.org ([80.91.229.2]:49078 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753796AbXGSF7m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 01:59:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBP32-0004Ai-2H
	for git@vger.kernel.org; Thu, 19 Jul 2007 07:59:36 +0200
Received: from dslb-084-061-038-079.pools.arcor-ip.net ([84.61.38.79])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 07:59:36 +0200
Received: from dak by dslb-084-061-038-079.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 07:59:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-038-079.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:1aaHbuNbODbuyWo3TpX4FhClTD0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52938>

Junio C Hamano <gitster@pobox.com> writes:

> Another issue I thought about was what you would do in the step
> 3 in the following:
>
>  1. David says "mkdir D; git add D"; you add S_IFDIR entry in
>     the index at D;
>
>  2. David says "date >D/F; git add D/F"; presumably you drop D
>     from the index (to keep the index more backward compatible)
>     and add S_IFREG entry at D/F.

I don't think that one should drop D here.  Operation 1 _is_ not
backward compatible, so if you want to revert it, you should
explicitly remove D.  And we can't "keep" the index backward
compatible if it isn't so after step 1.

>  3. David says "git rm D/F".
>
> Have we stopped keeping track of the "empty directory" at this
> point?

The case I am worrying about is rather

mkdir D
mkdir D/E
touch D/E/file
git add D
[*]
git rm D/E/file

>From a user perspective, E should be registered still.  Compare this
with

mkdir D
mkdir D/E
touch D/E/file
git add D/E/file
[*]
git rm D/E/file

Where likely both D and E should now be considered unregistered.  So
the situation is different between the first or the second [*], and
the difference might be impossible to express completely in the frame
of a backwards-compatible index, even though we don't track an empty
directory at the point [*] at all, and the only registered _file_ is
D/E/file.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
