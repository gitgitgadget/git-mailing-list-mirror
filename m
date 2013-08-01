From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v2 1/2] sha1_file: introduce close_one_pack() to close
 packs on fd pressure
Date: Thu, 1 Aug 2013 11:01:52 -0700
Message-ID: <CA+sFfMdp9j4LL4eocbsJu5DCEfhoE=uEN_wJ3o8VBW+hUVFVLQ@mail.gmail.com>
References: <CA+sFfMe1GTDqtgGs3NXoB0OBYTtyHxLDYgy0TmOe+3r=tMXS0A@mail.gmail.com>
	<1375300297-6744-1-git-send-email-bcasey@nvidia.com>
	<7vsiyts5bb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Brandon Casey <bcasey@nvidia.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 01 20:02:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4xCN-0007Vq-9o
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 20:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756864Ab3HASBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Aug 2013 14:01:55 -0400
Received: from mail-we0-f177.google.com ([74.125.82.177]:61621 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507Ab3HASBx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Aug 2013 14:01:53 -0400
Received: by mail-we0-f177.google.com with SMTP id m46so1968583wev.22
        for <git@vger.kernel.org>; Thu, 01 Aug 2013 11:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PCJmwU7IDvArjeJRoQ0VOT3D4R29qnnSLaOeLryd2Ac=;
        b=clXgID/mxjsjIKih8iysjudDyTPUUfcvlT9HYz2Gs8W+SDnAaE21oZUjORktFOWegx
         vUfH2xqk8buTlAQ9BdoI0c5VR047zXJUu7UjQZP0kd36YmLG1TRfebj20oiW6KeD5Srj
         LxaaqP2IaI5czMVFE97nhTxjsVTQ9qXjEBKLMhUFg6x2n0uUxS7kWX4Bb8epdynB29je
         LzJPMDgRk0TelhMvtzh0JoNP1T+dwvQmFM6Q5InBsMULTmEcpjrIUyZ0gwK1JJvASga7
         8zIDwsXL8so2ikpmHDBL/YnOxhadgBlIoxZshD2tuU4tN/RGwMxECN4h3DTJ1jeckeae
         mQMw==
X-Received: by 10.180.198.146 with SMTP id jc18mr8795981wic.61.1375380112213;
 Thu, 01 Aug 2013 11:01:52 -0700 (PDT)
Received: by 10.194.81.102 with HTTP; Thu, 1 Aug 2013 11:01:52 -0700 (PDT)
In-Reply-To: <7vsiyts5bb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231495>

On Thu, Aug 1, 2013 at 10:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Casey <bcasey@nvidia.com> writes:
>
>> If the refs are loose, then upload-pack will read each ref from the
>> pack (allocating one or more mmap windows) so it can peel tags and
>> advertise the underlying object. If the refs are packed and peeled,
>> then upload-pack will use the peeled sha1 in the packed-refs file and
>> will not need to read from the pack files, so no mmap windows will be
>> allocated and just like with receive-pack, unuse_one_window() will
>
> Even though what it says is not incorrect, the phrasing around here,
> especially "so it can", confused me in my first reading.  It reads
> objects "in order to" peel and advertise (and as a side-effect it
> can lead to windows into packs that eventually help relieaving the
> fd pressure), but a quick scan led me to misread it as "so it can do
> peel and advertise just fine", which misses the point, because it is
> not like we are having trouble peeling and advertising.
>
> Also, the objects at the tips of refs and the objects they point at
> may be loose objects, which is very likely for branch tips.  The fd
> pressure will not be relieved in such a case even if these refs were
> packed.
>
> I've tentatively reworded the above section like so:
>
>     ... If the refs are loose, then upload-pack will read each ref
>     from the object database (if the object is in a pack, allocating
>     one or more mmap windows for it) in order to peel tags and
>     advertise the underlying object.  But when the refs are packed
>     and peeled, upload-pack will use the peeled sha1 in the
>     packed-refs file and will not need to read from the pack files,
>     so no mmap windows will be allocated ...

Thanks.

>> +static int close_one_pack(void)
>> +{
>> +     struct packed_git *p, *lru_p = NULL;
>> +     struct pack_window *mru_w = NULL;
>> +
>> +     for (p = packed_git; p; p = p->next) {
>> +             if (p->pack_fd == -1)
>> +                     continue;
>> +             find_lru_pack(p, &lru_p, &mru_w);
>> +     }
>> +
>> +     if (lru_p) {
>> +             close_pack_windows(lru_p);
>> +             close(lru_p->pack_fd);
>> +             pack_open_fds--;
>> +             lru_p->pack_fd = -1;
>> +             if (lru_p == last_found_pack)
>> +                     last_found_pack = NULL;
>> +             return 1;
>> +     }
>> +
>> +     return 0;
>> +}
>
> OK, so in this codepath where we know we are under fd pressure, we
> find the pack that is least recently used that can be closed, and
> use close_pack_windows() to reclaim all of its open windows (if
> any),

I've been looking closer at uses of p->windows everywhere, and it
seems that we always open_packed_git() before we try to create new
windows.  There doesn't seem to be any reason that we can't continue
to use the existing open windows even after closing the pack file.  We
obviously do this when the window spans the entire file.

So, I'm thinking we can drop the close_pack_windows() and refrain from
resetting last_found_pack, so the last block will become simply:

 +     if (lru_p) {
 +             close(lru_p->pack_fd);
 +             pack_open_fds--;
 +             lru_p->pack_fd = -1;
 +             return 1;
 +     }

If the pack file needs to be reopened later and it has been rewritten
in the mean time, open_packed_git_1() should notice when it compares
either the file size or the pack's sha1 checksum to what was
previously read from the pack index.  So this seems safe.

If we don't need to close_pack_windows(), find_lru_pack() doesn't
strictly need to reject packs that have windows in use.  I think the
algorithm can be tweaked to prefer to close packs that have no windows
in use, but still select them for closing if not.  The order of
preference would look like:

   1. pack with no open windows, oldest mtime
   2. pack with oldest MRU window but none in use
   3. pack with oldest MRU window

> which takes care of the accounting for pack_mapped and
> pack_open_windows, but we need to do the pack_open_fds accounting
> here ourselves.  Makes sense to me.
>
> Thanks.

Sorry about the additional reroll.  I'll make the above changes and resubmit.

-Brandon
