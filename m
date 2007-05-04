From: "Dana How" <danahow@gmail.com>
Subject: Re: [RFD/PATCH] Implement pack.compression and pack-objects --compression=N
Date: Fri, 4 May 2007 00:01:14 -0700
Message-ID: <56b7f5510705040001y6d865d98x6a5cdb1d96cfc0fe@mail.gmail.com>
References: <463802ED.1080200@gmail.com>
	 <7vk5vr3w8n.fsf@assigned-by-dhcp.cox.net>
	 <56b7f5510705021155k40b576d6ke286e65494fc8b05@mail.gmail.com>
	 <56b7f5510705021551q2d48f1e5i3f4a5c2f9891368a@mail.gmail.com>
	 <7vejlxxho1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 04 09:01:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjrn5-0004aM-Tc
	for gcvg-git@gmane.org; Fri, 04 May 2007 09:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754502AbXEDHBR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 03:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754577AbXEDHBQ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 03:01:16 -0400
Received: from nz-out-0506.google.com ([64.233.162.239]:50170 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502AbXEDHBP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 03:01:15 -0400
Received: by nz-out-0506.google.com with SMTP id o1so774154nzf
        for <git@vger.kernel.org>; Fri, 04 May 2007 00:01:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DxbJR9MqUR4CJAsrwFYL4W1/kyTqM4+7tp8rYjJuZoYeQ8eCB3avH9fu6b7yiO9VbplpUwWLzLNXci+Y1SEra036dWB/7gkTN8ixdnstAF+KW0/+vQ4j84munfHjZU16x3wO1KdkPwahWp4GM6HAE2bbf1CarzsY8m/aE/u2FO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lYRbXeBVuG3On6sNb8E7VakqKyShneJwxAxn63EL3xyEIp3yaKLiu7uStM/9NAK/Dp3yHGbw5PcwbksSGLzxSqPeWaoSMPllJWB558jqp0ZmoQuELsDwTt7K7fLcVWNgduu7O55l7cNW3bY6i0nGrIvEiIL/JiA8NLIJLrBHhAM=
Received: by 10.114.81.1 with SMTP id e1mr986938wab.1178262074463;
        Fri, 04 May 2007 00:01:14 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Fri, 4 May 2007 00:01:14 -0700 (PDT)
In-Reply-To: <7vejlxxho1.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46134>

On 5/3/07, Junio C Hamano <junkio@cox.net> wrote:
> "Dana How" <danahow@gmail.com> writes:
> > So for a 25% increase in blob size I get 33% less elapsed time
> > in git-add, all by changing core.compression from -1 to 1.
> > I'll definitely take that improvement.  [For the compressible files
> > we typically have, using 0 is a bad idea:  the CPU "advantage"
> > is swamped out by the time to write a much larger file.]
> The above number is about loose objects, right?
Correct.

> > Since I don't care [to the same degree] about the responsiveness of
> > packing,  I'd rather pack with -1 or better to keep packs small.
> I see.  You are saying that the fact that core.compression is
> used also for packing makes the variable less useful.
Exactly.

> I agree that it would make sense to have at least the pack and
> core compression independent.  I am not sure if we would also
> want to make the pack compression tweakable depending on the
> purpose of the packing (network transfer vs .git/objects/pack/).
The final 12-line hunk in the patch implements --pack-compression=N.
To be blunt,  I'm not sure *I* need it.  Perhaps a high-use web-accessible
public repository would be interested in repacking off-line with 9,  and
creating packs for each puller using -1 to reduce CPU load.  In the latter
case,  due to builtin-pack-objects.c:write_object():to_reuse==1,
much of the transferred data would still be at the better compression
but without again paying the CPU cost.  Shall I remove it?

BTW, I'm now in the habit of browsing Git's Gitweb at git.or.cz and notice
"pu" has --max-pack-size.  You may want to upgrade to the last 5-patch
version in which --max-pack-size no longer forces --no-reuse-delta at
Shawn's request,  among other clean-ups.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
