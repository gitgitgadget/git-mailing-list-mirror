From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/2] add strbuf_set operations
Date: Thu, 12 Jun 2014 17:48:52 -0400
Message-ID: <CAPig+cTVLJQOsW7H4Ht2NNYkeiMb=EWT7BG3sNu0wNsTQ=oZNA@mail.gmail.com>
References: <cover.1402557437.git.jmmahler@gmail.com>
	<f4d043b7c1e00f9c967faff39244274fe40fd371.1402557437.git.jmmahler@gmail.com>
	<xmqqr42u55dq.fsf@gitster.dls.corp.google.com>
	<20140612193144.GA17077@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 12 23:49:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvCs2-0006is-S1
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 23:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbaFLVsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 17:48:54 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:58179 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbaFLVsw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 17:48:52 -0400
Received: by mail-yh0-f41.google.com with SMTP id z6so1496798yhz.28
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 14:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=E9kUe82gKmADHXdxVZg1TNdiLDzGNEnnTwFxiAFM6sI=;
        b=xFrAg4L7zdwbn0xzfwQ1DZVWY+ZKzGcuh9QoYtOCNibndXwFdmfoHt7WLE7u1tI06h
         +sgRN03mTgJ1LlucaudydgTAJrVJmx3MSpb/TA+5STJ0udzAkAoyF1yqkU9LuWq77xNV
         YyxMpq9FnJ9RlKuE+TzSri81ljr4bIF77q8mcfP3uHTxtWTkVNzF3h1EOm2zWzA1PWwS
         oy3NliIRr1s2g3PV4iLWJ9xJAnPuuou80VWWvXK2eBjjVWgQoaTJUtRhbiQNnty86iU9
         hwMvOYMY+PU2krUZIXTR1uBbQu/o1I/5AFXqcfo7vPhlIosZXZruSvUFoROBNeEeldPZ
         zsEw==
X-Received: by 10.236.101.198 with SMTP id b46mr19914036yhg.68.1402609732225;
 Thu, 12 Jun 2014 14:48:52 -0700 (PDT)
Received: by 10.170.36.19 with HTTP; Thu, 12 Jun 2014 14:48:52 -0700 (PDT)
In-Reply-To: <20140612193144.GA17077@hudson.localdomain>
X-Google-Sender-Auth: u31gH-pEjekrybLa0pU2NlG8TNw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251497>

On Thu, Jun 12, 2014 at 3:31 PM, Jeremiah Mahler <jmmahler@gmail.com> wrote:
> On Thu, Jun 12, 2014 at 11:50:41AM -0700, Junio C Hamano wrote:
>> I am on the fence.
>>
>> I have this suspicion that the addition of strbuf_set() would *only*
>> help when the original written with reset-and-then-add sequence was
>> suboptimal to begin with, and it helps *only* how the code reads,
>> without correcting the fact that it is still doing unnecessary
>> "first set to a value to be discarded and then reset to set the
>> right value", sweeping the issue under the rug.
>>
> It is certainly possible that builtin/remote.c (PATCH 2/2) saw the most
> benefit from this operation because it is so badly designed.  But this
> seems unlikely given the review process around here ;-)
>
> The one case where it would be doing extra work is when a strbuf_set
> replaces a strbuf_add that didn't previously have a strbuf_reset.
> strbuf_set is not appropriate for all cases, as I mentioned in the
> patch, but in some cases I think it makes it more readable.  And in this
> case it would be doing a reset on an empty strbuf.  Is avoiding this
> expense worth the reduction in readability?
>
> Also, as Eric Sunshine pointed out, being able to easily re-order
> operations can make the code easier to maintain.
>
>> Repeated reset-and-then-add on the same strbuf used to be something
>> that may indicate that the code is doing unnecessary work.  Now,
>> repeated uses of strbuf_set on the same strbuf replaced that pattern
>> to be watched for to spot wasteful code paths.
>>
> If a reset followed by and add was a rare occurrence I would tend to
> agree more.

When composing my review of the builtin/remote.c changes, I wrote
something like this:

    Although strbuf_set() does make the code a bit easier to read
    when strbufs are repeatedly re-used, re-using a variable for
    different purposes is generally considered poor programming
    practice. It's likely that heavy re-use of strbufs has been
    tolerated to avoid multiple heap allocations, but that may be a
    case of premature (allocation) optimization, rather than good
    programming. A different ("better") way to make the code more
    readable and maintainable may be to ban re-use of strbufs for
    different purposes.

But I deleted it before sending because it's a somewhat tangential
issue not introduced by your changes. However, I do see strbuf_set()
as a Band-Aid for the problem described above, rather than as a useful
feature on its own. If the practice of re-using strbufs (as a
premature optimization) ever becomes taboo, then strbuf_set() loses
its value.

>> I dunno...
>>
>> > Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
>> > ---
>> >  Documentation/technical/api-strbuf.txt | 18 ++++++++++++++++++
>> >  strbuf.c                               | 21 +++++++++++++++++++++
>> >  strbuf.h                               | 13 +++++++++++++
>> >  3 files changed, 52 insertions(+)
>> >
>> > diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
>> > index f9c06a7..ae9c9cc 100644
>> > --- a/Documentation/technical/api-strbuf.txt
>> > +++ b/Documentation/technical/api-strbuf.txt
>> > @@ -149,6 +149,24 @@ Functions
>> >     than zero if the first buffer is found, respectively, to be less than,
>> >     to match, or be greater than the second buffer.
>> >  /*----- add data in your buffer -----*/
> ...
>> >  static inline void strbuf_addch(struct strbuf *sb, int c)
>> >  {
>
> --
> Jeremiah Mahler
> jmmahler@gmail.com
> http://github.com/jmahler
