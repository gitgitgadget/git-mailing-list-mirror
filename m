From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v3] sha1_file: introduce close_one_pack() to close packs
 on fd pressure
Date: Fri, 2 Aug 2013 10:12:08 -0700
Message-ID: <CA+sFfMfZCAmPNzD8cBY0-1CePi5VM3dBqaxxNV=hvxkfStXK4g@mail.gmail.com>
References: <CA+sFfMdJgQaEBx_FsYPz1rC3--jknnb4Zwr+FOaL+9gNe4xwyw@mail.gmail.com>
	<1375421793-32224-1-git-send-email-drafnel@gmail.com>
	<7v38qsqcs8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Brandon Casey <bcasey@nvidia.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 02 19:12:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5Itj-0004PW-6k
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 19:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754677Ab3HBRMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 13:12:10 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:49549 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474Ab3HBRMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 13:12:09 -0400
Received: by mail-wi0-f174.google.com with SMTP id j17so784443wiw.13
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 10:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BdNvc2B7vFWU6VDbhVx1mJmLdjB5d1PpVhq9ojD4ko8=;
        b=TXj7nC+ChatvUfLPWZvwO59Pggf5Rs5OS0n17pgJXLohRhklysbBIGRHJD0z98y1a/
         p6rmfV6Lk5i4RGZl0YBTFKbh+3i5K3AxaoZuwCPMNnMHE3jTb2sJBjzNtFg4qAUea5DO
         iR1i+PvMCEPx1pZ8nlvx7RUtZo5i2gC2MMoigKjH1/WU7H9bRL78/s0C+2Pxs43UQgxR
         ntL8Ob5fHWUC1GCi5IDv+Oaqq+VjelGNdGD0tLxxVBu+7rbLTQ+cZ53oxXjps2l49SC6
         nqerOoZ5JLIdzQcLT9UpYP6TIhOu7tp/xLzZ+6RvwtI96+4K8cBJyG147gTd73VK4Xg/
         rm2g==
X-Received: by 10.180.39.236 with SMTP id s12mr2579980wik.14.1375463528270;
 Fri, 02 Aug 2013 10:12:08 -0700 (PDT)
Received: by 10.194.81.102 with HTTP; Fri, 2 Aug 2013 10:12:08 -0700 (PDT)
In-Reply-To: <7v38qsqcs8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231532>

On Fri, Aug 2, 2013 at 9:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Casey <drafnel@gmail.com> writes:
>
>> +/*
>> + * The LRU pack is the one with the oldest MRU window, preferring packs
>> + * with no used windows, or the oldest mtime if it has no windows allocated.
>> + */
>> +static void find_lru_pack(struct packed_git *p, struct packed_git **lru_p, struct pack_window **mru_w, int *accept_windows_inuse)
>> +{
>> +     struct pack_window *w, *this_mru_w;
>> +     int has_windows_inuse = 0;
>> +
>> +     /*
>> +      * Reject this pack if it has windows and the previously selected
>> +      * one does not.  If this pack does not have windows, reject
>> +      * it if the pack file is newer than the previously selected one.
>> +      */
>> +     if (*lru_p && !*mru_w && (p->windows || p->mtime > (*lru_p)->mtime))
>> +             return;
>> +
>> +     for (w = this_mru_w = p->windows; w; w = w->next) {
>> +             /*
>> +              * Reject this pack if any of its windows are in use,
>> +              * but the previously selected pack did not have any
>> +              * inuse windows.  Otherwise, record that this pack
>> +              * has windows in use.
>> +              */
>> +             if (w->inuse_cnt) {
>> +                     if (*accept_windows_inuse)
>> +                             has_windows_inuse = 1;
>> +                     else
>> +                             return;
>> +             }
>> +
>> +             if (w->last_used > this_mru_w->last_used)
>> +                     this_mru_w = w;
>> +
>> +             /*
>> +              * Reject this pack if it has windows that have been
>> +              * used more recently than the previously selected pack.
>> +              * If the previously selected pack had windows inuse and
>> +              * we have not encountered a window in this pack that is
>> +              * inuse, skip this check since we prefer a pack with no
>> +              * inuse windows to one that has inuse windows.
>> +              */
>> +             if (*mru_w && *accept_windows_inuse == has_windows_inuse &&
>> +                 this_mru_w->last_used > (*mru_w)->last_used)
>> +                     return;
>
> The "*accept_windows_inuse == has_windows_inuse" part is hard to
> grok, together with the fact that this statement is evaluated for
> each and every "w", even though it is about this_mru_w and that
> variable is not updated in every iteration of the loop.  Can you
> clarify/simplify this part of the code a bit more?
>
> For example, would the above be equivalent to this?
>
>                 if (w->last_used < this_mru_w->last_used)
>                         continue;
>
>                 this_mru_w = w;
>                 if (has_windows_inuse && *mru_w &&
>                     w->last_used > (*mru_w)->last_used)
>                         return;
>
> That is, if we already know a more recently used window in this
> pack, we do not have to do anything to maintain mru_w.  Otherwise,
> remember that this window is the most recently used one in this
> pack, and if it is newer than the newest one from the pack we are
> going to pick, we refrain from picking this pack.
>
> But we do not reject ourselves if we haven't seen a window that is
> in use (yet).

No that wouldn't be the same.  The function of "*accept_windows_inuse
== has_windows_inuse" and the testing of this_mru_w in every loop
rather than w, is too subtle.  I tried to draw attention to it in the
comment, but I agree it's not enough.

The case that your example would not catch is when the new pack's mru
window has already been found, but has_windows_inuse is not set until
later.  When has_windows_inuse is later set, we need to test
this_mru_w regardless of whether we have just assigned it.

For example, if mru_w points to a pack with last_used == 11 and
*accept_windows_inuse = 1, and p->windows looks like this:

   last_used  in_use
   12         0
   10         1

Then the first time through the loop, this_mru_w would be set to the
first window with last_used equal to 12.  The if statement that tests
"this_mru_w->last_used > (*mru_w)->last_used" would be skipped since
has_windows_inuse would still be 0.  The second time through the loop,
this_mru_w would _not_ be reset, but has_windows_inuse _would_ be set.
 This time, we would want to enter the last for loop so that we can
reject the pack.

I'll try to rework this loop or add comments to clarify.

-Brandon


>> +     }
>> +
>> +     /*
>> +      * Select this pack.
>> +      */
>> +     *mru_w = this_mru_w;
>> +     *lru_p = p;
>> +     *accept_windows_inuse = has_windows_inuse;
>> +}
>> +
>> +static int close_one_pack(void)
>> +{
>> +     struct packed_git *p, *lru_p = NULL;
>> +     struct pack_window *mru_w = NULL;
>> +     int accept_windows_inuse = 1;
>> +
>> +     for (p = packed_git; p; p = p->next) {
>> +             if (p->pack_fd == -1)
>> +                     continue;
>> +             find_lru_pack(p, &lru_p, &mru_w, &accept_windows_inuse);
>> +     }
>> +
>> +     if (lru_p) {
>> +             close(lru_p->pack_fd);
>> +             pack_open_fds--;
>> +             lru_p->pack_fd = -1;
>> +             return 1;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>>  void unuse_pack(struct pack_window **w_cursor)
>>  {
>>       struct pack_window *w = *w_cursor;
>> @@ -768,7 +845,7 @@ static int open_packed_git_1(struct packed_git *p)
>>                       pack_max_fds = 1;
>>       }
>>
>> -     while (pack_max_fds <= pack_open_fds && unuse_one_window(NULL, -1))
>> +     while (pack_max_fds <= pack_open_fds && close_one_pack())
>>               ; /* nothing */
>>
>>       p->pack_fd = git_open_noatime(p->pack_name);
