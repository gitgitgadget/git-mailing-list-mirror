From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Wed, 19 Feb 2014 17:14:46 +0700
Message-ID: <CACsJy8DsC9X=13iEpONcT6bw6qTw_O586_vZ2W_3O42ajEPF4A@mail.gmail.com>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
 <87r470ssuc.fsf@fencepost.gnu.org> <CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
 <87ioscsoow.fsf@fencepost.gnu.org> <20140218155842.GA7855@google.com>
 <xmqqzjlocf28.fsf@gitster.dls.corp.google.com> <CACsJy8AEXP45K+r3gGVTWbn4uuPLeHOkf-an20rj77QSfG1-ew@mail.gmail.com>
 <xmqq4n3warni.fsf@gitster.dls.corp.google.com> <CACsJy8C+wGd9WxnsML6-_G_S5GtN2pCPf09kcFtBVu-SDfP8YA@mail.gmail.com>
 <CAGK7Mr4wpwUK6UF6vTmgszX4sajPDvQazY2QagFfH9BEJx_9Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Kastrup <dak@gnu.org>,
	Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 11:15:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WG4Bg-00045J-Sd
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 11:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602AbaBSKPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Feb 2014 05:15:21 -0500
Received: from mail-qc0-f177.google.com ([209.85.216.177]:35006 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594AbaBSKPR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Feb 2014 05:15:17 -0500
Received: by mail-qc0-f177.google.com with SMTP id i8so163079qcq.22
        for <git@vger.kernel.org>; Wed, 19 Feb 2014 02:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RcSgGEJn8VNVUmD05iEqEAhfGRoRME+2Us5adUT9NJU=;
        b=UuP7bGtyHAhYmyFTcX8aUDqmLFXljFQaJveubOPaNMdpLuw0+xv1zIOlrDRcr9FRl3
         VjxhDMWMGk2iSJKhEwbX7RM47YfbXQW9TJB2cOJdacA/wFNp+AehN23Co+za2jk5sCmC
         nBMhMJgFEWAWJJonB0vSen7kFUiodrhE62xR9SYyqlWvUSWe7Mo5t/ntiZ94471BneZ2
         3CJaSmcghjqR0UMnrbebSIewdIJjMg1nPl0Oi/lZ8qMQGc5zKuTvv33ZJpJGSdbFCGjN
         e+mIMmrDe0SZUwPVlBTd0GomX+Uc26qM4iHAfejR8/2nM0K50789wOlhmka4in8XCxmd
         9rzQ==
X-Received: by 10.140.107.138 with SMTP id h10mr45582015qgf.30.1392804916849;
 Wed, 19 Feb 2014 02:15:16 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Wed, 19 Feb 2014 02:14:46 -0800 (PST)
In-Reply-To: <CAGK7Mr4wpwUK6UF6vTmgszX4sajPDvQazY2QagFfH9BEJx_9Ow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242387>

On Wed, Feb 19, 2014 at 3:38 PM, Philippe Vaucher
<philippe.vaucher@gmail.com> wrote:
>> fwiw this is the thread that added --depth=250
>>
>> http://thread.gmane.org/gmane.comp.gcc.devel/94565/focus=94626
>
> This post is quite interesting:
> http://article.gmane.org/gmane.comp.gcc.devel/94637

Especially this part

-- 8< --
And quite frankly, a delta depth
of 250 is likely going to cause overflows in the delta cache (which is
only 256 entries in size *and* it's a hash, so it's going to start having
hash conflicts long before hitting the 250 depth limit).
-- 8< --

So in order to get file A's content, we go through its 250 level chain
(and fill the cache), then we get to file B and do the same, which
evicts nearly everything from A. By the time we go to the next commit,
we have to go through 250 levels for A again because the cache is
pretty much useless.

I can think of two improvements we could make, either increase cache
size dynamically (within limits) or make it configurable. If we have N
entries in worktree (both trees and blobs) and depth M, then we might
need to cache N*M objects for it to be effective. Christian, if you
want to experiment this, update MAX_DELTA_CACHE in sha1_file.c and
rebuild.

The other is smarter eviction, instead of throwing all A's cached
items out (based on recent order), keep the last few items of A and
evict B's oldest cached items. Hopefully by the next comit, we can
still reuse some cache for A and other files/trees. Delta cache needs
to learn about grouping to achieve this.
-- 
Duy
