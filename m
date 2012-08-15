From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 2/4] revisions passed to cherry-pick should be in
 "default" order
Date: Tue, 14 Aug 2012 23:05:21 -0700
Message-ID: <CAOeW2eH--Y_gq4jBBhd5EQRw+uuaNWrMT-Sua7CeJO-N9KHCLg@mail.gmail.com>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
	<50289e50.a19f320a.5d99.3fdfSMTPIN_ADDED@gmr-mx.google.com>
	<7vtxw6d0ct.fsf@alter.siamese.dyndns.org>
	<CAOeW2eEbe9_m_QSbsJUbWPhf6G17X3vqbh__TCefrB0G2VKXdw@mail.gmail.com>
	<7vehnacxkf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 08:06:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1Wk1-0000XN-CA
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 08:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304Ab2HOGFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 02:05:23 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:58900 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab2HOGFW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 02:05:22 -0400
Received: by ghrr11 with SMTP id r11so1418859ghr.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 23:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ResbDLLoHtwMcMbnP9WuOO1NA08gNJ5iiNZxm1GXHfE=;
        b=FqAf5OgsyoPC94ITx2pGXMLlZdhuQFg1Qbi+W3MDiiOpBte++u9LQ9j92EB14A7Mwi
         z/ycVK6/fhjGZduTNWRWHBRfBFXoGZlUCBYrB3klJSOllZWBm5906BrrCfs28oQ47qLl
         kKnVJMmA4Bnbdmyv9C5gD35w6wXW8pq+IWcXJYmcbISv5045R0K2kjzOxH/XnMel+Ump
         RhhRUcBnMAOY6fw9+H5RuGUbvwTEb4qOGfcYE96gKD1hTptDmjVgqOltDeZIBBLOrH94
         NamiNUOAQ80M1qtsoFA34BFMq+Od/5kXFGM+YXcMcyB/MeuL9BtCvkUZvz5WraH8ddNY
         si0A==
Received: by 10.68.224.170 with SMTP id rd10mr24879170pbc.106.1345010721382;
 Tue, 14 Aug 2012 23:05:21 -0700 (PDT)
Received: by 10.68.120.112 with HTTP; Tue, 14 Aug 2012 23:05:21 -0700 (PDT)
In-Reply-To: <7vehnacxkf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203462>

On Mon, Aug 13, 2012 at 2:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>
>> To connect to the other mail I sent on this thread (in parallel with
>> yours), do you think "git cherrry-pick HEAD HEAD~1" should apply the
>> commits in the same order as "git cherry-pick HEAD~2..HEAD" (which
>> would give the same result if passed to 'rev-list --no-walk' for a
>> linear history) or in the order specified on the command line?
>
> Definitely the latter; I do not think of any semi-reasonable excuse
> to do otherwise.

Indeed. My patches tried to fix the wrong problem.

Sorry I'm slow, but I think I'm finally starting to understand
what you've been saying all along about the bug being in
sequencer. I'll try to recapitulate a bit for my own and maybe
others' understanding. For simplicity, let's assume a linear
history with unique timestamps, but not necessarily increasing
with each commit.

Currently:

 1) 'git cherry-pick A..C' picks the commits order in
  reverse "default" order

 2) 'git cherry-pick B C' picks the commits in chronological
  order

 3) 'git rev-list --reverse A..C | git cherry-pick --stdin'
  behaves just like 'git cherry-pick B C' and therefore picks
  the commits in chronological order

In cases 2) and 3), even though cherry-pick tells the revision
walker not to walk, it still sorts the commits in reverse
chronological order. But cherry-pick also tells the revision
walker explicitly to reverse the list, so in the end, the order
is chronological.

In case 2), however, the first ordering make no difference in
this "limited" case (IIUC). So the "default" ordering (which
would be C, then B in this case, regardless of timestamps), gets
reversed and B gets applied first, followed by C.

So all of the above case give the right result in the end as long
as the timestamps are chronological, and case 1) gives the right
result regardless. The other two cases only works in most cases
because the unexpcted sorting when no-walk is in effect
counteracts the final reversal.

When I noticed that the order of inputs to cases 2) and 3) above
was ignored, and thinking that 'git rev-list A..C | git
cherry-pick --stdin' should mimic 'git cherry-pick A..C', I
incorrectly thought that the error was the use of --reverse to
'git rev-list' as well as the sorting done in the no-walk case. I
think completely ignored case 2) at this point.

I now think I understand that the sorting done in the no-walk
case is indeed incorrect, but that the --reverse passed to
rev-list is correct. Instead, the final reversal, which is
currently unconditional, should not be done in the no-walk case.

IIUC, this could be implemented by making cherry-pick iterate
over rev_info.pending.objects just like 'git show' does when not
walking.

Junio, I think it makes sense to just drop this whole series for
now. I'll probably include patch 1/4 in my stalled rebase-range
series instead. If I understood you correctly, you didn't have
any objections to that patch.
