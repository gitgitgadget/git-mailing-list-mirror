From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 2/4] revisions passed to cherry-pick should be in
 "default" order
Date: Wed, 15 Aug 2012 11:22:18 -0700
Message-ID: <CAOeW2eFK+cKt9Tnh5oe74dU+f8rOOTaWk3KvE2rtUpgcOeDD7g@mail.gmail.com>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
	<50289e50.a19f320a.5d99.3fdfSMTPIN_ADDED@gmr-mx.google.com>
	<7vtxw6d0ct.fsf@alter.siamese.dyndns.org>
	<CAOeW2eEbe9_m_QSbsJUbWPhf6G17X3vqbh__TCefrB0G2VKXdw@mail.gmail.com>
	<7vehnacxkf.fsf@alter.siamese.dyndns.org>
	<CAOeW2eH--Y_gq4jBBhd5EQRw+uuaNWrMT-Sua7CeJO-N9KHCLg@mail.gmail.com>
	<7vk3x06ppi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 20:22:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1iEb-0002in-4l
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 20:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983Ab2HOSWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 14:22:19 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52781 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab2HOSWS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 14:22:18 -0400
Received: by pbbrr13 with SMTP id rr13so183239pbb.19
        for <git@vger.kernel.org>; Wed, 15 Aug 2012 11:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=a5UC8oZBiYRoMdt8PjjwfdIjRvyspzQisdaRNIy6SmA=;
        b=R/IdW6VkEyQrzgr56ORbcLL8T5vnBFbo3Ztb6BGHNEHiNWoBuDqkhruRMo/RI1qXSp
         LeFk9jn0+ioZjxWd0AnTUYby0KWzRaUoV3NzfLwxztC44LLWeQZWYnyaRZjXxkl0IzV1
         X82U95EO3MyYJT1InfbgfQJqnyqlZj9SIlO85Z0a084JCHZ8j8QsqIZxVBkwWmOmCySL
         Vke+n5pP0yYiSnAXgrYsFfQsg+CvfhcJC+SURitPiUUoNgTaKnpiZXL7CWOd64l6S2lX
         OjmElgMG07JEuwRq/PFJgxSEeGrTmrj82auFOgKYABy0dwN6+hT3fMEHeRHB5R5H5PPc
         r5wQ==
Received: by 10.68.224.161 with SMTP id rd1mr42703993pbc.133.1345054938090;
 Wed, 15 Aug 2012 11:22:18 -0700 (PDT)
Received: by 10.68.120.112 with HTTP; Wed, 15 Aug 2012 11:22:18 -0700 (PDT)
In-Reply-To: <7vk3x06ppi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203480>

On Wed, Aug 15, 2012 at 10:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>
>> So all of the above case give the right result in the end as long
>> as the timestamps are chronological, and case 1) gives the right
>> result regardless. The other two cases only works in most cases
>> because the unexpcted sorting when no-walk is in effect
>> counteracts the final reversal.
>
> In short, if you have three commits in a row, A--B--C, with
> timestamps that are not skewed, and want to replay changes of B and
> then C in that order, all three you listed ends up doing the right
> thing.  But if you want to apply the change C and then B:
>
>     - "git cherry-pick A..C" is obviously not a way to do so, so we
>       won't discuss it further.
>
>     - "git cherry-pick C B" is the most natural way the user would
>       want to express this request, but because of the sorting
>       (i.e. commit_list_sort_by_date() in prepare_revision_walk(),
>       combined with ->reverse in sequencer.c::prepare_revs()), it
>       applies B and then C.  That is the real bug.
>
>       Feeding the revs to "git cherry-pick --stdin" in the order the
>       user wishes them to be applied has the same issue.

Exactly.

> I actually think your approach to place the "do not sort when we are
> not walking" logic in prepare_revision_walk() makes more sense.
> "show" has to look at pending.objects[] because it needs to show
> objects other than commits (e.g. "git show :foo"), so there won't be
> any change in its implementation with your change.  It will have to
> look at pending.objects[] itself.

Yes, I noticed that's why "show" has to do it that way.

> But "cherry-pick" and sequencer-derived commands only deal with
> commits.  It would be far less error prone to let them call
> get_revision() repeatedly like all other revision enumerating
> commands do, than to have them go over the pending.objects[] list,
> dereferencing tags and using only commits.  The resulting callers
> would be more readable, too, I would think.

Makes sense, I'll try to implement it that way. I was afraid that
we would need to call prepare_revision_walk() once first and then
if we afterwards find out that we should not walk, we would need
to call it again without the reverse option. But after looking at
how rev_info.reverse is used, it seem like it's only used in
get_revision(), so we can leave it either on or off during the
prepare_revision_walk() and the and set appropriately before
calling get_revision(), like so:

  init_revisions(&revs);
  revs.no_walk = REVISION_WALK_NO_WALK_UNSORTED;
  setup_revisions(...);
  prepare_revision_walk(&revs);
  revs.reverse = !revs.no_walk;
  // iterate over revisions
