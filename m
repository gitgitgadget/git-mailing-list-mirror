From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 4/8] git-repack --max-pack-size: add fixup_header_footer()
Date: Mon, 9 Apr 2007 14:38:57 -0700
Message-ID: <56b7f5510704091438v4d42a7efq9b241bdc31affd08@mail.gmail.com>
References: <46197950.3080804@gmail.com>
	 <7vwt0m76rv.fsf@assigned-by-dhcp.cox.net>
	 <alpine.LFD.0.98.0704082012220.28181@xanadu.home>
	 <20070409173858.GT5436@spearce.org>
	 <alpine.LFD.0.98.0704091404530.28181@xanadu.home>
	 <20070409184039.GZ5436@spearce.org>
	 <56b7f5510704091211i3d101cafq371fbb96ca27238b@mail.gmail.com>
	 <alpine.LFD.0.98.0704091525260.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 02:09:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb1bS-0003e6-O4
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 23:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbXDIVji (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 17:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752996AbXDIVj1
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 17:39:27 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:35004 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078AbXDIVi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 17:38:59 -0400
Received: by wr-out-0506.google.com with SMTP id 71so997322wri
        for <git@vger.kernel.org>; Mon, 09 Apr 2007 14:38:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JRxxH5GxgAx4kDOebANjp0Ref+NznQnxegT8H3KZRW8AnCTIt6MU565sU352LZHwqtxRZfHbrmcw+u24K6mY/YTlkpQ12aNMUeXajiVkt9ssRYqDpfFnVnpWk9Amue/MhkUlJNjZISrNFQh9ZyrGPA1yjVCxFmMhdCCgJ9zbDTY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pwQ7qMV62CwhOATyWbuqpEjqHPUGSN90us5visp1958djxYR8APPY3nxnFfu5ThZfbaY7hjCJqyH9G8TSWwbtyvgwt0+CQF1MUyI35z569Zc/6S2bs9GGDRZfrQdtZb+/iiSmFsKyS4gAD10Ibu4Jc0FBs649LSZhgfQ3B+pPtE=
Received: by 10.114.132.5 with SMTP id f5mr2522875wad.1176154737538;
        Mon, 09 Apr 2007 14:38:57 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Mon, 9 Apr 2007 14:38:57 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0704091525260.28181@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44088>

On 4/9/07, Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 9 Apr 2007, Dana How wrote:
> > Wouldn't the following address the "object count unknown
> > at the start of sequential pack writing" problem:
> >  Write 0 for object count in the header. This is a flag to look for
> >  another header of same format just before the final SHA-1 which
> >  has the correct count. The SHA-1 is still a checksum of everything
> >  before it and no seeking/rewriting is needed on generation.
>
> No.  You really wants to know up front how many objects a pack contains
> when streaming it.  And this is not only for packs written to stdout.
OK, let me ask a dumb question and flog one last additional obvious idea.

Does your wanting to know stem from more than wanting
to stick to one malloc of all the object info at once?

My suggestion quoted above is actually a change to the .pack format.
With all the other ideas for .pack format changes floating around,
let me withdraw that and suggest a simpler one: write a "0" in the header,
and terminate the pack with a sentinel in object format before the final SHA-1s.
The sentinel would be type=OBJ_NONE/length=0, i.e. a null byte.
"Not much" would need to be updated to tolerate it and
you could count objects while looking for it (if header has 0)
during normal processing.  (I'm reacting to your word "streaming".)

> > Finally, when I generate several 2GB split packfiles,  I do notice
> > the slight delay for fixup_header_footer(), and I do think it's a bit
> > ugly, but in quantitative terms it's an insignificant part of a long
> > operation that's infrequently performed.  Does this need to be
> > optimized at all?
> Maybe, maybe not.  That depends how much data we think GIT could be used
> to manage in the future.  With a 1TB pack file you definitely want to
> optimize that case.
OK.  Just FYI, we have a perforce repository near 200GB and
this is not what would concern me right now if we converted all
or part of it to git.  Of course that would depend on the packing schedule.

> OTOH this could wait for the real pack v4 too.
Makes sense to me.  The fewer format changes the better.

BTW,  I've caught up on reading the mailing list archives,
but I don't recall seeing any overview of the objectives of pack v2/v3/v4.
Does that exist any where? I didn't see it in Documentation or
Documentation/technical. It would probably reduce uninformed
questions like the above.  I've deduced rationales for what
miscellaneous details I have seen,
except moving the SHA-1s from .idx to .pack (?).

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
