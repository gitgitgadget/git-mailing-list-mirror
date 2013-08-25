From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 00/24] Index-v5
Date: Sun, 25 Aug 2013 11:40:42 +0700
Message-ID: <CACsJy8BgQxefys0h7ZfiLP3zrGnEqtkiUoe4GkBAEi+JnojT9A@mail.gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
 <CACsJy8AkvUiJhjYVCuMrNwZPR7AiO-CZFazvOG-mVO=+Qq9O3Q@mail.gmail.com> <xmqq61uuo4dl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 06:41:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDS8c-0003rI-9t
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 06:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756016Ab3HYElO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 00:41:14 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:53237 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755980Ab3HYElN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 00:41:13 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so2101964obc.26
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 21:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sDS0BlPEYnhpM6Io8PZNTe2WYPHFhkhNyzHL6bu9Ans=;
        b=a1En4nvaYAkKperQJ0uodgd/Bw4e1SCZesOx3dAwvSmgZ/tfluDU1eLkHBWQscbVdo
         iD/UI/NnQmqU5XSHk4+5VcILLIBn4AqJI/hbgs1TWWEnKsf4ZJgJwVBY5Zg0er+gh1bi
         0JHNquxam3kOVT84NCPtcyEUhK+dMm3tAHbsuqq8T6skHAKDj1zKFNlaASohKqVOuen9
         TN3gxrlo7fdbWBWYapy3GCsMYzUKWGiUhD5sXAugPUns3yWzaob3oruv+Cr4P2xoeipg
         JjvcYDAk11OKjnB+I17NR0wu1BH+zw7w5RHsNXTja54KHp84GGEncxS9PGECacHrpCp7
         VTFA==
X-Received: by 10.182.46.232 with SMTP id y8mr7570975obm.13.1377405672536;
 Sat, 24 Aug 2013 21:41:12 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Sat, 24 Aug 2013 21:40:42 -0700 (PDT)
In-Reply-To: <xmqq61uuo4dl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232913>

On Sun, Aug 25, 2013 at 10:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Mon, Aug 19, 2013 at 2:41 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>>
>> I'm done reviewing this version (I neglected the extension writing
>> patches because after spending hours on the main write patch I don't
>> want to look at them anymore :p). Now that rc period is over, with a
>> partial write proof-of-concept, I think it's enough to call Junio's
>> attention on the series, see if we have any chance of merging it. The
>> partial write POC is needed to make sure we don't overlook anything,
>> just support update-index is enough.
>
> I've been following the review comment threads after looking at the
> patches myself when they were posted. I was hoping to see some API
> improvement over the current "we (have to) have everything available
> in-core in a flat array" model, which gives a lot of convenience and
> IO overhead at the same time, that would make me say "yes, this
> operation, that we need to do very often, will certainly be helped
> by this new API, and in order to support that style of API better,
> the current file format is inadequate and we do need to go to the
> proposed tree like on-disk format" for at least one, but
> unfortunately I haven't found any (yet).

Thomas is in the best position to answer this, but I'll give it a try.
In my opinon, v2-4 works well for moderate-sized worktrees, v5 aims to
make the index scale better. One way to make it scale is not to read
the whole index up when you only need a portion of the index.
read_index_filtered() enables this. We could implement
read_index_filtered() on v2 too, but because v2 lacks proper data
structure to support it, we need to scan through all on-disk entries.
"git diff" and "git status" with pathspec may benefit from this (and
for large worktrees, people better use pathspec than whole-tree
"status"). The flat (but not full) array model seems best fit because
we still need to support v2. Another v5 improvement is fast "git add
-u/git commit -a" when partial write is implemented. I don't think
such a patch is posted. There may be API addition to aid v5 code but
it should not be big API change.
-- 
Duy
