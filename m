From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Limit file descriptors used by packs
Date: Tue, 1 Mar 2011 06:58:49 -0800
Message-ID: <AANLkTik=FiwsQUg89MRXZX1-jR-fkF7uyJAimSXVSLvR@mail.gmail.com>
References: <1298924835-23413-1-git-send-email-spearce@spearce.org>
 <7vwrkjhp27.fsf@alter.siamese.dyndns.org> <20110228204727.GB26052@spearce.org>
 <7vwrkiex62.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 15:59:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuR2i-0006R5-C3
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 15:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756509Ab1CAO7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 09:59:10 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:32937 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756447Ab1CAO7J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 09:59:09 -0500
Received: by vxi39 with SMTP id 39so4225276vxi.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 06:59:09 -0800 (PST)
Received: by 10.52.68.180 with SMTP id x20mr6754454vdt.43.1298991549110; Tue,
 01 Mar 2011 06:59:09 -0800 (PST)
Received: by 10.52.163.66 with HTTP; Tue, 1 Mar 2011 06:58:49 -0800 (PST)
In-Reply-To: <7vwrkiex62.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168225>

On Tue, Mar 1, 2011 at 06:24, Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> In this particular part of C Git, if we are bumping up against the
>> hard pack_max_fds limit we're already into some pretty difficult
>> computation. Trying to push the rlimit higher in order to avoid
>> close/open calls as we cycle through fds isn't really going to make
>> a huge difference on end-user latency for the command to finish
>> its task. So maybe we are better off honoring the rlim_cur that we
>> inherited from the user/environment.
>
> Let's step back a bit.
...
> For a .pack that fits inside a single pack window, however, can't we close
> the file descriptor immediately after mmap() it to obtain a sole window
> into it?

Yes. And its unrelated to this patch. You can still run out of file
descriptors because you have a lot of large packs. :-)

I've considered this in the past, but avoided it because I thought the
unuse_one_window() function might become more complex. But its not, we
can just keep popping windows until the condition is met, which for a
file descriptor is that we are below the limit.

I'll send a follow-up patch that builds on top of this one to close
the pack fd if the entire thing fits into one window.

-- 
Shawn.
