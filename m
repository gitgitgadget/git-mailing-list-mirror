From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 2/5] t/t3511: demonstrate breakage in cherry-pick -s
Date: Thu, 15 Nov 2012 18:40:30 -0800
Message-ID: <CA+sFfMfvZg5An5sZ4TvXM5k_op5WwhvKgma3Mq4bX9NG-a6-Cg@mail.gmail.com>
References: <1352943474-15573-1-git-send-email-drafnel@gmail.com>
	<1352943474-15573-2-git-send-email-drafnel@gmail.com>
	<7v8va28g1c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Brandon Casey <bcasey@nvidia.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 03:42:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZBsc-0005el-P0
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 03:42:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148Ab2KPCkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 21:40:31 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:62903 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024Ab2KPCkb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 21:40:31 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so2426370vbb.19
        for <git@vger.kernel.org>; Thu, 15 Nov 2012 18:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yOPQ7TorZjJkN9e1j/242wN11xzFOiDy5cuhv3Qggcw=;
        b=EdXOJOkOlUIFwn/Z2OjeAb8GGkdPWuytVsMnqbEjIn4w6RTPC9k7iWPsMal9f0I6cY
         p4516JzDj80OovD6d+jCo4dhWAi3lkW6Uvok5zipOqQnBWmbL/rBiJ5KhHe0prydk1HO
         qgGbm0hZm9SDb7hRMMorqfAUSthDGZ3OE510VTQg4LnnN8flsONfSuWq9GU6jxEymxTF
         5+LHqYLUsgIkhdMG4dQ0bIWBPnr9RjIKLcWFpJNHQUcMyHmTE0xrpmn1iZxq38QzYDnc
         Lvt72LhsHhU3TdAowzbaJ5OVIgtkIP3d8ADMHpu30VUqDXiW0mY997nZctYIycZlbu6L
         o5Ug==
Received: by 10.52.17.244 with SMTP id r20mr1798052vdd.29.1353033630270; Thu,
 15 Nov 2012 18:40:30 -0800 (PST)
Received: by 10.58.220.9 with HTTP; Thu, 15 Nov 2012 18:40:30 -0800 (PST)
In-Reply-To: <7v8va28g1c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209859>

On Thu, Nov 15, 2012 at 5:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Casey <drafnel@gmail.com> writes:
>
>> The cherry-pick -s functionality is currently broken in two ways.
>>
>>    1. handling of rfc2822 continuation lines has a bug, and the
>>       continuation lines are not handled correctly.
>
> This is not limited to you, but people should think twice when
> writing "has a bug" and "are not handled correctly" in their log
> message.  Did you write what the expected and actual behaviours?

Yeah, I wasn't clear here.  The "bug" was that the incorrect index
variable was being used, which caused the wrong line to be examined to
see if it was an rfc2822 continuation line.  I could have mentioned
that.

>> +rfc2822_mesg="$non_rfc2822_mesg
>> +
>> +Signed-off-by: A.U. Thor
>> + <author@example.com>
>> +Signed-off-by: B.U. Thor <buthor@example.com>"
>
> The S-o-b: lines are meant to record people's contact info in human
> readable forms, and folding the lines like the above makes it a lot
> harder to read.  They typically do not have to be folded.

Well, I wasn't adding functionality here, I was only fixing what I
noticed was broken when I started touching this code.

> Besides, the footer lines are *not* RFC2822 headers (and are not
> used as such when send-email comes up with Cc: list) in the first
> place; have we ever said anything about supporting the RFC2822 line
> folding in the commit footer?  If not (and I am reasonably sure we
> never have), I personally think we should actively *discourage* line
> folding there.

That's fine with me.  I can't think of a reason that would make it
necessary to support line continuation.

>>       i.e. we should produce this:
>>
>>          Signed-off-by: A.U. Thor <author@example.com>
>>          (cherry picked from )
>>          Signed-off-by: C O Mmitter <committer@example.com>
>>
>>       not
>>
>>          Signed-off-by: A.U. Thor <author@example.com>
>>          (cherry picked from da39a3ee5e6b4b0d3255bfef95601890afd80709)
>>
>>          Signed-off-by: C O Mmitter <committer@example.com>
>
> I can buy that, but then this makes it very clear that these footer
> lines are not shaped like RFC2822 headers, no?

The lines that are _not_ "(cherry picked from ...)" lines do follow
the format defined by rfc2822 for header lines (mostly).  That's
probably why the author of the function in sequencer.c that checks for
a s-o-b footer named it "ends_rfc2822_footer".

I'll remove the *broken* existing code that was intended to support
continuation lines and submit a new patch.

-Brandon
