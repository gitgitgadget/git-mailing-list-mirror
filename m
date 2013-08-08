From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC PATCH] During a shallow fetch, prevent sending over unneeded objects
Date: Thu, 8 Aug 2013 14:21:33 +0700
Message-ID: <CACsJy8BahoGcDcLjSaHA-62_KQE2wD-p5oeJOOA4nk8ZRfXrEA@mail.gmail.com>
References: <20130711220127.GK10217@login.drsnuggles.stderr.nl>
 <CACsJy8CP6pGRwEn6H=cbKxTMuOjzAF3=Qh8qsLbJaw6feK3NMw@mail.gmail.com> <7vfvukbrqh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthijs Kooijman <matthijs@stdin.nl>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 09:22:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7KXy-0005Hl-3j
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 09:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757499Ab3HHHWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 03:22:05 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:42372 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756745Ab3HHHWE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 03:22:04 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf1so223944pab.38
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 00:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zaMGzVmmqAOwkZWcqQhgWdbL+R7E3krsueqGaZc9ygA=;
        b=Wm/M/qkvfBfBfqtLlorTxkWRMZ+KfVUYaZjRRy2OpUdA+LyapdrUdhgBv52JPSG4VR
         lxfftQE0sc7zGe91BtmbScCo8TQr7+4PFB8HnX9ifDJCLFOp4N9RYC9305GA4bxOCa6l
         P8sNtCXCm6P0zJFJ/wa8Sg8IHnbL+gvP+Pzj7lME8hlQrqM9uLLSwNXqFC4+dBufx23h
         Fv4z0Efg9/UQOAUM3F6MGLwFOHklPKuUFM9iNZogS4EfJpMUM3ocDZ7i2fJvJHHazphl
         8FljQnVGHBA8wZ4AgymRdYVwrj9X0Uwm5v7TpYXjPfORTUITuKCXnW5UapyrBW4EP1Os
         ynQw==
X-Received: by 10.68.169.161 with SMTP id af1mr4667683pbc.22.1375946523154;
 Thu, 08 Aug 2013 00:22:03 -0700 (PDT)
Received: by 10.70.102.163 with HTTP; Thu, 8 Aug 2013 00:21:33 -0700 (PDT)
In-Reply-To: <7vfvukbrqh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231869>

On Thu, Aug 8, 2013 at 1:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> I think this applies to general case as well, not just shallow.
>> Imagine I have a disconnected commit that points to the latest tree
>> (i.e. it contains most of latest changes). Because it's disconnected,
>> it'll be ignored by the server side. But if the servide side does
>> mark_tree_interesting on this commit, a bunch of blobs might be
>> excluded from sending.
>
> I think you meant mark_tree_UNinteresting.

Yes, thanks for correcting.

>> ... So perhaps we could go over have_obj list
>> again, if it's not processed and is
>>
>>  - a tree-ish, mark_tree_uninteresting
>>  - a blob, just mark unintesting
>>
>> and this does regardless of shallow state or edges.
>
> As a general idea, I agree it may be worth trying out to see if your
> concern that the "have" list may be so big that this approach may be
> more costly than it is worth.
>
> If the recipient is known to have something, we do not have to send
> it.

OK. Mathijs, do you want make a patch for it?

> The things that we decide not to send are not necessarily what the
> recipient has, which introduces a twist you need to watch out for if
> we want to go that route.
>
> If the recipient is known to have something, a thin transfer can
> send a delta against it.  You do not want to send the commits before
> the shallow boundary (i.e. the parents of the commits listed in
> .git/shallow) because the recipient does not want them, and that
> means you may have to use a different mark to record that fact.  The
> recipient does not have them, we do not want to send them, and they
> cannot be used as a delta base for what we do send.  Which is quite
> different from the ordinary "uninteresting" objects, those we decide
> not to send because the recipient has them.

I fail to see the point here. There are two different things: what we
want to send, and what we can make deltas against. Shallow boundary
affects the former. What the recipient has affects latter. What is the
twist about?

As for considering objects before shallow boundary uninteresting, I
have a plan for it: kill upload-pack.c:do_rev_list(). The function is
created to make a cut at shallow boundary, but we already have a tool
for that: grafting. In my ongoing shallow series I will create a
temporary shallow file that contains new roots and pass the file to
pack-objects with --shallow-file. pack-objects will never see anything
outside what the recipient may want (i.e. commits before shallow
boundary) to receive and pack-objects' rev-list should do what
upload-pack.c:do_rev_list() currently does.
-- 
Duy
